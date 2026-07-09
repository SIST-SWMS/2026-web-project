<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 상품 목록 조회 --%>
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

.thumb-sm {
	width: 56px;
	height: 56px;
	object-fit: cover;
	border-radius: 6px;
	background: #f5f5f5;
}

.prod-row {
	cursor: pointer;
}

.prod-row:hover {
	background: #f8f8f8;
}
</style>
</head>
<body>
	<%-- 상단: 제목 + 상품 등록 버튼 --%>
	<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4">
		<h4 class="fw-bold mb-0">상품 관리</h4>
		<a href="../admin/goods_insert.do" class="btn btn-dark">상품 등록</a>
	</div>

	<%-- ===================== 검색 영역 ===================== --%>
	<form action="product_list.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">카테고리</label>
				<select name="category" class="form-select">
					<option value="">전체</option>
					<option value="스니커즈">스니커즈</option>
					<option value="스포츠">스포츠</option>
					<option value="구두">구두</option>
					<option value="샌들">샌들</option>
					<option value="부츠">부츠</option>
				</select>
			</div>

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">브랜드</label>
				<select name="brand" class="form-select">
					<option value="">전체</option>
					<option value="나이키">나이키</option>
					<option value="아디다스">아디다스</option>
					<option value="뉴발란스">뉴발란스</option>
					<option value="닥터마틴">닥터마틴</option>
					<option value="킨">킨</option>
				</select>
			</div>

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">상품명</label>
				<input type="text" name="productName" class="form-control" placeholder="상품명 입력" value="${param.productName}">
			</div>

			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="product_list.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<%-- ===================== 목록 테이블 ===================== --%>
	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">상품코드</th>
				<th style="width: 80px;">이미지</th>
				<th>상품명</th>
				<th style="width: 100px;">브랜드</th>
				<th style="width: 100px;">카테고리</th>
				<th style="width: 110px;">가격</th>
				<th style="width: 80px;">할인율</th>
			</tr>
		</thead>
		<tbody>
			<%-- 1건 = tr 하나. <c:forEach var="p" items="${productList}"> 로 반복 --%>
			<!-- <c:forEach var="p" items="${productList}"> -->
			<tr class="prod-row" onclick="location.href='../admin/goods_view.do?code=SHOE-1001'">
				<td>SHOE-1001</td>
				<td>
					<img src="../resources/images/product-thumb-1.png" class="thumb-sm" alt="이미지">
				</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>데카트론</td>
				<td>스니커즈</td>
				<td class="text-end pe-4">49,900원</td>
				<td>0%</td>
			</tr>
			<!-- </c:forEach> -->
			<tr class="prod-row" onclick="location.href='../admin/goods_view.do?code=SHOE-1001'">
				<td>SHOE-1001</td>
				<td>
					<img src="../resources/images/product-thumb-1.png" class="thumb-sm" alt="이미지">
				</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>데카트론</td>
				<td>스니커즈</td>
				<td class="text-end pe-4">49,900원</td>
				<td>0%</td>
			</tr>
			<tr class="prod-row" onclick="location.href='../admin/goods_view.do?code=SHOE-1001'">
				<td>SHOE-1001</td>
				<td>
					<img src="../resources/images/product-thumb-1.png" class="thumb-sm" alt="이미지">
				</td>
				<td class="text-start">스트라이커 (Z1)_Black</td>
				<td>데카트론</td>
				<td>스니커즈</td>
				<td class="text-end pe-4">49,900원</td>
				<td>0%</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 페이지네이션 ===================== --%>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="product_list.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="product_list.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="product_list.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>