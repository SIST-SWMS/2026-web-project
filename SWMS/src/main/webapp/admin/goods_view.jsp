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

.soldout-row {
	background: #fff0f0;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#deleteBtn').on('click',function(){
		let no = 1
		if (confirm("삭제 시 해당 상품의 재고·이력 데이터도 영향을 받습니다. 삭제하시겠습니까?")) {
			location.href = "../admin/goods_delete.do?goods_no=" + no
		} 
		else {
			return;
		}
	})
})
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 상세</h4>

	<div class="row g-4 mb-5">

		<div class="col-md-4">
			<img src="../resources/images/product-thumb-1.png" class="w-100 rounded-3 mb-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 이미지">
		</div>

		<div class="col-md-8">
			<div class="info-row">
				<div class="label">상품코드</div>
				<div class="value">${vo.productCode}</div>
			</div>
			<div class="info-row">
				<div class="label">상품명</div>
				<div class="value">${vo.productName}</div>
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
				<div class="label">가격</div>
				<div class="value">${vo.goods_price}원</div>
			</div>
			<div class="info-row">
				<div class="label">할인율</div>
				<div class="value">
					<span class="text-danger">${vo.goods_discount}%</span>
				</div>
			</div>
			<div class="info-row">
				<div class="label">등록일</div>
				<div class="value">${product.regDate}</div>
			</div>
		</div>

		<div>
			<img src="../resources/images/product-thumb-1.png" class="w-100 rounded-3 mb-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 상세 이미지">
		</div>

	</div>

	<h5 class="fw-bold border-bottom pb-2 mb-3">사이즈별 재고 현황</h5>

	<table class="table align-middle text-center" style="max-width: 560px;">
		<thead>
			<tr class="text-body-secondary">
				<th>사이즈</th>
				<th>현재고</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="lvo" items="${list }">
				<tr>
					<td>${lvo.goods_size }</td>
					<td>${lvo.quantity }</td>
					<td>
						<span class="badge bg-success">정상</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="mt-4 d-flex gap-2">
		<a href="../admin/goods_update.do?code=${vo.goods_no }" class="btn btn-dark px-4">수정</a>
		<button type="button" class="btn btn-danger px-4" id="deleteBtn">삭제</button>
		<a href="../admin/goods_list.do" class="btn btn-outline-dark px-4">목록</a>
	</div>

</body>
</html>