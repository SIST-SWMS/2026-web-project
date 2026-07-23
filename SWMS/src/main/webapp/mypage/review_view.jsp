<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4">
		<h4 class="fw-bold mb-0">리뷰 상세</h4>        
		  <a href="../mypage/reviewList.do" class="btn btn-outline-secondary">목록으로</a>
	</div>

	<%-- 상품 정보 --%>

	<div class="d-flex align-items-center gap-3 pb-4 border-bottom mb-4">
		<img src="${vo.goods.poster_url }" width="70"
			height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
		<div>		
			<div class="fw-bold">${vo.goods.goods_name}</div>
			<%-- <div class="text-body-secondary small">${review.productName}</div> --%>
		</div>
	</div>
	<%-- 별점 (rating 값만큼 채운 별) --%>
	<div class="mb-3">
		<span class="d-inline-flex"> <c:forEach var="i" begin="1"
				end="5">
				<c:if test="${i <= vo.hit}">
					<svg width="24" height="24" viewBox="0 0 12 12"
						class="text-warning">
						<use xlink:href="#star-solid"></use></svg>
				</c:if>
				<c:if test="${i > vo.hit}">
					<svg width="24" height="24" viewBox="0 0 12 12"
						class="text-secondary">
						<use xlink:href="#star-outline"></use></svg>
				</c:if>
			</c:forEach>
		</span> <span class="text-body-secondary small ms-2">${vo.created_at}</span>
	</div>

	<%-- 리뷰 사진 (있을 때만) --%>
	<c:if test="${not empty review.image}">
		<div class="mb-3">
			<img src="#   
				style="width: 160px; height: 160px; object-fit: cover; border-radius: 8px;" 
				alt="리뷰 사진">    <!--  ../resources/images/${review.image} -->
		</div>
	</c:if>

	<%-- 제목 + 내용 --%>
	<%-- <span class="text-body-secondary">작성자 : ${vo.nickname}</span> --%>	
	<h5 class="fw-bold mb-2">${vo.subject}</h5>
	<div class="mb-4" style="white-space: pre-line;">${vo.content}</div>

	<%-- 수정 / 삭제 버튼 --%>
	<div class="d-flex gap-2 justify-content-end border-top pt-3">
		<a href="../mypage/review_edit.do?no=${vo.review_no}" class="btn btn-dark px-4">수정</a> 
		<!-- <a href="../mypage/review_edit.do" class="btn btn-dark px-4">수정</a>  -->
		<a href="#" class="btn btn-outline-danger px-4"
           onclick="if(confirm('삭제하시겠습니까?')){ location.href='../mypage/review_delete.do?no=${vo.review_no}'; } return false;">삭제</a>
           <!-- <a href="../mypage/review_delete.do" class="btn btn-outline-danger px-4">삭제</a> -->
	</div>
</body>
</html>