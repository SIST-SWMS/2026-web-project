<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div
		class="d-flex justify-content-between align-items-center border-bottom border-dark border-2 pb-2 mb-4">
		<h4 class="fw-bold mb-0">1:1 문의</h4>
		<a href="../mypage/qna.do" class="btn btn-dark">문의하기</a>
	</div>
	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th class="text-center" style="width: 110px;">유형</th>
				<th>제목</th>
				<th class="text-center" style="width: 130px;">작성일</th>
				<th class="text-center" style="width: 110px;">답변상태</th>
			</tr>
		</thead>
		<tbody>
			<%-- 문의 1건 = tr 하나. <c:forEach var="qna" items="${qnaList}"> 로 반복 --%>
			<!-- <c:forEach var="qna" items="${qnaList}"> -->
			<c:forEach var="vo" items="${list}">
			<tr>
				 <td class="text-center">${vo.type }</td> 
				<td><a href="../mypage/qna_view.do" class="text-dark text-decoration-none">
						${vo.subject }</a></td>
				<td class="text-center text-body-secondary">${vo.created_at}</td>
				<td class="text-center"><span class="badge bg-success">${vo.status }</span></td>
			</tr> 
			</c:forEach>   
			 <!-- </c:forEach> -->

			<tr>
				<td class="text-center">배송 문의</td>
				<td><a href="#" class="text-dark text-decoration-none"> <svg
							width="14" height="14" viewBox="0 0 24 24">
							<use xlink:href="#lock"></use></svg> 비밀글입니다
				</a></td>
				<td class="text-center text-body-secondary">2026.06.28</td>
				<td class="text-center"><span class="badge bg-secondary">답변대기</span></td>
			</tr>

			<tr>
				<td class="text-center">재입고 문의</td>
				<td><a href="#" class="text-dark text-decoration-none">재입고
						예정 있나요?</a></td>
				<td class="text-center text-body-secondary">2026.06.15</td>
				<td class="text-center"><span class="badge bg-success">답변완료</span></td>
			</tr>

		</tbody>
	</table>
</body>
</html>