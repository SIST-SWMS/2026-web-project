<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>

.like-table img{
	width:100px;
	height:100px;
	object-fit:cover;
	border-radius:10px;
}

.like-table tbody tr{
	transition:.2s;
}

.like-table tbody tr:hover{
	background:#f8f9fa;
}

.like-table td{
	vertical-align:middle;
}

.goods-name{
	font-size:17px;
	font-weight:bold;
	color:#222;
	text-decoration:none;
}

.goods-name:hover{
	color:#0d6efd;
}

.price{
	font-size:18px;
	font-weight:bold;
	color:#212529;
}

.brand{
	color:#666;
	font-weight:600;
}

.like-header{
	display:flex;
	justify-content:space-between;
	align-items:center;
	margin-bottom:25px;
}

</style>


<div class="container mt-4">


<form action="../mypage/likeDelete.do" method="post">


	<div class="like-header">

		<h3>
			좋아요 목록
		</h3>


		<button class="btn btn-outline-danger">
			선택 삭제
		</button>

	</div>



	<table class="table like-table align-middle">


		<thead class="table-light text-center">

			<tr>

				<th width="7%">
					<input type="checkbox" id="allCheck">
				</th>

				<th width="15%">
					이미지
				</th>

				<th>
					상품명
				</th>

				<th width="18%">
					브랜드
				</th>

				<th width="18%">
					가격
				</th>

			</tr>

		</thead>



		<tbody>


			<c:if test="${empty list}">

				<tr>

					<td colspan="5" class="text-center p-5">

						좋아요한 상품이 없습니다.

					</td>

				</tr>

			</c:if>





			<c:forEach var="vo" items="${list}">


				<tr>


					<td class="text-center">

						<input type="checkbox"
							   name="goods_no"
							   value="${vo.goods_no}">

					</td>



					<td class="text-center">


						<a href="../goods/detail.do?goods_no=${vo.gvo.goods_no}">


							<img src="${vo.gvo.poster_url}">


						</a>


					</td>





					<td>


						<a class="goods-name"
						   href="../goods/detail.do?goods_no=${vo.gvo.goods_no}">

							${vo.gvo.goods_name}

						</a>


					</td>





					<td class="text-center">

						<span class="brand">

							${vo.gvo.brand_name}

						</span>


					</td>





					<td class="text-center">


						<span class="price">

							${vo.gvo.goods_price}

						</span>


					</td>


				</tr>


			</c:forEach>



		</tbody>


	</table>


</form>


</div>



<script>

document.getElementById("allCheck")
.addEventListener("change",function(){


	const list=document.getElementsByName("goods_no");


	for(let i=0;i<list.length;i++){

		list[i].checked=this.checked;

	}


});


</script>