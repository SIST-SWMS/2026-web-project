<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.star-rating svg {
	cursor: pointer;
	color: #ddd;
}

.star-rating svg.on {
	color: #ffc107;
}

.photo-upload {
	width: 100px;
	height: 100px;
	border: 1px solid #ddd;
	background: #333;
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 30px;
	cursor: pointer;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script>
	$(function() {
		$('#starRating svg').on('click', function() {
			var score = $(this).data('score');
			$('#ratingValue').val(score);
			// 클릭한 별까지 색칠
			$('#starRating svg').each(function(idx) {
				if (idx < score) {
					$(this).addClass('on');
				} else {
					$(this).removeClass('on');
				}
			});
		});
	});
</script>
</head>
<body>

	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">리뷰 등록</h4>
	<form action="../mypage/review_ok.do" method="post">
	 <c:forEach var="vo" items="${list }">
		<!-- 상품 정보 -->
		<input type="hidden" name="goods_no" value="${vo.goods_no}">
		<input type="hidden" name="order_no" value="${vo.order_no}">
		<div class="d-flex align-items-center gap-3 pb-4 border-bottom mb-4">
			<img src="${vo.goods.poster_url }" width="70" height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
			<div>
				<div class="fw-bold">${vo.goods.goods_name}</div>
				<!-- <div class="text-body-secondary small">릴리프 스티치 백팩 M_3Color/ 도난방지 RFID차단 여행가방</div> -->
			</div>
		</div>
     </c:forEach>
		<!-- 별점 -->
		<div class="mb-4">
			<div class="fw-bold mb-2">
				<span class="text-danger">*</span>
				상품은 어떠셨나요?
				<span class="text-body-secondary fw-normal">별점을 매겨주세요</span>
			</div>
			<div class="star-rating" id="starRating">
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="1">
				<use xlink:href="#star-solid"></use></svg>
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="2">
				<use xlink:href="#star-solid"></use></svg>
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="3">
				<use xlink:href="#star-solid"></use></svg>
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="4">
				<use xlink:href="#star-solid"></use></svg>
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="5">
				<use xlink:href="#star-solid"></use></svg>
			</div>
			<input type="hidden" id="ratingValue" name="rating" value="0">
		</div>

		<!-- 사진 업로드 -->
		<div class="mb-4 pb-4 border-bottom">
			<div class="fw-bold mb-2">상품 사진 또는 착용 사진을 올려주세요.</div>
			<label class="photo-upload"> + <input type="file" name="reviewImage" accept="image/*" hidden>
			</label>
		</div>

		<!-- 후기 -->
		<div class="mb-3">
			<div class="fw-bold mb-3">
				<span class="text-danger">*</span>
				사용 후기를 적어주세요
			</div>

			<div class="row mb-3">
				<label class="col-sm-1 col-form-label">제목</label>
				<div class="col-sm-11">
					<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요">
				</div>
			</div>

			<div class="row">
				<label class="col-sm-1 col-form-label">내용</label>
				<div class="col-sm-11">
					<textarea class="form-control" name="content" rows="6" placeholder="제품에 대해 만족스러웠던 점이나, 디자인·사용감·스타일링·사용 팁 등에 대해 남겨주세요."></textarea>
				</div>
			</div>
		</div>

		<!-- 버튼 -->
		<div class="d-flex gap-2 justify-content-center mt-4">
			<a href="../mypage/reviewList.do" class="btn btn-outline-secondary btn-lg px-5" onclick="javascript:history.back()">취소</a>
			<button type="submit" class="btn btn-dark btn-lg px-5">등록</button>
		</div>
	</form>

</body>
</html>