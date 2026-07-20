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
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 수정</h4>

	<form id="productEditForm" action="../admin/goods_update_ok.do" method="post" enctype="multipart/form-data" style="max-width: 760px;">

		<input type="hidden" name="goods_no" value="${vo.goods_no}">

		<!-- 카테고리 -->
		<div class="mb-3">
			<label class="form-label fw-bold">카테고리<span class="text-danger">*</span></label>
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

		<!-- 브랜드 -->
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
			<label class="form-label fw-bold">상품코드</label>
			<input type="text" name="goods_code" class="form-control" value="${vo.goods_code}">
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">상품명 <span class="text-danger">*</span></label>
			<input type="text" name="goods_name" class="form-control" value="${vo.goods_name}" required>
		</div>

		<div class="row">
			<div class="col-md-6 mb-3">
				<label class="form-label fw-bold">가격 <span class="text-danger">*</span></label>
				<div class="input-group">
					<input type="text" name="price" class="form-control" min="0" value="${vo.goods_price}" required>
					<span class="input-group-text">원</span>
				</div>
			</div>
			<div class="col-md-6 mb-3">
				<label class="form-label fw-bold">할인율</label>
				<div class="input-group">
					<input type="text" name="discount" class="form-control" min="0" max="100" value="${vo.goods_discount}">
					<span class="input-group-text">%</span>
				</div>
			</div>
		</div>

		<div class="mb-3">
			<label class="form-label fw-bold">상품 이미지</label>
			<div class="mb-2">
				<c:choose>
					<c:when test="${fn:startsWith(vo.poster_url, 'http')}">
						<img src="${vo.poster_url }" width="90" height="90" style="object-fit: cover; border-radius: 6px; background: #f5f5f5;" alt="기존 이미지">
					</c:when>
					<c:otherwise>
						<img src="/SWMS/uploads/${vo.poster_url }" width="90" height="90" style="object-fit: cover; border-radius: 6px; background: #f5f5f5;" alt="기존 이미지">
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="old_poster_url" value="${vo.poster_url}">
			</div>
			<input type="file" name="poster_url" class="form-control" accept="image/*">
			<div class="form-text">새 파일을 선택하면 기존 이미지가 교체됩니다.</div>
		</div>

		<div class="mb-4">
			<label class="form-label fw-bold">상세 이미지</label>
			<div class="mb-2">
				<c:choose>
					<c:when test="${fn:startsWith(vo.subposter_url, 'http')}">
						<img src="${vo.subposter_url }" width="90" height="90" style="object-fit: cover; border-radius: 6px; background: #f5f5f5;" alt="기존 상세이미지">
					</c:when>
					<c:otherwise>
						<img src="/SWMS/uploads/${vo.subposter_url }" width="90" height="90" style="object-fit: cover; border-radius: 6px; background: #f5f5f5;" alt="기존 상세이미지">
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="old_subposter_url" value="${vo.subposter_url}">
			</div>
			<input type="file" name="subposter_url" class="form-control" accept="image/*">
			<div class="form-text">새 파일을 선택하면 기존 이미지가 교체됩니다.</div>
		</div>

		<!-- 버튼 -->
		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-dark px-5">저장</button>
			<a href="../admin/goods_view.do?no=${vo.goods_no}" class="btn btn-outline-secondary px-5">취소</a>
		</div>

	</form>
</body>
</html>
