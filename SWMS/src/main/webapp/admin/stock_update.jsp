<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
	$(function() {

		$('#stockinForm').on('submit', function(e) {

			let changed = 0

			$('.qty-input').each(function() {

				let no = $(this).attr('data-no')
				let qty = $(this).val().trim()
				let origin = $(this).attr('data-origin').trim()

				if (qty === "" || Number(qty) < 0) {
					alert("수량은 0 이상 입력해야 합니다.")
					$(this).focus()
					error = true
					return false
				}

				if (qty !== origin) {
					$(this).attr('name', 'quantities')
					$('#no' + no).attr('name', 'stock_nos')
					$('#size' + no).attr('name', 'sizes')
					changed++
				}
			})

			if (changed === 0) {
				alert("변경된 수량이 없습니다.")
				e.preventDefault()
				return
			}

			if (!confirm("수량 변경 시 재고에 즉시 반영됩니다. 저장하시겠습니까?")) {
				return
			}
		})
	})
</script>
</head>
<body>
	<div class="container-fluid py-4">

		<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입고 수정</h4>

		<div class="alert alert-warning">수량 변경 시 재고에 즉시 반영됩니다.</div>

		<form id="stockinForm" action="../admin/stock_update_ok.do" method="post" style="max-width: 860px;">

			<input type="hidden" name="goods_no" value="${vo.goods_no}">

			<div class="mb-3">
				<label class="form-label fw-bold">상품코드</label>
				<input type="text" class="form-control" value="${vo.goods_code}" readonly style="background: #f5f5f5;">
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">상품명</label>
				<input type="text" class="form-control" value="${vo.goods_name}" readonly style="background: #f5f5f5;">
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">브랜드</label>
				<input type="text" class="form-control" value="${vo.brand_name}" readonly style="background: #f5f5f5;">
			</div>

			<!-- 사이즈별 수량 수정 -->
			<div class="border rounded-4 p-4 mb-3">
				<div class="mb-3">
					<span class="fw-bold">사이즈별 재고 수량</span>
					<div class="form-text mb-0">수정할 수량을 입력하세요. 변경된 사이즈만 저장됩니다.</div>
				</div>

				<table class="table align-middle mb-0">
					<thead>
						<tr class="text-body-secondary">
							<th style="width: 200px;">사이즈</th>
							<th>수량</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="s" items="${list}">
							<tr>
								<td>
									<span class="fw-bold">${s.goods_size}</span>
									<input type="hidden" id="no${s.no}" value="${s.no}">
									<input type="hidden" id="size${s.no}" value="${s.goods_size}">
								</td>
								<td>
									<input type="number" class="form-control form-control-sm qty-input" min="0" value="${s.quantity}" data-origin="${s.quantity}" data-no="${s.no}" style="max-width: 160px;">
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty vo.sizeList}">
							<tr>
								<td colspan="2" class="text-center text-body-secondary py-4">등록된 사이즈가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div class="d-flex gap-2">
				<button type="submit" class="btn btn-dark px-5">저장</button>
				<a href="../admin/stock_list.do" class="btn btn-outline-secondary px-5">취소</a>
			</div>

		</form>
	</div>

</body>
</html>
