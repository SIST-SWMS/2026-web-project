<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style type="text/css">
.pagination {
	display: inline-flex;
	list-style: none;
	gap: 6px;
	padding: 0;
	margin: 0 auto;
}

.pagination li a {
	display: block;
	padding: 8px 14px;
	color: #333;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.refunds').on('click',function(){
		let order_detail_no = $(this).attr('data-dno')
		let order_no = $(this).attr('data-ono')
		let sizes = $(this).attr('data-size')
		let quantity = $(this).attr('data-quantity')
		let goods_no = $(this).attr('data-gno')
		
		
		if(!confirm("반품 처리하시겠습니까?")) return;
		$.ajax({
			type:'post',
			url:'../admin/return_ok.do',
			data:{"order_detail_no":order_detail_no,
					"sizes":sizes,
					"quantity":quantity,
					"goods_no":goods_no,
					"order_no":order_no},
			success:function(result){
				location.reload()
			}
		})
	})
	
	$('.deliverys').on('click', function(){
		let order_detail_no = $(this).attr('data-dno')
		let order_no = $(this).attr('data-ono')
		let sizes = $(this).attr('data-size')
		let quantity = $(this).attr('data-quantity')
		let goods_no = $(this).attr('data-gno')
		
        if(!confirm("출고 처리하시겠습니까?")) return;

        $.ajax({
            type: 'post',
            url: '../admin/delivery_ok.do',
            data: {"order_detail_no":order_detail_no,
					"sizes":sizes,
					"quantity":quantity,
					"goods_no":goods_no,
					"order_no":order_no},
            success: function(result){
            	if(result.trim() == 'YES'){
					location.reload()
				}
				else {
					alert("재고가 부족합니다")
					return
				}
            }
        });
    });
})	
</script>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">출고 처리</h4>

	<form action="stockout.do" method="get" class="border rounded-4 p-4 mb-4 bg-light">
		<div class="row g-3 align-items-end">

			<div class="col-md-3">
				<label class="form-label small text-body-secondary">주문 상태</label>
				<select name="status" class="form-select">
					<option value="">전체</option>
					<option value="PAID">결제완료(미출고)</option>
					<option value="DONE">배송완료</option>
				</select>
			</div>

			<div class="col-md-6">
				<label class="form-label small text-body-secondary">상품명 / 주문번호 / 회원ID</label>
				<input type="text" name="keyword" class="form-control" placeholder="검색어 입력" value="${param.keyword}">
			</div>

			<div class="col-md-3 d-flex gap-2">
				<button type="submit" class="btn btn-dark flex-fill">검색</button>
				<a href="stockout.do" class="btn btn-outline-secondary flex-fill">초기화</a>
			</div>

		</div>
	</form>

	<table class="table align-middle text-center">
		<thead>
			<tr class="text-body-secondary">
				<th>주문번호</th>
				<th>회원ID</th>
				<th>상품명</th>
				<th style="width: 70px;">사이즈</th>
				<th style="width: 60px;">수량</th>
				<th style="width: 110px;">주문일</th>
				<th style="width: 100px;">주문상태</th>
				<th style="width: 110px;">출고처리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${list }">
				<tr>
					<td class="fw-bold">${vo.ovo.order_no }</td>
					<td>${vo.ovo.id }</td>
					<td class="text-start">${vo.gvo.goods_name }</td>
					<td>${vo.sizes }</td>
					<td>${vo.quantity }</td>
					<td class="text-body-secondary">${vo.ovo.dbday }</td>
					<td>
						<span class="badge bg-secondary">${vo.status }</span>
					</td>
					<td>
						<c:choose>
							<c:when test="${vo.status == '반품요청'}">
								<button type="button" class="btn btn-sm btn-danger refunds" data-ono="${vo.ovo.order_no }" data-dno="${vo.order_detail_no }" data-size="${vo.sizes }" data-quantity="${vo.quantity }" data-gno="${vo.gvo.goods_no }">환불처리</button>
							</c:when>
							<c:when test="${vo.status == '결제완료'}">
								<button type="button" class="btn btn-sm btn-dark deliverys" data-ono="${vo.ovo.order_no }" data-dno="${vo.order_detail_no }" data-size="${vo.sizes }" data-quantity="${vo.quantity }" data-gno="${vo.gvo.goods_no }">출고처리</button>
							</c:when>
							<c:otherwise>
								<span class="badge bg-secondary">처리완료</span>
							</c:otherwise>
						</c:choose>
					</td>

				</tr>
			</c:forEach>
		</tbody>
	</table>

	<%-- ===================== 페이지네이션 ===================== --%>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${startPage > 1}">
				<li><a href="stockout.do?page=${startPage - 1}">&laquo;</a></li>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<li ${i == curPage ? "class='active'" : ""}><a href="stockout.do?page=${i}">${i}</a></li>
			</c:forEach>
			<c:if test="${endPage < totalPage}">
				<li><a href="stockout.do?page=${endPage + 1}">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>