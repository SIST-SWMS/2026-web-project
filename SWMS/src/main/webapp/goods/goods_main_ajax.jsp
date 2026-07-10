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
    <c:forEach var="vo" items="${list}">
    <div class="col">
        <div class="product-card">
            <a href="../goods/detail.do?goods_no=${vo.goods_no}">
                <div class="thumb-box">
                    <img src="${vo.poster_url}" alt="${vo.goods_name}">
                </div>
            </a>
            <button type="button" class="like-btn">
                <svg width="18" height="18" viewBox="0 0 24 24">
                    <use xlink:href="#heart"></use>
                </svg>
            </button>
            <div class="product-brand">${vo.brand_name}</div>
            <div class="product-name">${vo.goods_name}</div>
            <div class="product-price">${vo.goods_price}</div>
            <div class="product-meta">
                <svg width="12" height="12" viewBox="0 0 24 24">
                <use xlink:href="#heart"></use>
                </svg>
                ${vo.like_count}
                <svg width="12" height="12" viewBox="0 0 12 12">
                <use xlink:href="#star-solid"></use>
                </svg>
                ${vo.hit}
            </div>
        </div>
    </div>
    </c:forEach>
</div>

<div class="row text-center" style="margin-top: 40px">
    <div class="d-flex justify-content-center">
        <ul class="pagination">
            
            <c:if test="${startPage > 1}">
                <li><a href="#" class="page-link-btn" data-page="${startPage - 1}">&laquo;</a></li>
            </c:if>
            
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li ${i == curPage ? "class='active'" : ""}>
                    <a href="#" class="page-link-btn" data-page="${i}">${i}</a>
                </li>
            </c:forEach>
            
            <c:if test="${endPage < totalPage}">
                <li><a href="#" class="page-link-btn" data-page="${endPage + 1}">&raquo;</a></li>
            </c:if>
            
        </ul>
    </div>
</div>
</body>
</html>