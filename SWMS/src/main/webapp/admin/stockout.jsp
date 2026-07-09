<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%-- 출고 처리 --%>
<style type="text/css">
.pagination {
	display: inline-flex;
	list-style: none;
	gap: 6px;
	padding: 0;
	margin: 0 auto;
}

.pagination li a {
	display: block;
	padding: 8px 14px;
	color: #333;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}
</style>
<script type="text/javascript">
	// 출고처리: 재고 확인 → 부족 시 알림, 충분하면 확인 팝업 후 서버 전송
	// 파라미터: 주문번호, 주문수량, 현재고 (실제로는 서버에서 재고 재확인 필요)
	function processOut(orderNo, orderQty, currentStock) {
		if (currentStock < orderQty) {
			alert("재고가 부족합니다.");
			return;
		}
		if (confirm("출고 처리하시겠습니까?")) {
			// 서버로 전송 → stock.quantity 차감, stock_history INSERT(chk='OUT'), 주문상태 '배송중' 변경
			location.href = "stockout_process.do?orderNo=" + orderNo;
		}
	}
</script>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">출고 처리</h4>

	<%-- ===================== 검색 / 필터 영역 ===================== --%>
	<form action="stockout.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">주문 상태</label>
				<select name="status" class="form-select">
					<option value="">전체</option>
					<option value="PAID">결제완료(미출고)</option>
					<option value="DONE">배송완료</option>
				</select>
			</div>

			<div class="col-md-6">
				<label class="form-label small text-body-secondary">상품명 / 주문번호 / 회원ID</label>
				<input type="text" name="keyword" class="form-control" placeholder="검색어 입력" value="${param.keyword}">
			</div>

			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="stockout.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<%-- ===================== 목록 테이블 ===================== --%>
	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th>주문번호</th>
				<th>회원ID</th>
				<th>상품명</th>
				<th style="width: 70px;">사이즈</th>
				<th style="width: 60px;">수량</th>
				<th style="width: 110px;">주문일</th>
				<th style="width: 100px;">주문상태</th>
				<th style="width: 110px;">출고처리</th>
			</tr>
		</thead>
		<tbody>
			<%-- 주문 1건 = tr 하나. <c:forEach var="order" items="${orderList}"> 로 반복 --%>
			<!-- <c:forEach var="order" items="${orderList}"> -->
			<tr>
				<td class="fw-bold">ORD20260705-4253501</td>
				<td>ups****</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>270</td>
				<td>1</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<span class="badge bg-secondary">미출고</span>
				</td>
				<td>
					<%-- 미출고 주문: 출고처리 버튼 활성 --%>
					<button type="button" class="btn btn-sm btn-dark" onclick="processOut('ORD20260705-4253501', 1, 5)">출고처리</button>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td class="fw-bold">ORD20260705-4253498</td>
				<td>kim****</td>
				<td class="text-start">클래식 러너 스니커즈</td>
				<td>265</td>
				<td>2</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<span class="badge bg-secondary">미출고</span>
				</td>
				<td>
					<button type="button" class="btn btn-sm btn-dark" onclick="processOut('ORD20260705-4253498', 2, 1)">출고처리</button>
				</td>
			</tr>
			<tr>
				<td class="fw-bold">ORD20260704-4251102</td>
				<td>lee****</td>
				<td class="text-start">레더 브라운 로퍼</td>
				<td>280</td>
				<td>1</td>
				<td class="text-body-secondary">2026.07.04</td>
				<td>
					<span class="badge bg-primary">배송중</span>
				</td>
				<td>
					<%-- 이미 출고된 주문: 버튼 비활성 + 출고완료 텍스트 --%>
					<span class="text-body-secondary small">출고완료</span>
				</td>
			</tr>
			<tr>
				<td class="fw-bold">ORD20260704-4250887</td>
				<td>park***</td>
				<td class="text-start">뉴포트 H2 샌들</td>
				<td>250</td>
				<td>1</td>
				<td class="text-body-secondary">2026.07.04</td>
				<td>
					<span class="badge bg-success">배송완료</span>
				</td>
				<td>
					<span class="text-body-secondary small">출고완료</span>
				</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 페이지네이션 ===================== --%>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="stockout.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="stockout.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="stockout.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>