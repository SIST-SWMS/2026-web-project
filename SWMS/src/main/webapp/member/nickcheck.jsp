<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복확인</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function(){

	$('#okBtn').click(function(){

		opener.document.getElementById("nickname").value='${nickname}';
		opener.document.getElementById("nickname").readOnly=true;

		window.close();

	});

});
</script>

</head>
<body>

<div class="container mt-4">

	<h4 class="text-center mb-3">닉네임 중복확인</h4>

	<form method="get" action="../member/nickcheck.do">

		<div class="input-group mb-3">

			<input type="text"
				name="nickname"
				class="form-control"
				value="${nickname}"
				placeholder="닉네임 입력">

			<button type="submit" class="btn btn-primary">
				확인
			</button>

		</div>

	</form>

	<c:if test="${nickname != null && nickname != ''}">

		<c:if test="${count==0}">

			<div class="alert alert-success">
				<b>${nickname}</b>는 사용 가능한 닉네임입니다.
			</div>

			<div class="text-center mt-3">
				<button type="button"
						id="okBtn"
						class="btn btn-primary">
					사용하기
				</button>
			</div>

		</c:if>

		<c:if test="${count>0}">

			<div class="alert alert-danger">
				<b>${nickname}</b>는 이미 사용 중인 닉네임입니다.
			</div>

		</c:if>

	</c:if>

</div>

</body>
</html>