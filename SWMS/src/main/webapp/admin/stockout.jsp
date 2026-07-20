<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

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
</style>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#init').on('click', function() {
		location.href = "../admin/stockout.do"
	})
})
</script>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">출고 처리</h4>
	<div id="app">
		<form @submit.prevent class="border rounded-4 p-4 mb-4 bg-light">
			<div class="row g-3 align-items-end">

				<div class="col-md-3">
					<label class="form-label small text-body-secondary">주문 상태</label>
					<select name="status" class="form-select" v-model="status">
						<option value="">전체</option>
						<option value="결제완료">결제완료(미출고)</option>
						<option value="배송완료">배송완료</option>
						<option value="주문취소">주문취소</option>
						<option value="반품요청">반품요청</option>
						<option value="반품완료">반품완료</option>
						<option value="구매확정">구매확정</option>
					</select>
				</div>

				<div class="col-md-6">
					<label class="form-label small text-body-secondary">회원ID</label>
					<input type="text" name="memberId" class="form-control" placeholder="검색어 입력" v-model="memberId">
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
					<th>주문번호</th>
					<th>회원ID</th>
					<th>상품명</th>
					<th style="width: 70px;">사이즈</th>
					<th style="width: 60px;">수량</th>
					<th style="width: 110px;">주문일</th>
					<th style="width: 100px;">주문상태</th>
					<th style="width: 110px;">출고처리</th>
				</tr>
			</thead>
			<tbody>
				<tr class="prod-row" v-for="(vo,index) in list" :key="index">
					<td class="fw-bold">{{vo.ovo.order_no }}</td>
					<td>{{vo.ovo.id }}</td>
					<td class="text-start">{{vo.gvo.goods_name }}</td>
					<td>{{vo.sizes }}</td>
					<td>{{vo.quantity }}</td>
					<td class="text-body-secondary">{{vo.ovo.dbday }}</td>
					<td>
						<span class="badge bg-secondary">{{vo.status }}</span>
					</td>
					<td>
						<template v-if="vo.status === '반품요청'">
							<button type="button" class="btn btn-sm btn-danger" @click="handleRefund(vo)">반품처리</button>
						</template>
						<template v-else-if="vo.status === '결제완료'">
							<button type="button" class="btn btn-sm btn-dark" @click="handleDelivery(vo)">출고처리</button>
						</template>
						<template v-else>
							<span class="badge bg-secondary">처리완료</span>
						</template>
					</td>

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
					status:'',
					memberId:'',
					list:[]
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				async dataRecv(){
					await axios.get('../admin/stockout_vue.do',{
						params:{
							page:this.curpage,
							status:this.status,
							memberId:this.memberId
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
	    		 handleRefund(vo) {
				    if (!confirm("반품 처리하시겠습니까?")) return;
				
				    const params = new URLSearchParams();
				    params.append('order_detail_no', vo.order_detail_no);
				    params.append('sizes', vo.sizes);
				    params.append('quantity', vo.quantity);
				    params.append('goods_no', vo.gvo.goods_no);
				    params.append('order_no', vo.ovo.order_no);
				
				    axios.post('../admin/return_ok.do', params)
				        .then(response => {
				            this.dataRecv()
				            
				        })
				        .catch(error => {
				            console.error("환불 처리 중 에러 발생:", error);
				        })
				},
				
				handleDelivery(vo) {
				    if (!confirm("출고 처리하시겠습니까?")) return;
				
				    const params = new URLSearchParams();
				    params.append('order_detail_no', vo.order_detail_no);
				    params.append('sizes', vo.sizes);
				    params.append('quantity', vo.quantity);
				    params.append('goods_no', vo.gvo.goods_no);
				    params.append('order_no', vo.ovo.order_no);
				
				    axios.post('../admin/delivery_ok.do', params)
				        .then(response => {
				            if (typeof response.data === 'string' && response.data.trim() === 'YES') {
				                this.dataRecv()
				            } else {
				                alert("재고가 부족합니다")
				            }
				        })
				        .catch(error => {
				            console.error("출고 처리 중 에러 발생:", error)
				        })
				}
	    		 
			}
		}).mount("#app")
	</script>
</body>
</html>