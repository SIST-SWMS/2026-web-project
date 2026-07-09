<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#loginBtn').on('click', function() {
		const id = $('#id').val().trim()
		const pwd = $('#pwd').val().trim()

		if (!id || !pwd) {
			$('#loginMsg').text('아이디와 비밀번호를 입력하세요.').show()
		}
		
		$.ajax({
			method:'POST',
			url:'../member/login_ok.do',
			data:{id, pwd},
			success:function(result){
				result = result.trim()
				console.log(result)
				if(result === 'NOID'){
					$('#loginMsg').text('존재하지 않는 아이디 입니다.').show()
					$('#id').val("").focus()
					$('#pwd').val("").focus()
				}
				else if(result === 'NOPWD') {
					$('#loginMsg').text('비밀번호가 일치하지 않습니다.').show()
					$('#pwd').val("").focus()
				}
				else {
					location.href="../main/main.do"
				}
			}
		})
	})
})
</script>
</head>
<body>
	<section class="py-5">
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="border rounded-4 p-4 p-md-5 shadow-sm">
						<h3 class="fw-bold text-center mb-4">로그인</h3>
						<div class="mb-3">
							<label for="id" class="form-label fw-bold">아이디</label>
							<input type="text" class="form-control form-control-lg bg-light" id="id" name="id" placeholder="아이디 입력">
						</div>
						<div class="mb-4">
							<label for="pwd" class="form-label fw-bold">비밀번호</label>
							<input type="password" class="form-control form-control-lg bg-light" id="pwd" name="pwd" placeholder="비밀번호 입력">
						</div>
						<div id="loginMsg" class="alert alert-danger" style="display: none;"></div>
						<button class="btn btn-primary btn-lg w-100 mb-3" type="button" id="loginBtn">로그인</button>
						<a href="../member/join.do" class="btn btn-outline-dark btn-lg w-100">회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>