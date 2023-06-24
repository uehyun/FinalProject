<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Banner
================================================== -->
<div class="main-search-container plain-color">
	<div class="main-search-inner">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
				
					<div class="main-search-headlines">
						<h2>
							여기도 멋진말 
							<!-- Typed words can be configured in script settings at the bottom of this HTML file -->
							<span class="typed-words"></span>
						</h2>
						<h4>여행관련 멋있는 문구 작성하는 구간</h4>
					</div>

					<div class="main-search-input">
						<div class="main-search-input-item">
							<input type="text" placeholder="지역검색 조건" value=""/>
						</div>
						<div class="main-search-input-item location">
							<div id="autocomplete-container">
								<input id="autocomplete-input" type="text" placeholder="날짜검색 조건">
							</div>
							<a href="#"><i class="fa fa-map-marker"></i></a>
						</div>
						<div class="main-search-input-item">
							<select data-placeholder="인간유형 조건" class="chosen-select" >
								<option>여기에</option>	
								<option>조건을</option>
								<option>넣는 거에용</option>
							</select>
						</div>
						<button class="button">검색</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Event Slider -->
	<div class="container msps-container">
	
	<!-- 이벤트 이미지 넣는 구간 -->
		<div class="main-search-photo-slider">
			<div class="msps-slider-container">
				<div class="msps-slider">
					<div class="item"><h1>이미지 넣는것 같음</h1></div>
					<div class="item"><h1>이미지 넣는것 같음</h1></div>
					<div class="item"><h1>이미지 넣는것 같음</h1></div>
				</div>
			</div>
		</div>
	<!-- 이벤트 이미지 넣는 구간 끝 -->

	<!-- 메인 효과 부분 -->
		<div class="msps-shapes" id="scene">
			<div class="layer" data-depth="0.2">
				<svg height="40" width="40" class="shape-a">
					<circle cx="20" cy="20" r="17" stroke-width="4" fill="transparent" stroke="#C400FF" />
				</svg>
			</div>
			<div class="layer" data-depth="0.5">
				<svg width="90" height="90" viewBox="0 0 500 800" class="shape-b">
				<g transform="translate(281,319)">
				<path fill="transparent" style="transform:rotate(25deg)" stroke-width="35" stroke="#F56C83" fill  d="M260.162831,132.205081
				A18,18 0 0,1 262.574374,141.205081
				A18,18 0 0,1 244.574374,159.205081H-244.574374
				A18,18 0 0,1 -262.574374,141.205081
				A18,18 0 0,1 -260.162831,132.205081L-15.588457,-291.410162
				A18,18 0 0,1 0,-300.410162
				A18,18 0 0,1 15.588457,-291.410162Z"/></g></svg>
			</div>
			<div class="layer" data-depth="0.2" data-invert-x="false" data-invert-y="false" style="z-index: -10">
				<svg height="200" width="200" viewbox="0 0 250 250" class="shape-c">
				<path d=" M 0, 30 C 0, 23.400000000000002 23.400000000000002, 0 30,
				 		  0 S 60, 23.400000000000002 60, 30
				          36.599999999999994, 60 30, 60
				          0, 36.599999999999994 0, 30" fill="#FADB5F" 
				transform="rotate(-25, 100, 100) translate(00) scale(3.5)"></path>
				</svg>
			</div>


			<div class="layer" data-depth="0.6" style="z-index: -10">
				<svg height="120" width="120" class="shape-d">
					<circle cx="60" cy="60" r="60" fill="#222" />
				</svg>
			</div>


			<div class="layer" data-depth="0.2">
				<svg height="70" width="70" viewBox="0 0 200 200"  class="shape-e">
					<path fill="#FF0066" d="M68.5,-24.5C75.5,-0.8,58.7,28.5,33.5,46.9C8.4,65.4,-25.2,73.1,-42.2,60.2C-59.2,47.4,-59.6,13.9,-49.8,-13.7C-40,-41.3,-20,-63.1,5.4,-64.8C30.7,-66.6,61.5,-48.3,68.5,-24.5Z" transform="translate(100 100)" />
				</svg>
			</div>

		</div>
	</div>
</div>




<!-- 
============================================================================================
============================================================================================
 -->


<!-- Content
================================================== -->
<section class="fullwidth margin-top-0 padding-top-0 padding-bottom-40" data-background-color="#fcfcfc">
<div class="container">
	<div class="row">

		<div class="col-md-12">
			<h3 class="headline margin-top-75">
				<strong class="headline-with-separator">카테고리</strong>
			</h3>
		</div>

		<div class="col-md-12">
			<div class="categories-boxes-container-alt margin-top-5 margin-bottom-30">
				
				<a href="#" class="category-small-box-alt">
					<i class="im im-icon-Hamburger"></i>
					<img src="${pageContext.request.contextPath}/resources/images/category-box-01.jpg">
				</a>

				<a href="#" class="category-small-box-alt">
					<i class="im  im-icon-Sleeping"></i>
					<img src="${pageContext.request.contextPath}/resources/images/category-box-02.jpg">
				</a>

				<a href="#" class="category-small-box-alt">
					<i class="im im-icon-Shopping-Bag"></i>
					<img src="${pageContext.request.contextPath}/resources/images/category-box-03.jpg">
				</a>

				<a href="#" class="category-small-box-alt">
					<i class="im im-icon-Cocktail"></i>
					<img src="${pageContext.request.contextPath}/resources/images/category-box-04.jpg">
				</a>

				<a href="#" class="category-small-box-alt">
					<i class="im im-icon-Electric-Guitar"></i>
					<img src="${pageContext.request.contextPath}/resources/images/category-box-05.jpg">
				</a>

			</div>
		</div>
	</div>
</div>
</section>
<!-- Category Boxes / End -->

<!-- Listings -->
<div class="container margin-top-70">
	<h1>여기가 숙소 무한 로딩 나오는 구간</h1>
</div>
<!-- Listings / End -->