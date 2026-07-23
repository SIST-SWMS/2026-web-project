<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<section class="py-5">
		<div class="container-fluid">

			<h2 class="fw-bold mb-4">주문 완료</h2>

			<div class="row g-4">
				<div class="row justify-content-center">
					<div class="col-lg-6 text-center">
						<div class="py-5 border-bottom text-center" style="height: 500px;">
							<i class="fw-bold fs-1 fa-solid fa-receipt"></i><div class="fw-bold fs-3 ">주문번호 : ${order_no }</div>
							<div class="fw-bold fs-3 ">결제가 완료되었습니다</div>
							<a href="../main/main.do" class="btn btn-outline-dark">메인으로</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>