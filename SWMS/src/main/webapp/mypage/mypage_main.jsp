<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>

<!-- ===================== 최근 주문 ===================== -->
<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4">
    <h4 class="fw-bold mb-0">최근 주문</h4>

    <a href="../mypage/recent_order.do"
       class="text-body-secondary text-decoration-none small">
        더보기 ›
    </a>
</div>


<c:forEach var="vo" items="${list}">

<div class="card shadow-sm mb-3">

    <div class="card-body">

        <div class="row align-items-center">

            <!-- 이미지 -->
            <div class="col-md-2 text-center">

                <a href="../mypage/orderListDetail.do?order_no=${vo.ovo.order_no}">
                    <img src="${vo.gvo.poster_url}"
                         width="90"
                         height="90"
                         style="object-fit:cover;border-radius:8px;">
                </a>

            </div>


            <!-- 상품 정보 -->
            <div class="col-md-10">

                <a href="../mypage/orderListDetail.do?order_no=${vo.ovo.order_no}"
                   class="text-decoration-none text-dark fw-bold fs-5">

                    ${vo.gvo.goods_name}

                </a>


                <div class="text-secondary mt-2">
                    주문일 : ${vo.ovo.dbday}
                </div>


                <div class="text-secondary">
                    주문번호 : ${vo.ovo.order_no}
                </div>


                <!-- 상태 -->
                <div class="mt-2">

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

                </div>

            </div>

        </div>

    </div>

</div>

</c:forEach>



<!-- ===================== 나의 좋아요 ===================== -->

<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4 mt-5">

    <h4 class="fw-bold mb-0">
        나의 좋아요
    </h4>

    <a href="../mypage/likeList.do"
       class="text-body-secondary text-decoration-none small">
        더보기 ›
    </a>

</div>


<div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">

<c:if test="${empty likeList}">
    <div class="text-secondary">
        좋아요한 상품이 없습니다.
    </div>
</c:if>


<c:forEach var="vo" items="${likeList}">

    <div class="col">

        <a href="../goods/detail.do?goods_no=${vo.gvo.goods_no}"
           class="text-decoration-none text-dark">

            <img src="${vo.gvo.poster_url}"
                 width="150"
                 height="150"
                 style="object-fit:cover;border-radius:8px;">


            <div class="fw-bold mt-2">
                ${vo.gvo.goods_name}
            </div>


            <div class="text-secondary">
                ${vo.gvo.brand_name}
            </div>


            <div>
                ${vo.gvo.goods_price}
            </div>

        </a>

    </div>

</c:forEach>

</div>

</body>
</html>