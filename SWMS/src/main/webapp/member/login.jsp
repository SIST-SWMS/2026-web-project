<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  <section class="py-5">
    <div class="container-fluid">
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
          <div class="border rounded-4 p-4 p-md-5 shadow-sm">
            <h3 class="fw-bold text-center mb-4">로그인</h3>

            <%-- 에러 메시지 영역 (기본 숨김, 아이디/비번 틀렸을 때 스크립트에서 show()) --%>
            <div id="loginMsg" class="alert alert-danger" style="display:none;">
              아이디 또는 비밀번호가 일치하지 않습니다.
            </div>

            <div class="mb-3">
              <label for="id" class="form-label fw-bold">아이디</label>
              <input type="text" class="form-control form-control-lg bg-light" id="id" name="id" placeholder="아이디 입력">
            </div>

            <div class="mb-4">
              <label for="pwd" class="form-label fw-bold">비밀번호</label>
              <input type="password" class="form-control form-control-lg bg-light" id="pwd" name="pwd" placeholder="비밀번호 입력">
            </div>

            <button class="btn btn-primary btn-lg w-100 mb-3" type="button" id="loginBtn">로그인</button>

            <a href="join.do" class="btn btn-outline-dark btn-lg w-100">회원가입</a>

          </div>
        </div>
      </div>
    </div>
  </section>

  <%-- 로그인 페이지 전용 스크립트 --%>
  <script>
    $(function() {
      $('#loginBtn').on('click', function() {
        var id = $('#id').val();
        var pwd = $('#pwd').val();

        // TODO: 실제로는 서버(login.do)로 값을 보내 검증합니다.
        // 아래는 에러 메시지 표시 예시입니다.
        // 서버 응답이 "실패"일 때 이 부분을 실행하세요.
        if (id === '' || pwd === '') {
          $('#loginMsg').text('아이디와 비밀번호를 입력하세요.').show();
          return;
        }

        // 예시: 검증 실패 시 에러 메시지 노출
        // $('#loginMsg').text('아이디 또는 비밀번호가 일치하지 않습니다.').show();

        // 예시: 검증 성공 시 페이지 이동
        // location.href = 'main.do';
      });
    });
  </script>
