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
<%-- 상세 페이지 전용 스타일 --%>
<style>
.size-btn.active {
	background: #000;
	color: #fff;
}

.thumb.active {
	border-color: #000 !important;
}

</style>

<%-- 상세 페이지 전용 스크립트 (썸네일 전환 / 사이즈 선택 / 수량 조절) --%>
<script>
$(function() {
	document.querySelectorAll('.thumb').forEach(function(t) {
		t.addEventListener('click', function() {
			document.getElementById('mainImage').src = this.src;
			document.querySelectorAll('.thumb').forEach(function(x) {
				x.classList.remove('active');
			});
			this.classList.add('active');
		});
	});
	document.querySelectorAll('.size-btn').forEach(function(b) {
		b.addEventListener('click', function() {
			document.querySelectorAll('.size-btn').forEach(function(x) {
				x.classList.remove('active');
			});
			this.classList.add('active');
		});
	});
	let qty = document.getElementById('qtyInput');
	document.getElementById('qtyPlus').addEventListener('click', function() {
		qty.value = parseInt(qty.value) + 1;
	});
	document.getElementById('qtyMinus').addEventListener('click', function() {
		if (parseInt(qty.value) > 1)
			qty.value = parseInt(qty.value) - 1;
	});
	

	    $('#likeOn').on('click', function() {
	        let gno=$(this).attr('data-no');
	        location.href = "../like/likeOn.do?goods_no="+gno;
	    });

	    $('#likeOff').on('click', function() {
	        let gno=$(this).attr('data-no');
	        location.href = "../like/likeOff.do?goods_no="+gno;
	    });
	    
		$('#cartBtn').on('click', function() {
			let gno = $(this).attr('data-no');
			
			let selectedSizeBtn=$('.size-btn.active');
			if(selectedSizeBtn.length===0) {
				alert("상품 사이즈를 먼저 선택해주세요.");
				return;
			}
			let size=selectedSizeBtn.text().trim(); 
			
			let qty=$('#qtyInput').val(); 
			
			$.ajax({
				type: 'post',
				url: '../goods/cart_insert.do',
				data: {
					goods_no: gno,
					sizes: size,
					quantity: qty
				},
				success: function(res) {
					let result=res.trim(); 
					
					if(result==='NO_LOGIN') {
						alert("로그인이 필요한 서비스입니다.");
						location.href = "../member/login.do"; 
						
					} else if(result==='NO_STOCK_DATA') {
						alert("죄송합니다. 해당 사이즈의 상품 정보가 존재하지 않습니다");
						
					} else if(result==='OUT_OF_STOCK') {
						alert("죄송합니다. 선택하신 제품의 재고가 부족합니다.");
						
					} else if(result==='SUCCESS') {
						alert("장바구니에 상품이 담겼습니다. 장바구니로 이동합니다.");
						location.href = "../cart/cart.do"; 
					} 
				},
				error: function(err) {
					console.log(err);
					alert("서버에러가 발생했습니다.");
				}
			});
		});
		
		$('#buyBtn').on('click', function() {
			
			let gno = '${vo.goods_no}';
			console.log("다이렉트 상품번호: ", gno);
			
			let selectedSizeBtn = $('.size-btn.active');
			
			if(selectedSizeBtn.length === 0) {
				alert("상품 사이즈를 먼저 선택해주세요.");
				return;
			}
			
			let size = selectedSizeBtn.text().trim();
			let qty = $('#qtyInput').val();

			$.ajax({
				type: 'post',
				url: '../goods/getStockNo.do',
				data: {
					goods_no: gno,
					goods_size: size
				},
				success: function(res) {
					let stock_no = res.trim();
					console.log("서버에서 받은 재고번호: ", stock_no);
					
					if(stock_no === '' || stock_no === '0') {
						alert("죄송합니다. 해당 사이즈의 재고 정보가 존재하지 않습니다.");
						return;
					}
					
					location.href = "../order/order.do?stock_no=" + stock_no + "&quantity=" + qty;
				},
				error: function(err) {
					console.log(err);
					alert("서버 통신 중 에러가 발생했습니다.");
				}
			});
		});
		/* http://localhost/SWMS/order/order.do?stock_no=41&quantity=1 */
	});
