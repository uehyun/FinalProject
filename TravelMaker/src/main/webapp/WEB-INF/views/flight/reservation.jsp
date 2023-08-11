<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:csrfMetaTags/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flights.css">

<!--  -->

<div class="tou_booking_form_Wrapper1">
	<div class="booking_tour_form">
		<div class="booking_tour_form2">
			<h3 class="heading_theme" id="pf_heading">탑승객 및 정보</h3>
			<div class="personType1">
				<img alt="person" src="${pageContext.request.contextPath}/resources/images/person.png" id="personImg">
				<span class="passenger1">승객1명, 전체</span>
			</div>
		</div>
				<button type="button" id="fillBtn">클릭해주세요</button>
		<!-- 승객 수 선택 모달 -->
			<div class="selectPerson1">
				<div class="selectPerson2">
					<div class="selectPerson3">
						<div class="adultSelect">
							<span class="adultSpan"> <span class="adultSpan2">성인</span>
								<span class="adultSpan3">만 16세 이상</span>
							</span>
							<div class="adultCount">
								<button type="button" id="plusAdultBtn">
									<img alt="plus2"
										src="${pageContext.request.contextPath}/resources/images/plus2.png">
								</button>
								<span class="adultNum">1</span>
								<button type="button" id="minusAdultBtn">
									<img alt="plus"
										src="${pageContext.request.contextPath}/resources/images/minus.png">
								</button>
							</div>
						</div>
						<div class="childSelect">
							<span class="adultSpan"> <span class="adultSpan2">유소년</span>
								<span class="adultSpan3">만 0~15세</span>
							</span>
							<div class="childCount">
								<button type="button" id="plusChildBtn">
									<img alt="plus" src="${pageContext.request.contextPath}/resources/images/plus2.png">
								</button>
								<span class="childNum">0</span>
								<button type="button" id="minusChildBtn">
									<img alt="minus" src="${pageContext.request.contextPath}/resources/images/minus.png">
								</button>
							</div>
						</div>
						<div id="personCheckBox">
							<button type="button" class="personCheckBtn">확인</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 승객 수 선택 모달 끝 -->
		<div class="reservationContainer">
			<div class="tour_booking_form_box">
				<form action="" id="tour_bookking_form_item" class="passengerForm">
					<input type="hidden" name="flightNo" value="${flight}" id="flightNo">
					<input type="hidden" name="passengerType" value="성인" id="passengerType">
					<div class="row">
						<div class="subDiv1">
							<div class="col-lg-6">
								<div class="form-group">
									<label for="firstName">성</label>
									<input type="text" class="passengerFirstname" placeholder="영문 성" id="passengerFirstname" name="passengerFirstname" value="">
									<span class="firstnameEx"></span>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="form-group">
									<label for="lastName">이름</label>
									<input type="text" class="passengerLastname" placeholder="이름 및 중간이름" id="passengerLastname" name="passengerLastname" value="">
									<span class="lastnameEx"></span>
								</div>
							</div>
						</div>
						<div class="subDiv2">
							<div class="col-lg-6">
								<div class="form-group">
									<label for="email">이메일</label>
									<input type="text" class="passengerEmail" placeholder="이메일" id="passengerEmail" name="passengerEmail" value="">
									<span class="emailEx"></span>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="form-group">
									<label for="tel">전화번호</label>
									<input type="text" class="passengerPhone" placeholder="휴대폰" id="passengerPhone" name="passengerPhone" value="">
								</div>
							</div>
							<div class="col-lg-6">
								<div class="form-group">
									<label for="email">여권번호</label>
									<input type="text" class="passportNo" placeholder="여권번호" id="passportNo" name="passportNo" value="">
								</div>
							</div>
							<div class="col-lg-6">
								<div class="form-group">
									<label for="tel">여권만기일</label>
									<input type="text" class="passportEndDate" placeholder="여권만기일" id="passportEndDate" name="passportEndDate" value="">
								</div>
							</div>
						</div>
						<div class="subDiv3">
							<div class="col-lg-6">
								<div class="form-group">
									<label for="email">생년월일</label>
									<input type="text" class="passengerBirth" placeholder="YYYY-MM-DD" id="passengerBirth" name="passengerBirth" value="">
									<span class="birthEx"></span>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>	
		
	</div>
	<div class="booking_tour_form">
		<h3 class="heading_theme" id="pf_heading">수하물</h3>
		<div class="tour_booking_form_box">
			<!--  -->
				<div class="a1">
					<div class="a2">
						<div class="a3">
							<h4><span>개인물품</span></h4>
						</div>
					</div>
					<div class="b2">
						<div class="b3">
							<span>앞 좌석 밑에 들어갈 수 있는 작은 가방.</span>
						</div>
						<div class="c3">
							<div class="c4">
								<img alt="luggage1" src="${pageContext.request.contextPath}/resources/images/luggage1.png" class="luggageImg">
								<span class="optionSpan">포함됨</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="a1">
					<div class="a2">
						<div class="a3">
							<h4><span>기내수하물</span></h4>
						</div>
					</div>
					<div class="b2">
						<div class="b3">
							<p>앞 좌석 밑에 들어갈 수 있는 작은 가방.</p>
						</div>
						<div class="c3">
							<div class="c4">
								<img alt="luggage2" src="${pageContext.request.contextPath}/resources/images/luggage2.png" class="luggageImg">
								<span class="optionSpan">포함됨</span>
								<span class="luggageWeight">1 x 10kg</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="a1">
					<div class="a2">
						<div class="a3">
							<h4><span>위탁수하물</span></h4>
						</div>
					</div>
					<div class="b2">
						<div class="b3">
							<p>앞 좌석 밑에 들어갈 수 있는 작은 가방.</p>
						</div>
						<div class="c3">
							<div class="c4">
								<img alt="luggage3" src="${pageContext.request.contextPath}/resources/images/luggage3.png" class="luggageImg">
								<span class="optionSpan">제외됨</span>
								<span class="luggageWeight">1 x 15kg</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="booking_tour_form_submit">
			<button type="button" id="nextFBtn">계속</button>
		</div>
</div>


<!-- 스크립트 -->

<script src="${pageContext.request.contextPath}/resources/scripts/flight/reservation.js"></script>

