<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
<script type="text/javascript">
	$(function() {
		$('#starRating svg').on('click', function() {
			var score = $(this).data('score');
			$('#ratingValue').val(score);
			$('#starRating svg').each(function(idx) {
				if (idx < score) {
					$(this).addClass('on');
				} else {
					$(this).removeClass('on');
				}
			});
		});
		
		$('#reviewImageInput').on('change', function(e) {
		    var file = e.target.files[0];
		    if (!file) return;

		    var reader = new FileReader();
		    reader.onload = function(event) {
		        $('#previewImg').attr('src', event.target.result).show();
		        $('#uploadPlus').hide();
		    };
		    reader.readAsDataURL(file);
		});
	});
</script>
</head>
<body>

	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">리뷰
		수정</h4>
    <form action="../mypage/review_edit_ok.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="review_no" value="${vo.review_no}">
	<%-- 상품 정보 --%>
	<div class="d-flex align-items-center gap-3 pb-4 border-bottom mb-4">
		<img src="${vo.goods.poster_url }" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div>
			<div class="fw-bold">${vo.goods.goods_name}</div>
			<%-- <div class="text-body-secondary small">${review.productName}</div> --%>
		</div>
	</div>

	<%-- 별점 (기존 rating 만큼 on 클래스로 채움) --%>
	<div class="mb-4">
		<div class="fw-bold mb-2">
			<span class="text-danger">*</span>상품은 어떠셨나요?
		</div>
		<div class="star-rating" id="starRating">
			<c:forEach var="i" begin="1" end="5">
				<svg width="30" height="30" viewBox="0 0 12 12" data-score="${i}"
					class="${i <= vo.hit ? 'on' : ''}">
					<use xlink:href="#star-solid"></use></svg>
			</c:forEach>
		</div>
		<input type="hidden" id="ratingValue" name="rating"
			value="${vo.hit }">
	</div>

	<%-- 사진 --%>
	<div class="mb-4 pb-4 border-bottom">
		<div class="fw-bold mb-2">상품 사진 또는 착용 사진을 올려주세요.</div>
		<div class="d-flex gap-2 align-items-center">
			<%-- 기존 사진 미리보기 (있을 때만) --%>
			<c:choose>
				<c:when test="${fn:startsWith(vo.image,'http')}">
					<img src="${vo.image_url}" class="w-100 rounded-3 mb-3" style="object-fit: cover; background: #f5f5f5;" alt="상품 상세 이미지">
				</c:when>
				<c:otherwise>
					<img src="/SWMS/uploads/${vo.image}" class="w-100 rounded-3 mb-3" style="object-fit: cover; background: #f5f5f5;" alt="상품 상세 이미지">
				</c:otherwise>
			</c:choose>
		<label class="photo-upload" id="photoUploadBox">
	        <span id="uploadPlus">+</span>
	        <img id="previewImg" style="display:none; width:100%; height:100%; object-fit:cover; border-radius:8px;">
	        <input type="file" id="reviewImageInput" name="reviewImage" accept="image/*" hidden>	        
	    </label>
		</div>
	</div>

	<%-- 제목 / 내용 (기존 값 바인딩) --%>
	<div class="mb-3">
		<div class="fw-bold mb-3">
			<span class="text-danger">*</span>사용 후기를 적어주세요
		</div>

		<div class="row mb-3">
			<label class="col-sm-1 col-form-label">제목</label>
			<div class="col-sm-11">
				<input type="text" class="form-control" name="title"
					value="${vo.subject}">
			</div>
		</div>

		<div class="row">
			<label class="col-sm-1 col-form-label">내용</label>
			<div class="col-sm-11">
				<textarea class="form-control" name="content" rows="6">${vo.content}</textarea>
			</div>
		</div>
	</div>

	<%-- 버튼 --%>
	<div class="d-flex gap-2 justify-content-center mt-4">
		<a href="../mypage/review_view.do?no=${vo.review_no}" class="btn btn-outline-secondary btn-lg px-5">취소</a>
		<button type="submit" class="btn btn-dark btn-lg px-5">수정 완료</button>
	</div>
    </form>

</body>
</html>