<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	cursor: pointer;
}

.pagination li.active a {
	background: #000;
	color: #fff;
	border-color: #000;
}

.thumb-sm {
	width: 56px;
	height: 56px;
	object-fit: cover;
	border-radius: 6px;
	background: #f5f5f5;
}

.prod-row {
	cursor: pointer;
}

.prod-row:hover {
	background: #f8f8f8;
}
</style>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-4.0.0.min.js"></script>
</head>
<body>
	<h4 class="fw-bold border-bottom border-dark border-2 pb-2 mb-4">상품 리뷰</h4>
	<div id="app">
		<div class="d-flex align-items-center gap-3 py-3 border-bottom" v-for="(vo,index) in list" :key="index" @click="goView(vo.review_no)">
			<img :src="vo.goods.poster_url" width="70" height="70" style="object-fit: cover; border-radius: 8px;" alt="상품">
			<div class="flex-grow-1">
				<div class="fw-bold">
					<a href="../mypage/review_view.do?no=3">{{vo.goods.goods_name}}</a>
				</div>
			</div>

			<a v-if="vo.review_no > 0" :href="'../mypage/review_view.do?no='+vo.review_no" class="btn btn-dark">리뷰 보기</a>
			<a v-else :href="'../mypage/review.do?order_no='+vo.order_no+'&goods_no='+vo.goods_no" class="btn btn-dark write">리뷰 쓰기</a>
		</div>

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
					list:[]
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				async dataRecv(){
					await axios.get('../mypage/reviewList_vue.do',{
						params:{
							page:this.curpage,
						}
					}).then(response=>{
	    				 this.curpage=response.data.curpage
	    				 this.totalpage=response.data.totalpage
	    				 this.startPage=response.data.startPage
	    				 this.endPage=response.data.endPage
	    				 this.list=response.data.list
	    			 })
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
	    			 location.href = "../mypage/review_view.do?no="+no;
	    		 }
			}
		}).mount("#app")
	</script>
</body>
</html>