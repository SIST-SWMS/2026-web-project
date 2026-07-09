<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// 오늘 날짜 기본값 세팅
	document.getElementById("inDate").valueAsDate = new Date();

	// [상품 검색] - 실제로는 팝업 또는 자동완성 연동. 여기서는 자동 채움 예시
	function searchProduct() {
		var keyword = document.getElementById("searchKeyword").value.trim();
		if (keyword === "") {
			alert("검색어를 입력하세요.");
			return;
		}
		// TODO: 서버에서 상품 조회 후 아래 값 세팅 (예시 값)
		document.getElementById("productCode").value = "SHOE-1001";
		document.getElementById("productName").value = "스트라이커 (Z1)_Black";
		document.getElementById("brand").value = "데카트론";

		// 사이즈 콤보 활성화 + 옵션 채움 (예시)
		var sizeSel = document.getElementById("size");
		sizeSel.disabled = false;
		sizeSel.innerHTML = '<option value="">사이즈 선택</option>'
				+ '<option value="250">250</option>'
				+ '<option value="260">260</option>'
				+ '<option value="270">270</option>';

		checkValid();
	}

	// 유효성 검사: 상품/사이즈 선택 + 수량 1 이상일 때만 [저장] 활성화
	function checkValid() {
		var code = document.getElementById("productCode").value;
		var size = document.getElementById("size").value;
		var qty = parseInt(document.getElementById("quantity").value, 10);
		var ok = (code !== "") && (size !== "") && (qty >= 1);
		document.getElementById("saveBtn").disabled = !ok;
	}

	document.getElementById("size").addEventListener("change", checkValid);
	document.getElementById("quantity").addEventListener("input", checkValid);

	// 제출 직전 최종 검사
	document.getElementById("stockinForm").addEventListener(
			"submit",
			function(e) {
				var qty = parseInt(document.getElementById("quantity").value,
						10);
				if (isNaN(qty) || qty <= 0) {
					e.preventDefault();
					alert("수량은 1 이상 입력해야 합니다.");
					return;
				}
				if (document.getElementById("size").value === "") {
					e.preventDefault();
					alert("사이즈를 선택하세요.");
				}
			});
</script>
</head>
<body>
	<%-- 입고 등록 --%>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입고 등록</h4>

	<form id="stockinForm" action="stockin_save.do" method="post" style="max-width: 720px;">

		<!-- 상품 검색 -->
		<div class="mb-3">
			<label class="form-label fw-bold">상품 검색</label>
			<div class="d-flex gap-2">
				<input type="text" id="searchKeyword" class="form-control" placeholder="상품코드 또는 상품명 입력">
				<button type="button" class="btn btn-dark px-4" onclick="searchProduct()">검색</button>
			</div>
			<div class="form-text">검색 후 상품을 선택하면 아래 정보가 자동 입력됩니다.</div>
		</div>

		<!-- 선택된 상품코드 (hidden) -->
		<input type="hidden" id="productCode" name="productCode" value="${param.code}">

		<!-- 상품명 (읽기 전용) -->
		<div class="mb-3">
			<label class="form-label fw-bold">상품명</label>
			<input type="text" id="productName" name="productName" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
		</div>

		<!-- 브랜드 (읽기 전용) -->
		<div class="mb-3">
			<label class="form-label fw-bold">브랜드</label>
			<input type="text" id="brand" name="brand" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
		</div>

		<!-- 사이즈 콤보 (상품 선택 후 활성화) -->
		<div class="mb-3">
			<label class="form-label fw-bold">사이즈 <span class="text-danger">*</span></label>
			<select id="size" name="size" class="form-select" disabled>
				<option value="">상품을 먼저 선택하세요</option>
				<%-- 상품 선택 시 해당 상품의 사이즈 목록을 <c:forEach> 로 채움 --%>
				<!-- <c:forEach var="s" items="${sizeList}">
				      <option value="${s}">${s}</option>
				      </c:forEach> -->
			</select>
		</div>

		<!-- 입고 수량 -->
		<div class="mb-3">
			<label class="form-label fw-bold">입고 수량 <span class="text-danger">*</span></label>
			<input type="number" id="quantity" name="quantity" class="form-control" min="1" placeholder="1 이상 입력">
		</div>

		<!-- 입고일 -->
		<div class="mb-3">
			<label class="form-label fw-bold">입고일 <span class="text-danger">*</span></label>
			<input type="date" id="inDate" name="inDate" class="form-control">
		</div>

		<!-- 비고 -->
		<div class="mb-4">
			<label class="form-label fw-bold">비고</label>
			<textarea name="remark" class="form-control" rows="3" placeholder="선택 입력"></textarea>
		</div>

		<!-- 버튼 -->
		<div class="d-flex gap-2">
			<button type="submit" id="saveBtn" class="btn btn-dark px-5" disabled>저장</button>
			<a href="stock_list.do" class="btn btn-outline-secondary px-5">취소</a>
		</div>

	</form>

</body>
</html>