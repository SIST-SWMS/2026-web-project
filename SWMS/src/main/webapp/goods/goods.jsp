<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- *****커밋 테스트***** --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.category-sidebar-menu a {
	display: block;
	padding: 6px 0;
	color: #666;
	text-decoration: none;
	font-size: 15px;
}

.category-sidebar-menu a:hover {
	color: #000;
}

.category-sidebar-menu a.active {
	color: #000;          
	font-weight: 800;    
}
</style>

<script>
$(function() {
    $('.category-menu .category-btn').on('click', function(e) {
        e.preventDefault(); 
        
        $('.category-menu .category-btn').removeClass('active');
        
        $(this).addClass('active');
    });
});
</script>
</head>
<body>
	<c:if test="${empty goods_content}">
		<c:set var="goods_content" value="../goods/goods_main.jsp" />
	</c:if>

	<section class="py-5">
		<div class="container-fluid">
			<div class="row">

				<div class="col-lg-2">
					<h4 class="fw-bold border-bottom border-dark border-2 pb-3 mb-3">신발 카테고리</h4>
					
					<nav class="category-sidebar-menu category-menu">
						<a href="#" class="category-btn active" data-cno="0">ALL</a> 
						<a href="#" class="category-btn" data-cno="1">스포츠화</a> 
						<a href="#" class="category-btn" data-cno="2">샌들/슬리퍼</a>
						<a href="#" class="category-btn" data-cno="3">라이프스타일</a> 
						<a href="#" class="category-btn" data-cno="4">구두</a> 
						<a href="#" class="category-btn" data-cno="5">부츠</a> 
					</nav>
					
					<h5 class="fw-bold border-top border-dark border-2 pt-3 mt-4">필터</h5>
				</div>
                
				<div class="col-lg-10">
					<jsp:include page="${goods_content}"></jsp:include>
				</div>

			</div>
		</div>
	</section>
</body>
</html>