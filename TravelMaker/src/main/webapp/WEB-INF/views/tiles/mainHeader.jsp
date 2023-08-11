<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainHeader.css">

<header id="header-container" class="no-shadow">
	<div id="header">
		<c:set value="ko" var="preLang" />
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.member" var="guestMember"/>
			<c:set value="${member.memPreLanguage}" var="preLang" />
		</sec:authorize>
		
		<c:if test="${not empty updateMember}">
	        <c:set target="${guestMember}" property="memProfilePath" value="${updateMember.memProfilePath}"/>
	        <c:set target="${guestMember}" property="memName" value="${updateMember.memName}"/>
	    </c:if>
		<div class="container">

			<div class="left-side">
		
				<div id="logo">
					<a href="/main/home">
						<img src="${pageContext.request.contextPath}/resources/images/logo.png" width="300px" height="120px" alt="">
					</a>
				</div>
				
				<!-- Mobile Navigation -->
				<div class="mmenu-trigger">
					<button class="hamburger hamburger--collapse" type="button">
						<span class="hamburger-box"> <span class="hamburger-inner"></span>
						</span>
					</button>
				</div>

				<!-- Main Navigation -->
				<nav id="navigation" class="style-1" style="float: right; font-weight: 700;">
					<ul id="responsive">
						<li>
							<a href="/flight/home">비행기</a>
						</li>
						
						<li>
							<a href="/tripBoard/main">여행 커뮤니티</a>
						</li>

						<li>
							<a href="/member/inlist">문의 사항</a>
						</li>

						<li>
							<a href="/member/faqlist">도움말</a>
						</li>

					</ul>
				</nav>
				<div class="clearfix"></div>
			</div>
			
			<div class="right-side">
				<div class="header-widget">
				
					<a href="#small-dialog-shg" class="send-message-to-owner button shg popup-with-zoom-anim" style="border: none; background: none; color: black;">
						<i class="fa-solid fa-globe" id="globalSetting"><div id="google_translate_element" style="display:none;"></div></i>
					</a>
					
					<div id="small-dialog-shg" class="zoom-anim-dialog mfp-hide">
						<div class="small-dialog-header">
							<h3>글로벌 설정</h3>
						</div>
						<div class="message-reply margin-top-0">
							<ul id="translation-ul">
				                <li class="translation-links">
				                	<a href="#" data-lang="ko" title="한국어">
				                		<span style="font-weight: 800;">한국어</span>
				                	</a>
				                </li>
				                
				                <li class="translation-links">
				                	<a href="#" data-lang="en" title="English">
				                		<span style="font-weight: 800;">영어</span>
				                	</a>
				                </li>
				                
				                <li class="translation-links">
				                	<a href="#" data-lang="ja" title="日本語">
				                		<span style="font-weight: 800;">일본어</span>
				                	</a>
				                </li>
				                
				                <li class="translation-links">
				                	<a href="#" data-lang="zh-CN" title="中文(简体)">
				                		<span style="font-weight: 800;">중국어</span>
				                	</a>
				                </li>
				            </ul>
						</div>
					</div>

		            <script type="text/javascript">
		                function googleTranslateElementInit() {
		                	new google.translate.TranslateElement({
		                		pageLanguage: "ko",
		                		autoDisplay: false
		                	}, 'google_translate_element');
		                }
		                
		                let translate_li = $(".translation-links");
		                
		                translate_li.on("click", function(event) {
							event.preventDefault();
							
							let tolang = $(this).find("a").data("lang");
							
							const gtcombo = document.querySelector('.goog-te-combo');

							if (gtcombo == null) {
	                            console.log("번역 실패");
	                            return false;
	                        }

							gtcombo.value = tolang; 
	                        gtcombo.dispatchEvent(new Event('change')); 
							
	                        $(".mfp-close").click();
						});
		            </script>
					<script src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
						
					<div class="user-menu">
						<div class="user-name">
							<sec:authorize access="isAnonymous()">
								<span>
									<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">
								</span>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<c:choose>
									<c:when test="${empty guestMember.memProfilePath}">
										<span>
											<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" alt="">
										</span>	
									</c:when>
									<c:otherwise>
										<span>
											<img src="${guestMember.memProfilePath}" alt="">
										</span>
									</c:otherwise>
								</c:choose>
								${guestMember.memName}
							</sec:authorize>
							<input type="hidden" name="memNo" id="memNo" value="${guestMember.memNo}">
						</div>
						
						<sec:authorize access="isAnonymous()">
							<ul>
								<li><a href="/signup"><i class="sl sl-icon-user-follow"></i> 회원가입</a></li>
								<li><a href="/login"><i class="sl sl-icon-login"></i> 로그인</a></li>
							</ul>
						</sec:authorize>
						
						<c:set value="/host/register" var="aTagHref"></c:set>
						<c:set value="숙소 등록하기" var="aTagText"></c:set>
						
						<sec:authorize access="hasRole('ROLE_HOST')">
							<c:set value="/host/main" var="aTagHref"></c:set>
							<c:set value="호스트 모드" var="aTagText"></c:set>
						</sec:authorize>
						
						<sec:authorize access="hasRole('ROLE_MEMBER') and !hasRole('ROLE_ADMIN')">
							<ul>
								<li>
									<a href="/member/chat">
										<i class="sl sl-icon-bubble"></i> 메세지<span class="SHGnotification-badge"></span>
									</a>
								</li>
								
								<li>
									<a href="/member/alarm">
										<i class="sl sl-icon-bell"></i> 알림<span class="SHGnotification-badge" id="alarm-badge"></span>
									</a>
								</li>
									
								<li>
									<a href="/member/trip">
										<i class="fa fa-calendar-check-o"></i> 여행
									</a>
								</li>
								
								<li>
									<a href="/member/wishlist">
										<i class="sl sl-icon-heart"></i> 위시리시트
									</a>
								</li>
								
								<hr/>
								
								<li>
									<a href="${aTagHref}">
										<i class="sl sl-icon-home"></i> ${aTagText}
									</a>
								</li>
								
								<li>
									<a href="/member/detail">
										<i class="sl sl-icon-settings"></i> 계정
									</a>
								</li>
								
								<hr />
								
								<li>
									<form action="/logout" method="post">
										<sec:csrfInput/>
										<button type="submit" style="border: none; background: white;"><i class="sl sl-icon-logout"></i> 로그아웃</button>
									</form>
								</li>
							</ul>
						</sec:authorize>
						
						<sec:authorize access="hasRole('ROLE_ADMIN') and hasRole('ROLE_MEMBER')">
							<ul>
								<li>
									<a href="/admin/manage/revenue">
										<i class="sl sl-icon-settings"></i> 관리자 모드
									</a>
								</li>
								<hr/>
								<li>
									<form action="/logout" method="post">
										<sec:csrfInput/>
										<button type="submit" style="border: none; background: white;"><i class="sl sl-icon-logout"></i> 로그아웃</button>
									</form>
								</li>
							</ul>
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="clearfix"></div>
<script src="${pageContext.request.contextPath}/resources/scripts/main/mainHeader.js"></script>