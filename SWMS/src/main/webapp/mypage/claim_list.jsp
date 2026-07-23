<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소/교환/반품 내역</title>
</head>
<body>

	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">취소/교환/반품 내역</h4>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th style="width: 120px;">신청일</th>
				<th>상품내역</th>
				<th class="text-center" style="width: 110px;">구분</th>
				<th class="text-end" style="width: 120px;">금액</th>
				<th class="text-center" style="width: 110px;">처리상태</th>
			</tr>
		</thead>

		<tbody>

			<c:forEach var="vo" items="${list}">

				<tr>

					<td class="text-body-secondary">${vo.ovo.dbday}</td>

					<td>
						<div class="d-flex align-items-center gap-3">

							<img src="${vo.gvo.poster_url}" width="70" height="70" style="object-fit: cover; border-radius: 6px;">

							<div>${vo.gvo.goods_name}</div>

						</div>
					</td>

					<!-- 구분 -->
					<td class="text-center">

						<c:choose>

							<c:when test="${vo.status=='주문취소'}">
								<span class="badge bg-secondary">취소</span>
							</c:when>

							<c:when test="${vo.status=='교환접수' || vo.status=='교환완료'}">
								<span class="badge bg-warning text-dark">교환</span>
							</c:when>

							<c:when test="${vo.status=='반품완료' || vo.status=='환불완료'}">
								<span class="badge bg-danger">반품</span>
							</c:when>

							<c:otherwise>
								<span class="badge bg-secondary">-</span>
							</c:otherwise>

						</c:choose>

					</td>

					<!-- 금액 -->
					<td class="text-end">
						<fmt:formatNumber value="${vo.ovo.total_price}" pattern="#,###" />
						원
					</td>

					<!-- 처리상태 -->
					<td class="text-center">

						<c:choose>

							<c:when test="${vo.status=='주문취소'}">
								<span class="badge bg-secondary">주문취소</span>
							</c:when>

							<c:when test="${vo.status=='교환접수'}">
								<span class="badge bg-warning text-dark">교환접수</span>
							</c:when>

							<c:when test="${vo.status=='교환완료'}">
								<span class="badge bg-success">교환완료</span>
							</c:when>

							<c:when test="${vo.status=='반품접수'}">
								<span class="badge bg-danger">반품접수</span>
							</c:when>

							<c:when test="${vo.status=='환불완료'}">
								<span class="badge bg-success">환불완료</span>
							</c:when>

							<c:otherwise>
								<span class="badge bg-secondary"> ${vo.status} </span>
							</c:otherwise>

						</c:choose>

					</td>

				</tr>

			</c:forEach>

		</tbody>

	</table>

</body>
</html>