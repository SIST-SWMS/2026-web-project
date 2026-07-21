<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <c:forEach var="vo" items="${list }">
	<!-- 상품 정보 -->
	<div class="d-flex align-items-center gap-3 pb-4 border-bottom mb-4">
		<img src="../resources/images/${vo.goods.poster_url }" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div>
			<div class="fw-bold">${vo.goods.goods_name }</div>
			<!-- <div class="text-body-secondary small">송이송이 x 야세 고아웃 빈티지 스니커즈
				그레이</div> -->
			<!-- <div>
				<span class="text-danger fw-bold">15%</span> <span class="fw-bold">152,150원</span>
			</div> -->
		</div>
	</div>
	</c:forEach>

	<!-- 문의 유형 -->
	<form action="../mypage/qna_ok.do" method="post">
	<div class="mb-3">
		<label class="form-label fw-bold">문의 유형 <span
			class="text-danger">(필수)</span></label> 
			<select
			class="form-select form-select-lg">
			<option>선택해주세요</option>
			<option>상품 문의</option>
			<option>배송 문의</option>
			<option>재입고 문의</option>
			<option>기타 문의</option>
		</select>
		<div class="text-body-secondary small mt-1">교환/환불/취소 관련 문의는 1:1
			문의에서 등록해주세요.</div>
	</div>

	<!-- 문의 상품옵션 -->
	<div class="mb-3">
		<label class="form-label fw-bold">문의 상품옵션</label> <select
			class="form-select form-select-lg">
			<option>옵션을 선택해주세요</option>
			<option>[color]Grey [size]250mm</option>
			<option>[color]Grey [size]260mm</option>
			<option>[color]Grey [size]270mm</option>
		</select>
	</div>

	<!-- 제목 -->
	<div class="mb-2">
		<label class="form-label fw-bold">제목 <span class="text-danger">(필수)</span></label>
		<input type="text" class="form-control form-control-lg" maxlength="30"
			placeholder="30자 이내로 입력해주세요">
	</div>

	<!-- 비밀글 -->
	<div class="form-check mb-3">
		<input class="form-check-input" type="checkbox" id="secret"> <label
			class="form-check-label" for="secret">비밀글</label>
	</div>

	<!-- 내용 -->
	<div class="mb-4">
		<label class="form-label fw-bold">내용 <span class="text-danger">(필수)</span></label>
		<textarea class="form-control" rows="6" placeholder="문의할 내용을 입력해주세요"></textarea>
	</div>

	<!-- 버튼 -->
	<div class="d-flex gap-2">
		<a href="#" class="btn btn-outline-secondary btn-lg w-50">취소</a>
		<button type="button" class="btn btn-secondary btn-lg w-50">등록</button>		
	</div>
	</form>
</body>
</html>