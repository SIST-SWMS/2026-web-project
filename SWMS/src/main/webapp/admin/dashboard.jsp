<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">대시보드</h4>

	<div class="row g-3 mb-5">

		<div class="col-6 col-lg-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">오늘 주문건수</div>
				<div class="fs-3 fw-bold">${dashboard.todayOrderCount}건</div>
			</div>
		</div>

		<div class="col-6 col-lg-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">이번 달 매출액</div>
				<div class="fs-3 fw-bold">${dashboard.monthSales}원</div>
			</div>
		</div>

		<div class="col-6 col-lg-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">재고 부족 상품 (10개 이하)</div>
				<div class="fs-3 fw-bold text-warning">${dashboard.lowStockCount}개</div>
			</div>
		</div>

		<div class="col-6 col-lg-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">미처리 출고 건수</div>
				<div class="fs-3 fw-bold text-danger">${dashboard.pendingShipCount}건</div>
			</div>
		</div>

	</div>

	<div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
		<h5 class="fw-bold mb-0">최근 주문</h5>
		<a href="../admin/stockout.do" class="text-body-secondary text-decoration-none small">더보기 ›</a>
	</div>

	<table class="table align-middle mb-5">
		<thead>
			<tr class="text-body-secondary">
				<th>주문번호</th>
				<th>회원ID</th>
				<th>상품명</th>
				<th class="text-center">수량</th>
				<th class="text-center">주문일</th>
				<th class="text-center">처리상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- 주문 1건 = tr 하나. <c:forEach var="order" items="${recentOrders}"> 로 반복 (최근 5건) --%>
			<!-- <c:forEach var="order" items="${recentOrders}"> -->
			<tr>
				<td class="fw-bold">ORD20260705-4253501</td>
				<td>ups****</td>
				<td>스트라이커 (Z1)_Black</td>
				<td class="text-center">1</td>
				<td class="text-center text-body-secondary">2026.07.05</td>
				<td class="text-center">
					<span class="badge bg-secondary">미출고</span>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td class="fw-bold">ORD20260705-4253498</td>
				<td>kim****</td>
				<td>클래식 러너 스니커즈</td>
				<td class="text-center">2</td>
				<td class="text-center text-body-secondary">2026.07.05</td>
				<td class="text-center">
					<span class="badge bg-primary">배송중</span>
				</td>
			</tr>
			<tr>
				<td class="fw-bold">ORD20260704-4251102</td>
				<td>lee****</td>
				<td>레더 브라운 로퍼</td>
				<td class="text-center">1</td>
				<td class="text-center text-body-secondary">2026.07.04</td>
				<td class="text-center">
					<span class="badge bg-success">배송완료</span>
				</td>
			</tr>
			<tr>
				<td class="fw-bold">ORD20260704-4250887</td>
				<td>park***</td>
				<td>뉴포트 H2 샌들</td>
				<td class="text-center">1</td>
				<td class="text-center text-body-secondary">2026.07.04</td>
				<td class="text-center">
					<span class="badge bg-secondary">미출고</span>
				</td>
			</tr>
			<tr>
				<td class="fw-bold">ORD20260703-4248551</td>
				<td>choi**</td>
				<td>삼바 OG 클라우드</td>
				<td class="text-center">1</td>
				<td class="text-center text-body-secondary">2026.07.03</td>
				<td class="text-center">
					<span class="badge bg-success">배송완료</span>
				</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 미답변 QNA 목록 ===================== --%>
	<div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
		<h5 class="fw-bold mb-0">미답변 QNA</h5>
		<%-- 더보기 → QNA 목록으로 이동 --%>
		<a href="qna_list.do" class="text-body-secondary text-decoration-none small">더보기 ›</a>
	</div>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th class="text-center" style="width: 80px;">번호</th>
				<th>상품명</th>
				<th>문의제목</th>
				<th class="text-center">작성자</th>
				<th class="text-center">등록일</th>
				<th class="text-center">상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- QNA 1건 = tr 하나. <c:forEach var="qna" items="${unansweredQna}"> 로 반복 (최근 5건) --%>
			<!-- <c:forEach var="qna" items="${unansweredQna}"> -->
			<tr>
				<td class="text-center">128</td>
				<td>클래식 러너 스니커즈</td>
				<td>
					<a href="qna_view.do?id=128" class="text-dark text-decoration-none">사이즈가 어떻게 되나요?</a>
				</td>
				<td class="text-center">kim****</td>
				<td class="text-center text-body-secondary">2026.07.05</td>
				<td class="text-center">
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td class="text-center">127</td>
				<td>뉴포트 H2 샌들</td>
				<td>
					<a href="qna_view.do?id=127" class="text-dark text-decoration-none">배송 언제 되나요?</a>
				</td>
				<td class="text-center">lee****</td>
				<td class="text-center text-body-secondary">2026.07.04</td>
				<td class="text-center">
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<tr>
				<td class="text-center">126</td>
				<td>레더 브라운 로퍼</td>
				<td>
					<a href="qna_view.do?id=126" class="text-dark text-decoration-none">재입고 예정 있나요?</a>
				</td>
				<td class="text-center">park***</td>
				<td class="text-center text-body-secondary">2026.07.03</td>
				<td class="text-center">
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<tr>
				<td class="text-center">125</td>
				<td>삼바 OG 클라우드</td>
				<td>
					<a href="qna_view.do?id=125" class="text-dark text-decoration-none">정품 맞나요?</a>
				</td>
				<td class="text-center">choi**</td>
				<td class="text-center text-body-secondary">2026.07.02</td>
				<td class="text-center">
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<tr>
				<td class="text-center">124</td>
				<td>993 메이드인 USA</td>
				<td>
					<a href="qna_view.do?id=124" class="text-dark text-decoration-none">폭이 넓은 편인가요?</a>
				</td>
				<td class="text-center">jung**</td>
				<td class="text-center text-body-secondary">2026.07.01</td>
				<td class="text-center">
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>