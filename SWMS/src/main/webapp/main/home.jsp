<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section>
	<div>
		<div class="slideshow slide-in arrow-absolute text-white"
			style="height: 70vh;">
			<div class="swiper-wrapper">

				<div class="swiper-slide jarallax swiper-slide-next">

					<img src="../resources/images/slide-2.jpg" class="jarallax-img"
						alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up">Sports
										Collection</h2>
								</div>
							</div>
						</div>
					</div>

				</div>
				<div class="swiper-slide jarallax">

					<img src="../resources/images/slide-3.jpg" class="jarallax-img"
						alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up">Casual
										Shoes</h2>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="swiper-slide jarallax">

					<img src="../resources/images/slide-4.jpg" class="jarallax-img"
						alt="slideshow">
					<div class="banner-content w-100">
						<div class="container-fluid">
							<div class="row justify-content-center text-center">
								<div class="col-md-10 pt-5">
									<h2
										class="display-xl text-white ls-0 mt-5 pt-5 txt-fx slide-up">Clearance
										Sale</h2>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
			<div class="pagination-wrapper position-absolute">
				<div class="container">
					<div class="slideshow-swiper-pagination text-center"></div>
				</div>
			</div>
			<div class="icon-arrow icon-arrow-left text-white">
				<svg width="50" height="50" viewBox="0 0 24 24">
            <use xlink:href="#arrow-left"></use>
          </svg>
			</div>
			<div class="icon-arrow icon-arrow-right text-white">
				<svg width="50" height="50" viewBox="0 0 24 24">
            <use xlink:href="#arrow-right"></use>
          </svg>
			</div>

		</div>
	</div>
</section>

<section class="features"
	style="position: relative; margin-top: -100px; z-index: 2;">
	<div class="container-lg">
		<div class="bg-white p-5">
			<div class="row">
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#cart"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Pick up in
								store</h4>
							<p>At imperdiet dui accumsan sit amet nulla risus est
								ultricies quis.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#gift"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Special
								packaging</h4>
							<p>At imperdiet dui accumsan sit amet nulla risus est
								ultricies quis.</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="row">
						<div class="col-2">
							<svg width="40" height="40">
                  <use xlink:href="#love"></use>
                </svg>
						</div>
						<div class="col-10">
							<h4 class="element-title text-capitalize mb-2">Free global
								returns</h4>
							<p>At imperdiet dui accumsan sit amet nulla risus est
								ultricies quis.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="py-5">
	<div class="container-fluid">

		<div class="row">
			<div class="col-md-12">
				<div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5">
					<div class="col">
						<div class="product-item">
							<span class="badge bg-success position-absolute m-3">-30%</span>
							<figure>
								<a href="../goods/detail.do" title="Product Title"> 
								<img src="../resources/images/product-thumb-1.png" alt="Product Thumbnail" class="img-fluid">
								</a>
							</figure>
							<span>Super Shoes</span>
							<div class="d-flex justify-content-between">
								<p>
									<span class="text-dark">$18.00</span>
									<del>$23</del>
									<span class="text-success">-30%</span>
								</p>
								<span class="d-flex"> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
								</span>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="product-item">
							<span class="badge bg-success position-absolute m-3">-30%</span>
							<figure>
								<a href="../goods/detail.do" title="Product Title"> 
								<img src="../resources/images/product-thumb-1.png" alt="Product Thumbnail" class="img-fluid">
								</a>
							</figure>
							<span>Super Shoes</span>
							<div class="d-flex justify-content-between">
								<p>
									<span class="text-dark">$18.00</span>
									<del>$23</del>
									<span class="text-success">-30%</span>
								</p>
								<span class="d-flex"> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
								</span>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="product-item">
							<span class="badge bg-success position-absolute m-3">-30%</span>
							<figure>
								<a href="../goods/detail.do" title="Product Title"> 
								<img src="../resources/images/product-thumb-1.png" alt="Product Thumbnail" class="img-fluid">
								</a>
							</figure>
							<span>Super Shoes</span>
							<div class="d-flex justify-content-between">
								<p>
									<span class="text-dark">$18.00</span>
									<del>$23</del>
									<span class="text-success">-30%</span>
								</p>
								<span class="d-flex"> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
								</span>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="product-item">
							<span class="badge bg-success position-absolute m-3">-30%</span>
							<figure>
								<a href="../goods/detail.do" title="Product Title"> 
								<img src="../resources/images/product-thumb-1.png" alt="Product Thumbnail" class="img-fluid">
								</a>
							</figure>
							<span>Super Shoes</span>
							<div class="d-flex justify-content-between">
								<p>
									<span class="text-dark">$18.00</span>
									<del>$23</del>
									<span class="text-success">-30%</span>
								</p>
								<span class="d-flex"> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
								</span>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="product-item">
							<span class="badge bg-success position-absolute m-3">-30%</span>
							<figure>
								<a href="../goods/detail.do" title="Product Title"> 
								<img src="../resources/images/product-thumb-1.png" alt="Product Thumbnail" class="img-fluid">
								</a>
							</figure>
							<span>Super Shoes</span>
							<div class="d-flex justify-content-between">
								<p>
									<span class="text-dark">$18.00</span>
									<del>$23</del>
									<span class="text-success">-30%</span>
								</p>
								<span class="d-flex"> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
									<svg width="18" height="18" class="text-warning">
				                    	<use xlink:href="#star-solid"></use>
				                    </svg> 
								</span>
							</div>
						</div>
					</div>
				</div>
				<!-- / product-grid -->

			</div>
		</div>
	</div>
</section>

</body>
</html>