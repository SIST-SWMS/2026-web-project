<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            
            <button type="button" class="like-btn" style="border:none; background:none;">
			    <c:choose>
			        
			        <c:when test="${vo.like_count > 0}">
			            <svg width="18" height="18" viewBox="0 0 24 24" fill="red">
			                <use xlink:href="#heart-fill"></use>
			            </svg>
			        </c:when>
			        <c:otherwise>
			            <svg width="18" height="18" viewBox="0 0 24 24">
			                <use xlink:href="#heart-empty"></use>
			            </svg>
			        </c:otherwise>
			    </c:choose>
			</button>
			
            <div class="product-brand">${vo.brand_name}</div>
            <div class="product-name">${vo.goods_name}</div>
            <!-- 가격 -->
                <c:set var="removeComma" value="${fn:replace(vo.goods_price, ',', '')}" />
				<c:set var="purePrice" value="${fn:replace(removeComma, '원', '')}" />
				
				<c:set var="calcPrice" value="${purePrice - (purePrice * vo.goods_discount / 100)}" />
				
				<div class="product-price">
				    <%-- 할인 후 가격 --%>
				    <span class="text-dark fw-bold"><fmt:formatNumber value="${calcPrice}" pattern="#,###" />원</span>
				    
				    <%--  할인 전 가격 --%>
				    <del class="text-body-secondary ms-1" style="font-size: 0.85em;"><fmt:formatNumber value="${purePrice}" pattern="#,###" />원</del>
				    
				    <%-- 할인율 --%>
				    <span class="text-danger ms-1 fw-bold">-${vo.goods_discount}%</span>
				</div>
            <div class="product-meta">
                <svg width="12" height="12" viewBox="0 0 24 24">
                <use xlink:href="#heart"></use>
                </svg>
                ${vo.like_count}
                <svg width="12" height="12" viewBox="0 0 12 12">
                <use xlink:href="#eye"></use>
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