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
				<img src="${vo.poster_url}" class="w-100 rounded-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 이미지">
			</div>

			<!-- 기본 정보 -->
			<div class="col-md-9">
				<div class="info-row">
					<div class="label">상품명</div>
					<div class="value">${vo.goods_name}</div>
				</div>
				<div class="info-row">
					<div class="label">브랜드</div>
					<div class="value">${vo.brand_name}</div>
				</div>
				<div class="info-row">
					<div class="label">카테고리</div>
					<div class="value">${vo.category_name}</div>
				</div>
				<div class="info-row">
					<div class="label">상품코드</div>
					<div class="value">${vo.goods_code}</div>
				</div>
			</div>

		</div>
	</div>

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
			<c:forEach var="svo" items="${list }">
				<tr>
					<td>${svo.goods_size}</td>
					<td>${svo.quantity }</td>
					<td>
						<c:choose>
					        <c:when test="${svo.quantity == 0}">
					            <span class="badge bg-danger">품절</span>
					        </c:when>
					        <c:when test="${svo.quantity < 10}">
					            <span class="badge bg-warning text-dark">부족</span>
					        </c:when>
					        <c:otherwise>
					            <span class="badge bg-success">정상</span>
					        </c:otherwise>
					    </c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="mt-4 d-flex gap-2">
		<a href="../admin/stock_update.do?no=${vo.goods_no}" class="btn btn-dark px-4">수정</a>
		<a href="../admin/stock_list.do" class="btn btn-outline-dark px-4">목록으로</a>
	</div>
</body>
</html>