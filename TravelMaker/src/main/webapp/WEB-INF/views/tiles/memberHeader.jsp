<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Header Container
================================================== -->
<header id="header-container" class="fixed fullwidth dashboard">

	<!-- Header -->
	<div id="header" class="not-sticky">
		<div class="container">
			
			<!-- Left Side Content -->
			<div class="left-side">
				
				<!-- Logo -->
				<div id="logo">
					<a href="/main/home"><img src="${pageContext.request.contextPath }/resources/images/logo.png" alt=""></a>
					<a href="/main/home" class="dashboard-logo"><img src="${pageContext.request.contextPath }/resources/images/logo.png" alt=""></a>
				</div>

				<!-- Mobile Navigation -->
				<div class="mmenu-trigger">
					<button class="hamburger hamburger--collapse" type="button">
						<span class="hamburger-box">
							<span class="hamburger-inner"></span>
						</span>
					</button>
				</div>

				<!-- Main Navigation -->
				<nav id="navigation" class="style-1">
					<ul id="responsive">

						<li><a href="#">Home</a>
							<ul>
								<li><a href="index.html">Home 1 (Modern)</a></li>
								<li><a href="index-2.html">Home 2 (Default)</a></li>
								<li><a href="index-3.html">Home 3 (Airbnb)</a></li>
								<li><a href="index-4.html">Home 4 (Creative)</a></li>
								<li><a href="index-5.html">Home 5 (Slider)</a></li>
								<li><a href="index-6.html">Home 6 (Map)</a></li>
								<li><a href="index-7.html">Home 7 (Video)</a></li>
								<li><a href="index-8.html">Home 8 (Classic)</a></li>
							</ul>
						</li>
						<li><a href="#">여행 커뮤니티</a>
							<ul>
								<li><a href="#">List Layout</a>
									<ul>
										<li><a href="#">With Sidebar</a></li>
										<li><a href="#">Full Width</a></li>
										<li><a href="#">Full Width + Map</a></li>
									</ul>
								</li>
								<li><a href="#">Grid Layout</a>
									<ul>
										<li><a href="#">With Sidebar 1</a></li>
										<li><a href="#">With Sidebar 2</a></li>
										<li><a href="#">Full Width</a></li>
										<li><a href="#">Full Width + Map</a></li>
									</ul>
								</li>
								<li><a href="#">Half Screen Map</a>
									<ul>
										<li><a href="#">List Layout</a></li>
										<li><a href="#">Grid Layout 1</a></li>
										<li><a href="#">Grid Layout 2</a></li>
									</ul>
								</li>
								<li><a href="#">Single Listings</a>
									<ul>
										<li><a href="#">Single Listing 1</a></li>
										<li><a href="#">Single Listing 2</a></li>
										<li><a href="#">Single Listing 3</a></li>
									</ul>
								</li>
								<li><a href="#">Open Street Map</a>
									<ul>
										<li><a href="#">Half Screen Map List Layout</a></li>
										<li><a href="#">Half Screen Map Grid Layout 1</a></li>
										<li><a href="#">Half Screen Map Grid Layout 2</a></li>
										<li><a href="#">Full Width List</a></li>
										<li><a href="#">Full Width Grid</a></li>
										<li><a href="#">Single Listing</a></li>
									</ul>
								</li>
							</ul>
						</li>

						<li><a href="#">문의 사항</a>
							<ul>
								<li><a href="#">Dashboard</a></li>
								<li><a href="#">Messages</a></li>
								<li><a href="#">Bookings</a></li>
								<li><a href="#">Wallet</a></li>
								<li><a href="#">My Listings</a></li>
								<li><a href="#">Reviews</a></li>
								<li><a href="#">Bookmarks</a></li>
								<li><a href="#">Add Listing</a></li>
								<li><a href="#">My Profile</a></li>
								<li><a href="#">Invoice</a></li>
							</ul>
						</li>

						<li><a href="#">도움말</a>
							<div class="mega-menu mobile-styles three-columns">

									<div class="mega-menu-section">
										<ul>
											<li class="mega-menu-headline">Pages #1</li>
											<li><a href="#"><i class="sl sl-icon-user"></i> User Profile</a></li>
											<li><a href="#"><i class="sl sl-icon-check"></i> Booking Page</a></li>
											<li><a href="#"><i class="sl sl-icon-plus"></i> Add Listing</a></li>
											<li><a href="#"><i class="sl sl-icon-docs"></i> Blog</a></li>
										</ul>
									</div>
									<div class="mega-menu-section">
										<ul>
											<li class="mega-menu-headline">Pages #2</li>
											<li><a href="#"><i class="sl sl-icon-envelope-open"></i> Contact</a></li>
											<li><a href="#"><i class="sl sl-icon-hourglass"></i> Coming Soon</a></li>
											<li><a href="#"><i class="sl sl-icon-close"></i> 404 Page</a></li>
											<li><a href="#"><i class="sl sl-icon-equalizer"></i> Masonry Filtering</a></li>
										</ul>
									</div>
									<div class="mega-menu-section">
										<ul>
											<li class="mega-menu-headline">Other</li>
											<li><a href="#"><i class="sl sl-icon-settings"></i> Elements</a></li>
											<li><a href="#"><i class="sl sl-icon-tag"></i> Pricing Tables</a></li>
											<li><a href="#"><i class="sl sl-icon-pencil"></i> Typography</a></li>
											<li><a href="#"><i class="sl sl-icon-diamond"></i> Icons</a></li>
										</ul>
									</div>
							</div>
						</li>
					</ul>
				</nav>
				<div class="clearfix"></div>
				<!-- Main Navigation / End -->
			</div>
			<!-- Left Side Content / End -->

			<!-- Right Side Content / End -->
			<div class="right-side">
				<!-- Header Widget -->
				<div class="header-widget">
					
					<!-- User Menu -->
					<div class="user-menu">
						<div class="user-name"><span><img src="${pageContext.request.contextPath }/resources/images/default-user.png" alt=""></span>Hi, Tom!</div>
						<ul>
							<li><a href="#"><i class="sl sl-icon-settings"></i> 메세지</a></li>
							<li><a href="#"><i class="sl sl-icon-envelope-open"></i> 알림</a></li>
							<li><a href="/member/trip"><i class="fa fa-calendar-check-o"></i> 여행</a></li>
							<li><a href="#"><i class="sl sl-icon-power"></i> 위시리시트</a></li>
							<hr/>
							<li><a href="#"><i class="sl sl-icon-power"></i> 숙소관리</a></li>
							<li><a href="#"><i class="sl sl-icon-power"></i> 계정</a></li>
							<hr/>
							<li><a href="#"><i class="sl sl-icon-power"></i> 로그아웃</a></li>
						</ul>
					</div>

					<a href="dashboard-add-listing.html" class="button border with-icon">Add Listing <i class="sl sl-icon-plus"></i></a>
				</div>
				<!-- Header Widget / End -->
			</div>
			<!-- Right Side Content / End -->

		</div>
	</div>
	<!-- Header / End -->

</header>
<div class="clearfix"></div>
<!-- Header Container / End -->