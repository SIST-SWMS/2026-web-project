<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 상품 수정 (등록 폼과 동일 구성 + 기존값 채움) --%>
<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 수정</h4>

<form id="productEditForm" action="product_update.do" method="post" enctype="multipart/form-data" style="max-width: 760px;">

  <input type="hidden" name="productCode" value="${product.productCode}">

  <!-- 카테고리 -->
  <div class="mb-3">
    <label class="form-label fw-bold">카테고리 <span class="text-danger">*</span></label>
    <select name="category" class="form-select" required>
      <option value="스니커즈" ${product.category == '스니커즈' ? 'selected' : ''}>스니커즈</option>
      <option value="스포츠"   ${product.category == '스포츠'   ? 'selected' : ''}>스포츠</option>
      <option value="구두"     ${product.category == '구두'     ? 'selected' : ''}>구두</option>
      <option value="샌들"     ${product.category == '샌들'     ? 'selected' : ''}>샌들</option>
      <option value="부츠"     ${product.category == '부츠'     ? 'selected' : ''}>부츠</option>
    </select>
  </div>

  <!-- 브랜드 -->
  <div class="mb-3">
    <label class="form-label fw-bold">브랜드 <span class="text-danger">*</span></label>
    <select name="brand" class="form-select" required>
      <option value="나이키"   ${product.brand == '나이키'   ? 'selected' : ''}>나이키</option>
      <option value="아디다스" ${product.brand == '아디다스' ? 'selected' : ''}>아디다스</option>
      <option value="뉴발란스" ${product.brand == '뉴발란스' ? 'selected' : ''}>뉴발란스</option>
      <option value="닥터마틴" ${product.brand == '닥터마틴' ? 'selected' : ''}>닥터마틴</option>
      <option value="킨"       ${product.brand == '킨'       ? 'selected' : ''}>킨</option>
    </select>
  </div>

  <!-- 상품코드 (읽기 전용 - 식별자) -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품코드</label>
    <input type="text" class="form-control" value="${product.productCode}" readonly style="background:#f5f5f5;">
  </div>

  <!-- 상품명 -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품명 <span class="text-danger">*</span></label>
    <input type="text" name="productName" class="form-control" value="${product.productName}" required>
  </div>

  <div class="row">
    <div class="col-md-6 mb-3">
      <label class="form-label fw-bold">가격 <span class="text-danger">*</span></label>
      <div class="input-group">
        <input type="number" name="price" class="form-control" min="0" value="${product.price}" required>
        <span class="input-group-text">원</span>
      </div>
    </div>
    <div class="col-md-6 mb-3">
      <label class="form-label fw-bold">할인율</label>
      <div class="input-group">
        <input type="number" name="discount" class="form-control" min="0" max="100" value="${product.discount}">
        <span class="input-group-text">%</span>
      </div>
    </div>
  </div>

  <!-- 상품 이미지 (기존 미리보기 + 교체) -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품 이미지</label>
    <div class="mb-2">
      <img src="../resources/images/product-thumb-1.png" width="90" height="90"
        style="object-fit:cover;border-radius:6px;background:#f5f5f5;" alt="기존 이미지">
    </div>
    <input type="file" name="image" class="form-control" accept="image/*">
    <div class="form-text">새 파일을 선택하면 기존 이미지가 교체됩니다.</div>
  </div>

  <!-- 상세 이미지 (기존 미리보기 + 교체) -->
  <div class="mb-4">
    <label class="form-label fw-bold">상세 이미지</label>
    <div class="mb-2">
      <img src="../resources/images/product-thumb-1.png" width="90" height="90"
        style="object-fit:cover;border-radius:6px;background:#f5f5f5;" alt="기존 상세이미지">
    </div>
    <input type="file" name="detailImage" class="form-control" accept="image/*">
    <div class="form-text">새 파일을 선택하면 기존 이미지가 교체됩니다.</div>
  </div>

  <!-- 버튼 -->
  <div class="d-flex gap-2">
    <button type="submit" class="btn btn-dark px-5">저장</button>
    <a href="product_view.do?code=${product.productCode}" class="btn btn-outline-secondary px-5">취소</a>
  </div>

</form>
