<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 상품 리스트 페이지 전용 스타일 --%>
<style>
.category-menu a {
	display: block;
	padding: 8px 0;
	color: #888;
	text-decoration: none;
	font-size: 15px;
}

.category-menu a:hover {
	color: #000;
}

.category-menu a.active {
	color: #000;
	font-weight: 700;
}

.product-card {
	position: relative;
}

.product-card .like-btn {
	position: absolute;
	right: 12px;
	bottom: 12px;
	background: #fff;
	border-radius: 50%;
	width: 34px;
	height: 34px;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 1px 4px rgba(0, 0, 0, .15);
	cursor: pointer;
	border: none;
}

.product-card .thumb-box {
	background: #f5f5f5;
	border-radius: 8px;
	overflow: hidden;
	aspect-ratio: 1/1;
	display: flex;
	align-items: center;
	justify-content: center;
}

.product-card .thumb-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.product-brand {
	font-size: 13px;
	color: #888;
	margin-top: 10px;
}

.product-name {
	font-size: 14px;
	color: #222;
	margin: 2px 0;
}

.product-price {
	font-size: 16px;
	font-weight: 700;
}

.product-meta {
	font-size: 12px;
	color: #999;
}

/* 페이지네이션 */
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
<script>
$(function() {
    let currentCno=${currentCno!=null ? currentCno : 1};
    let currentPage=${curPage!=null ? curPage : 1};

    function getProductList(cno, sortVal, pageNum) {
        currentPage = pageNum;
        $.ajax({
            type: 'GET',
            url: '../goods/goods_main_ajax.do',
            data: { category_no: cno, sort: sortVal, page: pageNum },
            success: function(res) {

                $('#product-list-box').html(res);
            },
            error: function() {
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    }

    $('.category-menu').on('click', '.category-btn', function(e) {
        e.preventDefault(); 
        $('.category-menu .category-btn').removeClass('active');
        $(this).addClass('active');
        
        currentCno=$(this).attr('data-cno');
        let sortVal=$('#sort-select').val();
        getProductList(currentCno, sortVal, 1); 
    });

    // 셀렉트박스 변경
    $('#sort-select').change(function() {
        let sortVal=$(this).val();
        getProductList(currentCno, sortVal, 1);
    });

    // 페이지네이션 클릭
    $('#product-list-box').on('click', '.page-link-btn', function(e) {
        e.preventDefault();
        let targetPage = $(this).attr('data-page');
        let sortVal = $('#sort-select').val();
        getProductList(currentCno, sortVal, targetPage);
    });
});
</script>
</head>
<body>
<div class="d-flex justify-content-end border-bottom pb-3 mb-4">
    <select id="sort-select" class="sort-select" style="width: 140px;">
        <option value="default">최신등록순</option> 
        <option value="price_asc">낮은가격순</option> 
        <option value="price_desc">높은가격순</option>
        <option value="hit_desc">조회수순</option>
    </select>
</div>

<div id="product-list-box">

    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="vo" items="${list}">
        <div class="col">
            <div class="product-card">
                <a href="../goods/detail.do?goods_no=${vo.goods_no}">
                    <div class="thumb-box">
                        <img src="${vo.poster_url}" alt="${vo.goods_name}">
                    </div>
                </a>
                <button type="button" class="like-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24">
                        <use xlink:href="#heart"></use>
                    </svg>
                </button>
                <div class="product-brand">${vo.brand_name}</div>
                <div class="product-name">${vo.goods_name}</div>
                <div class="product-price">${vo.goods_price}</div>
                <div class="product-meta">
                    <svg width="12" height="12" viewBox="0 0 24 24">
                    <use xlink:href="#heart"></use>
                    </svg>
                    ${vo.like_count}
                    <svg width="12" height="12" viewBox="0 0 12 12">
                    <use xlink:href="#eye"></use>
                    </svg>
                    ${vo.hit}
                </div>
            </div>
        </div>
        </c:forEach>
    </div>

    <div class="row text-center" style="margin-top: 40px">
        <div class="d-flex justify-content-center">
            <ul class="pagination">
                <c:if test="${startPage > 1}">
                    <li><a href="#" class="page-link-btn" data-page="${startPage - 1}">&laquo;</a></li>
                </c:if>
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <li ${i == curPage ? "class='active'" : ""}>
                        <a href="#" class="page-link-btn" data-page="${i}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${endPage < totalPage}">
                    <li><a href="#" class="page-link-btn" data-page="${endPage + 1}">&raquo;</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>


</body>
</html>