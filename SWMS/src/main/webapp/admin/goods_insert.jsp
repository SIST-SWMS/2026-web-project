<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 등록</h4>

	<form id="productForm" action="../admin/goods_insert_ok.do" method="post" enctype="multipart/form-data" style="max-width: 760px;">

		<div class="mb-3">
			<label class="form-label fw-bold">카테고리 <span class="text-danger">*</span></label>
			<select name="category" class="form-select" required>
				<c:forEach var="cvo" items="${cList }">
					<c:if test="${cvo.category_no != 0}">
						<option value="${cvo.category_no }" <c:if test="${cvo.category_no == vo.category_no}">selected</c:if>>
			                ${cvo.category_name }
			            </option>
		            </c:if>
				</c:forEach>
			</select>
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">브랜드 <span class="text-danger">*</span></label>
			<select name="brand" class="form-select" required>
				<c:forEach var="bvo" items="${bList }">
					<c:if test="${bvo.brand_no != 0}">
						<option value="${bvo.brand_no }" <c:if test="${bvo.brand_no == vo.brand_no}">selected</c:if>>
			                ${bvo.brand_name }
			            </option>
		            </c:if>
				</c:forEach>
			</select>
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">상품코드 <span class="text-danger">*</span></label>
			<input type="text" name="goods_code" class="form-control" placeholder="예: SHOE-1001" required>
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">상품명 <span class="text-danger">*</span></label>
			<input type="text" name="goods_name" class="form-control" required>
		</div>

		<div class="row">
			<div class="col-md-6 mb-3">
				<label class="form-label fw-bold">가격 <span class="text-danger">*</span></label>
				<div class="input-group">
					<input type="number" name="goods_price" class="form-control" min="0" required>
					<span class="input-group-text">원</span>
				</div>
			</div>

			<div class="col-md-6 mb-3">
				<label class="form-label fw-bold">할인율</label>
				<div class="input-group">
					<input type="number" name="goods_discount" class="form-control" min="0" max="100" value="0">
					<span class="input-group-text">%</span>
				</div>
			</div>
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">상품 이미지</label>
			<input type="file" name="poster_url" class="form-control" accept="image/*">
		</div>

		<div class="mb-4">
			<label class="form-label fw-bold">상세 이미지</label>
			<input type="file" name="subposter_url" class="form-control" accept="image/*">
		</div>

		<div class="border rounded-4 p-4 mb-4 bg-light">
			<div class="fw-bold mb-3">사이즈별 초기 재고</div>
			<div class="d-flex flex-wrap gap-3">
				<c:forEach var="sz" begin="230" end="290" step="10">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="sizes" value="${sz}" id="size${sz}">
						<label class="form-check-label" for="size${sz}">${sz}</label>
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-dark px-5">저장</button>
			<a href="../admin/goods_list.do" class="btn btn-outline-secondary px-5">취소</a>
		</div>

	</form>
</body>
</html>

