<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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

		$('#deleteBtn').on('click', function() {
			let no = $(this).attr("data-no")
			if (confirm("삭제 시 해당 상품의 재고·이력 데이터도 영향을 받습니다. 삭제하시겠습니까?")) {
				location.href = "../admin/goods_delete.do?no=" + no
			} else {
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
			<c:choose>
				<c:when test="${fn:startsWith(vo.poster_url, 'http')}">
					<img src="${vo.poster_url}" class="w-100 rounded-3 mb-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 이미지">
				</c:when>
				<c:otherwise>
					<img src="/SWMS/uploads/${vo.poster_url}" class="w-100 rounded-3 mb-3" style="aspect-ratio: 1/1; object-fit: cover; background: #f5f5f5;" alt="상품 이미지">
				</c:otherwise>
			</c:choose>
		</div>

		<div class="col-md-8">
			<div class="info-row">
				<div class="label">상품코드</div>
				<div class="value">${vo.goods_code}</div>
			</div>
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
				<div class="value">${vo.dbday}</div>
			</div>
		</div>

		<div>
			<c:choose>
				<c:when test="${fn:startsWith(vo.subposter_url, 'http')}">
					<img src="${vo.subposter_url}" class="w-100 rounded-3 mb-3" style="object-fit: cover; background: #f5f5f5;" alt="상품 상세 이미지">
				</c:when>
				<c:otherwise>
					<img src="/SWMS/uploads/${vo.subposter_url}" class="w-100 rounded-3 mb-3" style="object-fit: cover; background: #f5f5f5;" alt="상품 상세 이미지">
				</c:otherwise>
			</c:choose>
		</div>

	</div>

	<h5 class="fw-bold border-bottom pb-2 mb-3">사이즈별 재고 현황</h5>

	<table class="table align-middle text-center" style="max-width: 560px;">
		<thead>
			<tr class="text-body-secondary">
				<th>사이즈</th>
				<th>재고수량</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="lvo" items="${list }">
				<tr>
					<td>${lvo.goods_size }</td>
					<td>${lvo.quantity }</td>
					<td>
						<c:if test="${lvo.quantity >= 10}">
							<span class="badge bg-success">정상</span>
						</c:if>
						<c:if test="${lvo.quantity < 10 && lvo.quantity > 0}">
							<span class="badge bg-warning">부족</span>
						</c:if>
						<c:if test="${lvo.quantity == 0}">
							<span class="badge bg-danger">품절</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="mt-4 d-flex gap-2">
		<a class="btn btn-dark px-4" href="../admin/goods_update.do?no=${vo.goods_no }">수정</a>
		<button type="button" class="btn btn-danger px-4" id="deleteBtn" data-no="${vo.goods_no }">삭제</button>
		<a href="../admin/goods_list.do" class="btn btn-outline-dark px-4">목록</a>
	</div>

</body>
</html>