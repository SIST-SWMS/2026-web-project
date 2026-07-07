<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- *****커밋 테스트***** --%>
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
	<%-- 우측 콘텐츠 기본값 지정: Controller에서 mypage_content 를 바꿔주면 우측 화면만 교체됨 --%>
	<c:if test="${empty mypage_content}">
		<c:set var="goods_content" value="../goods/goods_main.jsp" />
	</c:if>

	<section class="py-5">
		<div class="container-fluid">
			<div class="row">

				<!-- ================= 좌측 카테고리 사이드바 ================= -->
				<div class="col-lg-2">
					<h4 class="fw-bold border-bottom border-dark border-2 pb-3 mb-3">남성슈즈</h4>
					<nav class="category-menu">
						<a href="#" class="active">ALL</a> 
						<a href="#">스포츠화</a> 
						<a href="#">샌들/슬리퍼</a>
						<a href="#">라이프스타일</a> 
						<a href="#">구두</a> 
						<a href="#">부츠</a> 
					</nav>
					<h5 class="fw-bold border-top border-dark border-2 pt-3 mt-4">필터</h5>
				</div>
				<!-- ================= 우측 콘텐츠 (교체) ================= -->
				<div class="col-lg-10">
					<jsp:include page="${goods_content}"></jsp:include>
				</div>

			</div>
		</div>
	</section>
</body>
</html>