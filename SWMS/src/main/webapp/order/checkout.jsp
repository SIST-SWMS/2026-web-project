<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <section class="py-5">
    <div class="container-fluid">
      <h3 class="fw-bold mb-4">결제하기</h3>
      <div class="row g-5">

        <!-- 배송/결제 정보 -->
        <div class="col-lg-7">
          <div class="border rounded-4 p-4 mb-4">
            <h5 class="fw-bold mb-3">배송지 정보</h5>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">받는 사람</label>
                <input type="text" class="form-control bg-light" placeholder="홍길동">
              </div>
              <div class="col-md-6">
                <label class="form-label">연락처</label>
                <input type="tel" class="form-control bg-light" placeholder="010-0000-0000">
              </div>
              <div class="col-12">
                <label class="form-label">주소</label>
                <div class="input-group mb-2">
                  <input type="text" class="form-control bg-light" placeholder="우편번호">
                  <button class="btn btn-outline-dark" type="button">주소 찾기</button>
                </div>
                <input type="text" class="form-control bg-light mb-2" placeholder="기본 주소">
                <input type="text" class="form-control bg-light" placeholder="상세 주소">
              </div>
              <div class="col-12">
                <label class="form-label">배송 메모</label>
                <select class="form-select bg-light">
                  <option>배송 시 요청사항을 선택하세요</option>
                  <option>문 앞에 놓아주세요</option>
                  <option>경비실에 맡겨주세요</option>
                  <option>배송 전 연락 바랍니다</option>
                </select>
              </div>
            </div>
          </div>

          <div class="border rounded-4 p-4">
            <h5 class="fw-bold mb-3">결제 수단</h5>
            <div class="form-check mb-2">
              <input class="form-check-input" type="radio" name="pay" id="payCard" checked>
              <label class="form-check-label" for="payCard">신용/체크카드</label>
            </div>
            <div class="form-check mb-2">
              <input class="form-check-input" type="radio" name="pay" id="payTrans">
              <label class="form-check-label" for="payTrans">실시간 계좌이체</label>
            </div>
            <div class="form-check mb-2">
              <input class="form-check-input" type="radio" name="pay" id="payKakao">
              <label class="form-check-label" for="payKakao">카카오페이</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="pay" id="payToss">
              <label class="form-check-label" for="payToss">토스페이</label>
            </div>
          </div>
        </div>

        <!-- 주문 요약 -->
        <div class="col-lg-5">
          <div class="border rounded-4 p-4 bg-light position-sticky" style="top:20px;">
            <h5 class="fw-bold mb-3">주문 요약</h5>

            <ul class="list-group list-group-flush mb-3">
              <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center">
                <div class="d-flex gap-2 align-items-center">
                  <img src="../resources/images/product-thumb-1.png" width="48" height="48" style="object-fit:contain;" alt="item">
                  <div>
                    <div class="fw-bold small">클래식 러너 스니커즈</div>
                    <small class="text-body-secondary">260 / 수량 1</small>
                  </div>
                </div>
                <span>₩89,000</span>
              </li>
              <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center">
                <div class="d-flex gap-2 align-items-center">
                  <img src="../resources/images/product-thumb-2.png" width="48" height="48" style="object-fit:contain;" alt="item">
                  <div>
                    <div class="fw-bold small">레더 브라운 로퍼</div>
                    <small class="text-body-secondary">270 / 수량 1</small>
                  </div>
                </div>
                <span>₩112,000</span>
              </li>
            </ul>

            <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">상품 금액</span><span>₩201,000</span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">배송비</span><span>무료</span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">할인</span><span class="text-success">-₩20,100</span>
            </div>
            <hr>
            <div class="d-flex justify-content-between mb-4">
              <strong class="fs-5">총 결제금액</strong>
              <strong class="fs-5 text-primary">₩180,900</strong>
            </div>

            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="agree">
              <label class="form-check-label small" for="agree">주문 내용을 확인했으며 결제에 동의합니다.</label>
            </div>

            <button class="btn btn-primary btn-lg w-100">₩180,900 결제하기</button>
          </div>
        </div>
      </div>
    </div>
  </section>