</script>
</head>
<body>

	<!-- Breadcrumb -->
	<div class="container-fluid mt-4">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="main.do"
					class="text-decoration-none text-dark">홈</a></li>
				<li class="breadcrumb-item"><a href="index.html#men"
					class="text-decoration-none text-dark">${vo.category_name}</a></li>
				<li class="breadcrumb-item active" aria-current="page">${vo.goods_name}</li>
			</ol>
		</nav>
	</div>

	<!-- Product Detail -->
	<section class="py-4">
		<div class="container-fluid">
			<div class="row g-5">

				<!-- Gallery -->
				<div class="col-lg-6">
					<div class="border rounded-4 p-3 bg-light text-center mb-3">
						<c:choose>
							<c:when test="${fn:startsWith(vo.poster_url, 'http')}">
								<img id="mainImage" src="${vo.poster_url }" alt="상품 이미지" class="img-fluid" style="max-height: 460px; object-fit: contain;">
							</c:when>
							<c:otherwise>
								<img id="mainImage" src="/SWMS/uploads/${vo.poster_url}" alt="상품 이미지" class="img-fluid" style="max-height: 460px; object-fit: contain;">
							</c:otherwise>
						</c:choose>
					</div> 
				</div>

				<!-- Info -->
				<div class="col-lg-6">
					<span class="badge bg-success mb-2">${vo.goods_discount }% 할인</span>
					<h2 class="fw-bold">${vo.goods_name }</h2>
					<div class="d-flex align-items-center gap-2 my-2">
					    <c:set var="topTotalHit" value="0" />
					    <c:set var="topTotalCount" value="0" />
					    
					    <c:forEach var="rvo" items="${rList}">
					        <c:set var="topTotalHit" value="${topTotalHit + rvo.hit}" />
					        <c:set var="topTotalCount" value="${topTotalCount + 1}" />
					    </c:forEach>
					    
					    <c:set var="topAvgScore" value="0" />
					    <c:if test="${topTotalCount > 0}">
					        <c:set var="topAvgScore" value="${topTotalHit / topTotalCount}" />
					    </c:if>
					    <c:choose>
					        <c:when test="${0 < topAvgScore && topAvgScore <= 1}">
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg>
					            </span>
					        </c:when>
					        <c:when test="${1 < topAvgScore && topAvgScore <= 2}">
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg>
					            </span>
					        </c:when>
					        <c:when test="${2 < topAvgScore && topAvgScore <= 3}">
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg>
					            </span>
					        </c:when>
					        <c:when test="${3 < topAvgScore && topAvgScore <= 4}">
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg>
					            </span>
					        </c:when>
					        <c:when test="${4 < topAvgScore && topAvgScore <= 5}">
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-solid"></use></svg>
					            </span>
					        </c:when>
					        <%-- 리뷰가 0개일 때 (기본 빈 별 5개 노출) --%>
					        <c:otherwise>
					            <span class="d-inline-flex"> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg> 
					                <svg width="20" height="20" class="text-warning"><use xlink:href="#star-outline"></use></svg>
					            </span>
					        </c:otherwise>
					    </c:choose>
					    
					</div>
					<!-- 가격  -->
					<c:set var="removeComma" value="${fn:replace(vo.goods_price, ',', '')}" />
					<c:set var="purePrice" value="${fn:replace(removeComma, '원', '')}" />
					
					
					<c:set var="calcPrice" value="${purePrice - (purePrice * vo.goods_discount / 100)}" />
					
					<div class="my-3">
					    <!-- 할인 후 가격 -->
					    <span class="fs-3 fw-bold text-dark">
					        ₩ <fmt:formatNumber value="${calcPrice}" pattern="#,###" />
					    </span>
					    
					    <!-- 할인 전 기본 가격  -->
					    <del class="text-body-secondary ms-2">
					        ₩ <fmt:formatNumber value="${purePrice}" pattern="#,###" />
					    </del>
					    
					    <!-- 할인률 -->
					    <span class="text-success ms-2 fw-bold">- ${vo.goods_discount} %</span>
					</div>

					<p class="text-body-secondary">배송비 무료</p>
					
					<!-- 사이즈 -->
					<div class="my-4">
					    <label class="fw-bold d-block mb-2">사이즈</label>
					    
					    <div class="d-flex flex-wrap gap-2" id="sizeGroup">
					        <c:set var="allSizes" value="230,240,250,260,270,280" />
					        
					        <c:forEach var="size" items="${allSizes}">
					            
					            <c:set var="hasStock" value="false" />
					            <c:forEach var="svo" items="${stockList}">
					                <c:if test="${svo.goods_size == size && svo.quantity > 0}">
					                    <c:set var="hasStock" value="true" />
					                </c:if>
					            </c:forEach>
					            <c:choose>
					                <c:when test="${hasStock}">
					                    <button type="button" class="btn btn-outline-dark size-btn">${size}</button>
					                </c:when>
					                <c:otherwise>
					                    <button type="button" class="btn btn-outline-secondary size-btn opacity-50" disabled style="cursor: not-allowed;">
					                        ${size}
					                    </button>
					                </c:otherwise>
					            </c:choose>
					            
					        </c:forEach>
					    </div>
					</div>

					<!-- 수량 -->
					<div class="my-4">
						<label class="fw-bold d-block mb-2">수량</label>
						<div class="input-group" style="max-width: 150px;">
							<button class="btn btn-outline-dark" type="button" id="qtyMinus">
								<svg width="18" height="18">
									<use xlink:href="#minus"></use></svg>
							</button>
							<input type="text" class="form-control text-center" id="qtyInput"
								value="1" readonly>
							<button class="btn btn-outline-dark" type="button" id="qtyPlus">
								<svg width="18" height="18">
									<use xlink:href="#plus"></use></svg>
							</button>
						</div>
					</div>

					<!-- CTA -->
					<div class="d-flex flex-wrap gap-2 my-4">
						<button class="btn btn-primary btn-lg px-4" id="cartBtn" data-no="${vo.goods_no}">
   							장바구니 담기 
   						</button>
   							
						<!--바로구매 버튼으로 수정 -->
						<button type="button" class="btn btn-dark btn-lg px-4" id="buyBtn" data-no="${svo.stock_no}">
    						바로 구매
						</button> 
						<c:if test="${check==0}">
						    <button class="btn btn-outline-dark btn-lg" id="likeOn" data-no="${vo.goods_no}">
						        <svg width="22" height="22">
						            <use xlink:href="#heart-empty"></use> 
						        </svg>
						        <span class="ms-2">${like_count}</span>
						    </button>
						</c:if>
						<c:if test="${check==1}">
						    <button class="btn btn-danger btn-lg" id="likeOff" data-no="${vo.goods_no}">
						        <svg width="22" height="22" fill="white">
						            <use xlink:href="#heart-fill"></use> 
						        </svg>
						        <span class="ms-2">${like_count}</span>
						    </button>
						</c:if>
					</div>

					<ul class="list-unstyled text-body-secondary small border-top pt-3">
						<li class="mb-1">• 무료 배송 (3만원 이상 구매 시)</li>
						<li class="mb-1">• 7일 이내 무료 반품</li>
						<li class="mb-1">• 정품 인증 상품</li>
					</ul>
				</div>
			</div>

			<!-- Tabs -->
			<div class="row mt-5">
				<div class="col-12 text-center">
					<h5 class="fw-bold mb-4 text-start">상품 상세 이미지</h5>
					<c:choose>
						<c:when test="${fn:startsWith(vo.subposter_url, 'http')}">
							<img src="${vo.subposter_url}" class="img-fluid w-100" alt="상품 상세설명">
						</c:when>
						<c:otherwise>
							<img src="/SWMS/uploads/${vo.subposter_url}" class="img-fluid w-100" alt="상품 상세설명">
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="row mt-5">
				<div class="col-12">
					<ul class="nav nav-tabs" id="pTab" role="tablist">
						<li class="nav-item"><button class="nav-link active"
								data-bs-toggle="tab" data-bs-target="#desc" type="button">상품 리뷰</button></li>
						<li class="nav-item"><button class="nav-link"
								data-bs-toggle="tab" data-bs-target="#qna" type="button">상품문의</button></li>
					</ul>
			<div class="tab-content border border-top-0 p-4 rounded-bottom">
				<div class="tab-pane fade show active" id="desc">
							<div class="row mt-5" id="reviewArea">
				<div class="col-12">

					<h4 class="fw-bold mb-4">상품 리뷰</h4>

					<!-- (1) 평균 별점 요약 박스 -->
					<div class="border rounded-4 p-4 mb-4 bg-light">
						<div class="row align-items-center">

							<!-- 평균 점수 -->
							<c:set var="totalHit" value="0" />
							<c:set var="totalCount" value="0" />
							
							<c:forEach var="rvo" items="${rList}">
							    <c:set var="totalHit" value="${totalHit + rvo.hit}" />
							    <c:set var="totalCount" value="${totalCount + 1}" />
							</c:forEach>
							
							<c:set var="avgScore" value="0" />
							<c:if test="${totalCount > 0}">
							    <c:set var="avgScore" value="${totalHit / totalCount}" />
							</c:if>
							
							<fmt:formatNumber var="roundScore" value="${avgScore}" pattern="0" />
							
							
							<div class="col-md-4 text-center border-end">
								<div class="display-4 fw-bold">
							        <fmt:formatNumber value="${avgScore}" pattern="0.0" />
							    </div>

								
								<%-- <c:forEach var="rvo" items="${rList}"> --%>
								<c:choose>
					       		<c:when test="${0 < avgScore && avgScore <= 1}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${1 < avgScore && avgScore <= 2}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${2 < avgScore && avgScore <= 3}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${3 < avgScore && avgScore <= 4}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${4 < avgScore && avgScore <= 5}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg><svg width="20"
										 height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg>
									</span>
								</c:when>
					      	</c:choose>
							<%-- </c:forEach> --%>
								
								<!-- 전체 리뷰 개수 -->
								<p class="text-body-secondary mb-0 mt-2">전체 리뷰 ${vo.review_count }개</p>
							</div>

							<!-- 점수 안내 문구 -->
							<div class="col-md-8 mt-3 mt-md-0 ps-md-4">
								<p class="mb-0 text-body-secondary">실제 구매 고객이 남긴 리뷰입니다. 평점은
									5점 만점 기준입니다.</p>
							</div>

						</div>
					</div>
					
					<!-- (2) 리뷰 목록 -->
					<c:if test="${empty rList}">
					<div class="text-center p-4 text-body-secondary border rounded-4 bg-light mb-3">
					    아직 등록된 리뷰가 없습니다. 첫 리뷰를 작성해주세요.
					</div>
					</c:if>
					
					<c:forEach var="rvo" items="${rList}">
					<div class="review-card border rounded-4 p-4 mb-3">
					    <div class="d-flex justify-content-between align-items-start mb-2">
					        <div>
					            <h6 class="fw-bold mb-1">
					                <a href="../mypage/reviewList.do?review_no=${rvo.review_no}" class="text-dark text-decoration-none">
					                    ${rvo.subject}
					                </a>
					            </h6>
					            <small class="text-body-secondary">작성자: ${rvo.id}</small>
					            <small class="text-body-tertiary ms-2">${rvo.dbday}</small>
					        </div>
					         
					        <%-- 리뷰 평점 --%>
					       	<c:choose>
					       		<c:when test="${rvo.hit==1}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${rvo.hit==2}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${rvo.hit==3}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${rvo.hit==4}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-outline"></use></svg>
									</span>
								</c:when>
								<c:when test="${rvo.hit==5}">
									<span class="d-inline-flex"> <svg width="20" height="20"
										class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg> <svg width="20"
										height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg><svg width="20"
										 height="20" class="text-warning">
									<use xlink:href="#star-solid"></use></svg>
									</span>
								</c:when>
					      	</c:choose>
					    </div>
					    <!-- 리뷰 내용 -->
					    <p class="text-body-secondary mb-0">${rvo.content}</p>
					</div>
					</c:forEach>
				</div>
			</div>
			</div>
						
						<%-- 상품 문의 내역 리스트 --%>
						<div class="tab-pane fade" id="qna">
					    <table class="table align-middle">
					        <thead>
					            <tr class="text-body-secondary">
					                <th class="text-center" style="width: 110px;">유형</th>
					                <th>제목</th>
					                <th class="text-center" style="width: 130px;">작성일</th>
					                <th class="text-center" style="width: 110px;">답변상태</th>
					            </tr>
					        </thead>
					        <tbody>
					            <%-- 1. 문의글이 하나도 없을 경우 --%>
					            <c:if test="${empty qList}">
					                <tr>
					                    <td colspan="4" class="text-center py-4 text-body-secondary">등록된 상품 문의가 없습니다.</td>
					                </tr>
					            </c:if>
					
					            <%-- 2. 문의글 목록 반복 출력 --%>
					            <c:forEach var="qvo" items="${qList}">
					                <tr>
					                    <td class="text-center">${qvo.type}</td>
					                    
					                    <td>
					                        <c:choose>
					                            <%-- 비밀글인 경우 --%>
					                            <c:when test="${qvo.is_secret == '비밀글'}">
					                                
					                                <%-- 작성자 본인이거나 관리자인 경우 --%>
					                                <c:choose>
					                                    <c:when test="${sessionScope.id == qvo.id || sessionScope.id == 'admin'}">
					                                         <a href="../mypage/qnaList.do?qna_no=${qvo.qna_no}" class="text-dark text-decoration-none">
					                                            <svg width="14" height="14" viewBox="0 0 24 24"><use xlink:href="#lock"></use></svg>
					                                            ${qvo.subject}
					                                        </a>
					                                    </c:when>
					                                    
					                                    <%-- 권한이 없는 다른 사용자인 경우 --%>
					                                    <c:otherwise>
					                                        <span class="text-body-secondary" style="cursor: not-allowed;">
					                                            <svg width="14" height="14" viewBox="0 0 24 24"><use xlink:href="#lock"></use></svg>
					                                            비밀글입니다.
					                                        </span>
					                                    </c:otherwise>
					                                </c:choose>
					                                
					                            </c:when>
					                            
					                            <%-- 공개글인 경우 --%>
					                            <c:otherwise>
					                                <%-- <a href="../qna/detail.do?qna_no=${qvo.qna_no}" class="text-dark text-decoration-none"> --%>
					                                <a href="../mypage/qnaList.do?qna_no=${qvo.qna_no}" class="text-dark text-decoration-none">
					                                    ${qvo.subject}
					                                </a>
					                            </c:otherwise>
					                        </c:choose>
					                    </td>              
					                    
					                    <td class="text-center text-body-secondary">${qvo.dbday}</td>
					                    <!-- 답변 상태 -->
					                    <td class="text-center">
					                        <c:choose>
					                            <c:when test="${qvo.status == '답변완료'}">
					                                <span class="badge bg-success">답변완료</span>
					                            </c:when>
					                            <c:otherwise>
					                                <span class="badge bg-secondary">${qvo.status}</span>
					                            </c:otherwise>
					                        </c:choose>
					                    </td>
					                </tr>
					            </c:forEach>
					        </tbody>
					    </table>
					
					    <%-- 상품문의 버튼 --%>
					    <div class="text-end mt-3">
					        <a href="../mypage/qna.do?goods_no=${vo.goods_no}" class="btn btn-dark">상품문의</a>
					    </div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>