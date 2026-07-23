<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<title>3hose</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="author" content="">
<meta name="keywords" content="">
<meta name="description" content="">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../resources/css/vendor.css">
<link rel="stylesheet" type="text/css" href="../resources/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap">
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
</head>
<body>

	<jsp:include page="icons.jsp"></jsp:include>

	<header>
		<div class="container-fluid">
			<div class="row py-3 border-bottom">

				<div class="col-sm-4 col-lg-3 text-center text-sm-start">
					<div class="main-logo">
						<a href="../main/main.do">
							<img src="../resources/images/logo.png" alt="logo" class="img-fluid">
						</a>
					</div>
				</div>

				<div class="col-sm-6 offset-sm-2 offset-md-0 col-lg-5 d-none d-lg-block">
					<form id="search-form" class="search-bar row bg-light p-2 my-2 rounded-4" action="../goods/find.do" method="get">

						<div class="col-md-4 d-none d-md-block">
							<select name="cno" class="form-select border-0 bg-transparent">
								<option value="0">All Categories</option>
								<option value="1">스포츠화</option>
								<option value="2">샌들/슬리퍼</option>
								<option value="3">라이프스타일</option>
								<option value="4">구두</option>
								<option value="5">부츠</option>
							</select>
						</div>

						<div class="col-11 col-md-7">
							<input type="text" name="fd" class="form-control border-0 bg-transparent text-center" placeholder="검색어를 입력하세요" required>
						</div>

						<div class="col-1">
							<button type="submit" class="border-0 bg-transparent text-dark p-0">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
				                    <path fill="currentColor" d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z" />
				                </svg>
							</button>
						</div>

					</form>
				</div>
				<div class="col-sm-8 col-lg-4 d-flex justify-content-end gap-5 align-items-center mt-4 mt-sm-0 justify-content-center justify-content-sm-end">
					<ul class="d-flex justify-content-end align-items-center list-unstyled m-0 gap-3">
						<c:if test="${sessionScope.id != null }">
							<li><a href="../mypage/likeList.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
									<svg width="18" height="18" viewBox="0 0 24 24">
								        <use xlink:href="#heart"></use>
								    </svg>
									<small>LIKE</small>
								</a></li>
							<li><a href="../cart/cart.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
									<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#cart"></use>
									</svg>
									<small>BAG</small>
								</a></li>
							<li><a href="../mypage/mypage.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
									<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#user"></use>
									</svg>
									<small>MY</small>
								</a></li>
							<c:if test="${sessionScope.auth == 'adm' }">
								<li><a href="../admin/admin.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
										<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#user"></use>
									</svg>
										<small>ADM</small>
									</a></li>
							</c:if>
							<li><a href="../member/logout.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
									<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#lock"></use>
									</svg>
									<small>LOGOUT</small>
								</a></li>
						</c:if>
						<c:if test="${sessionScope.id == null }">
							<li><a href="../member/login.do" class="d-flex align-items-center gap-1 text-dark text-decoration-none">
									<svg width="18" height="18" viewBox="0 0 24 24">
										<use xlink:href="#lock"></use>
									</svg>
									<small>LOGIN</small>
								</a></li>
						</c:if>
					</ul>

				</div>

			</div>
		</div>
		<div class="container-fluid">
			<div class="row py-3">
				<div class="d-flex  justify-content-center justify-content-sm-between align-items-center">
					<nav class="main-menu d-flex navbar navbar-expand-lg">

						<button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
							<span class="navbar-toggler-icon"></span>
						</button>

						<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar">

							<div class="offcanvas-header justify-content-center">
								<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
							</div>

							<div class="offcanvas-body">

								<ul class="navbar-nav justify-content-end menu-list list-unstyled d-flex gap-md-5 mb-0 text-black text-uppercase fw-bold">
									<li class="nav-item active"><a href="../goods/list.do?cno=1" class="nav-link">스포츠화</a></li>
									<li class="nav-item active"><a href="../goods/list.do?cno=2" class="nav-link">샌들/슬리퍼</a></li>
									<li class="nav-item active"><a href="../goods/list.do?cno=3" class="nav-link">라이프스타일</a></li>
									<li class="nav-item active"><a href="../goods/list.do?cno=4" class="nav-link">구두</a></li>
									<li class="nav-item active"><a href="../goods/list.do?cno=5" class="nav-link">부츠</a></li>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</div>
		</div>
	</header>
</body>
</html>