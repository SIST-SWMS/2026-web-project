<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 상품 등록 --%>
<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 등록</h4>

<%-- 이미지 업로드가 있으므로 enctype 필수 --%>
<form id="productForm" action="product_save.do" method="post" enctype="multipart/form-data" style="max-width: 760px;">

  <!-- 카테고리 -->
  <div class="mb-3">
    <label class="form-label fw-bold">카테고리 <span class="text-danger">*</span></label>
    <select name="category" class="form-select" required>
      <option value="">선택하세요</option>
      <option value="스니커즈">스니커즈</option>
      <option value="스포츠">스포츠</option>
      <option value="구두">구두</option>
      <option value="샌들">샌들</option>
      <option value="부츠">부츠</option>
    </select>
  </div>

  <!-- 브랜드 -->
  <div class="mb-3">
    <label class="form-label fw-bold">브랜드 <span class="text-danger">*</span></label>
    <select name="brand" class="form-select" required>
      <option value="">선택하세요</option>
      <option value="나이키">나이키</option>
      <option value="아디다스">아디다스</option>
      <option value="뉴발란스">뉴발란스</option>
      <option value="닥터마틴">닥터마틴</option>
      <option value="킨">킨</option>
    </select>
  </div>

  <!-- 상품코드 -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품코드 <span class="text-danger">*</span></label>
    <input type="text" name="productCode" class="form-control" placeholder="예: SHOE-1001" required>
  </div>

  <!-- 상품명 -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품명 <span class="text-danger">*</span></label>
    <input type="text" name="productName" class="form-control" required>
  </div>

  <div class="row">
    <!-- 가격 -->
    <div class="col-md-6 mb-3">
      <label class="form-label fw-bold">가격 <span class="text-danger">*</span></label>
      <div class="input-group">
        <input type="number" name="price" class="form-control" min="0" required>
        <span class="input-group-text">원</span>
      </div>
    </div>

    <!-- 할인율 -->
    <div class="col-md-6 mb-3">
      <label class="form-label fw-bold">할인율</label>
      <div class="input-group">
        <input type="number" name="discount" class="form-control" min="0" max="100" value="0">
        <span class="input-group-text">%</span>
      </div>
    </div>
  </div>

  <!-- 상품 이미지 -->
  <div class="mb-3">
    <label class="form-label fw-bold">상품 이미지</label>
    <input type="file" name="image" class="form-control" accept="image/*">
  </div>

  <!-- 상세 이미지 -->
  <div class="mb-4">
    <label class="form-label fw-bold">상세 이미지</label>
    <input type="file" name="detailImage" class="form-control" accept="image/*">
  </div>

  <!-- ===================== 사이즈별 초기 재고 ===================== -->
  <div class="border rounded-4 p-4 mb-4 bg-light">
    <div class="fw-bold mb-3">사이즈별 초기 재고</div>
    <div class="form-text mb-3">체크한 사이즈마다 재고 행이 생성됩니다. (초기 수량 0)</div>
    <div class="d-flex flex-wrap gap-3">
      <%-- 230 ~ 290 사이즈 체크박스 --%>
      <c:forEach var="sz" begin="230" end="290" step="10">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="sizes" value="${sz}" id="size${sz}">
          <label class="form-check-label" for="size${sz}">${sz}</label>
        </div>
      </c:forEach>
    </div>
  </div>

  <!-- 버튼 -->
  <div class="d-flex gap-2">
    <button type="submit" class="btn btn-dark px-5">저장</button>
    <a href="product_list.do" class="btn btn-outline-secondary px-5">취소</a>
  </div>

</form>
