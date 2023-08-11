<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sec:csrfMetaTags/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/host/main.css">

<div id="dashboard">
	<div class="dashboard-content" style="margin-left: 10%; margin-right: 10%;">
		<div class="row">
			<div class="col-md-12">
				<div style="padding: 10px;">
					<div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
					    <h2 style="margin: 0;">${member.memName}님, 반갑습니다.</h2>
					    <a id="modal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim">
					    	<c:choose>
					    		<c:when test="${fn:length(accList) > 4}">
							    	모두 보기(${fn:length(accList)}개)
					    		</c:when>
					    	</c:choose>
					    </a>
					</div>
					<div style="width: 100%; display: flex;">
					
						<c:set var="list_loop" value="true" />
						
						<c:forEach items="${accList}" var="acc" varStatus="stat">
							<c:if test="${list_loop}">
								<c:if test="${acc.accStatus eq '대기'}">
									<div class="accBlock">
										<div style="float: left;">
											<p class="accName">${acc.accName}</p>
											<p class="errorName">해당 숙소 승인대기 중 입니다.</p>
										</div>
										<div style="float: right;">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
												aria-hidden="true" role="presentation" focusable="false"
												style="display: block; fill: none; height: 24px; width: 24px; stroke: rgb(193, 53, 21); stroke-width: 2.66667; overflow: visible;">
												<circle cx="16" cy="16" r="14" fill="none"></circle>
												<path fill="none" d="M16 8v10"></path>
												<circle cx="16" cy="22.5" r=".5"></circle>
											</svg> 
										</div>
									</div>
								</c:if>
								<c:if test="${acc.accStatus eq '미완성'}">
									<div class="accBlock">
										<div style="float: left;">
											<p class="accName">${acc.accName}</p>
											<p class="errorName">숙소를 등록하려면 끝까지 완성해주세요.</p>
											<a class="continue">정보 계속 입력하기</a>
										</div>
										<div style="float: right;">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
												aria-hidden="true" role="presentation" focusable="false"
												style="display: block; fill: none; height: 24px; width: 24px; stroke: rgb(193, 53, 21); stroke-width: 2.66667; overflow: visible;">
												<circle cx="16" cy="16" r="14" fill="none"></circle>
												<path fill="none" d="M16 8v10"></path>
												<circle cx="16" cy="22.5" r=".5"></circle>
											</svg>
										</div>
									</div>
								</c:if>
								<c:if test="${acc.accStatus eq '거절'}">
									<div class="accBlock">
										<div style="float: left;">
											<p class="accName">${acc.accName}</p>
											<p class="errorName">해당 숙소가 승인 거절됬습니다.</p>
											<a class="continue">숙소 수정하기</a>
										</div>
										<div style="float: right;">
											<i class="tip" data-tip-content="${acc.accRejectComment}" style="width: 24px; height: 24px;">
												<div class="tip-content">${acc.accRejectComment}</div>
											</i>
										</div>
									</div>
								</c:if>
								
								<c:if test="${stat.index eq '3'}">
									<c:set var="list_loop" value="false" />
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>


		<div class="row" style="margin-top: 20px;">
			<div class="col-lg-12 col-md-12">
				<div id="reservationBlock">
					<div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
					    <h2 style="margin: 0;">예약</h2>
					    <a href="/host/calendar"><button type="button">모두 보기</button></a>
					</div>
					<div style="display: flex; margin-top: 10px; margin-bottom: 10px;">
						<div class="accFilter">체크아웃 예정</div>
						<div class="accFilter">현재 호스팅 중</div>
						<div class="accFilter">체크인 예정</div>
					</div>
					<div style="display: block;">
						<div id="reservationDetail">
							<div style="margin-bottom: 10px;">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
									aria-hidden="true" role="presentation" focusable="false"
									style="display: block; height: 32px; width: 32px; fill: rgb(34, 34, 34);">
									<path d="M24 1a5 5 0 0 1 5 4.78v5.31h-2V6a3 3 0 0 0-2.82-3H8a3 3 0 0 0-3 2.82V26a3 3 0 0 0 2.82 3h5v2H8a5 5 0 0 1-5-4.78V6a5 5 0 0 1 4.78-5H8zm-2 12a9 9 0 1 1 0 18 9 9 0 0 1 0-18zm0 2a7 7 0 1 0 0 14 7 7 0 0 0 0-14zm3.02 3.17 1.36 1.46-6.01 5.64-3.35-3.14 1.36-1.46 1.99 1.86z"></path>
								</svg>
							</div>
							<div id="reservationContent">
								
							</div>
						</div>
						<div id="tableBlock">
							
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row" style="margin-top: 20px;">
			<div class="col-lg-12 col-md-12">
				<div style="width: 100%; padding: 10px;">
					<h2>자료 및 팁</h2>
					<div style="display: flex;">
						<div class="tipDiv" style="">
							<img src="../resources/images/hostSample/123.png">
							<span>눈에 띄는 숙소를 만드는 방법</span>
						</div>
						<div class="tipDiv">
							<img src="../resources/images/hostSample/234.png">
							<span>요금 책정 전략 세우기</span>
						</div>
						<div class="tipDiv">
							<img src="../resources/images/hostSample/345.png">
							<span>게스트를	위한 숙소 준비</span>
						</div>
						<div class="tipDiv">
							<img src="../resources/images/hostSample/456.png"> 
							<span>효과적인	숙소 설명 작성 방법</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
	<div class="small-dialog-header">
		<h3>조치가 필요한 사항 ${fn:length(accList)}개</h3>
	</div>
	
	<span style="color: #6f6a6a;">필요한 작업</span>
	<div class="sign-in-form style-1">
		<div class="tabs-container alt">
			<div class="tab-content" id="tab1" style="display: none;">
				<c:forEach items="${accList}" var="acc" varStatus="stat">
					<c:if test="${acc.accStatus eq '대기'}">
						<div class="accBlock" style="width: 100%; margin-left: 0; margin-bottom: 10px;">
							<div style="float: left;">
								<p class="accName">${acc.accName}</p>
								<p class="errorName">해당 숙소 승인대기 중 입니다.</p>
							</div>
							<div style="float: right;">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
									aria-hidden="true" role="presentation" focusable="false"
									style="display: block; fill: none; height: 24px; width: 24px; stroke: rgb(193, 53, 21); stroke-width: 2.66667; overflow: visible;">
									<circle cx="16" cy="16" r="14" fill="none"></circle>
									<path fill="none" d="M16 8v10"></path>
									<circle cx="16" cy="22.5" r=".5"></circle>
								</svg>
							</div>
						</div>
					</c:if>
					<c:if test="${acc.accStatus eq '미완성'}">
						<div class="accBlock" style="width: 100%; margin-left: 0; margin-bottom: 10px;">
							<div style="float: left;">
								<p class="accName">${acc.accName}</p>
								<p class="errorName">숙소를 등록하려면 끝까지 완성해주세요.</p>
								<a class="continue">정보 계속 입력하기</a>
							</div>
							<div style="float: right;">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
									aria-hidden="true" role="presentation" focusable="false"
									style="display: block; fill: none; height: 24px; width: 24px; stroke: rgb(193, 53, 21); stroke-width: 2.66667; overflow: visible;">
									<circle cx="16" cy="16" r="14" fill="none"></circle>
									<path fill="none" d="M16 8v10"></path>
									<circle cx="16" cy="22.5" r=".5"></circle>
								</svg>
							</div>
						</div>
					</c:if>
					<c:if test="${acc.accStatus eq '거절'}">
						<div class="accBlock" style="width: 100%; margin-left: 0; margin-bottom: 10px;">
							<div style="float: left;">
								<p class="accName">${acc.accName}</p>
								<p class="errorName">해당 숙소가 승인 거절됬습니다.</p>
								<p class="errorName">이유: ${acc.accRejectComment}</p>
								<a class="continue">숙소 수정하기</a>
							</div>
							<div style="float: right;">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
									aria-hidden="true" role="presentation" focusable="false"
									style="display: block; fill: none; height: 24px; width: 24px; stroke: rgb(193, 53, 21); stroke-width: 2.66667; overflow: visible;">
									<circle cx="16" cy="16" r="14" fill="none"></circle>
									<path fill="none" d="M16 8v10"></path>
									<circle cx="16" cy="22.5" r=".5"></circle>
								</svg>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath}/resources/scripts/host/main.js"></script>