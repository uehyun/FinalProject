<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<style>
.user-name span img {
	height : 100%;
}
</style>
<header id="header-container" class="fixed fullwidth dashboard">
	<div id="header" class="not-sticky">
		<div class="container">
			<div class="left-side">
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
						<span class="hamburger-box"> <span class="hamburger-inner"></span>
						</span>
					</button>
				</div>

				<nav id="navigation" class="style-1" style="float: right; font-weight: 700;">
					<ul id="responsive">
						<li>
							<a href="/flight/home">비행기</a>
						</li>
						<li>
							<a href="/tripBoard/main">여행 커뮤니티</a>
						</li>
						<li>
							<a href="#">문의 사항</a>
						</li>
						<li>
							<a href="#">도움말</a>
						</li>
					</ul>
				</nav>
				<div class="clearfix"></div>
			</div>

			<div class="right-side">
				<div class="header-widget" style="margin-right : 100px;">
					<div class="user-menu">
						<div class="user-name">
							<sec:authorize access="isAnonymous()">
								<span>
									<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">
								</span>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<c:choose>
									<c:when test="${empty member.memProfilePath}">
										<span>
											<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="">
										</span>	
									</c:when>
									<c:otherwise>
										<span>
											<img src="${member.memProfilePath}" alt="">
										</span>
									</c:otherwise>
								</c:choose>
							</sec:authorize>
							${member.memName}
							<input type="hidden" name="memNo" id="memNo" value="${member.memNo}">
						</div>
						<ul>
							<li><a href="/host/main" style="text-decoration: none;"><i class="sl sl-icon-home"></i> 메인페이지</a></li>
							<li><a href="/host/manage" style="text-decoration: none;"><i class="sl sl-icon-settings"></i> 숙소관리</a></li>
							<li><a href="/host/calendar" style="text-decoration: none;"><i class="fa-sharp fa-regular fa-calendar-days"></i> 캘린더</a></li>
							<li><a href="/host/revenue" style="text-decoration: none;"><i class="fa fa-money"></i> 매출</a></li>
							<hr>
							<li><a href="/main/home" style="text-decoration: none;"><i class="sl sl-icon-reload"></i> 게스트 모드</a></li>
							<hr>
							<li>
								<form action="/logout" method="post">
									<sec:csrfInput/>
									<button type="submit" style="text-decoration: none; border: none; background: white;"><i class="sl sl-icon-logout"></i> 로그아웃</button>
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
