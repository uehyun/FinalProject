<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<header id="header-container" class="fixed fullwidth dashboard">
	<div id="header" class="not-sticky">
		<div class="container">
			<div class="left-side" style="width : 55%;">

				<div id="logo">
					<a href="/main/home">
						<img src="${pageContext.request.contextPath }/resources/images/logo.png" alt="">
					</a>
					<a href="/main/home" class="dashboard-logo">
						<img src="${pageContext.request.contextPath }/resources/images/logo.png" alt="">
					</a>
				</div>

				<div class="mmenu-trigger">
					<button class="hamburger hamburger--collapse" type="button">
						<span class="hamburger-box">
							<span class="hamburger-inner"></span>
						</span>
					</button>
				</div>

				<nav id="navigation" class="style-1" style="float: right; font-weight: 700;">
					<ul id="responsive">

						<li><a href="/flight/home">비행기</a></li>
						<li><a href="/tripBoard/main">여행 커뮤니티</a></li>
						<li><a href="#">문의 사항</a></li>
						<li><a href="#">도움말</a></li>
						
					</ul>
				</nav>
				<div class="clearfix"></div>
			</div>

			<div class="right-side">
				<div class="header-widget">
					<div class="user-menu">
						<div class="user-name">
							<span>
								<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="">
							</span>
						</div>
						<ul>
							<li>
								<a href="/main/home">
									<i class="sl sl-icon-settings"></i> 메인화면
								</a>
							</li>
							<li>
								<form action="/logout" method="post">
									<sec:csrfInput/>
									<button type="submit" style="border: none; background: white;"><i class="sl sl-icon-logout"></i> 로그아웃</button>
								</form>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="clearfix"></div>
