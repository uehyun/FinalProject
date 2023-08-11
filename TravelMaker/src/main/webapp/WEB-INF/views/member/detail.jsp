<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberDetail.css">

<div id="titlebar" class="gradient">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="user-profile-titlebar">
					<div class="user-profile-avatar">
						<c:choose>
							<c:when test="${empty member.memProfilePath}">
								<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">
							</c:when>
							<c:otherwise>
								<img src="${member.memProfilePath}" alt="">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="user-profile-name">
						<h2>${member.memName}</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container" style="height: 500px;">
	<div class="row sticky-wrapper">
		<div class="col-lg-4 col-md-4 margin-top-0">
			<a href="" id="updateMember">
				<div class="verified-badge" style="cursor: pointer;">
					<i class="sl sl-icon-user-following"></i> 회원정보 수정
				</div>
			</a>
			<div class="boxed-widget margin-top-30 margin-bottom-50">
				<h3>연락방법</h3>
				<ul class="listing-details-sidebar">
					<li><i class="sl sl-icon-phone"></i> ${member.memPhone}</li>
					<li><i class="fa fa-envelope-o"></i> <a href="#">${member.memEmail}</a></li>
				</ul>
			</div>
		</div>


		<div class="col-lg-8 col-md-8 padding-left-30">
			<div class="row">
				<div class="col-lg-4 col-md-3 detailFirstRow" id="couponDiv">
					<h4><i class="im im-icon-Present"></i> 쿠폰</h4>
					쿠폰 등록 및 조회
				</div>
				
				<div class="col-lg-4 col-md-3 detailFirstRow" id="globalDiv">
					<h4><i class="im im-icon-Globe"></i> 글로벌 환경</h4>
					기본 언어, 통화, 시간대 설정하기
				</div>
				
				<div class="col-lg-4 col-md-3 detailFirstRow" id="paymentDiv">
					<h4><i class="im im-icon-Credit-Card2"></i>	예약 및 결제 내역</h4>
					예약 및 결제 내역 확인하기				
				</div>
			</div>
		</div>
		
		<div class="col-lg-8 col-md-8 padding-left-30" style="padding-top: 80px;">
			<div class="row">
				<h3>${member.memName}님에 대한 호스트의 후기</h3>
	
				<c:choose>
					<c:when test="${empty reviewList}">
						<br>
						<div class="col-lg-4 col-md-4" style="height: 80px; padding:0px;">
							<h4>후기가 존재하지 않습니다.</h4>
						</div>
						<br>
					</c:when>
					<c:otherwise>
						<c:forEach items="${reviewList}" var="review">
							<div class="col-lg-4 col-md-4 detailSecondRow" data-accno="${review.accNo}">
								<div style="padding: 5px;">
									<span class="reviewProfile">
										<c:choose>
											<c:when test="${empty review.hostProfilePath}">
												<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">
											</c:when>
											<c:otherwise>
												<img src="..${review.hostProfilePath}" alt="">
											</c:otherwise>
										</c:choose>
									</span>
									<div style="display: block;">
										<h5><c:out value="${review.hostId}" /></h5>
										<fmt:parseDate value="${review.memReviewRegDate}" var="regDate" pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${regDate}" pattern="yyyy-MM"/>
									</div>
									<div class="reviewContentDiv">
										<c:out value="${review.memReviewContent}" />
									</div>
								</div>
							</div>			
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
				<div class="col-md-12 browse-all-user-listings">
					<a href="/member/review" style="cursor: pointer;">모든 후기 보기 <i class="fa fa-angle-right"></i></a>
				</div>
			</div>
		</div>
	</div>
</div>
<br><br>

<div id="myModal" class="modal">
    <div class="modal-content">
    	<div>
	    	<span id="close" style="font-size: 4rem;"><i class="im im-icon-Close"></i></span>
	    	<h1>쿠폰</h1>
    	</div>
    	<hr>
    	<div class="tabs">
		    <input id="all" type="radio" name="tab_item" checked>
		    <label class="tab_item" for="all">쿠폰 등록</label>
		    
		    <input id="programming" type="radio" name="tab_item">
		    <label class="tab_item" for="programming">쿠폰 조회</label>
		    
		    <div class="tab_content" id="all_content">
		        <form>
		        	<input type="hidden" name="memNo" id="memNo" value="${member.memNo}">
		        	<input type="text" name="coupon" id="coupon">
		        	<sec:csrfInput/>
		        	<button type="button">등록</button>
		        </form>
		    </div>
		    
		    <div class="tab_content" id="programming_content">
			</div>
  		</div>
  	</div>
</div>

<div id="myModal2" class="modal">
    <div class="modal-content">
    	<div>
	    	<span id="close2" style="font-size: 4rem;"><i class="im im-icon-Close"></i></span>
	    	<h1>비밀번호 입력</h1>
    	</div>
    	<hr>
    	<div class="tab-content" id="tab1" style="">
			<form method="post" class="login">
				<p class="form-row form-row-wide">
					<label for="memPw">비밀번호
						<i class="im im-icon-Lock-2"></i>
						<input class="input-text" type="password" name="memPw" id="memPw">
					</label>
				</p>
				<sec:csrfInput/>
		        <button type="button" class="button" id="pwBtn">확인</button>
			</form>
		</div>
  	</div>
</div>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/member/detail.js"></script>

<script>
let error = "${error}";

if(error != "") {
	swal(error, "", "error");
}
</script>