<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.mypage-menu-title {
	font-weight: 700;
	margin-top: 24px;
	margin-bottom: 8px;
}

.mypage-menu a {
	display: block;
	padding: 6px 0;
	color: #666;
	text-decoration: none;
	font-size: 15px;
}

.mypage-menu a:hover {
	color: #000;
}

.mypage-nickname {
	font-size: 28px;
	font-weight: 700;
}
</style>
</head>
<body>
	<c:if test="${empty mypage_content}">
		<c:set var="mypage_content" value="../mypage/mypage_main.jsp" />
	</c:if>

	<section class="py-5">
		<div class="container-fluid">
			<div class="row">

				<div class="col-lg-2">
					<div class="mypage-nickname mb-4">${name }님</div>

					<nav class="mypage-menu">
						<div class="mypage-menu-title">나의 쇼핑정보</div>
						<a href="../mypage/orderList.do">주문 내역</a> <a
							href="../mypage/claimList.do">취소/교환/반품 내역</a> <a
							href="../mypage/reviewList.do">Review 작성</a> <a
							href="../mypage/qnaList.do">1:1 문의</a> <a
							href="../mypage/recent.do">최근 본 상품</a>

						<div class="mypage-menu-title">나의 계정정보</div>
						<a href="../member/detail.do">회원정보수정</a>
					</nav>
				</div>

				<div class="col-lg-10">
					<jsp:include page="${mypage_content}"></jsp:include>
				</div>

			</div>
		</div>
	</section>
</body>
</html>