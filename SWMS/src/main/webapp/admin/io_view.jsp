<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 상세 정보 한 줄 = 라벨 + 값 */
.info-row {
	display: flex;
	padding: 14px 0;
	border-bottom: 1px solid #eee;
}

.info-row .label {
	width: 160px;
	color: #888;
	font-size: 15px;
}

.info-row .value {
	flex: 1;
	font-weight: 500;
}
</style>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입출고 상세</h4>

	<div class="border rounded-4 p-4 p-lg-5" style="max-width: 720px;">
		<%-- 구분 뱃지 (입고 파랑 / 출고 빨강) --%>
		<div class="mb-4">
			<c:choose>
				<c:when test="${io.chk == 'OUT'}">
					<span class="badge bg-danger fs-6">출고</span>
				</c:when>
				<c:otherwise>
					<span class="badge bg-primary fs-6">입고</span>
				</c:otherwise>
			</c:choose>
		</div>

		<table class="table">
			<tr>
				<th width=30%>상품코드</th>
				<td width=60%>${io.productCode}</td>
			</tr>
			<tr>
				<th width=30%>상품명</th>
				<td width=60%>${io.productName}</td>
			</tr>
			<tr>
				<th width=30%>사이즈</th>
				<td width=60%>${io.size}</td>
			</tr>
			<tr>
				<th width=30%>수량</th>
				<td width=60%>${io.quantity}</td>
			</tr>
			<tr>
				<th width=30%>${io.chk == 'OUT' ? '출고일' : '입고일'}</th>
				<td width=60%>${io.ioDate}</td>
			</tr>
			<tr>
				<th width=30%>등록자</th>
				<td width=60%>${io.regId}</td>
			</tr>
		</table>
	</div>

	<%-- ===================== 버튼 ===================== --%>
	<div class="mt-4">
		<a href="../admin/io_list.do" class="btn btn-outline-dark px-4">목록</a>
	</div>
</body>
</html>