<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#cancleBtn').on('click',function(){
		let no = $(this).attr("data-no")
		let order_no = $(this).attr("data-orderno")
		
		$.ajax({
			type:'post',
			url:'../mypage/order_cancel.do',
			data:{
				"no":no
			},
			success:function(result){
				alert("취소되었습니다.")
				location.href="../mypage/orderListDetail.do?order_no="+order_no
			}
		})
	})
	
	$('#returnBtn').on('click',function(){
		let no = $(this).attr("data-no")
		let order_no = $(this).attr("data-orderno")
		
		$.ajax({
			type:'post',
			url:'../mypage/order_return.do',
			data:{
				"no":no
			},
			success:function(result){
				alert("반품요청 되었습니다.")
				location.href="../mypage/orderListDetail.do?order_no="+order_no
			}
		})
	})
	
	$('#okBtn').on('click',function(){
		let no = $(this).attr("data-no")
		let order_no = $(this).attr("data-orderno")
		
		$.ajax({
			type:'post',
			url:'../mypage/order_ok.do',
			data:{
				"no":no
			},
			success:function(result){
				alert("구매확정 되었습니다.")
				location.href="../mypage/orderListDetail.do?order_no="+order_no
			}
		})
	})
	$('#reviewBtn').on('click',function(){
		let order_no = $(this).attr("data-no")
		let goods_no = $(this).attr("data-goodsno")
		location.href="../mypage/review.do?order_no="+order_no+"&goods_no="+goods_no
	})
})
</script>
</head>
<body>
	<c:set var="order" value="${list[0]}" />

	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">주문 상세보기</h4>

	<!-- 주문 정보 -->
	<div class="card shadow-sm mb-4">
		<div class="card-header fw-bold bg-light">주문 정보</div>

		<div class="card-body">
			<table class="table table-borderless align-middle mb-0">
				<tr>
					<th width="180">주문번호</th>
					<td>${order.ovo.order_no}</td>
				</tr>
				<tr>
					<th>주문일</th>
					<td>${order.ovo.dbday}</td>
				</tr>
				<tr>
					<th>주문상태</th>
					<td>

						<c:choose>

							<c:when test="${order.ovo.delivery_status=='상품준비중'}">
								<span class="badge" style="background: #fff3cd; color: #664d03; border: 1px solid #ffecb5; font-size: 14px;"> 상품준비중 </span>
							</c:when>

							<c:when test="${order.ovo.delivery_status=='배송중'}">
								<span class="badge" style="background: #cfe2ff; color: #084298; border: 1px solid #b6d4fe; font-size: 14px;"> 배송중 </span>
							</c:when>

							<c:when test="${order.ovo.delivery_status=='배송완료'}">
								<span class="badge" style="background: #d1e7dd; color: #0f5132; border: 1px solid #badbcc; font-size: 14px;"> 배송완료 </span>
							</c:when>

							<c:when test="${order.ovo.delivery_status=='주문취소'}">
								<span class="badge" style="background: #f8d7da; color: #842029; border: 1px solid #f5c2c7; font-size: 14px;"> 주문취소 </span>
							</c:when>

							<c:otherwise>
								<span class="badge bg-secondary"> ${order.ovo.delivery_status} </span>
							</c:otherwise>

						</c:choose>

					</td>
				</tr>
				<tr>
					<th>총 결제금액</th>
					<td class="fw-bold text-danger fs-5">
						<fmt:formatNumber value="${order.ovo.total_price}" pattern="#,###" />원
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 배송 정보 -->
	<div class="card shadow-sm mb-4">
		<div class="card-header fw-bold bg-light">배송 정보</div>

		<div class="card-body">
			<table class="table table-borderless align-middle mb-0">
				<tr>
					<th width="180">받는 사람</th>
					<td>${order.ovo.delivery_name}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${order.ovo.delivery_phone}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>${order.ovo.delivery_zipcode}</td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td>${order.ovo.delivery_addr}${order.ovo.delivery_addr_detail}</td>
				</tr>
				<tr>
					<th>배송메시지</th>
					<td>${order.ovo.delivery_msg}</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 주문 상품 -->
	<div class="card shadow-sm">
		<div class="card-header fw-bold bg-light">주문 상품</div>

		<div class="card-body">

			<c:forEach var="vo" items="${list}">

				<div class="row align-items-center border-bottom py-3">

					<div class="col-md-2 text-center">
						<c:choose>
							<c:when test="${fn:startsWith(vo.gvo.poster_url, 'http')}">
								<img src="${vo.gvo.poster_url}" width="90" height="90" style="object-fit: cover; border-radius: 8px;">
							</c:when>
							<c:otherwise>
								<img src="/SWMS/uploads/${vo.gvo.poster_url}"  width="90" height="90" style="object-fit: cover; border-radius: 8px;">
							</c:otherwise>
						</c:choose>
					</div>

					<div class="col-md-7">

						<div class="fw-bold fs-5 mb-2">${vo.gvo.goods_name}</div>

						<div class="text-secondary">사이즈 : ${vo.sizes}</div>

						<div class="text-secondary mb-2">수량 : ${vo.quantity}개</div>

						<c:choose>

							<c:when test="${order.status=='결제완료'}">
								<button id="cancleBtn" class="btn btn-sm btn-outline-danger" data-no="${vo.order_detail_no }" data-orderno="${order.ovo.order_no}">취소요청</button>
							</c:when>

							<c:when test="${order.status=='배송완료'}">
								<button id="returnBtn" class="btn btn-sm btn btn-outline-danger" data-no="${vo.order_detail_no }" data-orderno="${order.ovo.order_no}">반품요청</button>
								<button id="okBtn" class="btn btn-sm btn btn-outline-success" data-no="${vo.order_detail_no }" data-orderno="${order.ovo.order_no}">구매확정</button>
							</c:when>

							<c:when test="${order.status=='구매확정'}">
								<button id="reviewBtn" class="btn btn-sm btn-outline-dark" data-no="${vo.order_detail_no }" data-goodsno="${vo.goods_no }">리뷰작성</button>
							</c:when>

							<c:otherwise>
								<span class="badge bg-secondary"> ${order.status} </span>
							</c:otherwise>

						</c:choose>

					</div>

					<!-- 가격 -->
					<div class="col-md-3 text-end">

						<div class="fw-bold fs-4">
							<fmt:formatNumber value="${vo.price}" pattern="#,###" />원
						</div>

					</div>

				</div>

			</c:forEach>

		</div>
	</div>

	<div class="mt-4 text-end">
		<a href="../mypage/orderList.do" class="btn btn-outline-dark"> 이전 </a>
	</div>
</body>
</html>