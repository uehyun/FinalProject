<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flights.css">
<sec:csrfMetaTags/>


<section id="tour_booking_submission" class="section_padding">
	<div class="container">
		<input type="hidden" value="${sessionScope.passenger[0].adultCount}" id="adultCount">
		<input type="hidden" value="${sessionScope.passenger[0].childCount}" id="childCount">
<%-- 		<input type="hidden" value="${member.memNo }" id="memNo" name="memNo"> --%>
<%-- 		<p>${member.memNo }</p> --%>
		<div class="row">
			<h3 class="resInformation">예약자 정보</h3>
			<c:forEach items="${flight}" var="flight">
				<div class="col-lg-8">
					<div class="tou_booking_form_Wrapper">
						<div class="booking_tour_form">
							<h4 class="heading_theme2">${flight.passengerType}</h4>
							<div class="tour_booking_form_box_detail">
								<div class="your_info_arae">
									<ul>
										<li>
											<span class="name_first">성:</span>
											<span class="last_name">${flight.passengerFirstname }</span>
										</li>
										<li>
											<span class="name_first">이름:</span>
											<span class="last_name">${flight.passengerLastname }</span>
										</li>
										<li>
											<span class="name_first">이메일</span>
											<span class="last_name">${flight.passengerEmail }</span>
										</li>
										<li>
											<span class="name_first">전화번호</span>
											<span class="last_name">${flight.passengerPhone }</span>
										</li>
										<li>
											<span class="name_first">생년월일</span>
											<span class="last_name">${flight.passengerBirth }</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<div class="col-lg-4">
				<div class="tour_details_right_sidebar_wrapper">
					<div class="tour_details_heading">
						<h3>예약 상세 내역</h3>
					</div>
					<div class="tour_detail_right_sidebar">
						<div class="tour_details_right_boxed">
							<div class="tour_booking_amount_area">
								<div class="flight_depart_container">
									<div class="flight_depart_container_wrapper">
										<div class="flight_depart_container_wrapper2">
											<div class="depart_a1">
												<h3 class="depart_title">
													<span class="small_title">출발</span>
												</h3>
												<c:forEach items="${reservationDetail}" var="detail">
													<div class="depart_date_a1">
													<span>${detail.flightDate}(출발날짜)</span>
													</div>
													<div class="depart_date_a2">
														<h3 class="depart_time">
															<span>${detail.flightDepartTime} - ${detail.flightArriveTime }</span>
														</h3>
														<span class="depart_date_a3">(${detail.durationHour}시간 ${detail.durationMinute }분)</span>
														<div class="depart_img1">
															<div class="css-1tbeqbx epokimf3">
																<svg viewBox="0 0 64 64" pointer-events="all"
																	aria-hidden="true" class="etiIcon" role="presentation"
																	style="fill: rgb(51, 51, 51); height: 0.8rem; width: 0.8rem;">
																	<path
																		d="M6.12 27a3.12 3.12 0 01-1.3-2.4V14.5a1.52 1.52 0 01.65-1.35 1.71 1.71 0 011.45-.25l3.9 1.1a1.54 1.54 0 011.1 1l2.8 6.7 10.2 2.8-4.8-16.4a1.69 1.69 0 01.65-1.35 1.37 1.37 0 011.45-.25l6.5 1.7a1.8 1.8 0 011.2 1.2l10 19.2 9.8 2.7a14.18 14.18 0 017 4q3 3 2.35 5.45t-4.65 3.55a14.52 14.52 0 01-8.1-.1l-28.8-7.8A6 6 0 0115 35zM62.4 50.36a1.46 1.46 0 011.15.51 1.89 1.89 0 01.45 1.3v3.62a1.89 1.89 0 01-.45 1.3 1.46 1.46 0 01-1.15.51H1.6a1.46 1.46 0 01-1.15-.51 1.89 1.89 0 01-.45-1.3v-3.62a1.89 1.89 0 01.45-1.3 1.46 1.46 0 011.15-.51z"></path></svg>
															</div>
														</div>
													</div>
													<div data-testid="cart-trip-bound-info-location-0" class="css-kjafn5 epokimf0">CJJ ${detail.departAirport } - CJU ${detail.arriveAirport }</div>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
								<!--  -->
								<div class="luggage_a1">
									<h3 class="luggage_name_a1">
										<span>수하물</span>
									</h3>
									<h4 class="luggage_name_a2">
										<span><div class="luggage_svg1">
												<svg viewBox="0 0 20 20" fill="none" pointer-events="all"
													aria-hidden="true" class="etiIcon" role="presentation"
													style="height: 20px; width: 20px;">
													<path
														d="M13.667 10H6.333c-.184 0-.333.174-.333.389v6.222c0 .215.15.389.333.389h7.334c.184 0 .333-.174.333-.389V10.39c0-.215-.15-.389-.333-.389z"
														stroke="#000" stroke-linecap="round"
														stroke-linejoin="round"></path>
													<path d="M6 13h8m-6 0v1" stroke="#262626"
														stroke-linecap="round" stroke-linejoin="round"></path>
													<path
														d="M12 13v1m1-4v-.295C13 9.335 10.576 2 10.2 2h-.4C9.424 2 7 9.336 7 9.705V10"
														stroke="#000" stroke-linecap="round"
														stroke-linejoin="round"></path></svg>
											</div> <span>개인 물품</span> </span>
									</h4>
									<div class="luggage_a2">
										<span>모든 승객의 개인 물품 포함</span>
									</div>
									<h4 class="luggage_name_a2">
										<span><div class="luggage_svg1">
												<svg viewBox="0 0 32 32" fill="none" pointer-events="all"
													aria-hidden="true" class="etiIcon" role="presentation"
													style="height: 20px; width: 20px;">
													<path
														d="M12.8 25.944h-2.667c-.294 0-.533-.322-.533-.72V13.72c0-.397.239-.719.533-.719h11.734c.294 0 .533.322.533.72v11.505c0 .397-.239.719-.533.719H19.2m-6.4 0V27.4m0-1.456h6.4m0 0V27.4m0-14.6V3.912c0-.189-.135-.37-.375-.503-.24-.134-.566-.209-.905-.209h-3.84c-.34 0-.665.075-.905.209-.24.133-.375.314-.375.503V12.8"
														stroke="#000" stroke-width="1.5" stroke-linecap="round"
														stroke-linejoin="round"></path></svg>
											</div> <span>기내 수하물</span> </span>
									</h4>
									<div class="luggage_a2">
										<span>1x10 kg 포함(모든 승객)</span>
									</div>
									<h4 class="luggage_name_a2">
										<span><div class="luggage_svg1">
												<svg viewBox="0 0 32 32" fill="none" pointer-events="all"
													aria-hidden="true" class="etiIcon" role="presentation"
													style="height: 20px; width: 20px;">
													<path
														d="M10.025 25.4H5.733c-.515 0-.933-.398-.933-.889V10.29c0-.491.418-.889.933-.889h20.534c.515 0 .933.398.933.889v14.22c0 .491-.418.889-.933.889h-4.295m-11.947 0h11.947m-11.947 0V27m11.947-1.6V27M21 8.8v-2a2 2 0 00-2-2h-6a2 2 0 00-2 2v2"
														stroke="#000" stroke-width="1.5" stroke-linecap="round"
														stroke-linejoin="round"></path></svg>
											</div> <span>위탁수하물</span> </span>
									</h4>
									<div class="luggage_a2">
										<span>1x15 kg 승객당</span>
									</div>
								</div>
								<!--  -->
								<c:forEach items="${flight}" var="flight" varStatus="status">
									<div class="reservation_price_a1">
										<div class="reservation_price_a2">
											<div class="reservation_price_a3">
												<div class="reservation_price_a4">
													<div class="reservation_price_a5">
														<h4 class="reservation_price_b1">
															<span>${flight.passengerLastname } ${flight.passengerFirstname }, ${flight.passengerType }</span>
														</h4>
													</div>
													<div class="reservation_price_a6">
														<h4 class="reservation_price_b1">
															 <span>‪<fmt:formatNumber value="${flight.passengerType eq '성인' ? flight.adultPrice : flight.childPrice}" pattern="###,###원"/></span>
														</h4>
													</div>
												</div>
												<div class="reservation_price_c1">
													<span>${flight.passengerType} 가격</span><span class="css-1r6a5n6 ew7ojkc3">₩<fmt:formatNumber value="${flight.passengerType eq '성인' ? flight.adultPrice : flight.childPrice}" pattern="###,###원"/></span>
												</div>
												<div class="reservation_seat_c1">
													<c:if test="${flight.passengerType eq '성인'}">
												    	<span>좌석</span><span>${flight.flightSeatNo}</span>
												    </c:if>
												    <c:if test="${flight.passengerType eq '유소년' }">
												    	<span>좌석</span><span>${flight.flightSeatNo}</span>
												    </c:if>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
								
								<!--  -->
								<div class="total_price_a1">
									<div data-testid="total_price_a2">
										<h3 class="total_price_b1">
											<span>총계</span>
										</h3>
										<div class="total_price_a3">
											<span>소계</span><span class="css-1r6a5n6 ew7ojkc3">‪₩<fmt:formatNumber value="${totalPrice}" pattern="###,###원"/></span>
										</div>
										<div class="total_price_a4">
											<h4 class="total_price_b2">
												<span>결제액</span>
											</h4>
											<span class="total_price_b3"><strong>‪₩<fmt:formatNumber value="${totalPrice}" pattern="###,###원"/></strong></span>
										</div>
									</div>
								</div>
							</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<div id="buttonDiv">
	<button id="payBtn" class="nextFbtn" class="btn btn_theme btn_md">결제하기</button>
	<button id="kakaoBtn" class="nextFbtn" class="btn btn_theme btn_md">간편결제</button>
</div>

<div id="memberDiv">
	<input type="hidden" value="${flight[0].memNo }" name="memNo" id="memNo">
	<input type="hidden" value="${flight[0].memEmail }" name="memEmail" id="memEmail">
	<input type="hidden" value="${flight[0].memName }" name="memName" id="memName">
	<input type="hidden" value="${flight[0].memPhone }" name="memPhone" id="memPhone">
	<input type="hidden" value="${flight[0].freservationNo }" name="freservationNo" id="freservationNo">
	<input type="hidden" value="${flight[0].flightNo }" name="flightNo" id="flightNo">
	<input type="hidden" value="${uuidId}" id="uuidId">
	<input type="hidden" value="${totalPrice}" name="freservationTotalPrice  " id="freservationTotalPrice">
</div>

<!-- 스크립트 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/flight/reservationDetail.js"></script>





















