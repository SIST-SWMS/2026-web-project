<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>


<div class="container mt-4">


    <h3 class="fw-bold mb-4 border-bottom border-dark border-2 pb-2">
        최근 본 상품
    </h3>



    <c:if test="${empty list}">

        <div class="text-center p-5 text-secondary">
            최근 본 상품이 없습니다.
        </div>

    </c:if>



    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">


        <c:forEach var="vo" items="${list}">


            <div class="col">


                <div class="card shadow-sm h-100">


                    <a href="../goods/detail.do?goods_no=${vo.goods_no}"
                       class="text-decoration-none text-dark">


                        <img src="${vo.poster_url}"
                             class="card-img-top"
                             width="180"
                             height="180"
                             style="object-fit:cover;">



                        <div class="card-body">


                            <h6 class="fw-bold">
                                ${vo.goods_name}
                            </h6>


                            <div class="text-secondary small mb-2">
                                ${vo.brand_name}
                            </div>


                            <div class="fw-bold">
                                ${vo.goods_price}
                            </div>


                        </div>


                    </a>


                </div>


            </div>


        </c:forEach>


    </div>


</div>