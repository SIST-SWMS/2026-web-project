<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">주문/예매
		내역</h4>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">주문일</th>
				<th>주문내역</th>
				<th style="width: 220px;">주문번호</th>
				<th class="text-end" style="width: 120px;">결제금액</th>
				<th class="text-center" style="width: 110px;">상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="text-body-secondary">2026.05.14</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<a href="../mypage/detail.do" class="text-decoration-none">
							<img src="../resources/images/product-thumb-2.png" width="60" height="60" style="object-fit: cover; border-radius: 6px; "alt="상품"> 
							<span style="margin-left: 8px;">(7차) Cation Cotton Vest _ 2 colors</span>
						</a> 
					</div>
				</td>
				<td class="fw-bold">ORD20260514-2447373</td>
				<td class="text-end">83,010원</td>
				<td class="text-center"><span class="badge bg-success">배송완료</span></td>
			</tr>

			<tr>
				<td class="text-body-secondary">2026.05.14</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<a href="../mypage/detail.do" class="text-decoration-none">
							<img src="../resources/images/product-thumb-3.png" width="60" height="60" style="object-fit: cover; border-radius: 6px; "alt="상품"> 
							<span style="margin-left: 8px;">클래식 데님_light indigo</span>
						</a>
					</div>
				</td>
				<td class="fw-bold">ORD20260514-2438721</td>
				<td class="text-end">125,820원</td>
				<td class="text-center"><span class="badge bg-primary">배송중</span></td>
			</tr>

		</tbody>
	</table>
</body>
</html>