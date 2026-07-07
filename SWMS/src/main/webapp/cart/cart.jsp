<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cart-thumb {
	width: 90px;
	height: 90px;
	object-fit: cover;
	border-radius: 8px;
	background: #f5f5f5;
}

.qty-box .btn {
	width: 34px;
}

.qty-box input {
	width: 46px;
	text-align: center;
}

.summary-box {
	position: sticky;
	top: 20px;
}
</style>
</head>
<body>
	<section class="py-5">
		<div class="container-fluid">

			<h2 class="fw-bold mb-4">장바구니</h2>

			<div class="row g-4">

				<!-- ================= 좌측: 상품 리스트 ================= -->
				<div class="col-lg-8">

					<!-- 전체선택 / 선택삭제 -->
					<div
						class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="checkAll"
								checked> <label class="form-check-label fw-bold"
								for="checkAll">전체선택 (3/3)</label>
						</div>
						<a href="#" class="text-body-secondary text-decoration-none">선택삭제</a>
					</div>

					<!-- 상품 1 -->
					<div class="d-flex gap-3 py-4 border-bottom">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked>
						</div>
						<img src="../resources/images/product-thumb-1.png" alt="상품"
							class="cart-thumb">
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between">
								<div class="fw-bold">말로 스트랩 뮬 슬리퍼 [n5285]_3type</div>
								<a href="#" class="text-body-secondary text-decoration-none">✕</a>
							</div>
							<div class="text-body-secondary small mt-1">[color]Black
								(키튼힐 3cm) [size]230mm (+2,000원)</div>
							<div class="input-group qty-box mt-2" style="max-width: 130px;">
								<button class="btn btn-outline-secondary" type="button">−</button>
								<input type="text" class="form-control" value="1" readonly>
								<button class="btn btn-outline-secondary" type="button">+</button>
							</div>

							<div class="mt-2">
								<span class="text-danger fw-bold">38%</span> <span
									class="fw-bold fs-5">45,900원</span>
								<del class="text-body-secondary ms-1">74,000원</del>
							</div>

							<div class="mt-3" style="max-width: 300px;">
								<a href="../order/order.do" class="btn btn-outline-dark w-100">바로
									구매</a>
							</div>
						</div>
					</div>

					<!-- 상품 2 -->
					<div class="d-flex gap-3 py-4 border-bottom">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked>
						</div>
						<img src="../resources/images/product-thumb-2.png" alt="상품"
							class="cart-thumb">
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between">
								<div class="fw-bold">데일리 스니커즈 화이트</div>
								<a href="#" class="text-body-secondary text-decoration-none">✕</a>
							</div>
							<div class="text-body-secondary small mt-1">[color]White
								[size]260mm</div>
							<div class="input-group qty-box mt-2" style="max-width: 130px;">
								<button class="btn btn-outline-secondary" type="button">−</button>
								<input type="text" class="form-control" value="2" readonly>
								<button class="btn btn-outline-secondary" type="button">+</button>
							</div>

							<div class="mt-2">
								<span class="text-danger fw-bold">15%</span> <span
									class="fw-bold fs-5">118,000원</span>
								<del class="text-body-secondary ms-1">139,000원</del>
							</div>

							<div class="mt-3" style="max-width: 300px;">
								<a href="../order/order.do" class="btn btn-outline-dark w-100">바로
									구매</a>
							</div>
						</div>
					</div>

					<!-- 상품 3 -->
					<div class="d-flex gap-3 py-4 border-bottom">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked>
						</div>
						<img src="../resources/images/product-thumb-3.png" alt="상품"
							class="cart-thumb">
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between">
								<div class="fw-bold">뉴포트 H2 샌들 Grey Smoke Blue</div>
								<a href="#" class="text-body-secondary text-decoration-none">✕</a>
							</div>
							<div class="text-body-secondary small mt-1">[color]Grey
								[size]270mm</div>
							<div class="input-group qty-box mt-2" style="max-width: 130px;">
								<button class="btn btn-outline-secondary" type="button">−</button>
								<input type="text" class="form-control" value="1" readonly>
								<button class="btn btn-outline-secondary" type="button">+</button>
							</div>

							<div class="mt-2">
								<span class="text-danger fw-bold">10%</span> <span
									class="fw-bold fs-5">152,100원</span>
								<del class="text-body-secondary ms-1">169,000원</del>
							</div>

							<div class="mt-3" style="max-width: 300px;">
								<a href="../order/order.do" class="btn btn-outline-dark w-100">바로
									구매</a>
							</div>
						</div>
					</div>

				</div>

				<!-- ================= 우측: 주문 요약 ================= -->
				<div class="col-lg-4">
					<div class="border rounded-4 p-4 summary-box">

						<div class="d-flex justify-content-between mb-2">
							<span class="fw-bold">총 주문 금액</span> <span class="fw-bold">434,000원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-1">
							<span>└ 상품 금액</span><span>431,000원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-3">
							<span>└ 배송비</span><span>3,000원</span>
						</div>

						<hr>

						<div class="d-flex justify-content-between mb-2">
							<span class="fw-bold">총 할인 금액</span> <span
								class="fw-bold text-danger">-118,830원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-1">
							<span>└ 상품 할인</span><span>-83,830원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-3">
							<span>└ 장바구니 쿠폰</span><span>-35,000원</span>
						</div>

						<hr>

						<div class="d-flex justify-content-between mb-4">
							<span class="fw-bold fs-5">총 결제 금액</span> <span
								class="fw-bold fs-5">315,170원</span>
						</div>

						<a href="../order/order.do" class="btn btn-dark btn-lg w-100">315,170원
							결제하기 (3개)</a>

					</div>
				</div>
			</div>
		</div>
	</section>