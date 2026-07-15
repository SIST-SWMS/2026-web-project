<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

	// 연관상품 슬라이드 초기화 (한 화면에 6개씩, 옆으로 넘김)
	new Swiper('.relatedSwiper', {
		slidesPerView:6,
		spaceBetween:16,
		navigation:{
			nextEl:'.relatedSwiper .swiper-button-next',
			prevEl:'.relatedSwiper .swiper-button-prev'
		},
		breakpoints:{
			0:{
				slidesPerView:2
			},
			768:{
				slidesPerView:4
			},
			992:{
				slidesPerView:6
			}
		}
	});
	
	    $('#likeOn').on('click', function() {
	        let gno = $(this).attr('data-no');
	        location.href = "../like/likeOn.do?goods_no=" + gno;
	    });

	    $('#likeOff').on('click', function() {
	        let gno = $(this).attr('data-no');
	        location.href = "../like/likeOff.do?goods_no=" + gno;
	    });
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
						<img id="mainImage" src="${vo.poster_url }"
							alt="상품 이미지" class="img-fluid"
							style="max-height: 460px; object-fit: contain;">
					</div>
					<!-- <div class="d-flex gap-2 flex-wrap">
						<img class="thumb border rounded-3 p-1 bg-light"
							src="../resources/images/product-thumb-1.png" width="84"
							height="84" style="cursor: pointer; object-fit: contain;">
						<img class="thumb border rounded-3 p-1 bg-light"
							src="../resources/images/product-thumb-2.png" width="84"
							height="84" style="cursor: pointer; object-fit: contain;">
						<img class="thumb border rounded-3 p-1 bg-light"
							src="../resources/images/product-thumb-3.png" width="84"
							height="84" style="cursor: pointer; object-fit: contain;">
						<img class="thumb border rounded-3 p-1 bg-light"
							src="../resources/images/product-thumb-4.png" width="84"
							height="84" style="cursor: pointer; object-fit: contain;">
					</div> -->
				</div>

				<!-- Info -->
				<div class="col-lg-6">
					<span class="badge bg-success mb-2">${vo.goods_discount }% 할인</span>
					<h2 class="fw-bold">${vo.goods_name }</h2>
					<div class="d-flex align-items-center gap-2 my-2">
						<span class="d-flex"> <svg width="18" height="18"
								class="text-warning">
								<!-- 이부분은 나중에 리뷰 담당자와 논의 후 별점 유무 진행 -->
								<use xlink:href="#star-solid"></use></svg> <svg width="18" height="18"
								class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="18" height="18"
								class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="18" height="18"
								class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="18" height="18"
								class="text-warning">
								<use xlink:href="#star-solid"></use></svg>
						</span> <small class="text-body-secondary">리뷰 ${review_count }개</small> <!-- 리뷰 개수 세서 표시 -->
					</div>
					
					<div class="my-3">
						<span class="fs-3 fw-bold text-dark">₩ ${vo.goods_price }</span><!-- 할인 후 가격 -->
						<!-- var price= 금액 - (Math.floor((금액 * 할인율) / 100));-->
						<del class="text-body-secondary ms-2">₩ ${vo.goods_price }</del><!-- 할인 전 가격 -->
						<span class="text-success ms-2 fw-bold">- ${vo.goods_discount} %</span><!--  할인률 -->
					</div>

					<p class="text-body-secondary">배송비 무료</p>

					<!-- 사이즈 -->
					<div class="my-4">
						<label class="fw-bold d-block mb-2">사이즈</label><!-- 사이즈 버튼 클릭하면  -->
						<div class="d-flex flex-wrap gap-2" id="sizeGroup">
							<button type="button" class="btn btn-outline-dark size-btn">240</button>
							<button type="button" class="btn btn-outline-dark size-btn">250</button>
							<button type="button"
								class="btn btn-outline-dark size-btn active">260</button>
							<button type="button" class="btn btn-outline-dark size-btn">270</button>
							<button type="button" class="btn btn-outline-dark size-btn">280</button>
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
					<c:if test="${sessionScope.id!=null }">
					<div class="d-flex flex-wrap gap-2 my-4">
						<button class="btn btn-primary btn-lg px-4"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasCart">
							장바구니 담기</button>
						<a href="checkout.do" class="btn btn-dark btn-lg px-4">바로 구매</a>
						<!-- <button class="btn btn-outline-dark btn-lg" id=>
							<svg width="22" height="22">
								<use xlink:href="#heart"></use></svg>
						</button> -->
                        
						<c:if test="${check == 0}">
						    <button class="btn btn-outline-dark btn-lg" id="likeOn" data-no="${vo.goods_no}">
						        <svg width="22" height="22">
						            <use xlink:href="#heart-empty"></use> 
						        </svg>
						        <span class="ms-2">${like_count}</span>
						    </button>
						</c:if>
						<c:if test="${check == 1}">
						    <button class="btn btn-danger btn-lg" id="likeOff" data-no="${vo.goods_no}">
						        <svg width="22" height="22" fill="white">
						            <use xlink:href="#heart-fill"></use> 
						        </svg>
						        <span class="ms-2">${like_count}</span>
						    </button>
						</c:if>
					</div>
					</c:if>

					<ul class="list-unstyled text-body-secondary small border-top pt-3">
						<li class="mb-1">• 무료 배송 (3만원 이상 구매 시)</li>
						<li class="mb-1">• 7일 이내 무료 반품</li>
						<li class="mb-1">• 정품 인증 상품</li>
					</ul>
				</div>
			</div>

			<!-- Tabs -->
			<!-- ============================================= -->
			<!--  연관상품 슬라이드 (같은 카테고리 좋아요순 15개)  -->
			<!-- ============================================= -->
			<div class="row mt-5">
				<div class="col-12 text-center">
					<h5 class="fw-bold mb-4 text-start">상품 상세 이미지</h5>
					<img src="${vo.subposter_url}" class="img-fluid w-100" alt="상품 상세설명">
				</div>
			</div>
			<div class="row mt-5">
				<div class="col-12">
					<h5 class="fw-bold mb-3">연관상품추천</h5>
					<div class="swiper relatedSwiper">
						<div class="swiper-wrapper">
						
							<div class="swiper-slide">
								<a href="../main/product.do?no=1"
									class="text-decoration-none text-dark"> <img
									src="../resources/images/product-thumb-1.png"
									style="width: 100%; aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;"
									alt="상품">
									<div class="small mt-2">클래식 러너 스니커즈</div>
								</a>
							</div>
						</div>
					</div>
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
							<div class="col-md-4 text-center border-end">
								<!-- 평균 점수 숫자: JSP에서 ${avgRating} 등으로 교체 -->
								<div class="display-4 fw-bold">4.5</div>
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
								<!-- 전체 리뷰 개수: ${reviewCount} 등으로 교체 -->
								<p class="text-body-secondary mb-0 mt-2">전체 리뷰 128개</p>
							</div>

							<!-- 점수 안내 문구 -->
							<div class="col-md-8 mt-3 mt-md-0 ps-md-4">
								<p class="mb-0 text-body-secondary">실제 구매 고객이 남긴 리뷰입니다. 평점은
									5점 만점 기준입니다.</p>
							</div>

						</div>
					</div>

					<!-- (2) 리뷰 목록 -->
					<!-- <c:forEach var="review" items="${reviewList}"> -->
					<div class="review-card border rounded-4 p-4 mb-3">
						<div class="d-flex justify-content-between align-items-start mb-2">
							<div>
								<!-- 리뷰 제목: ${review.title} -->
								<h6 class="fw-bold mb-1">가볍고 편해서 매일 신어요</h6>
								<!-- 작성자: ${review.writer} 작성자 이름 -->
								<small class="text-body-secondary">작성자: 김민수</small>
							</div>
							<!-- 개별 평점: 별 개수를 ${review.rating} 값에 따라 표시 -->
							<span class="d-inline-flex"> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg>
							</span>
						</div>
						<!-- 리뷰 내용: ${review.content} -->
						<p class="text-body-secondary mb-0">사이즈 정사이즈입니다. 착화감이 부드럽고 하루종일 신어도 발이 편했어요.</p>
					</div>
					<!-- </c:forEach> -->

					<!-- (미리보기용 예시 리뷰 - JSTL 적용 후 삭제하세요) -->
					<div class="review-card border rounded-4 p-4 mb-3">
						<div class="d-flex justify-content-between align-items-start mb-2">
							<div>
								<h6 class="fw-bold mb-1">디자인이 예뻐요</h6>
								<small class="text-body-secondary">작성자: 이서연</small>
							</div>
							<span class="d-inline-flex"> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-body-tertiary">
								<use xlink:href="#star-outline"></use></svg>
							</span>
						</div>
						<p class="text-body-secondary mb-0">색상이 화면과 동일하고 코디하기 좋아요. 배송도 빨랐습니다.</p>
					</div>
				</div>
			</div>
						</div>
						
						<div class="tab-pane fade" id="qna">
							<%-- 상품 문의 내역 리스트 --%>
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
									<%-- 문의 1건 = tr 하나. <c:forEach var="qna" items="${qnaList}"> 로 반복 --%>
									<!-- <c:forEach var="qna" items="${qnaList}"> -->
									<tr>
										<td class="text-center">상품 문의</td>
										<td><a href="#" class="text-dark text-decoration-none">사이즈가
												어떻게 되나요?</a></td>
										<td class="text-center text-body-secondary">2026.07.03</td>
										<td class="text-center"><span class="badge bg-success">답변완료</span></td>
									</tr>
									<!-- </c:forEach> -->
									<tr>
										<td class="text-center">배송 문의</td>
										<td><a href="#" class="text-dark text-decoration-none">
												<svg width="14" height="14" viewBox="0 0 24 24">
												<use xlink:href="#lock"></use></svg> 비밀글입니다
										</a></td>
										<td class="text-center text-body-secondary">2026.06.28</td>
										<td class="text-center"><span class="badge bg-secondary">답변대기</span></td>
									</tr>
								</tbody>
							</table>

							<%-- 상품문의 버튼 --%>
							<div class="text-end mt-3">
								<a href="../mypage/qna.do" class="btn btn-dark">상품문의</a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- ============================================= -->
			<!--  리뷰 영역 (상세 페이지 하단)      =>  리뷰 위로 옮기고 버튼으로 제어             -->
			<!-- ============================================= -->
			<!-- <div class="row mt-5" id="reviewArea">
				<div class="col-12">

					<h4 class="fw-bold mb-4">상품 리뷰</h4>

					(1) 평균 별점 요약 박스
					<div class="border rounded-4 p-4 mb-4 bg-light">
						<div class="row align-items-center">

							평균 점수
							<div class="col-md-4 text-center border-end">
								평균 점수 숫자: JSP에서 ${avgRating} 등으로 교체
								<div class="display-4 fw-bold">4.5</div>
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
								전체 리뷰 개수: ${reviewCount} 등으로 교체
								<p class="text-body-secondary mb-0 mt-2">전체 리뷰 128개</p>
							</div>

							점수 안내 문구
							<div class="col-md-8 mt-3 mt-md-0 ps-md-4">
								<p class="mb-0 text-body-secondary">실제 구매 고객이 남긴 리뷰입니다. 평점은
									5점 만점 기준입니다.</p>
							</div>

						</div>
					</div>

					(2) 리뷰 목록
					<c:forEach var="review" items="${reviewList}">
					<div class="review-card border rounded-4 p-4 mb-3">
						<div class="d-flex justify-content-between align-items-start mb-2">
							<div>
								리뷰 제목: ${review.title}
								<h6 class="fw-bold mb-1">가볍고 편해서 매일 신어요</h6>
								작성자: ${review.writer} 작성자 이름
								<small class="text-body-secondary">작성자: 김민수</small>
							</div>
							개별 평점: 별 개수를 ${review.rating} 값에 따라 표시
							<span class="d-inline-flex"> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg>
							</span>
						</div>
						리뷰 내용: ${review.content}
						<p class="text-body-secondary mb-0">사이즈 정사이즈입니다. 착화감이 부드럽고 하루종일 신어도 발이 편했어요.</p>
					</div>
					</c:forEach>

					(미리보기용 예시 리뷰 - JSTL 적용 후 삭제하세요)
					<div class="review-card border rounded-4 p-4 mb-3">
						<div class="d-flex justify-content-between align-items-start mb-2">
							<div>
								<h6 class="fw-bold mb-1">디자인이 예뻐요</h6>
								<small class="text-body-secondary">작성자: 이서연</small>
							</div>
							<span class="d-inline-flex"> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-warning">
								<use xlink:href="#star-solid"></use></svg> <svg width="16" height="16"
									class="text-body-tertiary">
								<use xlink:href="#star-outline"></use></svg>
							</span>
						</div>
						<p class="text-body-secondary mb-0">색상이 화면과 동일하고 코디하기 좋아요. 배송도 빨랐습니다.</p>
					</div>
				</div>
			</div> -->
		</div>
	</section>
</body>
</html>