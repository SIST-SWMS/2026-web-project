<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(function(){

	$('#okBtn').click(function(){

		opener.document.getElementById("id").value='${id}';
		opener.document.getElementById("id").readOnly=true;

		window.close();

	});

});
</script>

</head>
<body>

<div class="container mt-4">

	<h4 class="text-center mb-3">아이디 중복확인</h4>

	<form method="get" action="../member/idcheck.do">

		<div class="input-group mb-3">

			<input type="text"
				name="id"
				class="form-control"
				value="${id}"
				placeholder="아이디 입력">

			<button type="submit" class="btn btn-primary">
				확인
			</button>

		</div>

	</form>

	<c:if test="${id != null && id != ''}">

		<c:if test="${count==0}">

			<div class="alert alert-success">
				<b>${id}</b>는 사용 가능한 아이디입니다.
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
				<b>${id}</b>는 이미 사용 중인 아이디입니다.
			</div>

		</c:if>

	</c:if>

</div>

</body>
</html>