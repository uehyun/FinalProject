<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/invoice.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/flightReceipt.css">
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
</head>
<body>
	<a href="javascript:window.print()" class="print-button">영수증 출력</a>
	
	<div id="invoice">
		<div class="row">
			<div class="" id="ordeplace">
				<div class="" id="imgPlace">
					<div id="logo"><img src="../resources/images/logo.png" alt=""></div>
				</div>
				<h2 style="display: inline-block;">Travel Maker</h2>
				<p id="details" style="float: right;">
					<strong>결제번호:</strong> <c:out value="${map.PAYMENTNO}" /> <br>
					<strong>날짜:</strong> <c:out value="${map.PAYMENTDATE}" /> <br>
				</p>
			</div>
	    </div>
    
		<div>
			<strong><i class="fas fa-chevron-right"></i> 예약한 정보</strong>
			<table border="1">
				<tr>
					<th class="myth">예약번호</th>
					<td style="width: 20%;"><c:out value="${map.FRESERVATIONNO}" /></td>
					<th class="myth">결제총액</th>
					<td id="priceTd" style="width: 20%;"><c:out value="${map.TOTALPRICE}" /></td>
					<th class="myth">인원수</th>
					<td style="width: 20%;"><c:out value="${map.PASSENGERCOUNT}" /></td>
				</tr>
			</table>
			<span>유류할증료/제세공과금은 항공사 사정 및 환율변동에 의해 매일 변경되여 발권 당일 환율에 따라 적용됩니다.</span>
		</div>
		
		<hr>
		
		<div>
			<strong><i class="fas fa-chevron-right"></i> 탑승객 정보</strong>
			<table border="1">
				<c:forEach items="${list}" var="passenger">
					<tr>
						<th class="myth">이름</th>
						<td style="width: 20%;"><c:out value="${passenger.NAME}" /></td>
						<th class="myth">전화번호</th>
						<td style="width: 20%;"><c:out value="${passenger.PHONE}" /></td>
						<th class="myth">이메일</th>
						<td style="width: 20%;"><c:out value="${passenger.EMAIL}" /></td>
					</tr>	
				</c:forEach>
			</table>
			<span>여권의 영문명과 다르면 출발이 안되므로, 반드시 여권의 영문명과 예약내용을 확인해 주시기 바랍니다.</span>
		</div>
		
		<hr>
		
		<div>
			<strong><i class="fas fa-chevron-right"></i> 항공 스케줄</strong>
			<table border="1">
				<tr>
					<th class="myth">항공편</th>
					<th class="myth">도시</th>
					<th class="myth">시간</th>
					<th class="myth">비행시간</th>
				</tr>
				<tr>
					<td rowspan='2' id="imgTd">
						<c:set value="" var="path" />
						<c:choose>
							<c:when test="${map.FLIGHTAIRLINE eq '대한항공'}">
								<c:set value="../resources/images/daehan.png" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '진에어'}">
								<c:set value="../resources/images/jinair.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '에어로케이'}">
								<c:set value="../resources/images/aerok.png" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '제주항공'}">
								<c:set value="../resources/images/jeju.png" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '아시아나'}">
								<c:set value="../resources/images/asiana.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '에어부산'}">
								<c:set value="../resources/images/airbusan.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '이스타항공'}">
								<c:set value="../resources/images/eastar.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '하이에어'}">
								<c:set value="../resources/images/hiair.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '티웨이항공'}">
								<c:set value="../resources/images/tway.jpg" var="path" />
							</c:when>
							<c:when test="${map.FLIGHTAIRLINE eq '에어서울'}">
								<c:set value="../resources/images/airseoul.jpg" var="path" />
							</c:when>
						</c:choose>
						<img src="${path}" alt="airplane" id="flightImg">
						<c:out value="${map.FLIGHTMODEL}" />
					</td>
					<td><c:out value="${map.DEPARTAIRPORT}" /> </td>
					<td><c:out value="${map.DEPARTTIME}" /> </td>
					<td rowspan="2">
						<c:out value="${map.DURATIONHOUR}" />시간
						<c:out value="${map.DURATIONMINUTE}" />분
					</td>
				</tr>
				<tr>
					<td><c:out value="${map.ARRIVEAIRPORT}" /></td>
					<td><c:out value="${map.ARRIVETIME}" /></td>
				</tr>
			</table>
		</div>
		<div class="row">
			<div class="col-md-12">
				<ul id="footer">
					<li><span>www.travelmaker.com</span></li>
					<li>office@travelmaker.com</li>
					<li>(123) 123-456</li>
				</ul>
			</div>
		</div>   
	</div>
</body>
</html>