<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<head>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	
	$('#postBtn').on('click',function(){
		new daum.Postcode({
			oncomplete(data)
			{
				$('#post').val(data.zonecode)
				$('#addr1').val(data.address)
			}
		}).open()
	})
	
	$('#info-clean').on('click', function(){
		$('#name').val("")
		$('#phone').val("")
		$('#post').val("")
		$('#addr1').val("")
		$('#addr2').val("")
	})
	
	$('#success-order').on('click', function(){
		let isCheck = $('#agree').prop('checked')
		
		if(isCheck===false)
		{
			alert("결제 동의를 체크해주세요")
			return
		}
		if($('#name').val().trim()==="")
		{
			alert("배송지 정보 - 이름을 입력해주세요")
			return
		}
		if($('#phone').val().trim()==="")
		{
			alert("배송지 정보 - 연락처를 입력해주세요")
			return
		}
		if($('#post').val().trim()==="" || $('#addr1').val().trim()==="")
		{
			alert("배송지 정보 - 우편번호 찾기로 주소를 입력해주세요")
			return
		}
		
		let list_size = $('#list-size').val()
		let stock_no_list = []
		let goods_no_list = []
		let sizes_list = []
		let quantity_list = []
		let goods_price_list = []
		
		console.log('list_size: '+list_size)
		for(let i=0; i<list_size; i++)
		{
			stock_no_list.push($('#stock-no-'+i).val())
			goods_no_list.push($('#goods-no-'+i).val())
			sizes_list.push($('#sizes-'+i).val())
			quantity_list.push($('#quantity-'+i).val())
			goods_price_list.push($('#goods-price-'+i).val())
		}
		
 		console.log(stock_no_list)
		console.log(goods_no_list)
		console.log(sizes_list)
		console.log(quantity_list)
		console.log(goods_price_list)
		
		$.ajax({
			type:'post',
			url:'../order/order_ok.do',
			data:{
				name:$('#name').val(),
				phone:$('#phone').val(),
				zipcode:$('#post').val(),
				addr:$('#addr1').val(),
				addr_detail:$('#addr2').val(),
				msg:$('#msg').val(),
				total_price:${totalPrice},
				stock_no:stock_no_list.join(),
				goods_no:goods_no_list.join(),
				sizes:sizes_list.join(),
				quantity:quantity_list.join(),
				goods_price:goods_price_list.join(),
				list_size:$('#list-size').val(),
				cnList:$('#cnList').val()
			},
			success:function(result)
			{
				location.href="../order/complete_order.do"
			}
		})
	})
	
})
</script>
</head>


  <section class="py-5">
    <div class="container-fluid">
      <h3 class="fw-bold mb-4">결제하기</h3>
      <div class="row g-5">
        <!-- 배송/결제 정보 -->
        <div class="col-lg-7">
          <div class="border rounded-4 p-4 mb-4">
            <h5 class="fw-bold mb-3">배송지 정보</h5>
            <div class="text-end">
				<button class="btn btn-outline-dark btn-sm" id="info-clean" type="button">새 배송지 입력</button>
            </div>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">받는 사람</label>
                <input type="text" class="form-control bg-light" id="name" name="name" placeholder="홍길동" value="${mvo.name }" required>
              </div>
              <div class="col-md-6">
                <label class="form-label">연락처</label>
                <input type="tel" class="form-control bg-light" id="phone" name="phone" placeholder="010-0000-0000" value="${mvo.phone }" required>
              </div>
              <div class="col-12">
                <label class="form-label">주소</label>
                <div class="input-group mb-2">
                  <input type="text" class="form-control bg-light" id="post" name="post" placeholder="우편번호" readonly value="${mvo.zipcode }" required>
                  <button class="btn btn-outline-dark" type="button" id="postBtn">우편번호 찾기</button>
                </div>
                <input type="text" class="form-control bg-light mb-2" id="addr1" name="addr1" placeholder="기본 주소" readonly value="${mvo.address }" required>
                <input type="text" class="form-control bg-light" id="addr2" name="addr2" placeholder="상세 주소" value="${mvo.address_detail }">
              </div>
              <div class="col-12">
                <label class="form-label">배송 메모</label>
                <select class="form-select bg-light" id="msg" name="msg">
                  <option value="">배송 시 요청사항을 선택하세요</option>
                  <option>문 앞에 놓아주세요</option>
                  <option>경비실에 맡겨주세요</option>
                  <option>배송 전 연락 바랍니다</option>
                </select>
              </div>
            </div>
          </div>

			<%-- 결제 수단 선택 --%>
<!--           <div class="border rounded-4 p-4">
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
          </div> -->
        </div>

        <!-- 주문 요약 -->
        <div class="col-lg-5">
          <div class="border rounded-4 p-4 bg-light position-sticky" style="top:20px;">
            <h5 class="fw-bold mb-3">주문 요약</h5>

            <ul class="list-group list-group-flush mb-3">
            
            <c:forEach var="vo" items="${list }" varStatus="s">
              <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center">
                <div class="d-flex gap-2 align-items-center">
                  <img src="${vo.gvo.poster_url }" width="48" height="48" style="object-fit:contain;" alt="item">
                  <div>
                    <div class="fw-bold small">${vo.gvo.goods_name }</div>
                    <small class="text-body-secondary">${vo.sizes } / 수량 ${vo.quantity }</small>
                  </div>
                </div>
                <span>${vo.gvo.after_sPrice }원</span>
              <input type="hidden" id="goods-no-${s.index }" value="${vo.goods_no }">
              <input type="hidden" id="sizes-${s.index }" value="${vo.sizes }">
              <input type="hidden" id="quantity-${s.index }" value="${vo.quantity }">
              <input type="hidden" id="stock-no-${s.index }" value="${vo.stock_no }">
              <input type="hidden" id="goods-price-${s.index }" value="${vo.price }">
              <input type="hidden" id="list-size" value="${list_size }">
              <input type="hidden" id="cnList" value="${cnList }">
              </li>
              
              </c:forEach>
              
              <!-- 반복 폼 -->
              <!-- <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center">
                <div class="d-flex gap-2 align-items-center">
                  <img src="../resources/images/product-thumb-2.png" width="48" height="48" style="object-fit:contain;" alt="item">
                  <div>
                    <div class="fw-bold small">레더 브라운 로퍼</div>
                    <small class="text-body-secondary">270 / 수량 1</small>
                  </div>
                </div>
                <span>₩112,000</span>
              </li> -->
            </ul>

            <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">상품 금액</span><span>${totalPrice_str }원</span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">배송비</span><span>무료</span>
            </div>
            <!-- 할인금액 --%>
            <!-- <div class="d-flex justify-content-between mb-2">
              <span class="text-body-secondary">할인</span><span class="text-success">-₩20,100</span>
            </div> -->
            <hr>
            <div class="d-flex justify-content-between mb-4">
              <strong class="fs-5">총 결제금액</strong>
              <strong class="fs-5 text-primary">${totalPrice_str }원</strong>
            </div>

            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="agree">
              <label class="form-check-label small" for="agree">주문 내용을 확인했으며 결제에 동의합니다.</label>
            </div>

            <button class="btn btn-primary btn-lg w-100" id="success-order">${totalPrice_str }원 결제하기</button>
          </div>
        </div>
      </div>
    </div>
  </section>
