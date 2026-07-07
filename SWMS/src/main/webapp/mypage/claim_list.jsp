<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">취소/교환/반품
		내역</h4>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">신청일</th>
				<th>상품내역</th>
				<th class="text-center" style="width: 110px;">구분</th>
				<th class="text-end" style="width: 120px;">금액</th>
				<th class="text-center" style="width: 110px;">처리상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- 1건 = tr 하나. <c:forEach var="claim" items="${claimList}"> 로 반복 --%>
			<!-- <c:forEach var="claim" items="${claimList}"> -->
			<tr>
				<td class="text-body-secondary">2026.06.02</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-5.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>뉴포트 H2 샌들 Grey Smoke Blue</span>
					</div>
				</td>
				<td class="text-center"><span
					class="badge bg-warning text-dark">교환</span></td>
				<td class="text-end">152,100원</td>
				<td class="text-center">처리완료</td>
			</tr>
			<!-- </c:forEach> -->

			<tr>
				<td class="text-body-secondary">2026.05.20</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-6.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>데일리 스니커즈 화이트</span>
					</div>
				</td>
				<td class="text-center"><span class="badge bg-danger">반품</span></td>
				<td class="text-end">118,000원</td>
				<td class="text-center">환불완료</td>
			</tr>

			<tr>
				<td class="text-body-secondary">2026.04.11</td>
				<td>
					<div class="d-flex align-items-center gap-3">
						<img src="../resources/images/product-thumb-7.png" width="60"
							height="60" style="object-fit: cover; border-radius: 6px;"
							alt="상품"> <span>클래식 데님_light indigo</span>
					</div>
				</td>
				<td class="text-center"><span class="badge bg-secondary">취소</span></td>
				<td class="text-end">125,820원</td>
				<td class="text-center">취소완료</td>
			</tr>
		</tbody>
	</table>
</body>
</html>