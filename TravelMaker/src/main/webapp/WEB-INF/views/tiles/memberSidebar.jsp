<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- Navigation
	================================================== -->

	<!-- Responsive Navigation Trigger -->
	<a href="#" class="dashboard-responsive-nav-trigger"><i class="fa fa-reorder"></i> Dashboard Navigation</a>
	
	<div class="dashboard-nav">
		<div class="dashboard-nav-inner">

			<ul data-submenu-title="Main">
				<li><a href="#"><i class="sl sl-icon-envelope-open"></i> 메세지</a></li>
				<li><a href="#"><i class="fa fa-calendar-check-o"></i> 알림</a></li>
			</ul>
			
			<ul data-submenu-title="Listings">
				<li class="active"><a><i class="sl sl-icon-layers"></i> 여행</a>
					<ul>
						<li><a href="#">여행 경로 </a></li>
						<li><a href="#">예약 내역  </a></li>
					</ul>	
				</li>
				<li><a href="#"><i class="sl sl-icon-star"></i> 위시리스트</a></li>
			</ul>	

			<ul data-submenu-title="Account">
				<li><a href="/host/main"><i class="sl sl-icon-user"></i> 호스트로 전환</a></li>
				<li><a href="#"><i class="sl sl-icon-user"></i> 계정</a></li>
				<li><a href="#"><i class="sl sl-icon-power"></i> 로그아웃</a></li>
			</ul>

		</div>
	</div>
	<!-- Navigation / End -->