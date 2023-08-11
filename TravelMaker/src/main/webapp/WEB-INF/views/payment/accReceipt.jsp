<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/invoice.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/accReceipt.css">
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
</head> 
<body>

<a href="javascript:window.print()" class="print-button">영수증 출력</a>

<div id="invoice">
	<div class="row">
		<div class="" id="orderPlace">
			<div class="" id="imgPlace">
				<div id="logo"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""></div>
			</div>
			<h2 style="display: inline-block;">Travel Maker</h2>
			<p id="details" style="float: right;">
				<strong>결제번호:</strong> <c:out value="${map.PAYMENTNO}" /> <br>
				<strong>날짜:</strong> <c:out value="${map.PAYMENTDATE}" /> <br>
			</p>
		</div>
    </div>
    
    <div id="leftSide">
    	<div id="imgBlock">
    		<img src="${map.ATTPATH}" alt="" style="width: 100%; height: 60%;">
    	</div>
    	<div id="detailBlock">
    		<h4><strong><c:out value="${map.ACCNAME}" /></strong></h4>
    		<strong><c:out value="${map.ACCNAME}" />에서 <c:out value="${map.DATECOUNT}" />박</strong>
    		<hr>
    		<label>체크 인 : </label><c:out value="${map.CHECKINDATE}" /> <c:out value="${map.CHECKIN}"></c:out><br>
    		<label>체크아웃 : </label><c:out value="${map.CHECKOUTDATE}" /><c:out value="${map.CHECKOUT}"></c:out><br>
			    		
    		예약번호: <c:out value="${map.ARESNO}" />
    		<br><br>
    		
    		<a href="/main/detail/${map.ACCNO}">숙소페이지로 이동</a>
			<br>
    		
    		<hr>
    		<h4>호스트: <c:out value="${map.HOSTNAME}" /></h4>
    		호스트 이메일: <c:out value="${map.HOSTEMAIL}" />
    		<br>
    		호스트 전화번호: <c:out value="${map.HOSTPHONE}" />
    		<br>
    		
    		<hr>
    		<h4>게스트: <c:out value="${map.GUESTNAME}" /></h4>
    		게스트 이메일: <c:out value="${map.GUESTEMAIL}" />
    		<br>
    		게스트 전화번호: <c:out value="${map.GUSERPHONE}" />
    		<br>
    	</div>
    </div>
    
    <div id="rightSide">
    	<div id="priceBlock">
    		<h4><strong>요금 내역</strong></h4>
    		<br>
    		
    		<fmt:formatNumber type="currency" value="${map.PERPRICE}" /> X <c:out value="${map.DATECOUNT}박"></c:out>
    		<span class="priceBlockSpan">
    			<fmt:formatNumber type="currency" value="${map.CHARGE}" />
    		</span>
	   		<br>
    
    		<c:if test="${map.EXTRAPRICE ne 0}">
    			추가 비용
    			<span class="priceBlockSpan">
    				<fmt:formatNumber type="currency" value="${map.EXTRAPRICE}" />
    			</span>
    			<br>
    		</c:if>
    		
    		서비스 수수료
    		<span class="priceBlockSpan">
    			<fmt:formatNumber type="currency" value="${map.FEE}" />
    		</span>
    		<br>
    		
    		<hr>
    		<span class="totalPriceText">총 합계(KRW)</span>
    		<span class="priceBlockSpan">
    			<fmt:formatNumber type="currency" value="${map.TOTALPRICE}" />
    		</span>
    	</div>
    	<br>
    	<div id="paymentBlock">
    		<h4><strong>결제</strong></h4>
    		<br>
    		카카오페이<br>
    		<span id="priceText">
    			<fmt:formatNumber type="currency" value="${map.TOTALPRICE}" />
    		</span> 
    		
    		<c:out value="${map.PAYMENTDATE}" />
    		
    		<hr>
    		<span class="totalPriceText">결제 금액(KRW)</span>
    		<span id="totalPrice"><fmt:formatNumber type="currency" value="${map.TOTALPRICE}" /></span>
    	</div>
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