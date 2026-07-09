<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- QNA 목록 (관리자) --%>
<style>
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
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">QNA 관리</h4>

	<%-- ===================== 검색 영역 ===================== --%>
	<form action="qna_list.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">상태</label>
				<select name="status" class="form-select">
					<option value="">전체</option>
					<option value="WAIT">답변대기</option>
					<option value="DONE">답변완료</option>
				</select>
			</div>

			<div class="col-md-6">
				<label class="form-label small text-body-secondary">상품명 / 작성자</label>
				<input type="text" name="keyword" class="form-control" placeholder="검색어 입력" value="${param.keyword}">
			</div>

			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="qna_list.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<%-- ===================== 목록 테이블 ===================== --%>
	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 60px;">번호</th>
				<th>상품명</th>
				<th style="width: 100px;">문의유형</th>
				<th>문의제목</th>
				<th style="width: 100px;">작성자</th>
				<th style="width: 110px;">등록일</th>
				<th style="width: 100px;">상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- 1건 = tr 하나. <c:forEach var="qna" items="${qnaList}"> 로 반복 --%>
			<!-- <c:forEach var="qna" items="${qnaList}"> -->
			<tr>
				<td>128</td>
				<td class="text-start">클래식 러너 스니커즈</td>
				<td>사이즈</td>
				<td class="text-start">
					<a href="qna_view.do?id=128" class="text-dark text-decoration-none">사이즈가 어떻게 되나요?</a>
				</td>
				<td>kim****</td>
				<td class="text-body-secondary">2026.07.05</td>
				<td>
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<!-- </c:forEach> -->
			<tr>
				<td>127</td>
				<td class="text-start">뉴포트 H2 샌들</td>
				<td>배송</td>
				<td class="text-start">
					<a href="qna_view.do?id=127" class="text-dark text-decoration-none">배송 언제 되나요?</a>
				</td>
				<td>lee****</td>
				<td class="text-body-secondary">2026.07.04</td>
				<td>
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
			<tr>
				<td>126</td>
				<td class="text-start">레더 브라운 로퍼</td>
				<td>재입고</td>
				<td class="text-start">
					<a href="qna_view.do?id=126" class="text-dark text-decoration-none">재입고 예정 있나요?</a>
				</td>
				<td>park***</td>
				<td class="text-body-secondary">2026.07.03</td>
				<td>
					<span class="badge bg-success">답변완료</span>
				</td>
			</tr>
			<tr>
				<td>125</td>
				<td class="text-start">삼바 OG 클라우드</td>
				<td>상품</td>
				<td class="text-start">
					<a href="qna_view.do?id=125" class="text-dark text-decoration-none">정품 맞나요?</a>
				</td>
				<td>choi**</td>
				<td class="text-body-secondary">2026.07.02</td>
				<td>
					<span class="badge bg-success">답변완료</span>
				</td>
			</tr>
			<tr>
				<td>124</td>
				<td class="text-start">993 메이드인 USA</td>
				<td>사이즈</td>
				<td class="text-start">
					<a href="qna_view.do?id=124" class="text-dark text-decoration-none">폭이 넓은 편인가요?</a>
				</td>
				<td>jung**</td>
				<td class="text-body-secondary">2026.07.01</td>
				<td>
					<span class="badge bg-danger">답변대기</span>
				</td>
			</tr>
		</tbody>
	</table>

	<%-- ===================== 페이지네이션 ===================== --%>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="qna_list.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="qna_list.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="qna_list.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>