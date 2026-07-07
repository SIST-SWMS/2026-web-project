<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">회원정보수정</h4>

<div class="row">
  <div class="col-lg-8">

    <div class="mb-3">
      <label for="name" class="form-label fw-bold">이름</label>
      <input type="text" class="form-control form-control-lg bg-light" id="name" name="name" value="${member.name}">
    </div>

    <div class="mb-3">
      <label for="nickname" class="form-label fw-bold">닉네임</label>
      <div class="input-group">
        <input type="text" class="form-control form-control-lg bg-light" id="nickname" name="nickname" value="${member.nickname}">
        <button class="btn btn-outline-dark" type="button" id="btnNickCheck">중복확인</button>
      </div>
      <div id="nickMsg" class="small mt-1" style="display:none;"></div>
    </div>

    <div class="mb-3">
      <label for="pwd" class="form-label fw-bold">비밀번호</label>
      <input type="password" class="form-control form-control-lg bg-light" id="pwd" name="pwd" placeholder="변경할 비밀번호 입력">
    </div>

    <div class="mb-3">
      <label for="pwd2" class="form-label fw-bold">비밀번호 확인</label>
      <input type="password" class="form-control form-control-lg bg-light" id="pwd2" name="pwd2" placeholder="비밀번호 다시 입력">
    </div>

    <div class="mb-3">
      <label for="phone" class="form-label fw-bold">연락처</label>
      <input type="tel" class="form-control form-control-lg bg-light" id="phone" name="phone" value="${member.phone}">
    </div>

    <div class="mb-3">
      <label for="zipcode" class="form-label fw-bold">우편번호</label>
      <div class="input-group">
        <input type="text" class="form-control form-control-lg bg-light" id="zipcode" name="zipcode" value="${member.zipcode}" readonly>
        <button class="btn btn-outline-dark" type="button" id="btnAddr">우편번호검색</button>
      </div>
    </div>

    <div class="mb-3">
      <label for="address" class="form-label fw-bold">주소</label>
      <input type="text" class="form-control form-control-lg bg-light" id="address" name="address" value="${member.address}" readonly>
    </div>

    <div class="mb-4">
      <label for="detailAddress" class="form-label fw-bold">상세주소</label>
      <input type="text" class="form-control form-control-lg bg-light" id="detailAddress" name="detailAddress" value="${member.detailAddress}">
    </div>

    <div class="d-flex gap-2">
      <a href="#" class="btn btn-outline-secondary btn-lg w-50">취소</a>
      <button type="button" class="btn btn-dark btn-lg w-50">수정 완료</button>
    </div>

  </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  $(function() {
    // 닉네임 중복확인
    $('#btnNickCheck').on('click', function() {
      var nick = $('#nickname').val();
      if (nick === '') {
        $('#nickMsg').text('닉네임을 입력하세요.').css('color', 'red').show();
        return;
      }
      // TODO: 서버(checkNick.do)로 중복 여부 확인 후 아래 메시지 표시
      // 사용 가능: $('#nickMsg').text('사용 가능한 닉네임입니다.').css('color','green').show();
      // 중복:     $('#nickMsg').text('이미 사용 중인 닉네임입니다.').css('color','red').show();
    });

    // 우편번호 검색
    $('#btnAddr').on('click', function() {
      new daum.Postcode({
        oncomplete: function(data) {
          $('#zipcode').val(data.zonecode);
          $('#address').val(data.roadAddress);
          $('#detailAddress').focus();
        }
      }).open();
    });
  });
</script>
