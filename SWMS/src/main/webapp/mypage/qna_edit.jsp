<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">1:1
		문의 수정</h4>

   <form action="../mypage/qna_edit_ok.do" method="post">
    <input type="hidden" name="qna_no" value="${vo.qna_no}">
	<!-- 상품 정보 -->
	<div class="d-flex align-items-center gap-3 pb-4 border-bottom mb-4">
		<img src="../resources/images/${vo.goods.poster_url}" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div>
			<div class="fw-bold">${vo.goods.goods_name}</div>
			<%-- <div class="text-body-secondary small">${qna.productName}</div> --%>
		</div>
	</div>

	<!-- 문의 유형 (기존 값 selected) -->
	<div class="mb-3">
		<label class="form-label fw-bold">문의 유형 <span
			class="text-danger">(필수)</span></label> <select
			class="form-select form-select-lg" name="type">
			<option ${vo.type == '상품 문의'   ? 'selected' : ''}>상품 문의</option>
			<option ${vo.type == '배송 문의'   ? 'selected' : ''}>배송 문의</option>
			<option ${vo.type == '재입고 문의' ? 'selected' : ''}>재입고 문의</option>
			<option ${vo.type == '기타 문의'   ? 'selected' : ''}>기타 문의</option>
		</select>
	</div>

	<!-- 문의 상품옵션 (기존 값 selected) -->
	<div class="mb-3">
		<label class="form-label fw-bold">문의 상품옵션</label> 
		<select	class="form-select form-select-lg" name="option">
			<option ${qna.option == '[color]Grey [size]250mm' ? 'selected' : ''}>[color]Grey
				[size]250mm</option>
			<option ${qna.option == '[color]Grey [size]260mm' ? 'selected' : ''}>[color]Grey
				[size]260mm</option>
			<option ${qna.option == '[color]Grey [size]270mm' ? 'selected' : ''}>[color]Grey
				[size]270mm</option>
		</select>
	</div>

	<!-- 제목 (기존 값 바인딩) -->
	<div class="mb-2">
		<label class="form-label fw-bold">제목 <span class="text-danger">(필수)</span></label>
		<input type="text" class="form-control form-control-lg" name="title"
			maxlength="30" value="${vo.subject}">
	</div>

	<!-- 비밀글 (기존 값 checked) -->
	<div class="form-check mb-3">
		<input class="form-check-input" type="checkbox" id="secret"
			name="secret" ${vo.is_secret == 'Y' ? 'checked' : ''}> <label
			class="form-check-label" for="secret">비밀글</label>
	</div>

	<!-- 내용 (기존 값 바인딩) -->
	<div class="mb-4">
		<label class="form-label fw-bold">내용 <span class="text-danger">(필수)</span></label>
		<textarea class="form-control" name="content" rows="6">${vo.content}</textarea>
	</div>

	<!-- 버튼 -->
	<div class="d-flex gap-2">
		<a href="#" class="btn btn-outline-secondary btn-lg w-50" onclick="javascript:history.back()">취소</a>
		<button type="submit" class="btn btn-dark btn-lg w-50">수정 완료</button>
	</div>
	</form>
</body>
</html>