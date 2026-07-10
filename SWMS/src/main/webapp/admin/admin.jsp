<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.admin-menu-title {
	font-weight: 700;
	margin-top: 24px;
	margin-bottom: 8px;
	font-size: 14px;
	color: #333;
}

.admin-menu a {
	display: block;
	padding: 8px 0;
	color: #666;
	text-decoration: none;
	font-size: 15px;
}

.admin-menu a:hover {
	color: #000;
}

.admin-menu a.active {
	color: #000;
	font-weight: 700;
}

.admin-title {
	font-size: 26px;
	font-weight: 700;
}
</style>
</head>
<body>
	<c:if test="${empty admin_content}">
		<c:set var="admin_content" value="../admin/dashboard.jsp" />
	</c:if>

	<section class="py-5">
		<div class="container-fluid">
			<div class="row">

				<div class="col-lg-2">
					<div class="admin-title mb-4">
						<a href="dashboard.do" class="text-dark text-decoration-none">관리자</a>
					</div>
					<nav class="admin-menu">
						<a href="../admin/goods_list.do" class="${admin_menu == 'goods' ? 'active' : ''}">상품 관리</a>
						<a href="../admin/stockin.do" class="${admin_menu == 'stockin' ? 'active' : ''}">입고 관리</a>
						<a href="../admin/stockout.do" class="${admin_menu == 'stockout' ? 'active' : ''}">출고 관리</a>
						<a href="../admin/io_list.do" class="${admin_menu == 'iolist' ? 'active' : ''}">입출고 조회</a>
						<a href="../admin/qna_list.do" class="${admin_menu == 'qna' ? 'active' : ''}">QNA 관리</a>
					</nav>
				</div>

				<!-- ================= 우측 콘텐츠 (교체) ================= -->
				<div class="col-lg-10">
					<jsp:include page="${admin_content}"></jsp:include>
				</div>

			</div>
		</div>
	</section>
</body>
</html>