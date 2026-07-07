<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 상품 리스트 페이지 전용 스타일 --%>
<style>
.category-menu a {
	display: block;
	padding: 8px 0;
	color: #888;
	text-decoration: none;
	font-size: 15px;
}

.category-menu a:hover {
	color: #000;
}

.category-menu a.active {
	color: #000;
	font-weight: 700;
}

.product-card {
	position: relative;
}

.product-card .like-btn {
	position: absolute;
	right: 12px;
	bottom: 12px;
	background: #fff;
	border-radius: 50%;
	width: 34px;
	height: 34px;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 1px 4px rgba(0, 0, 0, .15);
	cursor: pointer;
	border: none;
}

.product-card .thumb-box {
	background: #f5f5f5;
	border-radius: 8px;
	overflow: hidden;
	aspect-ratio: 1/1;
	display: flex;
	align-items: center;
	justify-content: center;
}

.product-card .thumb-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.product-brand {
	font-size: 13px;
	color: #888;
	margin-top: 10px;
}

.product-name {
	font-size: 14px;
	color: #222;
	margin: 2px 0;
}

.product-price {
	font-size: 16px;
	font-weight: 700;
}

.product-meta {
	font-size: 12px;
	color: #999;
}

/* 페이지네이션 */
.pagination {
	display: inline-flex;
	list-style: none;
	gap: 6px;
	padding: 0;
	margin: 0 auto;
}

.pagination li a {
	display: block;
	padding: 8px 14px;
	color: #333;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}
</style>
</head>
<body>

	<!-- 상단 정렬 드롭다운 -->
	<div class="d-flex justify-content-end border-bottom pb-3 mb-4">
		<select class="form-select" style="width: 140px;">
			<option>낮은가격순</option>
			<option>높은가격순</option>
			<option>좋아요순</option>
		</select>
	</div>

	<!-- 상품 그리드 (4열 x 3행 = 12개) -->
	<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">

		<!-- 카드 1 -->
		<div class="col">
			<div class="product-card">
				<a href="../goods/detail.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-1.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</button>
				<div class="product-brand">아치스</div>
				<div class="product-name">[ARCHIES] 아치스_블랙</div>
				<div class="product-price">49,900원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
					<use xlink:href="#heart"></use>
					</svg>
					4.1만
					<svg width="12" height="12" viewBox="0 0 12 12">
					<use xlink:href="#star-solid"></use>
					</svg>
					5 (4.7천)
				</div>
			</div>
		</div>

		<!-- 카드 2 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-2.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</button>
				<div class="product-brand">아치스</div>
				<div class="product-name">[ARCHIES] 아치스_토프</div>
				<div class="product-price">49,900원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
					<use xlink:href="#heart"></use>
					</svg>
					4.1만
					<svg width="12" height="12" viewBox="0 0 12 12">
					<use xlink:href="#star-solid"></use>
					</svg>
					5 (4.7천)				
				</div>
			</div>
		</div>

		<!-- 카드 3 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-3.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</button>
				<div class="product-brand">우포스</div>
				<div class="product-name">OORIGINAL STARDUST - 스타더스트</div>
				<div class="product-price">
					<span class="text-danger">42%</span> 39,900원
				</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
					<use xlink:href="#heart"></use>
					</svg>
					4.1만
					<svg width="12" height="12" viewBox="0 0 12 12">
					<use xlink:href="#star-solid"></use>
					</svg>
					5 (4.7천)				
				</div>
			</div>
		</div>

		<!-- 카드 4 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-4.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">휠라</div>
				<div class="product-name">[BEST] 글리오 실버문_FS261OD03X032_031</div>
				<div class="product-price">109,000원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					2.2만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (585)
				</div>
			</div>
		</div>

		<!-- 카드 5 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-5.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">킨</div>
				<div class="product-name">[29CM Only] 뉴포트 H2 샌들 Grey Smoke
					Blue</div>
				<div class="product-price">
					<span class="text-danger">10%</span> 152,100원
				</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					1.6만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (1.9천)
				</div>
			</div>
		</div>

		<!-- 카드 6 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-6.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">뉴발란스</div>
				<div class="product-name">993 메이드인 USA 그레이</div>
				<div class="product-price">259,000원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					3.3만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (2.5천)
				</div>
			</div>
		</div>

		<!-- 카드 7 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-7.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">아디다스</div>
				<div class="product-name">삼바 OG 클라우드 화이트</div>
				<div class="product-price">
					<span class="text-danger">15%</span> 118,000원
				</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					5.1만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (4.2천)
				</div>
			</div>
		</div>

		<!-- 카드 8 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-1.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">나이키</div>
				<div class="product-name">에어포스1 '07 화이트</div>
				<div class="product-price">139,000원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					4.8만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (3.9천)
				</div>
			</div>
		</div>

		<!-- 카드 9 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-2.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">크록스</div>
				<div class="product-name">클래식 클로그 블랙</div>
				<div class="product-price">
					<span class="text-danger">20%</span> 47,200원
				</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					2.7만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (2.1천)
				</div>
			</div>
		</div>

		<!-- 카드 10 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-3.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">닥터마틴</div>
				<div class="product-name">1460 8홀 부츠 블랙</div>
				<div class="product-price">239,000원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					1.9만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (1.5천)
				</div>
			</div>
		</div>

		<!-- 카드 11 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-4.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">반스</div>
				<div class="product-name">올드스쿨 클래식 블랙/화이트</div>
				<div class="product-price">
					<span class="text-danger">12%</span> 69,900원
				</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					3.5만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (2.8천)
				</div>
			</div>
		</div>

		<!-- 카드 12 -->
		<div class="col">
			<div class="product-card">
				<a href="product.do">
					<div class="thumb-box">
						<img src="../resources/images/product-thumb-5.png" alt="상품">
					</div>
				</a>
				<button type="button" class="like-btn">
					<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
				</button>
				<div class="product-brand">호카</div>
				<div class="product-name">본디 8 러닝화 블랙</div>
				<div class="product-price">219,000원</div>
				<div class="product-meta">
					<svg width="12" height="12" viewBox="0 0 24 24">
										<use xlink:href="#heart"></use></svg>
					2.1만
					<svg width="12" height="12" viewBox="0 0 12 12">
										<use xlink:href="#star-solid"></use></svg>
					5 (1.7천)
				</div>
			</div>
		</div>

	</div>

	<!-- ================= 페이지네이션 ================= -->
	<div class="row text-center" style="margin-top: 40px">
		<div class="d-flex justify-content-center">
			<ul class="pagination">
				<c:if test="${startPage > 1 }">
					<li><a href="list.do?page=${startPage - 1}">&laquo;</a></li>
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<li ${i==curPage ? "class='active'" : ""}><a
						href="list.do?page=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${endPage < totalPage }">
					<li><a href="list.do?page=${endPage + 1}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</div>

</body>
</html>