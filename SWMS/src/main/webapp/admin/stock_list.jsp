<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
/* 행 클릭 시 상세 이동 - 커서 손모양 */
.stock-row {
	cursor: pointer;
}

.stock-row:hover {
	background: #f8f8f8;
}
</style>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">재고 조회</h4>

	<%-- ===================== 검색 영역 ===================== --%>
	<form action="stock_list.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<div class="col-md-5">
				<label class="form-label small text-body-secondary">상품명 / 상품코드</label>
				<input type="text" name="keyword" class="form-control" placeholder="상품명 또는 상품코드 입력" value="${param.keyword}">
			</div>

			<!-- 재고 부족 필터 -->
			<div class="col-md-4">
				<div class="form-check mt-4">
					<input class="form-check-input" type="checkbox" name="lowStock" value="Y" id="lowStock" ${param.lowStock == 'Y' ? 'checked' : ''}>
					<label class="form-check-label" for="lowStock">재고 부족만 보기 (10개 이하)</label>
				</div>
			</div>

			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="stock_list.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<%-- ===================== 목록 테이블 ===================== --%>
	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 130px;">상품코드</th>
				<th>상품명</th>
				<th style="width: 110px;">브랜드</th>
				<th style="width: 110px;">카테고리</th>
				<th style="width: 90px;">총재고</th>
				<th style="width: 90px;">상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- 1건 = tr 하나. <c:forEach var="stock" items="${stockList}"> 로 반복 --%>
			<%-- 행 클릭 시 재고 상세로 이동 (onclick) --%>
			<!-- <c:forEach var="stock" items="${stockList}"> -->
			<tr class="stock-row" onclick="location.href='stock_view.do?code=SHOE-1001'">
				<td>SHOE-1001</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>데카트론</td>
				<td>스니커즈</td>
				<td>145</td>
				<td>
					<span class="badge bg-success">정상</span>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr class="stock-row" onclick="location.href='stock_view.do?code=SHOE-1002'">
				<td>SHOE-1002</td>
				<td class="text-start">클래식 러너 스니커즈</td>
				<td>스파크</td>
				<td>스니커즈</td>
				<td>8</td>
				<td>
					<span class="badge bg-warning text-dark">부족</span>
				</td>
			</tr>
			<tr class="stock-row" onclick="location.href='stock_view.do?code=SHOE-1003'">
				<td>SHOE-1003</td>
				<td class="text-start">레더 브라운 로퍼</td>
				<td>스파크</td>
				<td>구두</td>
				<td>0</td>
				<td>
					<span class="badge bg-danger">품절</span>
				</td>
			</tr>
			<tr class="stock-row" onclick="location.href='stock_view.do?code=SHOE-1004'">
				<td>SHOE-1004</td>
				<td class="text-start">뉴포트 H2 샌들</td>
				<td>킨</td>
				<td>샌들</td>
				<td>62</td>
				<td>
					<span class="badge bg-success">정상</span>
				</td>
			</tr>
			<tr class="stock-row" onclick="location.href='stock_view.do?code=SHOE-1005'">
				<td>SHOE-1005</td>
				<td class="text-start">1460 8홀 부츠 블랙</td>
				<td>닥터마틴</td>
				<td>부츠</td>
				<td>5</td>
				<td>
					<span class="badge bg-warning text-dark">부족</span>
				</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 페이지네이션 ===================== --%>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="stock_list.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="stock_list.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="stock_list.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>