<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 등록</title>
<style>
/* 사이즈 행: 체크 안 된 행은 흐리게 */
.size-row.off {
	opacity: .45;
}
/* 검색 결과 행 클릭 커서 */
.result-row {
	cursor: pointer;
}

.result-row:hover {
	background: #f8f8f8;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function() {

		let productModal = new bootstrap.Modal($('#productModal'))
		let searchResult = []; 

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
				success:function(result){
					let json = JSON.parse(result)
					console.log(json)
					if (!json || json.list.length === 0) {
						alert("검색 결과가 없습니다.")
						return
					}
					
					searchResult = json.list;
	
					if (json.list.length === 1) {
						selectProduct(json.list[0])
					} else {
						renderResult(json.list)
						productModal.show()
					}
				},
				error:function() {
					alert("상품 검색 중 오류가 발생했습니다.")
				}
			})
		})

		function renderResult(result) {
			let $tbody = $('#resultTbody').empty()

			$.each(result, function(i, p) {
				let $tr = $('<tr class="result-row"></tr>')
				$tr.append($('<td></td>').text(p.goods_code))
				$tr.append($('<td></td>').text(p.goods_name))
				$tr.append($('<td></td>').text(p.brand_name))
				$tr.append($('<td></td>').text(p.category_name))
				$tr.data('idx', i)
				$tbody.append($tr)
			});
		}

		$('#resultTbody').on('click', '.result-row', function() {
			let idx = $(this).data('idx')
			selectProduct(searchResult[idx])
			productModal.hide()
		});

		function selectProduct(p) {
			$('#productCode').val(p.goods_code)
			$('#productName').val(p.goods_name)
			$('#brand').val(p.brand_name)

			let $tbody = $('#sizeTbody').empty()

			$.each(p.sizeList || [], function(i, s) {
				$tbody.append(makeSizeRow(s.goods_size, s.quantity, false))
			});

			if ($tbody.children().length === 0) {
				$tbody
						.append('<tr id="emptyRow"><td colspan="5" class="text-center text-body-secondary py-4">'
								+ '등록된 사이즈가 없습니다. [+ 사이즈 추가]로 직접 추가하세요.</td></tr>')
			}
			checkValid()
		}

		function makeSizeRow(size, stock, isNew) {
			let $tr = $('<tr class="size-row off"></tr>')

			$tr.append($('<td class="text-center"></td>')
				.append($('<input type="checkbox" class="form-check-input size-check">')))

			let $sizeTd = $('<td></td>')
			if (isNew) {
				$sizeTd.append('<input type="text" class="form-control form-control-sm size-input" '
				+ 'placeholder="예: 295" disabled>')
			} else {
				$sizeTd.append($('<span class="fw-bold"></span>').text(size))
						.append($('<input type="hidden" class="size-input">').val(size))
			}
			$tr.append($sizeTd)

			$tr.append($('<td class="text-body-secondary"></td>')
					.text(isNew ? '신규' : (stock + '개')))

			$tr.append($('<td></td>')
				.append('<input type="number" class="form-control form-control-sm qty-input" '
				+ 'min="1" placeholder="1 이상" disabled style="max-width:160px;">'))

			let $delTd = $('<td class="text-center"></td>')
			if (isNew) {
				$delTd.append('<button type="button" class="btn btn-sm btn-outline-danger del-row">×</button>')
			}
			$tr.append($delTd)

			return $tr
		}

		$('#addSizeBtn').on('click', function() {
			if ($('#productCode').val() === "") {
				alert("상품을 먼저 선택하세요.")
				return
			}
			$('#emptyRow').remove()

			let $row = makeSizeRow('', 0, true)
			$row.find('.size-check').prop('checked', true)
			$row.removeClass('off')
			$row.find('.size-input, .qty-input').prop('disabled', false)
			$('#sizeTbody').append($row)
			checkValid()
		});

		$('#sizeTbody').on('click', '.del-row', function() {
			$(this).closest('tr').remove()
			checkValid()
		});

		$('#sizeTbody').on('change', '.size-check', function() {
			let $tr = $(this).closest('tr')
			let on = $(this).is(':checked')

			$tr.toggleClass('off', !on)
			$tr.find('.qty-input').prop('disabled', !on)
			$tr.find('input.size-input[type="text"]').prop('disabled', !on)

			if (!on) {
				$tr.find('.qty-input').val('')
			}
			checkValid()
		})

		$('#sizeTbody').on('input', '.qty-input, .size-input', checkValid)

		function checkValid() {
			let ok = ($('#productCode').val() !== "")
			let checkedCount = 0

			$('#sizeTbody .size-check:checked').each(function() {
				checkedCount++
				let $tr = $(this).closest('tr')
				let size = $tr.find('.size-input').val().trim()
				let qty = parseInt($tr.find('.qty-input').val(), 10)

				if (size === "" || isNaN(qty) || qty < 1) {
					ok = false
				}
			})

			if (checkedCount === 0) {
				ok = false
			}
			$('#saveBtn').prop('disabled', !ok)
		}

		$('#stockinForm').on('submit', function(e) {
			let sizeMap = {};
			let dup = false;
			let idx = 0;

			$('#sizeTbody').find('input').removeAttr('name');

			$('#sizeTbody .size-check:checked').each(function() {
				let $tr = $(this).closest('tr')
				let size = $tr.find('.size-input').val().trim()
				let qty = parseInt($tr.find('.qty-input').val(), 10)

				if (size === "" || isNaN(qty) || qty < 1) {
					alert("사이즈와 수량을 정확히 입력하세요.")
					dup = true
					return
				}

				if (sizeMap[size]) {
					alert(size + " 사이즈가 중복되었습니다.")
					dup = true
					return false
				}
				
				sizeMap[size] = true

				$tr.find('.size-input').attr('name', 'sizes[' + idx + ']')
				$tr.find('.qty-input').attr('name', 'quantities[' + idx + ']')
				idx++
			})

			if (dup) {
				e.preventDefault()
				return
			}
			
			if (idx === 0) {
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
					<button type="button" class="btn btn-dark px-3" id="searchBtn">검색</button>
				</div>
				<div class="form-text">검색 결과가 여러 건이면 목록에서 선택합니다.</div>
			</div>

			<input type="hidden" id="productCode" name="productCode" value="${param.code}">

			<div class="mb-3">
				<label class="form-label fw-bold">상품명</label>
				<input type="text" id="productName" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">브랜드</label>
				<input type="text" id="brand" class="form-control" readonly style="background: #f5f5f5;" placeholder="상품 선택 시 자동 입력">
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
						<tr id="emptyRow">
							<td colspan="5" class="text-center text-body-secondary py-4">상품을 먼저 검색·선택하세요.</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">입고일 <span class="text-danger">*</span></label>
				<input type="date" id="inDate" name="inDate" class="form-control" style="max-width: 260px;">
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
						<tbody id="resultTbody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>