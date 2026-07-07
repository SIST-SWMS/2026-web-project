<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 리뷰</h4>

	<%-- 상품 1건 = 아래 div 하나. <c:forEach var="item" items="${reviewableList}"> 로 반복 --%>
	<!-- <c:forEach var="item" items="${reviewableList}"> -->
	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-1.png" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">스트라이커 (Z1)_Black_DUS25N73Z1</div>
			<div class="text-body-secondary small">2026.07.05 구매 · 배송완료</div>
		</div>
		<a href="#" class="btn btn-dark">리뷰 쓰기</a>
	</div>
	<!-- </c:forEach> -->

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-2.png" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">(7차) Cation Cotton Vest _ 2 colors</div>
			<div class="text-body-secondary small">2026.05.14 구매 · 배송완료</div>
		</div>
		<a href="#" class="btn btn-dark">리뷰 쓰기</a>
	</div>

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-3.png" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">클래식 데님_light indigo</div>
			<div class="text-body-secondary small">2026.05.14 구매 · 배송완료</div>
		</div>
		<a href="#" class="btn btn-dark">리뷰 쓰기</a>
	</div>

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-4.png" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">릴리프 스티치 백팩 M_3Color/ 도난방지 RFID차단 여행가방</div>
			<div class="text-body-secondary small">2026.04.21 구매 · 배송완료</div>
		</div>
		<a href="#" class="btn btn-dark">리뷰 쓰기</a>
	</div>
</body>
</html>