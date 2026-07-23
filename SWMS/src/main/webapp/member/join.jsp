<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript"
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	$(function() {

		// 우편번호 검색
		$('#postSearch').click(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					$('#zipcode').val(data.zonecode);
					$('#address').val(data.roadAddress);
					$('#address_detail').focus();
				}
			}).open();
		});

		// 아이디 중복체크
		$('#idCheck').click(
				function() {

					window.open('../member/idcheck.do', 'idcheck',
							'width=500,height=300');

				});

		// 닉네임 중복체크
		$('#nickCheck').click(
				function() {

					window.open('../member/nickcheck.do', 'nickcheck',
							'width=500,height=300');

				});

		// 회원가입 검사
		$('#joinBtn').click(function(e) {

			if ($('#id').val().trim() == "") {
				alert("아이디를 입력하세요.");
				$('#id').focus();
				e.preventDefault();
				return;
			}

			if ($('#pwd').val().trim() == "") {
				alert("비밀번호를 입력하세요.");
				$('#pwd').focus();
				e.preventDefault();
				return;
			}
			
			//비밀번호가 8자 이상? => 비밀번호는 문자열 => 문자열은 몇글자인지 길이를 알 수 있음
			// 비밀번호에 공백  여부		
			if($('#pwd').val().length < 8 || $('#pwd').val().includes(" "))
				{
				  alert("비밀번호 조건을 확인해주세요."); // 팝업창 띄우기
				  $('#pwd').focus(); // 커서를 비밀번호 입력칸에
				  e.preventDefault(); // 다음 단계로 넘어가는 거 방지
				  return; // 여기서 함수 끝내라
				}
			

			if ($('#pwd').val() != $('#pwd2').val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$('#pwd2').focus();
				e.preventDefault();
				return;
			}

		});

	});
</script>

</head>
<body>

	<section class="py-5">

		<div class="container-fluid">

			<div class="row justify-content-center">

				<div class="col-md-6 col-lg-5">

					<div class="border rounded-4 p-4 p-md-5 shadow-sm">

						<h3 class="fw-bold text-center mb-4">회원가입</h3>

						<form method="post" action="../member/join_ok.do">

							<!-- 아이디 -->
							<div class="mb-3">
								<label class="form-label fw-bold">아이디</label>

								<div class="input-group">

									<input type="text"
										class="form-control form-control-lg bg-light" id="id"
										name="id">

									<button class="btn btn-outline-dark" type="button" id="idCheck">
										중복체크</button>

								</div>

								<div id="idMsg"></div>

							</div>


							<!-- 비밀번호 -->

							<div class="mb-3">

								<label class="form-label fw-bold">비밀번호</label> 
								<input
									type="password" class="form-control form-control-lg bg-light"
									id="pwd" name="pwd">

								<div id="pwdMsg"></div>

							</div>


							<!-- 비밀번호 확인 -->

							<div class="mb-3">

								<label class="form-label fw-bold">비밀번호 확인</label> <input
									type="password" class="form-control form-control-lg bg-light"
									id="pwd2" name="pwd2">

							</div>


							<!-- 이름 -->

							<div class="mb-3">

								<label class="form-label fw-bold">이름</label> <input type="text"
									class="form-control form-control-lg bg-light" id="name"
									name="name">

							</div>


							<!-- 닉네임 -->

							<div class="mb-3">

								<label class="form-label fw-bold">닉네임</label>

								<div class="input-group">

									<input type="text"
										class="form-control form-control-lg bg-light" id="nickname"
										name="nickname">

									<button class="btn btn-outline-dark" type="button"
										id="nickCheck">중복체크</button>

								</div>

								<div id="nickMsg"></div>

							</div>


							<!-- 우편번호 -->

							<div class="mb-3">

								<label class="form-label fw-bold">우편번호</label>

								<div class="input-group">

									<input type="text"
										class="form-control form-control-lg bg-light" id="zipcode"
										name="zipcode" readonly>

									<button class="btn btn-outline-dark" type="button"
										id="postSearch">우편번호 검색</button>

								</div>

							</div>


							<!-- 주소 -->

							<div class="mb-3">

								<label class="form-label fw-bold">주소</label> <input type="text"
									class="form-control form-control-lg bg-light" id="address"
									name="address" readonly>

							</div>


							<!-- 상세주소 -->

							<div class="mb-3">

								<label class="form-label fw-bold">상세주소</label> <input
									type="text" class="form-control form-control-lg bg-light"
									id="address_detail" name="address_detail">

							</div>


							<!-- 연락처 -->

							<div class="mb-4">

								<label class="form-label fw-bold">전화번호</label> <input
									type="text" class="form-control form-control-lg bg-light"
									id="phone" name="phone" placeholder="010-0000-0000">

							</div>


							<button class="btn btn-primary btn-lg w-100 mb-2" type="submit"
								id="joinBtn">회원가입</button>

							<button class="btn btn-secondary btn-lg w-100" type="button"
								onclick="history.back()">취소</button>

						</form>

					</div>

				</div>

			</div>

		</div>

	</section>

</body>
</html>