<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<sec:csrfMetaTags/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/host/calendar.css">

<style>
.swal-modal {
	width: 500px;
}
</style>

<div id="dashboard">
	<div class="dashboard-content" style="margin-left: 0px;">
		<div class="row">
			<select id="shgAccSelect" style="width: 16.66%; float: right;">
				<c:forEach items="${accList}" var="acc">
					<option class="accVO" value="${acc.accNo}">${acc.accName}</option>
				</c:forEach> 
			</select>
		</div>
		
		<div class="row">
			<div class="col-md-10" id="calDiv">
				<div class="rap">
				    <div class="header">
				        <div class="btn prevDay"></div>
				      	<h2 class='dateTitle' style="font-weight: 700;"></h2>
				      	<div class="btn nextDay"></div>
				    </div>
				    
				    <div class="grid dateHead">
				        <div>일</div>
				        <div>월</div>
				      	<div>화</div>
				      	<div>수</div>
				      	<div>목</div>
				      	<div>금</div>
				      	<div>토</div>
				    </div>
				
				    <div class="grid dateBoard" id="selectable">
				    </div>
				</div>
				
			</div>
			<div>
				<div id="bigBlock" style="width: 16.666%; float: right;">
					<div id="basicBlock" style="height: 50%;">
						<div id="reservationDiv">
							<h4 style="text-align: center;">예약 비활성화</h4>
							<h4 id="dayH4" style="text-align: center;"></h4>
							<p>예약 불가능 날짜를 설정할 수 있습니다.</p>
							<label for="toggle" class="toggleSwitch">
							    <span class="toggleButton"><font>예약 가능</font></span>
							</label>
						</div>
					</div>
					
					<div id="bigDiv">
						<div id="myEventBlock">
							<h4 style="text-align: center;">이벤트</h4>
							<p style="font-size: 12px;">
								요금을 조정하여 더 많은 게스트를 유치해보세요.<br>
								할인율을 설정하면 해당 일수를 채우면 자동으로 할인이 됩니다.
							</p>
							<div class="eventDiv" id="weekDiv">
								<h5 style="margin: 0; font-weight: bold;">주간</h5>
								<p style="margin-bottom: 3px;">7박이상</p>
								<p>
									<span class="shgcalendarspan">0%</span><br>
									<font class="eventPrice" style="font-size: 13px;">할인을 설정해보세요.</font>
								</p>
							</div>
							<br>
							
							<div class="eventDiv" id="monthEvent">
								<h5 style="margin: 0; font-weight: bold;">월간</h5>
								<p style="margin-bottom: 3px;">28박이상</p>
								<p>
									<span class="shgcalendarspan">0%</span><br>
									<font class="eventPrice" style="font-size: 13px;">할인을 설정해보세요.</font>
								</p>
							</div>
							<br>
							
							<div id="eventModalDiv" style="display: none;">
								<a id="eventModal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim">
									<span style="font-weight: 800; color: red;"><i class="fa-solid fa-gift"></i> Travel Maker 이벤트</span> 
								</a>
								<span>이벤트 확인하러 가기</span>
							</div>
							<div id="eventContent" style="color: black;"></div>
						</div>
						
						<div id="discountBlock">
							<h5 id="discountName">주간 할인</h5>
							<br>
							<div>
								<div>
									<h5 style="font-size: 2.2rem;">할인 설정하기</h5>
									<p id="discountTip"></p>
									<br>
									<div id="myinputDiv">
										<div class="myItem" tabindex="0" contenteditable id="inputDiv">0</div>
										<div class="myItem">%</div>
									</div>
								</div>
								
								<br>
								<div class="seek-bar">
								    <div id="circle" class="circle">
								    	<span id="seekSpan">&nbsp;</span>
								    	<br>
								  	</div>
								</div>
						    	<div style="display: flex; justify-content: space-between;">
						    		<p style="float: left;">0%</p><p style="float: right;">50%</p>
						    	</div>
								
								<br>
								<button class="shgDiscountBtn ok">저장</button>
								<button class="shgDiscountBtn cancel">취소</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-2" id="reservationBlock" style="height: auto;">
				</div>
			</div>
		</div>
	</div>
</div> 

<div id="small-dialog" class="zoom-anim-dialog mfp-hide">
	<div class="small-dialog-header">
		<h3>회원에 대한 후기를 남겨보세요.</h3>
	</div>
	<div class="message-reply margin-top-0">
		<textarea cols="40" rows="3" id="reviewContent"></textarea>
		<button class="button" id="register">등록</button>
	</div>
</div>
<a id="reviewModal" href="#small-dialog" class="send-message-to-owner button popup-with-zoom-anim" style="display: none;"></a>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.countdown.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/host/calendar.js"></script>
