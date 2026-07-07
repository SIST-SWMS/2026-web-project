<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div
		class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-3">
		<h4 class="fw-bold mb-0">주문 상세</h4>
		<a href="../mypage/orderList.do" class="btn btn-outline-secondary">목록으로</a>
	</div>

	<%-- 전체 상품 구매일시 --%>
	<div class="text-body-secondary mb-4">주문일시: ${order.orderDate} ·
		주문번호: ${order.orderNo}</div>

	<%-- 주문 상품 목록 (한 번에 구매한 아이템들) --%>
	<%-- 아이템 1건 = 아래 div 하나. <c:forEach var="item" items="${order.itemList}"> 로 반복 --%>
	<!-- <c:forEach var="item" items="${order.itemList}"> -->
	<div class="d-flex gap-3 py-4 border-bottom">
		<img src="../resources/images/product-thumb-1.png" width="90"
			height="90"
			style="object-fit: cover; border-radius: 8px; background: #f5f5f5;"
			alt="상품">
		<div class="flex-grow-1">
			<div class="text-body-secondary small">스트라이커</div>
			<%-- 상품명 클릭 시 상품 상세로 이동 --%>
			<a href="../main/product.do?no=1"
				class="fw-bold text-dark text-decoration-none">스트라이커
				(Z1)_Black_DUS25N73Z1</a>
			<div class="fw-bold mt-1">84,150원</div>

			<%-- 배송현황 (단순 텍스트) --%>
			<div class="mt-2">
				<span class="text-primary fw-bold">배송중</span>
			</div>

			<%-- 배송현황별 버튼 분기 --%>
			<div class="mt-3 d-flex gap-2">
				<%-- 배송중 = 취소 --%>
				<c:if test="${item.status == '배송중'}">
					<a href="#" class="btn btn-outline-danger">취소</a>
				</c:if>
				<%-- 배송완료 = 환불 + 구매확정 --%>
				<c:if test="${item.status == '배송완료'}">
					<a href="#" class="btn btn-outline-danger">환불</a>
					<a href="#" class="btn btn-dark">구매확정</a>
				</c:if>
				<%-- 구매확정 = 리뷰작성 --%>
				<c:if test="${item.status == '구매확정'}">
					<a href="#" class="btn btn-dark">리뷰작성</a>
				</c:if>
			</div>
		</div>
	</div>
	<!-- </c:forEach> -->

	<div class="d-flex gap-3 py-4 border-bottom">
		<img src="../resources/images/product-thumb-2.png" width="90"
			height="90"
			style="object-fit: cover; border-radius: 8px; background: #f5f5f5;"
			alt="상품">
		<div class="flex-grow-1">
			<div class="text-body-secondary small">카린</div>
			<a href="../main/product.do?no=2"
				class="fw-bold text-dark text-decoration-none">로엔S C1</a>
			<div class="fw-bold mt-1">192,018원</div>
			<div class="mt-2">
				<span class="text-success fw-bold">배송완료</span>
			</div>
			<div class="mt-3 d-flex gap-2">
				<a href="#" class="btn btn-outline-danger">환불요청</a> 
				<a href="#" class="btn btn-dark">구매확정</a>
			</div>
		</div>
	</div>

	<div class="d-flex gap-3 py-4 border-bottom">
		<img src="../resources/images/product-thumb-3.png" width="90"
			height="90"
			style="object-fit: cover; border-radius: 8px; background: #f5f5f5;"
			alt="상품">
		<div class="flex-grow-1">
			<div class="text-body-secondary small">아치스</div>
			<a href="../main/product.do?no=3"
				class="fw-bold text-dark text-decoration-none">[ARCHIES] 아치스_블랙</a>
			<div class="fw-bold mt-1">49,900원</div>
			<div class="mt-2">
				<span class="text-dark fw-bold">구매확정</span>
			</div>
			<div class="mt-3 d-flex gap-2">
				<a href="#" class="btn btn-dark">리뷰작성</a>
			</div>
		</div>
	</div>

	<%-- 결제 요약 --%>
	<div class="d-flex justify-content-end mt-4">
		<div class="text-end">
			<span class="text-body-secondary me-3">총 결제금액</span> <span
				class="fw-bold fs-4">326,068원</span>
		</div>
	</div>
</body>
</html>