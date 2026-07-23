<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#updateBtn').on('click',function(){
		$('#answerEditForm').show();
		$('#answerBtns').hide()
	})
	
	$('#cancelBtn').on('click',function(){
		$('#answerEditForm').hide()
		$('#answerBtns').show()
	})
	
	$('#deleteBtn').on('click',function(){
		let parent_no = $(this).attr("data-no")
		let origin_no = $(this).attr("data-origin")

		if (!confirm("답변을 삭제하시겠습니까? (문의글은 유지됩니다)")) {
			return
		}
		
		$.ajax({
			type:'post',
			url:'../admin/qna_answer_delete.do',
			data:{
				"parent_no":parent_no,
				"origin_no":origin_no
			},
			success:function(result)
			{
				location.href="../admin/qna_view.do?no="+origin_no
			}
		})
	})
	
})
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">QNA 상세</h4>

	<div class="border rounded-4 p-4 mb-4" style="max-width: 860px;">

		<div class="info-row">
			<div class="label">상품명</div>
			<div class="value">${vo.goods.goods_name}</div>
		</div>
		<div class="info-row">
			<div class="label">문의유형</div>
			<div class="value">${vo.type}</div>
		</div>
		<div class="info-row">
			<div class="label">문의제목</div>
			<div class="value">
				${vo.subject}
				<c:if test="${vo.is_secret == 'y'}">
					<span class="badge bg-secondary ms-2">비공개</span>
				</c:if>
			</div>
		</div>
		<div class="info-row">
			<div class="label">작성자</div>
			<div class="value">${vo.id}</div>
		</div>
		<div class="info-row">
			<div class="label">등록일</div>
			<div class="value">${vo.dbday}</div>
		</div>

		<div class="pt-4">
			<div class="text-body-secondary small mb-2">문의 내용</div>
			<div class="p-3 rounded-3" style="background: #f8f8f8; min-height: 120px; white-space: pre-line;">${vo.content}</div>
		</div>

	</div>

	<h5 class="fw-bold border-bottom pb-2 mb-3">답변</h5>

	<div style="max-width: 860px;">
		<c:choose>

			<c:when test="${empty pvo}">
				<form action="../admin/qna_answer_save.do" method="post">
					<input type="hidden" name="qna_no" value="${vo.qna_no}">
					<textarea name="answer" class="form-control mb-3" rows="5" placeholder="답변을 입력하세요"></textarea>
					<button type="submit" class="btn btn-dark px-4">답변 등록</button>
				</form>
			</c:when>

			<c:otherwise>
				<div class="border rounded-4 p-4 mb-3" style="background: #f8f8f8;">
					<div class="d-flex justify-content-between text-body-secondary small mb-2">
						<span>답변자: ${pvo.id}</span>
						<span>${pvo.dbday}</span>
					</div>
					<div style="white-space: pre-line;">${pvo.content}</div>
				</div>

				<form id="answerEditForm" action="../admin/qna_answer_update.do" method="post" style="display: none;">
					<input type="hidden" name="qna_no" value="${vo.qna_no}">
					<input type="hidden" name="parent_no" value="${pvo.qna_no}">
					<textarea name="answer" class="form-control mb-3" rows="5">${pvo.content}</textarea>
					<button type="submit" class="btn btn-dark px-4">저장</button>
					<button type="button" class="btn btn-outline-secondary px-4" id="cancelBtn">취소</button>
				</form>
				
				<div id="answerBtns">
					<div class="d-flex gap-2">
						<button type="button" class="btn btn-outline-dark px-4" id="updateBtn">수정</button>
						<button type="button" class="btn btn-outline-danger px-4" id="deleteBtn" data-no="${pvo.qna_no}" data-origin="${vo.qna_no }">삭제</button>
					</div>
				</div>
			</c:otherwise>

		</c:choose>
	</div>

	<div class="mt-4">
		<a href="../admin/qna_list.do" class="btn btn-outline-dark px-4">목록</a>
	</div>

</body>
</html>