<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입출고 조회</h4>

	<%-- ===================== 검색 영역 ===================== --%>
	<form action="io_list.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<!-- 기간 선택 -->
			<div class="col-md-4">
				<label class="form-label small text-body-secondary">기간</label>
				<div class="d-flex align-items-center gap-2">
					<input type="date" name="startDate" class="form-control" value="${param.startDate}">
					<span>~</span>
					<input type="date" name="endDate" class="form-control" value="${param.endDate}">
				</div>
			</div>

			<!-- 구분 콤보 -->
			<div class="col-md-2">
				<label class="form-label small text-body-secondary">구분</label>
				<select name="chk" class="form-select">
					<option value="">전체</option>
					<option value="IN">입고</option>
					<option value="OUT">출고</option>
				</select>
			</div>

			<!-- 상품명 검색 -->
			<div class="col-md-3">
				<label class="form-label small text-body-secondary">상품명</label>
				<input type="text" name="productName" class="form-control" placeholder="상품명 입력" value="${param.productName}">
			</div>

			<!-- 버튼 -->
			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="io_list.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<%-- ===================== 목록 테이블 ===================== --%>
	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 60px;">번호</th>
				<th style="width: 80px;">구분</th>
				<th>상품명</th>
				<th style="width: 70px;">사이즈</th>
				<th style="width: 70px;">수량</th>
				<th style="width: 110px;">입출고일</th>
				<th style="width: 90px;">등록자</th>
				<th style="width: 110px;">등록일</th>
				<th style="width: 80px;">상세</th>
			</tr>
		</thead>
		<tbody>
			<%-- 1건 = tr 하나. <c:forEach var="io" items="${ioList}"> 로 반복 --%>
			<!-- <c:forEach var="io" items="${ioList}"> -->
			<tr>
				<td>1024</td>
				<td>
					<span class="badge bg-primary">입고</span>
				</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>270</td>
				<td>50</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>admin</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<a href="../admin/io_view.do?id=1024" class="btn btn-sm btn-outline-dark">상세</a>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td>1023</td>
				<td>
					<span class="badge bg-danger">출고</span>
				</td>
				<td class="text-start">클래식 러너 스니커즈</td>
				<td>265</td>
				<td>2</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>admin</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<a href="../admin/io_view.do?id=1023" class="btn btn-sm btn-outline-dark">상세</a>
				</td>
			</tr>
			<tr>
				<td>1022</td>
				<td>
					<span class="badge bg-danger">출고</span>
				</td>
				<td class="text-start">레더 브라운 로퍼</td>
				<td>280</td>
				<td>1</td>
				<td class="text-body-secondary">2026.07.04</td>
				<td>admin</td>
				<td class="text-body-secondary">2026.07.04</td>
				<td>
					<a href="../admin/io_view.do?id=1022" class="btn btn-sm btn-outline-dark">상세</a>
				</td>
			</tr>
			<tr>
				<td>1021</td>
				<td>
					<span class="badge bg-primary">입고</span>
				</td>
				<td class="text-start">뉴포트 H2 샌들</td>
				<td>250</td>
				<td>30</td>
				<td class="text-body-secondary">2026.07.03</td>
				<td>admin</td>
				<td class="text-body-secondary">2026.07.03</td>
				<td>
					<a href="../admin/io_view.do?id=1021" class="btn btn-sm btn-outline-dark">상세</a>
				</td>
			</tr>
			<tr>
				<td>1020</td>
				<td>
					<span class="badge bg-danger">출고</span>
				</td>
				<td class="text-start">삼바 OG 클라우드</td>
				<td>275</td>
				<td>1</td>
				<td class="text-body-secondary">2026.07.02</td>
				<td>admin</td>
				<td class="text-body-secondary">2026.07.02</td>
				<td>
					<a href="../admin/io_view.do?id=1020" class="btn btn-sm btn-outline-dark">상세</a>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="../admin/io_list.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="../admin/io_list.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="../admin/io_list.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>