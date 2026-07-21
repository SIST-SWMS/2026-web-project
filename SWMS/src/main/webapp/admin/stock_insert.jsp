<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 등록</title>
<style>
.size-row.off {
	opacity: .45;
}

.result-row {
	cursor: pointer;
}

.result-row:hover {
	background: #f8f8f8;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
	$(function() {

		let productModal = new bootstrap.Modal($('#productModal'))
		let searchResult = []

		$('#searchBtn').on('click', function() {
			let keyword = $('#searchKeyword').val().trim()
			if (keyword === "") {
				alert("검색어를 입력하세요.")
				$('#searchKeyword').focus()
				return

			}
			$.ajax({
				url : '../admin/stock_search.do',
				type : 'get',
				data : {
					keyword : keyword
				},
				dataType : 'json',
				success : function(json) {
					let list = json.list
					if (!list || list.length === 0) {
						alert("검색 결과가 없습니다.")
						return

					}
					searchResult = list

					if (list.length === 1) {
						selectProduct(list[0])
					} else {
						renderResult(list)
						productModal.show()
					}
				},
				error : function() {
					alert("상품 검색 중 오류가 발생했습니다.")
				}
			})
		})

		function renderResult(list) {
			let html = ''
			$.each(list, function(i, p) {
				html += '<tr class="result-row" data-idx="' + i + '">' + '<td>'
						+ p.goods_code + '</td>' + '<td>' + p.goods_name
						+ '</td>' + '<td>' + p.brand_name + '</td>' + '<td>'
						+ p.category_name + '</td>' + '</tr>'
			})
			$('#resultTbody').html(html)
		}

		$('#resultTbody').on('click', '.result-row', function() {
			selectProduct(searchResult[$(this).data('idx')])
			productModal.hide()
		})

		function selectProduct(p) {
			$('#goods_no').val(p.goods_no)
			$('#goods_code').val(p.goods_code)
			$('#goods_name').val(p.goods_name)
			$('#brand_name').val(p.brand_name)

			let html = ''
			$.each(p.sizeList || [], function(i, s) {
				html += sizeRow(s.no, s.goods_size, s.quantity + '개', false)
			})

			if (html === '') {
				html = '<tr class="empty-row">'
						+ '<td colspan="5" class="text-center text-body-secondary py-4">'
						+ '등록된 사이즈가 없습니다. [+ 사이즈 추가]로 직접 추가하세요. </td>'
						+ '</tr>'
			}
			$('#sizeTbody').html(html)

			$('#sizeTbody tr.size-row').each(function() {
				syncRow($(this))
			})

			checkValid()
		}

		function sizeRow(stockNo, size, stockText, isNew) {
		    let sizeTd = ''
		    // 신규 추가 시 stockNo는 0으로 세팅
		    let noVal = isNew ? 0 : stockNo

		    if (isNew) {
		        sizeTd = '<input type="text" name="sizes" class="form-control form-control-sm size-input" placeholder="예: 295">'
		    } else {
		        sizeTd = '<span class="fw-bold">' + size + '</span>'
		               + '<input type="hidden" name="sizes" class="size-input" value="' + size + '">'
		    }

		    let delTd = isNew ? '<button type="button" class="btn btn-sm btn-outline-danger del-row">×</button>' : ''

		    return '<tr class="size-row off">'
		            + '<td class="text-center">'
		            +   '<input type="checkbox" class="form-check-input size-check">'
		            +   '<input type="hidden" name="stock_nos" class="stock-no-input" value="' + noVal + '">'
		            + '</td>'
		            + '<td>' + sizeTd + '</td>'
		            + '<td class="text-body-secondary">' + stockText + '</td>'
		            + '<td><input type="number" name="quantities" class="form-control form-control-sm qty-input" min="1" placeholder="1 이상" style="max-width:160px;" disabled></td>'
		            + '<td class="text-center">' + delTd + '</td>'
		            + '</tr>'
		}

		$('#addSizeBtn').on('click', function() {
		    if ($('#goods_no').val() === "") {
		        alert("상품을 먼저 선택하세요.")
		        return
		    }
		    $('.empty-row').remove()

		    let $row = $(sizeRow(0, '', '신규', true))
		    $row.find('.size-check').prop('checked', true)
		    $('#sizeTbody').append($row)
		    
		    syncRow($row)
		    checkValid()
		})

		$('#sizeTbody').on('click', '.del-row', function() {
			$(this).closest('tr').remove()
			checkValid()
		})

		$('#sizeTbody').on('change', '.size-check', function() {
			syncRow($(this).closest('tr'))
			checkValid()
		})

		function syncRow($tr) {
			let on = $tr.find('.size-check').is(':checked')

			$tr.toggleClass('off', !on)
			$tr.find('.size-input, .qty-input, .stock-no-input').prop(
					'disabled', !on)
		}

		$('#sizeTbody').on('input', '.qty-input, .size-input', checkValid)

		function checkValid() {
			let ok = ($('#goods_no').val() !== "")
			let count = 0

			$('#sizeTbody .size-check:checked').each(function() {
				count++
				let $tr = $(this).closest('tr')
				let size = $tr.find('.size-input').val().trim()
				let qty = $tr.find('.qty-input').val()

				if (size === "" || qty === "" || Number(qty) < 1)
					ok = false
			})

			if (count === 0)
				ok = false
			$('#saveBtn').prop('disabled', !ok)
		}

		$('#stockinForm').on('submit', function(e) {
			let sizes = []
			let error = ""

			$('#sizeTbody .size-check:checked').each(function() {
				let $tr = $(this).closest('tr')
				let size = $tr.find('.size-input').val().trim()
				let qty = $tr.find('.qty-input').val()

				if (size === "" || qty === "" || Number(qty) < 1) {
					error = "사이즈와 수량을 정확히 입력하세요."
					return false
				}
				if (sizes.indexOf(size) > -1) {
					error = size + " 사이즈가 중복되었습니다."
					return false
				}
				sizes.push(size)
			})

			if (error !== "") {
				e.preventDefault()
				alert(error)
				return

			}

			if (sizes.length === 0) {
				e.preventDefault()
				alert("입고할 사이즈를 1개 이상 선택하세요.")
			}
		})

	})
</script>
</head>
<body>
	<div class="container-fluid py-4">

		<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입고 등록</h4>

		<form id="stockinForm" action="../admin/stock_save.do" method="post" style="max-width: 860px;">

			<div class="mb-3">
				<label class="form-label fw-bold">상품 검색</label>
				<div class="d-flex gap-2">
					<input type="text" id="searchKeyword" class="form-control" placeholder="상품코드 또는 상품명 입력">
					<button type="button" class="btn btn-dark px-4 text-nowrap" id="searchBtn">검색</button>
				</div>
				<div class="form-text">검색 결과가 여러 건이면 목록에서 선택합니다.</div>
			</div>

			<input type="hidden" id="goods_no" name="goods_no" value="${param.no}">

			<div class="mb-3">
				<label class="form-label fw-bold">상품명</label>
				<input type="text" id="goods_name" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">브랜드</label>
				<input type="text" id="brand_name" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
			</div>

			<div class="border rounded-4 p-4 mb-3">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<div>
						<span class="fw-bold">사이즈별 입고 수량</span>
						<span class="text-danger">*</span>
						<div class="form-text mb-0">입고할 사이즈를 체크하고 수량을 입력하세요. 여러 개를 한 번에 등록할 수 있습니다.</div>
					</div>
					<button type="button" class="btn btn-outline-dark btn-sm" id="addSizeBtn">+ 사이즈 추가</button>
				</div>

				<table class="table align-middle mb-0">
					<thead>
						<tr class="text-body-secondary">
							<th style="width: 60px;" class="text-center">선택</th>
							<th style="width: 160px;">사이즈</th>
							<th style="width: 120px;">현재고</th>
							<th>입고 수량</th>
							<th style="width: 60px;"></th>
						</tr>
					</thead>
					<tbody id="sizeTbody">
						<tr class="empty-row">
							<td colspan="5" class="text-center text-body-secondary py-4">상품을 먼저 검색·선택하세요.</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="d-flex gap-2">
				<button type="submit" id="saveBtn" class="btn btn-dark px-5" disabled>저장</button>
				<a href="../admin/stock_list.do" class="btn btn-outline-secondary px-5">취소</a>
			</div>

		</form>
	</div>

	<div class="modal fade" id="productModal" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fw-bold">상품 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<table class="table align-middle mb-0">
						<thead>
							<tr class="text-body-secondary">
								<th style="width: 130px;">상품코드</th>
								<th>상품명</th>
								<th style="width: 110px;">브랜드</th>
								<th style="width: 100px;">카테고리</th>
							</tr>
						</thead>
						<tbody id="resultTbody"></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
