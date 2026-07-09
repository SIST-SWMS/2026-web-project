<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 제출 직전 수량 검사
	document.getElementById("stockinEditForm").addEventListener(
			"submit",
			function(e) {
				var qty = parseInt(document.getElementById("quantity").value, 10);
				if (isNaN(qty) || qty <= 0) {
					e.preventDefault();
					alert("수량은 1개 이상 입력해야 합니다.");
				}
			});
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">재고 수정</h4>

	<div class="alert alert-warning" role="alert">수량 변경 시 재고에 즉시 반영됩니다.</div>

	<form id="stockinEditForm" action="../admin/stock_update_ok.do" method="post" style="max-width: 720px;">

		<input type="hidden" name="id" value="${stockin.id}">

		<!-- 상품명 (읽기 전용, 변경 불가) -->
		<div class="mb-3">
			<label class="form-label fw-bold">상품명</label>
			<input type="text" class="form-control" value="${stockin.productName}" readonly style="background: #f5f5f5;">
		</div>

		<!-- 브랜드 (읽기 전용) -->
		<div class="mb-3">
			<label class="form-label fw-bold">브랜드</label>
			<input type="text" class="form-control" value="${stockin.brand}" readonly style="background: #f5f5f5;">
		</div>

		<!-- 사이즈 (읽기 전용) -->
		<div class="mb-3">
			<label class="form-label fw-bold">사이즈</label>
			<input type="text" class="form-control" value="${stockin.size}" readonly style="background: #f5f5f5;">
		</div>

		<!-- ===== 아래부터 수정 가능 항목 ===== -->

		<!-- 입고 수량 -->
		<div class="mb-3">
			<label class="form-label fw-bold">입고 수량 <span class="text-danger">*</span></label>
			<input type="number" id="quantity" name="quantity" class="form-control" min="1" value="${stockin.quantity}">
		</div>

		<!-- 입고일 -->
		<div class="mb-3">
			<label class="form-label fw-bold">입고일 <span class="text-danger">*</span></label>
			<input type="date" name="inDate" class="form-control" value="${stockin.inDate}">
		</div>

		<!-- 비고 -->
		<div class="mb-4">
			<label class="form-label fw-bold">비고</label>
			<textarea name="remark" class="form-control" rows="3">${stockin.remark}</textarea>
		</div>

		<!-- 버튼 -->
		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-dark px-5">저장</button>
			<a href="../admin/stock_list.do" class="btn btn-outline-secondary px-5">취소</a>
		</div>
	</form>
</body>
</html>