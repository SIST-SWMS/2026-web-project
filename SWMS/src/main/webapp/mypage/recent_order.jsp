<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최근 주문</title>
</head>
<body>

<!-- ===================== 최근 주문 ===================== -->
<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-3">
    <h4 class="fw-bold mb-0">최근 주문</h4>

    <a href="../mypage/recent_order.do"
       class="text-body-secondary text-decoration-none small">
        더보기 ›
    </a>
</div>

<table class="table align-middle">

    <thead>
        <tr class="text-body-secondary">
            <th style="width:120px;">주문일</th>
            <th>주문내역</th>
            <th style="width:220px;">주문번호</th>
            <th class="text-end" style="width:120px;">결제금액</th>
            <th class="text-center" style="width:110px;">상태</th>
        </tr>
    </thead>

    <tbody>

        <c:forEach var="vo" items="${list}">

            <tr>

                <td class="text-body-secondary">
                    ${vo.ovo.dbday}
                </td>

                <td>

                    <div class="d-flex align-items-center gap-3">

                        <a href="../mypage/orderListDetail.do?order_no=${vo.ovo.order_no}">
                            <img src="/uploads/${vo.gvo.poster_url}"
                                 width="70"
                                 height="70"
                                 style="object-fit:cover;border-radius:6px;">
                        </a>

                        <div>

                            <a href="../mypage/orderListDetail.do?order_no=${vo.ovo.order_no}"
                               class="text-decoration-none text-dark">
                                ${vo.gvo.goods_name}
                            </a>

                        </div>

                    </div>

                </td>

                <td class="fw-bold">
                    ${vo.ovo.order_no}
                </td>

                <td class="text-end">
                    ${vo.ovo.total_price}
                </td>

                <td class="text-center">

                    <c:choose>

                        <c:when test="${vo.ovo.delivery_status=='상품준비중'}">
                            <span class="badge"
                                  style="background:#fff3cd;color:#664d03;border:1px solid #ffecb5;font-size:12px;">
                                상품준비중
                            </span>
                        </c:when>

                        <c:when test="${vo.ovo.delivery_status=='배송중'}">
                            <span class="badge"
                                  style="background:#cfe2ff;color:#084298;border:1px solid #b6d4fe;font-size:12px;">
                                배송중
                            </span>
                        </c:when>

                        <c:when test="${vo.ovo.delivery_status=='배송완료'}">
                            <span class="badge"
                                  style="background:#d1e7dd;color:#0f5132;border:1px solid #badbcc;font-size:12px;">
                                배송완료
                            </span>
                        </c:when>

                        <c:when test="${vo.ovo.delivery_status=='주문취소'}">
                            <span class="badge"
                                  style="background:#f8d7da;color:#842029;border:1px solid #f5c2c7;font-size:12px;">
                                주문취소
                            </span>
                        </c:when>

                        <c:otherwise>
                            <span class="badge bg-secondary">
                                ${vo.ovo.delivery_status}
                            </span>
                        </c:otherwise>

                    </c:choose>

                </td>

            </tr>

        </c:forEach>

    </tbody>

</table>

</body>
</html>