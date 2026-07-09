<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.guide-section {
	margin-bottom: 48px;
}

.guide-code {
	background: #f5f5f5;
	border-radius: 6px;
	padding: 12px 16px;
	font-family: Consolas, monospace;
	font-size: 13px;
	color: #333;
	white-space: pre;
	overflow-x: auto;
	margin-top: 8px;
}

.guide-label {
	font-size: 13px;
	color: #888;
	margin-top: 12px;
}
</style>
<link rel="stylesheet" href="../resources/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<section class="py-5">
		<div class="container-fluid">

			<h2 class="fw-bold mb-2">CSS / 마크업 가이드</h2>

			<!-- ============ 1. 작성 규칙 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">1. JSP 작성 규칙</h4>
				<ul>
					<li>새 화면(본문 JSP)은 항상 <code>&lt;section&gt;</code>으로 시작합니다.
						header/footer는 include로 이미 들어오므로 본문만 작성합니다.
					</li>
					<li>바깥은 <code>&lt;div class="container-fluid"&gt;</code>로 감싸
						좌우 여백을 맞춥니다.
					</li>
					<li>상단에 JSP 지시어와 JSTL 태그를 넣습니다.</li>
				</ul>
				<div class="guide-code">
				&lt;%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%&gt; 
				&lt;%@ taglib prefix="c" uri="jakarta.tags.core"%&gt; 
				&lt;section class="py-5"&gt; 
				&lt;div class="container-fluid"&gt; 
				&lt;!-- 여기에 화면 내용 --&gt; 
				&lt;/div&gt; &lt;/section&gt;
				</div>
			</div>

			<!-- ============ 2. 버튼 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">2. 버튼</h4>
				<div class="d-flex flex-wrap gap-2 mb-2">
					<button class="btn btn-primary">btn-primary</button>
					<button class="btn btn-dark">btn-dark</button>
					<button class="btn btn-secondary">btn-secondary</button>
					<button class="btn btn-success">btn-success</button>
					<button class="btn btn-danger">btn-danger</button>
				</div>
				<div class="d-flex flex-wrap gap-2 mb-2">
					<button class="btn btn-outline-dark">btn-outline-dark</button>
					<button class="btn btn-outline-secondary">btn-outline-secondary</button>
					<button class="btn btn-outline-danger">btn-outline-danger</button>
				</div>
				<div class="d-flex flex-wrap gap-2 align-items-center">
					<button class="btn btn-dark btn-lg">btn-lg (큰 버튼)</button>
					<button class="btn btn-dark">기본</button>
					<button class="btn btn-dark btn-sm">btn-sm (작은 버튼)</button>
				</div>
				<div class="guide-label">전체 너비 버튼: w-100</div>
				<div class="guide-code">&lt;button class="btn btn-dark btn-lg
					w-100"&gt;전체 너비&lt;/button&gt;</div>
				<div class="guide-label">색상별 용도 안내</div>
				<ul class="mb-0 small">
					<li>btn-primary (파랑): 주요 액션 (결제, 확인)</li>
					<li>btn-dark (검정): 일반 액션 (등록, 수정, 구매확정)</li>
					<li>btn-success (초록): 완료/긍정 상태</li>
					<li>btn-danger (빨강): 삭제, 취소, 환불</li>
					<li>btn-warning (노랑): 주의, 교환</li>
					<li>btn-outline-* : 보조 액션 (취소, 목록으로)</li>
				</ul>
			</div>

			<button class="btn-xs btn-primary">왜 안돼</button>

			<!-- ============ 3. a 태그 밑줄 제거 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">3. a 태그 밑줄 제거</h4>
				<p class="mb-1">
					기본 a 태그: <a href="#">밑줄 있음</a>
				</p>
				<p class="mb-1">
					밑줄 제거: <a href="#" class="text-decoration-none">text-decoration-none</a>
				</p>
				<p class="mb-1">
					밑줄 제거 + 검정색: <a href="#" class="text-decoration-none text-dark">text-decoration-none
						text-dark</a>
				</p>
				<div class="guide-code">&lt;a href="#"
					class="text-decoration-none text-dark"&gt;링크&lt;/a&gt;</div>
			</div>

			<!-- ============ 4. 배지 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">4. 배지 (상태 표시)</h4>
				<div class="d-flex flex-wrap gap-2">
					<span class="badge bg-primary">배송중</span> <span
						class="badge bg-success">답변완료</span> <span
						class="badge bg-secondary">답변대기</span> <span
						class="badge bg-danger">반품</span> <span
						class="badge bg-warning text-dark">교환</span> <span
						class="badge bg-light text-dark border">기본</span>
				</div>
				<div class="guide-code">&lt;span class="badge
					bg-success"&gt;답변완료&lt;/span&gt;</div>
			</div>

			<!-- ============ 5. 카드 / 박스 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">5. 카드 / 박스</h4>
				<div class="row g-3">
					<div class="col-md-4">
						<div class="border rounded-4 p-4">
							<div class="fw-bold mb-1">border rounded-4 p-4</div>
							<div class="text-body-secondary small">테두리 + 둥근 모서리 박스</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="border rounded-4 p-4 shadow-sm">
							<div class="fw-bold mb-1">shadow-sm 추가</div>
							<div class="text-body-secondary small">그림자 있는 박스</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="border rounded-4 p-4 bg-light">
							<div class="fw-bold mb-1">bg-light 추가</div>
							<div class="text-body-secondary small">회색 배경 박스</div>
						</div>
					</div>
				</div>
				<div class="guide-code">&lt;div class="border rounded-4 p-4
					shadow-sm"&gt; ... &lt;/div&gt;</div>
			</div>

			<!-- ============ 6. 폼 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">6. 폼 (입력 요소)</h4>
				<div class="row g-3" style="max-width: 600px;">
					<div class="col-12">
						<label class="form-label fw-bold">기본 입력</label> <input type="text"
							class="form-control bg-light" placeholder="form-control">
					</div>
					<div class="col-12">
						<label class="form-label fw-bold">큰 입력 (form-control-lg)</label> <input
							type="text" class="form-control form-control-lg bg-light"
							placeholder="form-control-lg">
					</div>
					<div class="col-12">
						<label class="form-label fw-bold">버튼 붙은 입력 (input-group)</label>
						<div class="input-group">
							<input type="text" class="form-control bg-light"
								placeholder="우편번호">
							<button class="btn btn-outline-dark" type="button">검색</button>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label fw-bold">드롭다운</label> <select
							class="form-select">
							<option>선택하세요</option>
							<option>옵션 1</option>
						</select>
					</div>
					<div class="col-12">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="guideChk">
							<label class="form-check-label" for="guideChk">체크박스</label>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label fw-bold">여러 줄 입력</label>
						<textarea class="form-control" rows="3" placeholder="textarea"></textarea>
					</div>
				</div>
			</div>

			<!-- ============ 7. 간격 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">7. 간격 (margin /
					padding)</h4>
				<ul class="mb-2">
					<li><code>mb-3</code> = 아래 여백 (margin-bottom). 숫자 0~5로 크기 조절</li>
					<li><code>mt-4</code> = 위 여백, <code>my-3</code> = 상하 여백, <code>mx-2</code>
						= 좌우 여백</li>
					<li><code>p-4</code> = 안쪽 여백 (padding), <code>py-5</code> = 상하
						안쪽 여백</li>
					<li><code>gap-2</code> = flex 요소 사이 간격 (d-flex와 함께 사용)</li>
				</ul>
				<div class="guide-code">&lt;div class="d-flex gap-2 mb-3"&gt;
					... &lt;/div&gt;</div>
			</div>

			<!-- ============ 8. 테이블 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">8. 테이블</h4>
				<table class="table align-middle" style="max-width: 600px;">
					<thead>
						<tr class="text-body-secondary">
							<th style="width: 120px;">항목</th>
							<th>설명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="bg-light">table</th>
							<td>기본 테이블</td>
						</tr>
						<tr>
							<th class="bg-light">align-middle</th>
							<td>셀 세로 가운데 정렬</td>
						</tr>
						<tr>
							<th class="bg-light">text-end</th>
							<td>오른쪽 정렬 (금액 등)</td>
						</tr>
					</tbody>
				</table>
				<div class="guide-code">&lt;table class="table
					align-middle"&gt; ... &lt;/table&gt;</div>
			</div>

			<!-- ============ 9. 자주 쓰는 텍스트 ============ -->
			<div class="guide-section">
				<h4 class="fw-bold border-bottom pb-2 mb-3">9. 자주 쓰는 텍스트 클래스</h4>
				<ul class="mb-0">
					<li><span class="fw-bold">fw-bold</span> = 굵은 글씨</li>
					<li><span class="text-body-secondary">text-body-secondary</span>
						= 회색 보조 텍스트</li>
					<li><span class="text-danger">text-danger</span> = 빨강 (할인율·필수)</li>
					<li><span class="text-success">text-success</span> = 초록</li>
					<li><span class="small">small</span> = 작은 글씨</li>
					<li>text-center / text-end = 가운데 / 오른쪽 정렬</li>
				</ul>
			</div>

		</div>
	</section>
</body>
</html>