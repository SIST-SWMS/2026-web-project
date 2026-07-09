<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">

		<!-- 카드 1 -->
		<c:forEach var="vo" items="${list }">
		<div class="col">
			<div class="product-card">
				<a href="../goods/detail.do">
					<div class="thumb-box">
						<img src="${vo.poster_url }" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</button>
				<div class="product-brand">${vo.brand_name }</div>
				<div class="product-name">${vo.goods_name }</div>
				<div class="product-price">${vo.goods_price }</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
					<use xlink:href="#heart"></use>
					</svg>
					${vo.like_count}<!-- 좋아요 들어갈 자리 -->
					<svg width="12" height="12" viewBox="0 0 12 12">
					<use xlink:href="#star-solid"></use>
					</svg>
					${vo.hit}<!-- 조회수 들어갈 자리 -->
				</div>
			</div>
		</div>
		</c:forEach>
		</div>
</body>
</html>