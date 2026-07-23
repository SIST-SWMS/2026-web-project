<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">대시보드</h4>
	

	<div class="row g-3 mb-3">

		<div class="col-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">오늘 주문건수</div>
				<div class="fs-3 fw-bold">${order}건</div>
			</div>
		</div>

		<div class="col-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">이번 달 매출액</div>
				<div class="fs-3 fw-bold"><fmt:formatNumber value="${price}" type="number"/>원</div>
			</div>
		</div>

		<div class="col-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">재고 부족 상품 (10개 이하)</div>
				<div class="fs-3 fw-bold text-warning">${stock}개</div>
			</div>
		</div>

		<div class="col-3">
			<div class="border rounded-4 p-4 h-100">
				<div class="text-body-secondary small mb-2">미처리 출고 건수</div>
				<div class="fs-3 fw-bold text-danger">${delivery}건</div>
			</div>
		</div>

	</div>

	<div class="row g-3 mb-5">

		<div class="col-lg-6">
			<div class="border rounded-4 p-4 h-100">
				<div class="fw-bold mb-3">많이 팔린 상품 TOP 5</div>
				<canvas id="bestChart" height="180"></canvas>
			</div>
		</div>

		<div class="col-lg-6">
			<div class="border rounded-4 p-4 h-100">
				<div class="fw-bold mb-3">판매액 추이</div>
				<canvas id="salesChart" height="180"></canvas>
			</div>
		</div>

	</div>

	<div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
		<h5 class="fw-bold mb-0">최근 주문</h5>
		<a href="../admin/stockout.do" class="text-body-secondary text-decoration-none small">더보기 ›</a>
	</div>

	<table class="table align-middle mb-5">
		<thead>
			<tr class="text-body-secondary">
				<th>주문번호</th>
				<th>회원ID</th>
				<th>상품명</th>
				<th class="text-center">수량</th>
				<th class="text-center">주문일</th>
				<th class="text-center">처리상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="o" items="${oList}">
				<tr>
					<td class="fw-bold">${o.ovo.order_no}</td>
					<td>${o.ovo.id}</td>
					<td>${o.gvo.goods_name}</td>
					<td class="text-center">${o.quantity}</td>
					<td class="text-center text-body-secondary">${o.ovo.dbday}</td>
					<td class="text-center">
						<c:if test="${o.status == '결제완료'}">
							<span class="badge bg-secondary">처리필요(미출고)</span>
						</c:if>
						<c:if test="${o.status == '배송완료'}">
							<span class="badge bg-success">배송완료</span>
						</c:if>
						<c:if test="${o.status == '반품요청'}">
							<span class="badge bg-secondary">처리필요</span>
						</c:if>
						<c:if test="${o.status == '반품완료'}">
							<span class="badge bg-success">반품완료</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${empty oList}">
				<tr>
					<td colspan="6" class="text-center text-body-secondary py-4">주문 내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
		<h5 class="fw-bold mb-0">미답변 QNA</h5>
		<a href="../admin/qna_list.do" class="text-body-secondary text-decoration-none small">더보기 ›</a>
	</div>

	<table class="table align-middle">
		<thead>
			<tr class="text-body-secondary">
				<th class="text-center" style="width: 80px;">번호</th>
				<th>문의제목</th>
				<th class="text-center">작성자</th>
				<th class="text-center">등록일</th>
				<th class="text-center">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="q" items="${qList}">
				<tr>
					<td class="text-center">${q.qna_no}</td>
					<td>
						<a href="qna_view.do?no=${q.qna_no}" class="text-dark text-decoration-none">${q.subject}</a>
					</td>
					<td class="text-center">${q.id}</td>
					<td class="text-center text-body-secondary">${q.dbday}</td>
					<td class="text-center">
						<span class="badge bg-danger">${q.status}</span>
					</td>
				</tr>
			</c:forEach>

			<c:if test="${empty qList}">
				<tr>
					<td colspan="6" class="text-center text-body-secondary py-4">미답변 문의가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<script>
		/* 신발 차트 */
		let names = []
		let counts = []
	
		<c:forEach var="b" items="${bestList}">
			names.push('${b.goods_name}')
			counts.push(${b.quantity})
		</c:forEach>
	
		new Chart(document.getElementById('bestChart'), {
			type : 'bar',
			data : {
				labels : names,
				datasets : [ {
					label : '판매수량',
					data : counts,
					backgroundColor : '#0d6efd',
					borderRadius : 4
				} ]
			},
			options : {
				indexAxis : 'y',        
				plugins : {
					legend : {
						display : false
					}
				},
				scales : {
					x : {
						beginAtZero : true
					}
				}
			}
		})
		
		/* 매출액 차트 */
		let labels = []
		let data = []
	
		<c:forEach var="s" items="${salesList}">
			labels.push('${s.sale_date}')
			data.push(${s.total})
		</c:forEach>
	
		new Chart(document.getElementById('salesChart'), {
			type : 'line',
			data : {
				labels : labels,
				datasets : [ {
					label : '판매액',
					data : data,
					borderColor : '#0d6efd',
					backgroundColor : 'rgba(13, 110, 253, 0.1)',
					fill : true,
					tension : 0.3
				} ]
			},
			options : {
				plugins : {
					legend : {
						display : false
					},
					tooltip : {
						callbacks : {
							label : function(ctx) {
								return ctx.parsed.y.toLocaleString() + '원'
							}
						}
					}
				},
				scales : {
					y : {
						beginAtZero : true,
						ticks : {
							callback : function(value) {
								return value.toLocaleString()
							}
						}
					}
				}
			}
		})
	</script>
</body>
</html>