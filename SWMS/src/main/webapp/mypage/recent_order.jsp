<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%-- ===================== 최근 주문 ===================== --%>
	<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-3">
		<h4 class="fw-bold mb-0">최근 주문</h4>
		<a href="../mypage/recent_order.do" class="text-body-secondary text-decoration-none small"></a>
	</div>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">주문일</th>
				<th>주문내역</th>
				<th style="width: 220px;">주문번호</th>
				<th class="text-end" style="width: 120px;">결제금액</th>
				<th class="text-center" style="width: 110px;">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${list}">
    <tr>
        <td class="text-body-secondary">${vo.ovo.dbday}</td>
        <td>
            <div class="d-flex align-items-center gap-3">
                <img src="../resources/images/product-thumb-1.png"
                     width="60" height="60"
                     style="object-fit: cover; border-radius: 6px;"
                     alt="상품">
                <span>${vo.gvo.goods_name}</span>
            </div>
        </td>
        <td class="fw-bold">${vo.ovo.order_no}</td>
        <td class="text-end">${vo.ovo.total_price}</td>
        <td class="text-center"><span class="badge bg-success">${vo.ovo.delivery_status }</span></td>
    </tr>
</c:forEach>
		</tbody>
	</table>

	

</body>
</html>