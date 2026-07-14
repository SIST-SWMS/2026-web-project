<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cart-thumb {
	width: 90px;
	height: 90px;
	object-fit: cover;
	border-radius: 8px;
	background: #f5f5f5;
}

.qty-box .btn {
	width: 34px;
}

.qty-box input {
	width: 46px;
	text-align: center;
}

.summary-box {
	position: sticky;
	top: 20px;
}
</style>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<section class="py-5" id="cartApp">
		<div class="container-fluid">

			<h2 class="fw-bold mb-4">장바구니</h2>

			<div class="row g-4">

				<!-- ================= 좌측: 상품 리스트 ================= -->
				<div class="col-lg-8">

					<!-- 전체선택 / 선택삭제 -->
					<div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3" v-if="list.length>0">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="checkAll"
								:checked="isAllChecked" @click="toggleAll"> <label class="form-check-label fw-bold"
								for="checkAll">전체선택 ({{checkedCount}}/{{list.length}})</label>
						</div>
						<a href="#" @click="selectedDelete()" class="text-body-secondary text-decoration-none">선택삭제</a>
					</div>

					
					
					<!-- 상품 1 -->
					<div v-if="list.length>0 && id!=null">
						<div class="d-flex gap-3 py-4 border-bottom" v-for="(vo,index) in list" :key="index">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" v-model="vo.checked">
							</div>
							<img :src="vo.gvo.poster_url" alt="상품"
								class="cart-thumb">
							<div class="flex-grow-1">
								<div class="d-flex justify-content-between">
									<div class="fw-bold">{{vo.gvo.goods_name}}</div>
									<a :href="'../cart/delete.do?no='+vo.cart_no" class="text-body-secondary text-decoration-none">✕</a>
								</div>
								<div class="text-body-secondary small mt-1">
									{{vo.sizes}}</div>
								<div class="input-group qty-box mt-2" style="max-width: 130px;">
									<button class="btn btn-outline-secondary" type="button">−</button>
									<input type="text" class="form-control" :value="vo.quantity" readonly>
									<button class="btn btn-outline-secondary" type="button">+</button>
								</div>
	
								<div class="mt-2">
									<!-- <span class="text-danger fw-bold">xx%</span> --> <span
										class="fw-bold fs-5">{{vo.gvo.goods_price}}</span> <%-- 할인 후 가격 --%>
									<!-- <del class="text-body-secondary ms-1">xx,xxx원</del> --> <%-- 할인 전 가격 --%>
								</div>
	
								<div class="mt-3" style="max-width: 300px;">
									<a :href="'../order/order.do?no='+vo.svo.no+'&quantity='+vo.quantity" class="btn btn-outline-dark w-100">바로
										구매</a>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 장바구니 담긴 상품이 없는 경우 -->
					<div v-else-if="list.length==0 && id!=null">
						<div class="py-5 border-bottom text-center">
							<i class="fw-bold fs-1 fa-solid fa-box-open"></i>
							<div class="fw-bold fs-3 ">장바구니에 담긴 상품이 없습니다.</div>
						</div>
					</div>
					
					<!-- 로그인하고 들어오라는 페이지 -->
					<div v-else-if="id==null">
						<div class="py-5 border-bottom text-center">
							<i class="fw-bold fs-1 fa-solid fa-id-card"></i>
							<div class="fw-bold fs-3 ">로그인을 하셔야 장바구니를 사용하실 수 있습니다.</div>
						</div>
					</div>
					
					

					<!-- 상품 2 -->
					<!-- <div class="d-flex gap-3 py-4 border-bottom">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked>
						</div>
						<img src="../resources/images/product-thumb-2.png" alt="상품"
							class="cart-thumb">
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between">
								<div class="fw-bold">데일리 스니커즈 화이트</div>
								<a href="#" class="text-body-secondary text-decoration-none">✕</a>
							</div>
							<div class="text-body-secondary small mt-1">[color]White
								[size]260mm</div>
							<div class="input-group qty-box mt-2" style="max-width: 130px;">
								<button class="btn btn-outline-secondary" type="button">−</button>
								<input type="text" class="form-control" value="2" readonly>
								<button class="btn btn-outline-secondary" type="button">+</button>
							</div>

							<div class="mt-2">
								<span class="text-danger fw-bold">15%</span> <span
									class="fw-bold fs-5">118,000원</span>
								<del class="text-body-secondary ms-1">139,000원</del>
							</div>

							<div class="mt-3" style="max-width: 300px;">
								<a href="../order/order.do" class="btn btn-outline-dark w-100">바로
									구매</a>
							</div>
						</div>
					</div> -->

					<!-- 상품 3 -->
