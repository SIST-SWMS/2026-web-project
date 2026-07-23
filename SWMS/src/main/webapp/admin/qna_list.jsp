<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- QNA 목록 (관리자) --%>
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
			location.href = "../admin/goods_list.do"
		})
	})
</script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">QNA 관리</h4>
	<div id="app">
		<form @submit.prevent class="border rounded-4 p-4 mb-4 bg-light">
			<div class="row g-3 align-items-end">

				<div class="col-md-3">
					<label class="form-label small text-body-secondary">상태</label>
					<select name="status" class="form-select" v-model="status">
						<option value="">전체</option>
						<option value="답변대기">답변대기</option>
						<option value="답변완료">답변완료</option>
					</select>
				</div>

				<div class="col-md-6">
					<label class="form-label small text-body-secondary">작성자</label>
					<input type="text" name="id" class="form-control" placeholder="검색어 입력" v-model="id" @keydown.enter="find()">
				</div>

				<div class="col-md-3 d-flex gap-2">
					<button type="submit" class="btn btn-dark flex-fill" @click="find()">검색</button>
					<a href="qna_list.do" class="btn btn-outline-secondary flex-fill" id="init">초기화</a>
				</div>

			</div>
		</form>

		<table class="table align-middle text-center">
			<thead>
				<tr class="text-body-secondary">
					<th style="width: 60px;">번호</th>
					<th style="width: 300px;">상품명</th>
					<th style="width: 150px;">문의유형</th>
					<th>문의제목</th>
					<th style="width: 100px;">작성자</th>
					<th style="width: 110px;">등록일</th>
					<th style="width: 100px;">상태</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="(vo,index) in list" :key="index" @click="goView(vo.qna_no)">
					<td>{{vo.qna_no}}</td>
					<td>{{vo.goods.goods_name}}</td>
					<td>{{vo.type}}</td>
					<td class="text-start">{{vo.subject}}</td>
					<td>{{vo.id}}</td>
					<td class="text-body-secondary">{{vo.dbday}}</td>
					<td>
						<span v-if="vo.status=='답변대기'" class="badge bg-danger">{{vo.status}}</span>
						<span v-if="vo.status=='답변완료'" class="badge bg-success">{{vo.status}}</span>
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
					id:'',
					status:'',
					totalpage:0,
					startPage:0,
					endPage:0,
					list:[]
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				async dataRecv(){
					await axios.get('../admin/qna_list_vue.do',{
						params:{
							page:this.curpage,
							id:this.id,
							status:this.status
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
					for(i=0; i<=length; i++){
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
	    			 location.href = "../admin/qna_view.do?no="+no;
	    		 }
			}
		}).mount("#app")
	</script>
</body>
</html>