<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	$('#postSearch').on('click', function(){
		new daum.Postcode({
			oncomplete:function(data){
				$('#zipcode').val(data.zonecode);
				$('#address').val(data.roadAddress);
				// 상세주소 입력칸으로 커서 이동
				$('#detailAddress').focus();
			}
		}).open()		
	})
})
</script>
</head>
<body>
	<section class="py-5">
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-5">
					<div class="border rounded-4 p-4 p-md-5 shadow-sm">
						<h3 class="fw-bold text-center mb-4">회원가입</h3>

						<div class="mb-3">
							<label for="id" class="form-label fw-bold">이름</label> 
							<input type="text" class="form-control form-control-lg bg-light" id="id" name="id">
						</div>

						<div class="mb-3">
							<label for="pwd" class="form-label fw-bold">비밀번호</label> 
							<input type="password" class="form-control form-control-lg bg-light" id="pwd" name="pwd" >
						</div>

						<div class="mb-3">
							<label for="pwd2" class="form-label fw-bold">비밀번호 확인</label>
							<input type="password" class="form-control form-control-lg bg-light" id="pwd2" name="pwd2" placeholder="비밀번호 다시 입력">
						</div>

						<div class="mb-3">
							<label for="joinName" class="form-label fw-bold">닉네임</label> <input
								type="text" class="form-control form-control-lg bg-light" id="joinName" name="joinName" placeholder="홍길동">
						</div>
						
						<div class="mb-3">
							<label for="zipcode" class="form-label fw-bold">우편번호</label>
							<div class="input-group">
								<input type="text" class="form-control form-control-lg bg-light" id="zipcode" name="zipcode" readonly>
								<button class="btn btn-outline-dark" type="button" id="postSearch">우편번호검색</button>
							</div>
						</div>
						
						<div class="mb-3">
							<label for="address" class="form-label fw-bold">주소</label>
							<input type="text" class="form-control form-control-lg bg-light" id="address" name="address" readonly>
						</div>
						
						<div class="mb-4">
							<label for="detailAddress" class="form-label fw-bold">상세주소</label>
							<input type="text" class="form-control form-control-lg bg-light" id="detailAddress" name="detailAddress" placeholder="상세주소를 입력하세요">
						</div>

						<div class="mb-4">
							<label for="joinPhone" class="form-label fw-bold">연락처</label> 
							<input type="tel" class="form-control form-control-lg bg-light" id="joinPhone" name="joinPhone" placeholder="010-0000-0000">
						</div>


						<button class="btn btn-primary btn-lg w-100 mb-3" type="button">회원가입</button>

					</div>
				</div>
			</div>
		</div>
	</section>

</body>
</html>