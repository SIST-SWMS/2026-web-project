<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- QNA 상세 조회 및 답변 관리 --%>
<style type="text/css">
.info-row {
	display: flex;
	padding: 12px 0;
	border-bottom: 1px solid #eee;
}

.info-row .label {
	width: 120px;
	color: #888;
	font-size: 15px;
}

.info-row .value {
	flex: 1;
	font-weight: 500;
}
</style>
<script type="text/javascript">
	// [수정] 클릭 → textarea 표시
	function showEdit() {
		document.getElementById("answerEditForm").style.display = "block";
		document.getElementById("answerBtns").style.display = "none";
	}
	// 수정 취소
	function cancelEdit() {
		document.getElementById("answerEditForm").style.display = "none";
		document.getElementById("answerBtns").style.display = "flex";
	}
	// 답변만 삭제 (문의는 유지)
	function deleteAnswer(id) {
		if (confirm("답변을 삭제하시겠습니까? (문의글은 유지됩니다)")) {
			location.href = "qna_answer_delete.do?qnaId=" + id;
		}
	}
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">QNA 상세</h4>

	<%-- ===================== 상단 - 문의 내용 ===================== --%>
	<div class="border rounded-4 p-4 mb-4" style="max-width: 860px;">

		<div class="info-row">
			<div class="label">상품명</div>
			<div class="value">${qna.productName}</div>
		</div>
		<div class="info-row">
			<div class="label">문의유형</div>
			<div class="value">${qna.type}</div>
		</div>
		<div class="info-row">
			<div class="label">문의제목</div>
			<div class="value">
				${qna.title}
				<%-- 비공개 여부 표시 --%>
				<c:if test="${qna.secret == 'Y'}">
					<span class="badge bg-secondary ms-2">비공개</span>
				</c:if>
			</div>
		</div>
		<div class="info-row">
			<div class="label">작성자</div>
			<div class="value">${qna.writer}</div>
		</div>
		<div class="info-row">
			<div class="label">등록일</div>
			<div class="value">${qna.regDate}</div>
		</div>

		<%-- 문의 내용 (읽기 전용) --%>
		<div class="pt-4">
			<div class="text-body-secondary small mb-2">문의 내용</div>
			<div class="p-3 rounded-3" style="background: #f8f8f8; min-height: 120px; white-space: pre-line;">${qna.content}</div>
		</div>

	</div>

	<%-- ===================== 하단 - 답변 영역 ===================== --%>
	<h5 class="fw-bold border-bottom pb-2 mb-3">답변</h5>

	<div style="max-width: 860px;">
		<c:choose>

			<%-- ===== 답변 미등록 상태 ===== --%>
			<c:when test="${empty qna.answer}">
				<form action="qna_answer_save.do" method="post">
					<input type="hidden" name="qnaId" value="${qna.id}">
					<textarea name="answer" class="form-control mb-3" rows="5" placeholder="답변을 입력하세요"></textarea>
					<button type="submit" class="btn btn-dark px-4">답변 등록</button>
				</form>
			</c:when>

			<%-- ===== 답변 등록 상태 ===== --%>
			<c:otherwise>
				<%-- 기존 답변 표시 (답변자 / 답변일 포함) --%>
				<div class="border rounded-4 p-4 mb-3" style="background: #f8f8f8;">
					<div class="d-flex justify-content-between text-body-secondary small mb-2">
						<span>답변자: ${qna.answerWriter}</span>
						<span>${qna.answerDate}</span>
					</div>
					<div style="white-space: pre-line;">${qna.answer}</div>
				</div>

				<%-- 수정용 textarea (숨김 상태로 두고 [수정] 클릭 시 표시) --%>
				<form id="answerEditForm" action="qna_answer_update.do" method="post" style="display: none;">
					<input type="hidden" name="qnaId" value="${qna.id}">
					<textarea name="answer" class="form-control mb-3" rows="5">${qna.answer}</textarea>
					<button type="submit" class="btn btn-dark px-4">저장</button>
					<button type="button" class="btn btn-outline-secondary px-4" onclick="cancelEdit()">취소</button>
				</form>

				<%-- 버튼: 수정 / 삭제 --%>
				<div id="answerBtns" class="d-flex gap-2">
					<button type="button" class="btn btn-outline-dark px-4" onclick="showEdit()">수정</button>
					<button type="button" class="btn btn-outline-danger px-4" onclick="deleteAnswer('${qna.id}')">삭제</button>
				</div>
			</c:otherwise>

		</c:choose>
	</div>

	<%-- ===================== 버튼 ===================== --%>
	<div class="mt-4">
		<a href="../admin/qna_list.do" class="btn btn-outline-dark px-4">목록</a>
	</div>

</body>
</html>