<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">회원정보수정</h4>


<form action="../member/update_ok.do" method="post">

	<input type="hidden" name="id" value="${member.id}">


	<div class="row">

		<div class="col-lg-8">


			<!-- 이름 -->
			<div class="mb-3">
				<label class="form-label fw-bold"> 이름 </label>

				<input type="text" class="form-control form-control-lg bg-light" name="name" value="${member.name}">
			</div>



			<!-- 닉네임 -->
			<div class="mb-3">

				<label class="form-label fw-bold"> 닉네임 </label>


				<input type="text" class="form-control form-control-lg bg-light" name="nickname" value="${member.nickname}">

			</div>



			<!-- 비밀번호 -->
			<div class="mb-3">

				<label class="form-label fw-bold"> 비밀번호 </label>

				<input type="password" class="form-control form-control-lg bg-light" name="pwd" placeholder="변경할 비밀번호 입력">

			</div>



			<!-- 전화번호 -->
			<div class="mb-3">

				<label class="form-label fw-bold"> 연락처 </label>

				<input type="text" class="form-control form-control-lg bg-light" name="phone" value="${member.phone}">

			</div>




			<!-- 우편번호 -->
			<div class="mb-3">

				<label class="form-label fw-bold"> 우편번호 </label>


				<div class="input-group">

					<input type="text" class="form-control form-control-lg bg-light" id="zipcode" name="zipcode" value="${member.zipcode}" readonly>


					<button type="button" class="btn btn-outline-dark" onclick="addrSearch()">우편번호검색</button>


				</div>

			</div>




			<!-- 주소 -->
			<div class="mb-3">

				<label class="form-label fw-bold"> 주소 </label>


				<input type="text" class="form-control form-control-lg bg-light" id="address" name="address" value="${member.address}" readonly>

			</div>





			<!-- 상세주소 -->
			<div class="mb-4">

				<label class="form-label fw-bold"> 상세주소 </label>


				<input type="text" class="form-control form-control-lg bg-light" name="address_detail" value="${member.address_detail}">

			</div>





			<div class="d-flex gap-2">


				<a href="../mypage/member_detail.do" class="btn btn-outline-secondary btn-lg w-50"> 취소 </a>



				<button type="submit" class="btn btn-dark btn-lg w-50">수정 완료</button>


			</div>


		</div>

	</div>


</form>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script>
	function addrSearch() {

		new daum.Postcode({

			oncomplete : function(data) {

				document.getElementById("zipcode").value = data.zonecode;

				document.getElementById("address").value = data.roadAddress;

			}

		}).open();

	}
</script>