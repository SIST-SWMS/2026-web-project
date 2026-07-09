<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.info-row {
	display: flex;
	padding: 12px 0;
	border-bottom: 1px solid #eee;
}

.info-row .label {
	width: 120px;
	color: #888;
	font-size: 15px;
}

.info-row .value {
	flex: 1;
	font-weight: 500;
}
/* 재고 0 행 강조 */
.soldout-row {
	background: #fff0f0;
}
</style>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">재고 상세</h4>

	<div class="border rounded-4 p-4 mb-5">
		<div class="row g-4">

			<!-- 상품 이미지 -->
			<div class="col-md-3">
				<img src="../resources/images/product-thumb-1.png" class="w-100 rounded-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 이미지">
			</div>

			<!-- 기본 정보 -->
			<div class="col-md-9">
				<div class="info-row">
					<div class="label">상품명</div>
					<div class="value">${stock.productName}</div>
				</div>
				<div class="info-row">
					<div class="label">브랜드</div>
					<div class="value">${stock.brand}</div>
				</div>
				<div class="info-row">
					<div class="label">카테고리</div>
					<div class="value">${stock.category}</div>
				</div>
				<div class="info-row">
					<div class="label">상품코드</div>
					<div class="value">${stock.productCode}</div>
				</div>
			</div>

		</div>
	</div>

	<%-- ===================== 하단 - 사이즈별 재고 테이블 ===================== --%>
	<h5 class="fw-bold border-bottom pb-2 mb-3">사이즈별 재고</h5>

	<table class="table align-middle text-center" style="max-width: 560px;">
		<thead>
			<tr class="text-body-secondary">
				<th>사이즈</th>
				<th>현재고</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>

			<%-- 사이즈 1개 = tr 하나. <c:forEach var="s" items="${sizeStockList}"> 로 반복 --%>
			<%-- 재고 0 행은 soldout-row 클래스로 빨간 강조 --%>
			<!-- <c:forEach var="s" items="${sizeStockList}"> -->
			<tr>
				<td>230</td>
				<td>32</td>
				<td>
					<span class="badge bg-success">정상</span>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td>240</td>
				<td>18</td>
				<td>
					<span class="badge bg-success">정상</span>
				</td>
			</tr>
			<tr>
				<td>250</td>
				<td>7</td>
				<td>
					<span class="badge bg-warning text-dark">부족</span>
				</td>
			</tr>
			<tr class="soldout-row">
				<td>260</td>
				<td class="text-danger fw-bold">0</td>
				<td>
					<span class="badge bg-danger">품절</span>
				</td>
			</tr>
			<tr>
				<td>270</td>
				<td>25</td>
				<td>
					<span class="badge bg-success">정상</span>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="mt-4 d-flex gap-2">
		<a href="../admin/stock_insert.do?code=${stock.productCode}" class="btn btn-dark px-4">등록</a>
		<a href="../admin/stock_list.do" class="btn btn-outline-dark px-4">목록으로</a>
	</div>
</body>
</html>