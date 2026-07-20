<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">입출고 조회</h4>
	<div id="app">
		<form @submit.prevent class="border rounded-4 p-4 mb-4 bg-light">
			<div class="row g-3 align-items-end">

				<div class="col-md-4">
					<label class="form-label small text-body-secondary">기간</label>
					<div class="d-flex align-items-center gap-2">
						<!-- type="date" :: 2026-07-20 = to_char(regdate,'yyyy-mm-dd') -->
						<input type="date" id="startDate" class="form-control" v-model="startDate">
						<span>~</span>
						<input type="date" id="endDate" class="form-control" v-model="endDate">
					</div>
				</div>

				<div class="col-md-2">
					<label class="form-label small text-body-secondary">구분</label>
					<select name="chk" class="form-select" v-model="chk">
						<option value="">전체</option>
						<option value="입고">입고</option>
						<option value="출고">출고</option>
						<option value="반품">반품</option>
					</select>
				</div>

				<div class="col-md-3">
					<label class="form-label small text-body-secondary">상품명</label>
					<input type="text" name="goodsName" class="form-control" placeholder="상품명 입력" v-model="goodsName" @keydown.enter="find()">
				</div> 

				<div class="col-md-3 d-flex gap-2">
					<button type="button" class="btn btn-dark flex-fill" @click="find()">검색</button>
					<button type="button" class="btn btn-outline-secondary flex-fill" id="init">초기화</button>
				</div>

			</div>
		</form>

		<table class="table align-middle text-center">
			<thead>
				<tr class="text-body-secondary">
					<th style="width: 60px;">번호</th>
					<th style="width: 80px;">구분</th>
					<th>상품명</th>
					<th style="width: 70px;">사이즈</th>
					<th style="width: 70px;">수량</th>
					<th style="width: 110px;">입출고일</th>
					<th style="width: 90px;">등록자</th>
				</tr>
			</thead>
			<tbody>
				<tr class="prod-row" v-for="(vo,index) in list" :key="index">
					<td>{{vo.no}}</td>
					<td>
						<span class="badge bg-danger">{{vo.chk}}</span>
					</td>
					<td class="text-start">{{vo.goods_name}}</td>
					<td>{{vo.inout_size}}</td>
					<td>{{vo.quantity}}</td>
					<td class="text-body-secondary">{{vo.dbday}}</td>
					<td>{{vo.created_by}}</td>
				</tr>
			</tbody>
		</table>

		<div class="d-flex justify-content-center mt-4">
			<ul class="pagination">
				<li v-if="startPage > 1"><a @click="pageChange(startPage-1)">&laquo;</a></li>
				<li :class="{ active: i == curpage }" v-for="(i, index) in range(startPage, endPage)" :key="index"><a @click="pageChange(i)">{{i}}</a></li>
				<li v-if="endPage < totalpage"><a @click="pageChange(endPage+1)">&raquo;</a></li>
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
	            const today = new Date();
	            
	            const sevenDaysAgo = new Date();
	            sevenDaysAgo.setDate(today.getDate() - 7);
	            
	            const formatDate = (date) => {
	                const y = date.getFullYear();
	                const m = String(date.getMonth() + 1).padStart(2, '0');
	                const d = String(date.getDate()).padStart(2, '0');
	                
	                return y + '-' + m + '-' + d;
	            };
	            
	            
	            
	            this.startDate = formatDate(sevenDaysAgo);
	            this.endDate = formatDate(today);
	            
	            console.log(this.startDate)
	            console.log(this.endDate)
	            
				this.dataRecv()
			},
			methods:{
				async dataRecv(){
					await axios.get('../admin/io_list_vue.do',{
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
	    		 }
			}
		}).mount("#app")
	</script>
</body>
</html>