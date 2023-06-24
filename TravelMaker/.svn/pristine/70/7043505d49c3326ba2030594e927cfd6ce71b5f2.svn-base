<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#tripList {
	display: flex;
	align-items: center;
}

#tripList input {
	align-items: right;
	margin-left: auto;
	width : 125px;
}
</style>
<div class="dashboard-content">
	<!-- Titlebar -->
	<div id="titlebar">
		<div class="row">
			<div class="col-md-12">
				<h2>My Listings</h2>
				<!-- Breadcrumbs -->
				<nav id="breadcrumbs">
					<ul>
						<li><a href="#">Home</a></li>
						<li><a href="#">Dashboard</a></li>
						<li>My Listings</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<div class="row">
		
		<!-- Listings -->
		<div class="col-lg-12 col-md-12">
			<div class="dashboard-list-box margin-top-0">
				<h4 id="tripList">여행 경로 리스트<input type="button" value="추가하기" id="addTrip"/></h4>
				<ul>

					<li>
						<div class="list-box-listing">
							<div class="list-box-listing-img"><a href="#"><img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=60" alt=""></a></div>
							<div class="list-box-listing-content">
								<div class="inner">
									<h3><a href="#">Tom's Restaurant</a></h3>
									<span>964 School Street, New York</span>
								</div>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</div>
</div>
<script>
	const addTrip = document.querySelector("#addTrip");
	
	addTrip.addEventListener("click", function(){
		location.href="/member/addTrip";
	})
</script>