<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section>
	<div>
		<div class="slideshow slide-in arrow-absolute text-white"
			style="height: 70vh;">
			<div class="swiper-wrapper">
			
				<div class="swiper-slide jarallax swiper-slide-next" style="cursor: pointer;" onclick="location.href='../goods/list.do?cno=3'">

					<!-- <img src="../resources/images/slide-2.jpg" class="jarallax-img"
						alt="slideshow"> -->
						<img src="../resources/images/DailyShose.gif" class="jarallax-img" alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up">Daily
										Shoes</h2>
								</div>
							</div>
						</div>
					</div>

				</div>
				<div class="swiper-slide jarallax swiper-slide-next" style="cursor: pointer;" onclick="location.href='../goods/list.do?cno=1'">
					<!-- <img src="../resources/images/slide-3.jpg" class="jarallax-img"
						alt="slideshow"> -->
					<img src="../resources/images/sportCollection.avif" class="jarallax-img" alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up"> Sports
										Collection</h2>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="swiper-slide jarallax swiper-slide-next" style="cursor: pointer;" onclick="location.href='../goods/list.do?cno=2'">

					<!-- <img src="../resources/images/slide-4.jpg" class="jarallax-img"
						alt="slideshow"> -->
					<img src="../resources/images/ClearenceSale.avif" class="jarallax-img" alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up">Clearance
										Sale</h2>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
			<div class="pagination-wrapper position-absolute">
				<div class="container">
					<div class="slideshow-swiper-pagination text-center"></div>
				</div>
			</div>
			<div class="icon-arrow icon-arrow-left text-white">
				<svg width="50" height="50" viewBox="0 0 24 24">
            <use xlink:href="#arrow-left"></use>
          </svg>
			</div>
			<div class="icon-arrow icon-arrow-right text-white">
				<svg width="50" height="50" viewBox="0 0 24 24">
            <use xlink:href="#arrow-right"></use>
          </svg>
			</div>

		</div>
	</div>
</section>

<section class="features"
	style="position: relative; margin-top: -100px; z-index: 2;">
	<div class="container-lg">
		<div class="bg-white p-5">
			<div class="row">
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#cart"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Pick up in
								store</h4>
							<!-- <p>Order online and collect your items at your nearest store for free.</p> -->
							<p>온라인으로 주문하고 가까운 매장에서 무료로 수령하세요.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#gift"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Special
								packaging</h4>
							<!-- <p>Every order is carefully packed with our premium, signature materials.</p> -->
							<p>모든 주문은 당사의 프리미엄 시그니처 소재로 정성껏 포장됩니다.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#love"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Free global
								returns</h4>
							<!-- <p>Enjoy hassle-free shopping with free returns from anywhere in the world.</p> -->
							<p>전 세계 어디서나 무료 반품으로 번거로움 없는 쇼핑을 즐기세요.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="py-5">
	<div class="container-fluid">
		
		<div class="row">
		<h3>인기 상품</h3>
			<div class="col-md-12">
				<div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">
			    <c:forEach var="vo" items="${gList}">
			        <div class="col">
			            <div class="product-item">
			                <%-- 할인이 있을 때만 할인율 표시 --%>
			                <c:if test="${vo.goods_discount > 0}">
			                    <span class="badge bg-success position-absolute m-3">-${vo.goods_discount}%</span>
			                </c:if>
			                
			                <figure>
			                    <a href="../goods/detail.do?goods_no=${vo.goods_no}" title="${vo.goods_name}"> 
			                        <img src="${vo.poster_url}" alt="${vo.goods_name}" class="img-fluid">
			                    </a>
			                </figure>
			                
							<span class="d-block text-truncate pb-1" title="${vo.goods_name}">${vo.goods_name}</span>
			                
			                <div class="d-flex justify-content-between align-items-center mt-2">
			                   <!-- 가격 -->
			                    <c:set var="removeComma" value="${fn:replace(vo.goods_price, ',', '')}" />
								<c:set var="purePrice" value="${fn:replace(removeComma, '원', '')}" />
								
								<%-- 할인된 가격  --%>
								<c:set var="calcPrice" value="${purePrice - (purePrice * vo.goods_discount / 100)}" />
								
								<p class="mb-0"> 
								    <%-- 할인 후 가격  --%>
								    <span class="text-dark fw-bold"><fmt:formatNumber value="${calcPrice}" pattern="#,###" />원</span>
								    
								    <%-- 할인 전 가격  --%>
								    <del class="text-body-secondary ms-1" style="font-size: 0.85em;"><fmt:formatNumber value="${purePrice}" pattern="#,###" />원</del>
								    
								    <%-- 할인율 --%>
								    <span class="text-danger ms-1 fw-bold">-${vo.goods_discount}%</span>
								</p>
			                    
			                    <span class="d-flex"> 
			                        <svg width="18" height="18" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
			                        <svg width="18" height="18" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
			                        <svg width="18" height="18" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
			                        <svg width="18" height="18" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
			                        <svg width="18" height="18" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
			                    </span>
			                </div>
			            </div>
			        </div>
			    </c:forEach>
			</div>
			</div>
		</div>
	</div>
</section>

</body>
</html>