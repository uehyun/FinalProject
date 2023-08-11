<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.footer-cont {
	font: 15px "Fira Sans", sans-serif;
}
</style>
<div id="footer" class="sticky-footer" >
	<div class="container" style="display: flex; justify-content: space-between;">
		<div class="row">
			<div class="col-md-5 col-sm-6">
				<img class="footer-logo" src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""> <br>
				<br>
				<span class="footer-cont">Travel Maker는 통신판매 중개자로 Travel Maker 플랫폼을 통하여 게스트와 호스트 사이에 이루어지는 통신판매의 당사자가 아닙니다.<br/>
				Travel Maker 플랫폼을 통하여 예약된 숙소, 체험, 호스트 서비스에 관한 의무와 책임은 해당 서비스를 제공하는 호스트에게 있습니다.
				</span>
			</div>
			<div class="col-md-4 col-sm-6" style="margin-top: 65px;">
				<ul class="footer-links">
					<li><a href="#">사이트 정보</a></li>
					<li><a href="#">회원가입</a></li>
					<li><a href="#">계정</a></li>
				</ul>

				<ul class="footer-links">
					<li><a href="#">FAQ</a></li>
					<li><a href="#">문의사항</a></li>
				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="col-md-3  col-sm-12" style="margin-top: 55px;">
				<div class="text-widget">
					<span>대전광역시 중구 계룡로 846</span><br> 
					Phone: <span>010-0000-0000</span><br> 
					E-Mail:<span> <a href="#">eyony@naver.com</a></span><br>
				</div>
			</div>
		</div>
<!-- 		<div class="row"> -->
<!-- 			<div class="col-md-12"> -->
<!-- 				<div class="copyrights">© 2023 Travel Maker. Inc.</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
</div>
