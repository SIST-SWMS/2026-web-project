<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- ===================== 최근 주문 ===================== --%>
	<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-3">
		<h4 class="fw-bold mb-0">최근 주문</h4>
		<a href="#" class="text-body-secondary text-decoration-none small">더보기›</a>
	</div>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">주문일</th>
				<th>주문내역</th>
				<th style="width: 220px;">주문번호</th>
				<th class="text-end" style="width: 120px;">결제금액</th>
			</tr>
		</thead>
		<tbody>
			<%-- 주문 1건 = tr 하나. 나중에 <c:forEach var="order" items="${orderList}"> 로 감싸면 반복 출력됨 --%>
			<!-- <c:forEach var="order" items="${orderList}"> -->
			<tr>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-1.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>스트라이커 (Z1)_Black_DUS25N73Z1</span>
					</div>
				</td>
				<td class="fw-bold">ORD20260705-4253501</td>
				<td class="text-end">84,150원</td>
			</tr>
			<!-- </c:forEach> -->

			<tr>
				<td class="text-body-secondary">2026.05.14</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-2.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>(7차) Cation Cotton Vest _ 2 colors</span>
					</div>
				</td>
				<td class="fw-bold">ORD20260514-2447373</td>
				<td class="text-end">83,010원</td>
			</tr>

			<tr>
				<td class="text-body-secondary">2026.05.14</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-3.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>클래식 데님_light indigo</span>
					</div>
				</td>
				<td class="fw-bold">ORD20260514-2438721</td>
				<td class="text-end">125,820원</td>
			</tr>

			<tr>
				<td class="text-body-secondary">2026.04.21</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-4.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>릴리프 스티치 백팩 M_3Color/ 도난방지 RFID차단
							여행가방</span>
					</div>
				</td>
				<td class="fw-bold">ORD20260421-7168658</td>
				<td class="text-end">103,390원</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 나의 좋아요 ===================== --%>
	<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4 mt-5">
		<h4 class="fw-bold mb-0">나의 좋아요</h4>
		<a href="#" class="text-body-secondary text-decoration-none small">더보기›</a>
	</div>

	<div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">
		<div class="col">
			<div style="position: relative;">
				<img src="../resources/images/product-thumb-5.png" class="w-100" style="aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;" alt="상품">
				<span style="position: absolute; right: 10px; bottom: 10px; color: #ff4d4d;">
					<svg width="22" height="22" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use>
					</svg>
				</span>
			</div>
			<div class="small mt-2">휠라 에샤페 메리제인_1XM02376H_063</div>
			<div class="fw-bold">
				<span class="text-danger">30%</span> 69,300
			</div>
		</div>

		<div class="col">
			<div style="position: relative;">
				<img src="../resources/images/product-thumb-6.png" class="w-100"
					style="aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;"
					alt="상품"> <span
					style="position: absolute; right: 10px; bottom: 10px; color: #ff4d4d;">
					<svg width="22" height="22" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use></svg>
				</span>
			</div>
			<div class="small mt-2">Oversized World Best Print T-shirt
				VW2SE116_2color</div>
			<div class="fw-bold">63,000</div>
		</div>

		<div class="col">
			<div style="position: relative;">
				<img src="../resources/images/product-thumb-7.png" class="w-100"
					style="aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;"
					alt="상품"> <span
					style="position: absolute; right: 10px; bottom: 10px; color: #ff4d4d;">
					<svg width="22" height="22" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use></svg>
				</span>
			</div>
			<div class="small mt-2">HICKIES 여행 방수 워터파크 수건 신발수납 드라이백</div>
			<div class="fw-bold">
				<span class="text-danger">43%</span> 7,360
			</div>
		</div>

		<div class="col">
			<div style="position: relative;">
				<img src="../resources/images/product-thumb-1.png" class="w-100"
					style="aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;"
					alt="상품"> <span
					style="position: absolute; right: 10px; bottom: 10px; color: #ff4d4d;">
					<svg width="22" height="22" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use></svg>
				</span>
			</div>
			<div class="small mt-2">베사 웨지 샌들 BESSA WEDGE SANDAL (RW0163)</div>
			<div class="fw-bold">
				<span class="text-danger">40%</span> 144,000
			</div>
		</div>

		<div class="col">
			<div style="position: relative;">
				<img src="../resources/images/product-thumb-2.png" class="w-100"
					style="aspect-ratio: 1/1; object-fit: cover; border-radius: 8px; background: #f5f5f5;"
					alt="상품"> <span
					style="position: absolute; right: 10px; bottom: 10px; color: #ff4d4d;">
					<svg width="22" height="22" viewBox="0 0 24 24">
						<use xlink:href="#heart"></use></svg>
				</span>
			</div>
			<div class="small mt-2">[블루라이트렌즈]비비R C1</div>
			<div class="fw-bold">
				<span class="text-danger">21%</span> 204,780
			</div>
		</div>
	</div>
</body>
</html>