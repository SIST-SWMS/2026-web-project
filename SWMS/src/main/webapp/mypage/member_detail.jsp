<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
  .member-view { max-width: 760px; margin: 0 auto; }
  .member-view .row-line {
    display: flex;
    align-items: center;
    padding: 22px 4px;
    border-bottom: 1px solid #eee;
  }
  .member-view .row-label {
    width: 160px;
    color: #888;
    font-size: 15px;
  }
  .member-view .row-value {
    flex-grow: 1;
    color: #222;
    font-size: 15px;
  }
</style>

<div class="member-view py-2">

  <!-- 제목 + 가입일 -->
  <div class="d-flex justify-content-between align-items-end border-bottom border-dark border-2 pb-3 mb-2">
    <h4 class="fw-bold mb-0">회원정보</h4>
  </div>

  <!-- 이름 + 수정 버튼 -->
  <div class="row-line">
    <div class="row-label">이름</div>
    <div class="row-value">${member.name}</div>
    <a href="../member/editMember.do" class="btn btn-outline-dark">회원정보 변경</a>
  </div>

  <!-- 닉네임 -->
  <div class="row-line">
    <div class="row-label">닉네임</div>
    <div class="row-value">${member.nickname}</div>
  </div>

  <!-- 연락처 -->
  <div class="row-line">
    <div class="row-label">연락처</div>
    <div class="row-value">${member.phone}</div>
  </div>

  <!-- 우편번호 -->
  <div class="row-line">
    <div class="row-label">우편번호</div>
    <div class="row-value">${member.zipcode}</div>
  </div>

  <!-- 주소 -->
  <div class="row-line">
    <div class="row-label">주소</div>
    <div class="row-value">${member.address}</div>
  </div>

  <!-- 상세주소 -->
  <div class="row-line">
    <div class="row-label">상세주소</div>
    <div class="row-value">${member.detailAddress}</div>
  </div>

</div>
