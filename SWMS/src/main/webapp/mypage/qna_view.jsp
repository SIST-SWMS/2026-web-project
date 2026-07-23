<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div
		class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4">
		<h4 class="fw-bold mb-0">1:1 문의 상세</h4>
		<a href="../mypage/qnaList.do" class="btn btn-outline-secondary">목록으로</a>
	</div>

	<%-- ===================== 문의 정보 ===================== --%>
	<div class="border rounded-3 p-4 mb-3">

		<%-- 유형 + 답변상태 --%>
		<div class="d-flex justify-content-between align-items-center mb-2">
			<span class="badge bg-light text-dark border">${vo.type}</span>

			<%-- 답변상태 분기 --%>
			<c:if test="${not empty admin.status}">
				<span class="badge bg-success">답변완료</span>
			</c:if>
			<c:if test="${empty admin.status}">
				<span class="badge bg-secondary">답변대기</span>
			</c:if>
		</div>

		<%-- 제목 (비밀글이면 자물쇠 표시) --%>
		<h5 class="fw-bold mb-1">
			<c:if test="${is_secret == 'Y'}">
				<svg width="16" height="16" viewBox="0 0 24 24">
					<use xlink:href="#lock"></use></svg>
			</c:if>
			${vo.subject}
		</h5>
		<div class="text-body-secondary small mb-3">${vo.created_at}</div>

		<%-- 문의 본문 --%>
		<div class="pt-3 border-top" style="white-space: pre-line;">${vo.content}</div>
	</div>

	<%-- ===================== 관리자 답변 ===================== --%>
	<c:if test="${not empty admin.status}">
		<%-- 답변완료: 관리자 답변 내용 표시 --%>
		<div class="border rounded-3 p-4 bg-light">
			<div class="d-flex align-items-center gap-2 mb-2">
				<span class="badge bg-dark">관리자</span> <span
					class="text-body-secondary small">${answer.dbday}</span>
			</div>
			<div class="pt-2" style="white-space: pre-line;">${answer.Content}</div>
		</div>
	</c:if>

	<c:if test="${empty admin.status}">
		<%-- 답변대기: 안내 문구 --%>
		<div
			class="border rounded-3 p-4 bg-light text-center text-body-secondary">
			답변 준비중입니다. 빠른 시일 내에 답변드리겠습니다.</div>
	</c:if>

	<%-- 수정/삭제 버튼 (답변대기일 때만 노출, 답변완료면 수정 불가) --%>
	<c:if test="${vo.status != 'Y'}">
		<div class="d-flex gap-2 justify-content-end mt-3">
		    <c:if test="${not empty admin.status }">
			<a href="../mypage/qna_edit.do?qna_no=${vo.qna_no}" class="btn btn-dark px-4">수정</a>
			</c:if>
			 <a href="#" class="btn btn-outline-danger px-4"
           onclick="if(confirm('삭제하시겠습니까?')){ location.href='../mypage/qna_delete.do?no=${vo.qna_no}'; } return false;">삭제</a>
			<!-- <a href="../mypage/qnaList.do" class="btn btn-outline-danger px-4">삭제</a> -->
		</div>
	</c:if>
</body>
</html>