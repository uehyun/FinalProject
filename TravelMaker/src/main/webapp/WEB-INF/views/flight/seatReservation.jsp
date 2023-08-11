<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flights.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

<style>
#seatInfo{
	display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-family: Arial, sans-serif;
    font-size: 16px;
    color: #ffffff; 
    background-color: #333333; 
    padding: 10px; 
}
.seating-chart {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	margin-top: 30px;
	height: 670px; 
	overflow-y: auto;
}
.section {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-bottom: 10px;
}
.seat {
	width: 50px;
	height: 50px;
	line-height: 50px;
	text-align: center;
	margin: 5px;
	background-color: #eaeaea;
}

.flightSeat {
	width: 50px;
	height: 50px;
}
.toiletPng, .exitPng2{
	width: 50px;
	height: 50px;
}
#allArrowPng{
	width: 40px;
	height: 40px;
}
.leftWall{
	background-color: rgb(170, 170, 170);
    margin-left: 0.625rem;
    margin-right: 1.875rem;
    width: 0.3125rem;
}
.rightWall{
	background-color: rgb(170, 170, 170);
    margin-left: 1.725rem;
    margin-right: 1.875rem;
    width: 0.3125rem;
}
.exitDiv{
	height: 60px;
}
.hovered {
    background-color: #E8F5FF;
	border-radius: 10px;
}
.tooltip {
	position: absolute;
	background-color: #222;
	color: white;
	border-radius: 4px;
	padding: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	font-family: Arial, sans-serif;
	font-size: 14px;
	line-height: 1.4;
	z-index: 9999;
	white-space: nowrap;
	margin: 0 10px;
}
.tooltip::after {
	content: "";
	position: absolute;
	bottom: 100%;
	left: 20%;
	margin-left: -6px;
	border-width: 6px;
	border-style: solid;
	border-color: transparent transparent black transparent;
}
.selected {
	background-color: #4169E1;
	border-radius: 10px;
}
#personModal{
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
/*    	background-color: rgba(0, 0, 0, 0.5); */
}
#modal-content {
	position: absolute;
	top: 30%;
	left: 67%;
	transform: translate(-50%, -50%);
	background-color: #fff;
	padding-top: 73px;
/* 	padding: 20px; */
	border-radius: 5px;
	text-align: center;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
#modal-content label{
	display: inline-flex;
  	justify-content: center;
  	margin-right: 20px; 
}
#personModal p {
  margin-top: 40px;
}
#xBtn{
  background-color: white; 
  color: black; 
  font-weight: bold;
  font-size: large;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  position: absolute;
  top: 10px;
  right: 10px;
}
#confirmSeatBtn{
  background-color: #333; /* 어두운 배경색 */
  color: #fff; /* 흰색 글자색 */
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-bottom: 20px;
}

/* 버튼에 호버 효과 추가 */
#confirmSeatBtn:hover {
  background-color: #444; /* 어두운 배경색의 조금 더 어두운 버전 */
}
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
#modal-content {
  animation: fadeIn 0.3s;
}

</style>
<div id="seatInfo"></div>
<div class="seating-chart"> 
	<div class="leftWall"></div>
	<div class="section">
		<input type="hidden" name="adultCount" value="${sessionScope.passenger[0].adultCount}" id="adultCount">
		<input type="hidden" name="childCount" value="${sessionScope.passenger[0].childCount}" id="childCount">
		<c:forEach items="${rowA}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv">
					<img  src="${pageContext.request.contextPath}/resources/images/exit3.png" class="exitPng2">
				</div>
			</c:if>
			<c:if test="${stat.count % 30 == 0}">
				<img src="${pageContext.request.contextPath}/resources/images/toilet.png" class="toiletPng">
			</c:if>
		</c:forEach>
	</div>

	<div class="section">
		<c:forEach items="${rowB}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv"></div>
			</c:if>
		</c:forEach>
	</div>

	<div class="section">
		<c:forEach items="${rowC}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv"></div>
			</c:if>
		</c:forEach>
	</div>

	<div style="margin-left: 20px; margin-right: 20px; padding-top: 77.8em;">
		<img src="${pageContext.request.contextPath}/resources/images/arrow3.png" id="allArrowPng">
	</div>

	<div class="section">
		<c:forEach items="${rowD}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv"></div>
			</c:if>
		</c:forEach>
	</div>

	<div class="section">
		<c:forEach items="${rowE}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv"></div>
			</c:if>
		</c:forEach>
	</div>

	<div class="section">
		<c:forEach items="${rowF}" var="flight" varStatus="stat">
			<c:choose>
				<c:when test="${empty flight.freservationNo}">
					<a class="available" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat_empty.png" class="flightSeat">
					</a>		
				</c:when>
				<c:otherwise>
					<a class="disavailable" data-adult="${flight.adultPrice}" data-child="${flight.childPrice}" data-seatno="${flight.flightSeatNo}">
						<img src="${pageContext.request.contextPath}/resources/images/airplaneSeat.png" class="flightSeat">
					</a>
				</c:otherwise>
			</c:choose>
			<span>${flight.flightSeatNo}</span>
			<c:if test="${stat.count % 10 == 0}">
				<br><br><br>
			</c:if>
			<c:if test="${stat.count % 30 == 0}">
				<img src="${pageContext.request.contextPath}/resources/images/toilet.png" class="toiletPng">
			</c:if>
			<c:if test="${stat.count % 15 == 0 && stat.count % 30 != 0}">
				<div class="exitDiv">
					<img  src="${pageContext.request.contextPath}/resources/images/exit3.png" class="exitPng2">
				</div>
			</c:if>
		</c:forEach>
	</div>
	<div class="rightWall"></div>
</div>

<!-- 사람 유형 모달 -->
<div id="personModal">
	<div id="modal-content">
		<button id="xBtn">x</button>
		<h2>좌석 예약</h2>
		<p>이 좌석을 예약하시려면 선택해주세요:</p>
		<label>
		  <input type="radio" name="adultPrice" value="">
		  성인
		</label>
		<label>
		  <input type="radio" name="childPrice" value="">
		  유소년
		</label><br><br><br>
		<button id="confirmSeatBtn">확인</button>
	</div>
</div>
   <!-- 사람 유형 모달 끝 -->

<form action="/flight/reservationDetail" method="post" id="seatForm">
	<input type="hidden" value="${flightNo}" name="flightNo"/>
		<c:forEach items="${sessionScope.passenger }" var="passenger" varStatus="i">
			<div class="detailDiv">
				<input type="hidden" name="adultPrice" value="" class="adultPrice">
				<input type="hidden" name="childPrice" value="" class="childPrice">
				<input type="hidden" name="flightSeatNo" value="" class="flightSeatNo">
			</div>
		</c:forEach>
	<sec:csrfInput/>
</form>

<hr />

<button id="nextFBtn" class="nextFbtn" class="btn btn_theme btn_md">계속</button>

<!-- 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/scripts/flight/seatReservation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>



















