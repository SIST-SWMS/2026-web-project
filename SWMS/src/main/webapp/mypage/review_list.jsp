<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 리뷰</h4>

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-2.png" width="70" height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">(7차) Cation Cotton Vest _ 2 colors</div>
			<div class="text-body-secondary small">2026.05.14 구매 · 배송완료</div>
		</div>
		<c:choose>
	    <c:when test="">
	        <a href="../mypage/review_view.do?no=1" class="btn btn-dark view">리뷰 보기</a>
	    </c:when>
	    <c:otherwise>
	        <a href="../mypage/review.do?no=1" class="btn btn-dark write">리뷰 쓰기</a>
	    </c:otherwise>
	    </c:choose>
	</div>

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-3.png" width="70" height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">클래식 데님_light indigo</div>
			<div class="text-body-secondary small">2026.05.14 구매 · 배송완료</div>
		</div>
		<a href="../mypage/review.do?no=2" class="btn btn-dark">리뷰 쓰기</a>
	</div>

	<div class="d-flex align-items-center gap-3 py-3 border-bottom">
		<img src="../resources/images/product-thumb-4.png" width="70" height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div class="flex-grow-1">
			<div class="fw-bold">릴리프 스티치 백팩 M_3Color/ 도난방지 RFID차단 여행가방</div>
			<div class="text-body-secondary small">2026.04.21 구매 · 배송완료</div>
		</div>
		<a href="../mypage/review.do?no=3" class="btn btn-dark">리뷰 쓰기</a>
	</div>
</body>
</html>