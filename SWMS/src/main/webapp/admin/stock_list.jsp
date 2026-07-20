<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.pagination {
	display: inline-flex;
	list-style: none;
	gap: 6px;
	padding: 0;
	margin: 0 auto;
}

.pagination li a {
	display: block;
	padding: 8px 14px;
	color: #333;
	text-decoration: none;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}

.stock-row {
	cursor: pointer;
}

.stock-row:hover {
	background: #f8f8f8;
}
</style>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#init').on('click', function() {
			location.href = "../admin/io_list.do"
		})
	})
		
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">재고 조회</h4>

	<div id="app">
		<form @submit.prevent class="border rounded-4 p-4 mb-4 bg-light">
			<div class="row g-3 align-items-end">

				<div class="col-md-3">
					<label class="form-label small text-body-secondary">상품명</label>
					<input type="text" name="goodsName" class="form-control" placeholder="상품명 입력" v-model="goodsName">
				</div>
				
				<div class="col-md-3">
					<label class="form-label small text-body-secondary">상품코드</label>
					<input type="text" name="goodsCode" class="form-control" placeholder="상품코드 입력" v-model="goodsCode">
				</div>

				<div class="col-md-3">
					<div class="form-check mt-4">
						<input class="form-check-input" type="checkbox" name="lowStock" value="Y" id="lowStock" ${param.lowStock == 'Y' ? 'checked' : ''}>
						<label class="form-check-label" for="lowStock">재고 부족만 보기 (10개 이하)</label>
					</div>
				</div>

				<div class="col-md-3 d-flex gap-2">
					<button type="submit" class="btn btn-dark flex-fill">검색</button>
					<a href="stock_list.do" class="btn btn-outline-secondary flex-fill">초기화</a>
				</div>

			</div>
		</form>

		<table class="table align-middle text-center">
			<thead>
				<tr class="text-body-secondary">
					<th style="width: 130px;">상품코드</th>
					<th>상품명</th>
					<th style="width: 110px;">브랜드</th>
					<th style="width: 110px;">카테고리</th>
					<th style="width: 90px;">총재고</th>
					<th style="width: 90px;">상태</th>
				</tr>
			</thead>
			<tbody>
				<tr class="stock-row" v-for="(vo,index) in list" :key="index" @click="goView(vo.goods_no)"> 
					<td>SHOE-1002</td>
					<td class="text-start">클래식 러너 스니커즈</td>
					<td>스파크</td>
					<td>스니커즈</td>
					<td>8</td>
					<td>
						<span class="badge bg-warning text-dark">부족</span>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="d-flex justify-content-center mt-4">
			<ul class="pagination">
				<li v-if="startPage > 1">
					<a @click="pageChange(startPage-1)">&laquo;</a>
				</li>
				<li :class="{ active: i == curpage }" v-for="(i, index) in range(startPage, endPage)" :key="index">
					<a @click="pageChange(i)">{{i}}</a>
				</li>
				<li v-if="endPage < totalpage">
					<a @click="pageChange(endPage+1)">&raquo;</a>
				</li>
			</ul>
		</div>
	</div>
	<script>
		let app = Vue.createApp({
			data(){
				return {
					curpage:1,
					totalpage:0,
					startPage:0,
					endPage:0,
					startDate:'',
					endDate:'',
					chk:'',
					goodsName:'',
					list:[]
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				async dataRecv(){
					await axios.get('../admin/stock_list_vue.do',{
						params:{
							page:this.curpage,
							startDate:this.startDate,
							endDate:this.endDate,
							chk:this.chk,
							goodsName:this.goodsName
						}
					}).then(response=>{
	    				 console.log(response.data)
	    				 this.list=response.data.list
	    				 this.curpage=response.data.curpage
	    				 this.totalpage=response.data.totalpage
	    				 this.startPage=response.data.startPage
	    				 this.endPage=response.data.endPage
	    			 })
	    		 },
	    		 find(){
	    			 this.curpage=1
	    			 this.dataRecv()
	    		 },
	    		 range(start, end){
					let arr = []
					let length = end-start
					for(let i=0; i<=length; i++){
						arr[i] = start
						start++
					}
					return arr
	    		 },
	    		 pageChange(page){
	    			 this.curpage = page
	    			 this.dataRecv()
	    		 },
	    		 goView(no){
	    			 location.href = "../admin/stock_view.do?no="+no;
	    		 }
			}
		}).mount("#app")
	</script>
</body>
</html>