<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 검색 결과</title>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<style>
.product-card { 
	position: relative; 
}
.product-card .like-btn {
	position: absolute; 
	right: 12px; 
	bottom: 12px;
	background: #fff; 
	border-radius: 50%; 
	width: 34px; 
	height: 34px;
	display: flex; 
	align-items: center; 
	justify-content: center;
	box-shadow: 0 1px 4px rgba(0, 0, 0, .15); 
	cursor: pointer; 
	border: none;
}
.product-card .thumb-box {
	background: #f5f5f5; 
	border-radius: 8px; 
	overflow: hidden;
	aspect-ratio: 1/1; 
	display: flex; 
	align-items: center; 
	justify-content: center;
}
.product-card .thumb-box img {
 	width: 100%; height: 100%; object-fit: cover; 
 }
.product-brand { 
	font-size: 13px; color: #888; margin-top: 10px; 
}
.product-name { 
	font-size: 14px; color: #222; margin: 2px 0; 
}
.product-price { 
	font-size: 16px; font-weight: 700; 
}
.product-meta { 
	font-size: 12px; color: #999; 
}

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
</style>
</head>
<body>
<div id="findApp">

    <div class="border-bottom pb-3 mb-4">
        <h4>"<span style="color:#0d6efd;">{{fd}}</span>" 검색 결과</h4>
    </div>

    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
        <div class="col-12 text-center py-5" v-if="list.length === 0">
            <h5>조건에 맞는 상품이 없습니다.</h5>
        </div>
        <div class="col" v-for="vo in list" :key="vo.goods_no">
            <div class="product-card">
                <a :href="'../goods/detail.do?goods_no='+vo.goods_no">
                    <div class="thumb-box">
                        <img :src="imageUrl(vo.poster_url)" :alt="vo.goods_name">
                    </div>
                </a>

                <button type="button" class="like-btn" style="border:none; background:none;">
				    <svg v-if="vo.like_count > 0" width="18" height="18" viewBox="0 0 24 24" fill="red">
				        <use xlink:href="#heart-fill"></use>
				    </svg>
				    <svg v-else width="18" height="18" viewBox="0 0 24 24">
				        <use xlink:href="#heart-empty"></use>
				    </svg>
				</button>

                <div class="product-brand">{{ vo.brand_name }}</div>
                <div class="product-name">{{ vo.goods_name }}</div>
                <div class="product-price">{{ vo.goods_price }}</div> 
                <div class="product-meta">
                    <svg width="12" height="12" viewBox="0 0 24 24">
                    <use xlink:href="#heart"></use></svg> {{ vo.like_count }}
                    <svg width="12" height="12" viewBox="0 0 12 12">
                    <use xlink:href="#eye"></use></svg> {{ vo.hit }}
                </div>
            </div>
        </div>
    </div>

    <!-- 페이지네이션 -->
    <div class="row text-center" style="margin-top: 40px" v-if="list.length > 0">
        <div class="d-flex justify-content-center">
            <ul class="pagination">
                <li v-if="startPage > 1">
                    <a @click="pageChange(startPage - 1)">&laquo;</a>
                </li>
                <li v-for="i in range(startPage, endPage)" :class="i === curpage ? 'active' : ''">
                    <a @click="pageChange(i)">{{ i }}</a>
                </li>
                <li v-if="endPage < totalpage">
                    <a @click="pageChange(endPage + 1)">&raquo;</a>
                </li>
            </ul>
        </div>
    </div>
</div>

<script>
Vue.createApp({
    data() {
        return {
            cno: ${param.cno == null ? 0 : param.cno},
            fd: '${param.fd}',
            curpage: 1,
            totalpage: 0,
            startPage: 0,
            endPage: 0,
            list: []
        }
    },
    mounted() {
        this.dataRecv();

        let ctg = this; 

        $('.category-menu').on('click', '.category-btn', function(e) {
            e.preventDefault(); 
            
            $('.category-menu .category-btn').removeClass('active');
            $(this).addClass('active');
            
            let currentCno = $(this).attr('data-cno');
            
            ctg.cno = currentCno;
            ctg.curpage = 1; 
            ctg.dataRecv();  
           /*  this.cno=currentCno;
            this.curpage=1;
            this.dataRecv(); */
        });
    },
    methods: {
        dataRecv() {
            axios.get('../goods/find_vue.do', {
                params: {
                    cno: this.cno,
                    fd: this.fd,
                    page: this.curpage
                }
            }).then(response => {
                this.list=response.data.list;
                this.curpage=response.data.curpage;
                this.totalpage=response.data.totalpage;
                this.startPage=response.data.startPage;
                this.endPage=response.data.endPage;
            }).catch(error => {
                console.log(error);
            });
        },
        pageChange(page) {
            this.curpage = page;
            this.dataRecv(); 
        },
        range(start, end) {
            let arr = [];
            for(let i=start; i<=end; i++) {
                arr.push(i);
            }
            return arr;
        },
        imageUrl(url) {
            if (!url){
            	return '/SWMS/images/no-image.png'
            }
            return url.startsWith('http') ? url : '/SWMS/uploads/' + url
        }
    }
}).mount('#findApp');
</script>
</body>
</html>