<!-- 					<div class="d-flex gap-3 py-4 border-bottom">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked>
						</div>
						<img src="../resources/images/product-thumb-3.png" alt="상품"
							class="cart-thumb">
						<div class="flex-grow-1">
							<div class="d-flex justify-content-between">
								<div class="fw-bold">뉴포트 H2 샌들 Grey Smoke Blue</div>
								<a href="#" class="text-body-secondary text-decoration-none">✕</a>
							</div>
							<div class="text-body-secondary small mt-1">[color]Grey
								[size]270mm</div>
							<div class="input-group qty-box mt-2" style="max-width: 130px;">
								<button class="btn btn-outline-secondary" type="button">−</button>
								<input type="text" class="form-control" value="1" readonly>
								<button class="btn btn-outline-secondary" type="button">+</button>
							</div>

							<div class="mt-2">
								<span class="text-danger fw-bold">10%</span> <span
									class="fw-bold fs-5">152,100원</span>
								<del class="text-body-secondary ms-1">169,000원</del>
							</div>

							<div class="mt-3" style="max-width: 300px;">
								<a href="../order/order.do" class="btn btn-outline-dark w-100">바로
									구매</a>
							</div>
						</div>
					</div> -->

				</div>

				<!-- ================= 우측: 주문 요약 ================= -->
				<div class="col-lg-4" v-if="list.length!=0">
					<div class="border rounded-4 p-4 summary-box">

						<div class="d-flex justify-content-between mb-2">
							<span class="fw-bold">총 주문 금액</span> <span class="fw-bold">{{totalPrice.toLocaleString()}}원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-1">
							<span>└ 상품 금액</span><span>{{totalPrice.toLocaleString()}}원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-3">
							<span>└ 배송비</span><span>무료</span>
						</div>

						<hr>
						<!-- 할인이 있는 경우... -->
						<!-- <div class="d-flex justify-content-between mb-2">
							<span class="fw-bold">총 할인 금액</span> <span
								class="fw-bold text-danger">-118,830원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-1">
							<span>└ 상품 할인</span><span>-83,830원</span>
						</div>
						<div
							class="d-flex justify-content-between text-body-secondary small mb-3">
							<span>└ 장바구니 쿠폰</span><span>-35,000원</span>
						</div>

						<hr> -->

						<div class="d-flex justify-content-between mb-4">
							<span class="fw-bold fs-5">총 결제 금액</span> <span
								class="fw-bold fs-5">{{totalPrice.toLocaleString()}}원</span>
						</div>

						<a href="../order/order.do" class="btn btn-dark btn-lg w-100">{{totalPrice.toLocaleString()}}원
							결제하기</a>

					</div>
				</div>
			</div>
		</div>
	</section>
	<script>
	let cartApp = Vue.createApp({
		data() {
			return {
				list:[],
				id:null,
				checked:true
			}
		},
		mounted() {
			this.dataRecv()
		},
		methods:{
			async dataRecv() {
				await axios.get('../cart/cart_vue.do',{
					params:{
						
					}
				}).then(response=>{
					this.list = response.data.list
					for(let i = 0; i < this.list.length; i++)
					{
						this.list[i].checked = true
					}
					this.id = response.data.id
					
					console.log(response)
					console.log(this.id)
					console.log(this.checked)
				})
			},
			toggleAll() {
				let status = !this.isAllChecked // 모두 선택됐다면 false, 하나라도 꺼져있으면 true
				
				for(let i = 0; i < this.list.length; i++)
				{
					this.list[i].checked = status
				}
			},
			selectedDelete() {
				let selected = []
				for(let i = 0; i < this.list.length; i++)
				{
					if(this.list[i].checked)
					{
						selected.push(this.list[i].cart_no)
					}				
				}
				
				axios.get('../cart/selected_delete.do',{
					params:{
						deletes:selected.join()
					}
				}).then(response=>{
					this.dataRecv()
				})
			},
			selectedOrder() {
				axios.get('../order/order.do',{
					params:{
						
					}
				}).then(response=>{
					location.href="../order/order.do"
				})
			}
		},
		computed:{
    		totalPrice() {
    			let sum = 0
    			for(let i=0; i < this.list.length; i++)
    			{
    				if(this.list[i].checked===true)
    				{
    					let price = this.list[i].gvo.price
    					sum = sum + (price * this.list[i].quantity)
    				}
    			}
    			return sum
    		},
    		checkedCount() {
    			let count = 0
    			for(let i=0; i < this.list.length; i++)
    			{
    				if(this.list[i].checked===true)
    				{
    					count = count + 1
    				}
    			}
    			return count
    		},
    		isAllChecked() {
    			for(let i = 0; i < this.list.length; i++)
    			{
    				if(this.list[i].checked===false)
    				{
    					return false
    				}
    			}
    			return true
    		}
		},
		watch:{
			//
		}
		
	}).mount('#cartApp')
	</script>
</body>
</html>