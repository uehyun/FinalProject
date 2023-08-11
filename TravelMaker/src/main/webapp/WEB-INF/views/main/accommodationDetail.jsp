<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:csrfMetaTags/>
<style>
	/* 프로필 이미지 설정 */
	.profileImage {
		border-radius: 90%; /* 둥근 형태로 만들기 */
		object-fit: cover; /* 이미지 비율 유지하며 적절히 크롭 */
		margin: 0 2% 0 0;
		width: 100px; 
		height: 100px; 
		border: 3px white solid;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	}
	
	/* 기본 css 스타일 변경 */
	.boxed-widget h3 {
		border-bottom: none;
		padding: 0 0 0;
	}
	
	/* sideBar 따라다니게 설정 */
	#sideBar {
		position: sticky;
		top: 20%;
		width: 33%;
	}
	
	/* 체크인, 체크아웃 박스 수정 */
	#checkIn, #checkOut	{
		border: none;
	    cursor: pointer;
	    border-radius: 5px;
	    box-shadow: 0 1px 6px 0px rgba(0, 0, 0, 0.1);
	    font-weight: 600;
	    font-size: 16px;
	    height: auto;
	    padding: 10px 16px;
	    line-height: 30px;
	    margin: 0 0 15px 0;
	    position: relative;
	    background-color: #fff;
	    text-align: left;
	    color: #888;
	    display: block;
	    width: 100%;
	    transition: color 0.3s;
	}
	
	/* 모달 css */
	.modal {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.5);
		z-index: 9999;
	}
	.modal-content {
		position: absolute;
		top: 50%;
		left: 50%;
		width : 600px;
		height : 600px;
		transform: translate(-50%, -50%);
		background-color: white;
		padding: 2% 1.5%;
		border-radius: 3%;
		overflow: auto;
		transition: opacity 0.3s ease-in-out;
	}
	
	#reportModalContent {
		position: absolute;
		top: 50%;
		left: 50%;
		width : 25%;
		height : 50%;
		transform: translate(-50%, -50%);
		background-color: white;
		padding: 2% 1.5%;
		border-radius: 3%;
		overflow: auto;
		transition: opacity 0.3s ease-in-out;
	}
	
	.imagesModal-content {
		position: absolute;
		top: 50%;
		left: 50%;
		width : 40%;
		height : 80%;
		transform: translate(-50%, -50%);
		background-color: white;
		padding: 2% 1.5%;
		border-radius: 3%;
		overflow: auto;
	}
	.createWishModal-content {
		position: absolute;
		top: 50%;
		left: 50%;
		width : 30%;
		height : 35%;
		transform: translate(-50%, -50%);
		background-color: white;
		padding: 1%;
		border-radius: 3%;
		overflow: auto;
	
	}
	
	.close-modal-btn {
		position: absolute;
		top: 10px;
		right: 10px;
		cursor: pointer;
	}
	#accContent {
		word-break: break-all;
	}
	
	/* 스크롤바 커스텀 -> 커스텀 안 하면 스크롤바 너무 지저분함 */
	div::-webkit-scrollbar {
		width: 5px;  /* 스크롤바의 너비 */
		display: none;
	}

	
	/* 옵션 컨테이너 설정 -> 한 라인에 2개씩 */
	.accOptionContainer {
		width: 100%;
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
	}
	
	
	#listing-overview, #optionContainer, #topHostInformation {
		border-bottom: 1px solid #e8e8e8;
		padding-bottom: 3%;
	}
	
	
	/* 이미지 더보기 버튼 */
	#showMoreImagesBtn {
		position: absolute; 
		bottom: 10px; 
		right: 35px;
	    cursor: pointer;
	    font-weight: bold;
	    border: 1px solid #e8e8e8;
	    background: white;
	    border-radius: 8%;
	}
	
    /* 저장 버튼 */
	#showWishBtn, #createWishListBtn, #deleteWishBtn { cursor: pointer; }
	#addWishListBtn {
		background: black; 
		color: white; 
		border-radius: 10px; 
		width: 100%; 
		height: 100%;
	}
	
	/* 비활성화 상태일 때의 스타일 */
	#addWishListBtn[disabled] {
		background-color: #8e8e8e;
		color: white;
	}
	
	/* 활성화 상태일 때의 스타일 */
	#addWishListBtn:not([disabled]) {
		background-color: black;
		color: white;
	}
	
	#reportModalBtn, #reportBtn { cursor: pointer; }
	
	.read-more:hover {
		color : red;
	}
	.review-profileimg {
		width: 80px;
		height : 80px;
		border: 3px white solid;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	}
	
/* 	.overflow-ellipsis { */
/* 		white-space: nowrap; /* 텍스트가 줄 바꿈하지 않도록 설정 */ */
/* 		overflow: hidden; /* 요소 너비를 넘어가는 텍스트를 숨김 */ */
/* 		text-overflow: ellipsis; /* ...으로 표시할 위치를 설정 */ */
/* 		max-height: 500px; /* 텍스트가 최대한 얼마까지 표시될지 지정 */ */
/* 	} */
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/googlemap.css">
<div class="container">
	<div class="row sticky-wrapper">
		<div style="width: 100%;">
			<h2>${acommodation.accName }</h2>
			<div style="display: flex; justify-content: space-between;">
				<div style="display: flex; justify-content: space-between;">
					<div>후기 ${fn:length(reviewList) } ·&nbsp;</div>
					<div>지역 ${acommodation.accLocation }</div>
				</div>
				<div style="margin: 0 2% 0 0; cursor: pointer;">
					<div id="deleteWishBtn"><i class="fa-solid fa-heart" style="color: #e30d0d;"></i> 찜 목록 보기</div>
					<div id="showWishListBtn"><i class="fa-regular fa-heart"></i> 저장</div>
				</div>
			</div>
		</div>
		<div id="wishListModal" class="modal" style="display: none;">
			<div id="wishModalContent" class="modal-content">
				<h3 style="margin: 0 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">위시리스트</h3>
				<button id="closeWishListModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
				
				<div style="width: 50%; height: 10%; margin: 5% 0; display: flex;" id="createWishListBtn">
					<div style="width: 20%; height: 100%; margin-right: 4%;">
						<img alt="#" src="/resources/images/wishplus.png" style="width: 100%; height: 100%;">
					</div>
					<div style="width: 80%; height: 100%; display: flex; align-items: center;"><h4>새로운 위시리스트 만들기</h4></div>
				</div>
				<c:if test="${not empty wishCategoryList}">
					<c:forEach var="wishCategory" items="${wishCategoryList}">
						<div style="width: 50%; height: 10%; margin: 5% 0; display: flex;" onclick="selectCategoryList('${wishCategory.wishlistCategoryNo}')">
							<div style="width: 30%; height: 100%; margin-right: 4%;">
								<c:choose>
									<c:when test="${not empty wishCategory.attPath }">
										<img alt="#" src="${wishCategory.attPath }">
									</c:when>
									<c:otherwise><div style="background-color: #8e8e8e; height: 100%; width: 100%; border-radius: 5px;"></div></c:otherwise>
								</c:choose>
							</div>
							<div style="width: 70%; height: 100%; display: flex; align-items: center;"><h4>${wishCategory.wishlistCategoryName }</h4></div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<!-- 위시리스트 작성 모달 -->
		<div id="createWishListmodal" class="modal" style="">
			<div id="modalContent" class="createWishModal-content">
				<h3 style="margin: 0 0 5% 0; padding-bottom: 2%; border-bottom: 1px solid #e8e8e8; text-align: center;">위시리스트 이름 정하기</h3>
				<button id="closeCreateWishModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
				
				<div style="margin: 8% 0; padding-bottom: 5%; border-bottom: 1px solid #8e8e8e;">
					<div>
						<input type="text" maxlength="50" placeholder="이름" style="margin: 0 0 0 0;" id="wishListContent">
					</div>
					<div>최대 50자</div>
				</div>
				
				<div style="height: 20%;">
					<button type="button" disabled id="addWishListBtn">새로 만들기</button>
				</div>
			</div>
		</div>
		
		
	
		<!-- 이미지 출력 공간 -->
		<div style="width: 100%; position: relative;">
		    <div style="display: flex; margin: 1% 0 0 0; height: 45rem;">
		        <div style="flex: 0 0 49%; height: 100%;">
		        	<div style="margin: 0 1% 0 0; height: 100%;">
			            <img alt="#" src="${acommodation.files[0].attPath}" style="width: 100%; height: 100%;">
		        	</div>
		        </div>
		        <div style="flex: 0 0 49%; display: flex; flex-wrap: wrap;">
		            <c:forEach var="file" items="${acommodation.files }" varStatus="loop" begin="1" end="4">
		                <img alt="#" src="${file.attPath}" style="width: 49%; height: 49%; margin: 0 1% 0 0;">
		            </c:forEach>
		        </div>
		    </div>
	        <button id="showMoreImagesBtn">사진 더보기</button>
		</div>
		<div id="imagesModal" class="modal" style="">
			<div id="imagesModalContent" class="imagesModal-content">
		    	<div style="width: 100%; display: flex; flex-wrap: wrap;">
					<div style="width: 98%; height: 60rem; margin: 0 1% 1% 0;">
						<div style="height: 100%;">
							<img alt="#" src="${pageContext.request.contextPath}${acommodation.files[0].attPath}" style="width: 100%; height: 100%;">
		    			</div>
					</div>
					<c:forEach var="file" items="${acommodation.files }">
						<div style="width: 49%; height: 45rem; margin: 0 0.5% 0.5% 0">
							<img alt="#" src="${pageContext.request.contextPath}${file.attPath}" style="width: 100%; height: 100%;">
						</div>
					</c:forEach>
				</div>
				<button id="closeImagesModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
		    </div>
		</div>

		
		<div class="col-lg-8 col-md-8 padding-right-30">
			<!-- Listing Nav -->
			<div id="listing-nav" class="listing-nav-container" style="margin: 72px 0 0 0;">
				<div>
					<ul class="listing-nav">
						<li><a href="#listing-overview" class="active">숙소 내용</a></li>
						<li><a href="#listing-location">위치</a></li>
						<li><a href="#listing-reviews">후기</a></li>
					</ul>
				</div>
			</div>
			
			<!-- 호스트 정보 -->
			<div id="topHostInformation" style="display: flex; justify-content: space-between; width: 100%;">
				<div style="width: 85%;">
					<div><h3 style="margin: 1% 0;">${member.memName } 님이 호스팅하는 공간</h3></div>
					<div>
						<c:forEach var="accOption" items="${acommodation.accOption }" varStatus="status">
							<c:if test="${accOption.optionCount > 0 }">
								<span>${accOption.optionName eq '게스트' ? '최대인원' : ''} ${accOption.optionName }</span>&nbsp;
								<c:if test="${accOption.optionName eq '게스트' }">
									<c:set var="guestMaxCount" value="${accOption.optionCount }"></c:set>
								</c:if>
								<span>${accOption.optionCount }</span>
								<span>${accOption.optionName eq '게스트' ? '명' : '개'}</span>
								<c:if test="${status.count <= 3 }">,&nbsp;</c:if> 
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div style="width: 15%; height: auto;"><img alt="#" src="${member.memProfilePath }" class="profileImage"></div>
			</div>
			
			<!-- 숙소 정보 -->
			<div id="listing-overview" class="listing-section">

				<!-- Description -->
				<div id="accContent">
<!-- 					<h2>숙소 설명</h2> -->
					<p>${acommodation.accContent }<p>
				</div>
				<button id="showMoreBtn" style="display: none; border: none; background: none; text-decoration: underline; font-weight: bold;"><span>더보기</span></button>
			</div>
			<div id="modal" class="modal" style="">
  				<div id="modalContent" class="modal-content">
  					<h3 style="margin: 3% 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8;">숙소 설명</h3>
    				<span style="word-break: break-all;">${acommodation.accContent }</span>
	  				<button id="closeModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
  				</div>
			</div>

				
				
			<!-- 숙소 편의 시설 -->
			<div id="optionContainer">
				<div style="margin: 5% 0 3% 0;"><h2>숙소 편의 시설</h2></div>
				<div class="accOptionContainer">
					<c:forEach var="accOption" items="${acommodation.accOption }" begin="0" end="9" step="1">
						<c:if test="${not empty accOption.attGroupNo}">
							<div style="width: 49%; margin: 1% 0;">
								<div style="margin: 0 1% 0 0;">
									<i class="${accOption.attGroupNo }" style="color: black; font-size: 2.5rem;"></i>
								</div>
								<div><h4>${accOption.optionName }</h4></div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<c:if test="${fn:length(acommodation.accOption) > 9}">
					<button id="showOptionMoreBtn" style="display: block; border: none; background: none; text-decoration: underline; font-weight: bold;"><span>더보기</span></button>
				</c:if>
			</div>
			<div id="optionModal" class="modal" style="">
  				<div id="optionModalContent" class="modal-content">
					<h3 style="margin: 3% 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">숙소 편의시설</h3>
  					<div class="accOptionContainer">
    					<c:forEach var="accOption" items="${acommodation.accOption }">
    						<c:if test="${not empty accOption.attGroupNo}">
								<div style="width: 49%; margin: 1% 0; text-align: left; text-align: center;">
									<div style="margin: 0 1% 0 0;">
										<i class="${accOption.attGroupNo }" style="color: black; font-size: 2.5rem;"></i>
									</div>
									<div><h4>${accOption.optionName }</h4></div>
								</div>
							</c:if>
    					</c:forEach>
    				</div>
	  				<button id="closeOptionModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
  				</div>
			</div>
			
			<!-- Reviews -->
			<div id="listing-reviews" class="listing-section">
				<h3 class="listing-desc-headline margin-top-75 margin-bottom-20">리뷰 <span>(${fn:length(reviewList) })</span></h3>

				<!-- Rating Overview -->
				<div class="rating-overview">
					<div class="rating-overview-box">
						<c:choose>
							<c:when test="${not empty reviewScore }">
								<c:set var="totalScore" value="0"/>
								<c:forEach var="score" items="${reviewScore }">
									<c:set var="totalScore" value="${totalScore + score.accReviewScore}" />
								</c:forEach>
								<c:set var="averageScore" value="${totalScore / reviewScore.size()}" />
								
								<span class="rating-overview-box-total">${fn:substring(averageScore, 0, 3) }</span>
							</c:when>
							<c:otherwise>
								<span class="rating-overview-box-total">0</span>
							</c:otherwise>
						</c:choose>
						<span class="rating-overview-box-percent">out of 5.0</span>
						<div class="star-rating" data-rating="5"></div>
					</div>

					<div class="rating-bars">
						<c:choose>
							<c:when test="${not empty reviewScore }">
								<c:forEach var="score" items="${reviewScore }">
									<c:if test="${score.reviewScoreCategory eq 'clean' }">
										<div class="rating-bars-item">
											<span class="rating-bars-name">청결도 <i class="tip" data-tip-content="Quality of customer service and attitude to work with you"></i></span>
											<span class="rating-bars-inner">
												<span class="rating-bars-rating" data-rating='${score.accReviewScore }'>
													<span class="rating-bars-rating-inner"></span>
												</span>
												<strong>${score.accReviewScore }</strong>
											</span>
										</div>
									</c:if>
									<c:if test="${score.reviewScoreCategory eq 'location' }">
										<div class="rating-bars-item">
											<span class="rating-bars-name">위치 <i class="tip" data-tip-content="Overall experience received for the amount spent"></i></span>
											<span class="rating-bars-inner">
												<span class="rating-bars-rating" data-rating="${score.accReviewScore }">
													<span class="rating-bars-rating-inner"></span>
												</span>
												<strong>${score.accReviewScore }</strong>
											</span>
										</div>
									</c:if>
									<c:if test="${score.reviewScoreCategory eq 'checkin' }">
										<div class="rating-bars-item">
											<span class="rating-bars-name">체크인 <i class="tip" data-tip-content="Visibility, commute or nearby parking spots"></i></span>
											<span class="rating-bars-inner">
												<span class="rating-bars-rating" data-rating="${score.accReviewScore }">
													<span class="rating-bars-rating-inner"></span>
												</span>
												<strong>${score.accReviewScore }</strong>
											</span>
										</div>
									</c:if>
									<c:if test="${score.reviewScoreCategory eq 'valueformoney' }">
										<div class="rating-bars-item">
											<span class="rating-bars-name">가격대비 만족도 <i class="tip" data-tip-content="The physical condition of the business"></i></span>
											<span class="rating-bars-inner">
												<span class="rating-bars-rating" data-rating="${score.accReviewScore }">
													<span class="rating-bars-rating-inner"></span>
												</span>
												<strong>${score.accReviewScore }</strong>
											</span>
										</div>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="rating-bars-item">
									<span class="rating-bars-name">청결도 <i class="tip" data-tip-content="Quality of customer service and attitude to work with you"></i></span>
									<span class="rating-bars-inner">
										<span class="rating-bars-rating" data-rating='0'>
											<span class="rating-bars-rating-inner"></span>
										</span>
										<strong>0</strong>
									</span>
								</div>
								<div class="rating-bars-item">
									<span class="rating-bars-name">위치 <i class="tip" data-tip-content="Overall experience received for the amount spent"></i></span>
									<span class="rating-bars-inner">
										<span class="rating-bars-rating" data-rating="0">
											<span class="rating-bars-rating-inner"></span>
										</span>
										<strong>0</strong>
									</span>
								</div>
								<div class="rating-bars-item">
									<span class="rating-bars-name">가격대비 만족도 <i class="tip" data-tip-content="The physical condition of the business"></i></span>
									<span class="rating-bars-inner">
										<span class="rating-bars-rating" data-rating="0">
											<span class="rating-bars-rating-inner"></span>
										</span>
										<strong>0</strong>
									</span>
								</div>
								<div class="rating-bars-item">
									<span class="rating-bars-name">가격대비 만족도 <i class="tip" data-tip-content="The physical condition of the business"></i></span>
									<span class="rating-bars-inner">
										<span class="rating-bars-rating" data-rating="0">
											<span class="rating-bars-rating-inner"></span>
										</span>
										<strong>0</strong>
									</span>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- Rating Overview / End -->


				<div class="clearfix"></div>

				<div>
					<c:choose>
						<c:when test="${not empty reviewList }">
							<!-- Reviews -->
							<section class="comments listing-reviews">
								<ul> 
									<c:forEach var="review" items="${reviewList }" begin="0" end="2">
										<li>
											<div class="avatar"><img class="review-profileimg" src="${review.hostProfilePath }" alt="" /></div>
											<div class="comment-content"><div class="arrow-comment"></div>
												<div class="comment-by" style="margin: 0px; padding: 0px;">${review.hostNo }<i class="tip" data-tip-content="Person who left this review actually was a customer"></i>
													<div class="star-rating" data-rating="5"></div>
												</div>
												<span>${review.memReviewRegDate }</span>
												<p class="overflow-ellipsis">${review.memReviewContent }</p>
											</div>
										</li>
									</c:forEach>
									<c:if test="${fn:length(reviewList) > 3}">
										<button id="showReviewMoreBtn" style="display: block; border: none; background: none; text-decoration: underline; font-weight: bold;"><span>후기 더보기</span></button>
									</c:if>
								 </ul>
							</section>
						</c:when>
						<c:otherwise>
							<h3>작성된 후기가 1개 이상이면 후기가 표시됩니다.</h3>
						</c:otherwise>
					</c:choose>
				</div>
				
				<c:if test="${fn:length(reviewList) > 3}">
					<div id="reviewModal" class="modal" style="">
		  				<div id="reviewModalContent" class="modal-content">
		  					<h3 style="margin: 0 0 3% 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">후기</h3>
		  					<ul style="list-style: none; list-style-type: none;">
			    				<c:forEach var="review" items="${reviewList }">
									<li style="margin: 3% 0 3% -5%;">
										<div class="avatar" style="max-width: 80px; height: 80px; margin: 0 0 0 5%;">
											<img class="review-profileimg" src="${review.hostProfilePath }" alt=""/>
										</div>
										<div class="comment-content"><div class="arrow-comment"></div>
											<div class="comment-by" style="margin: 0px; padding: 0px;">${review.hostNo }<i class="tip" data-tip-content="Person who left this review actually was a customer"></i>
												<div class="star-rating" data-rating="5"></div>
											</div>
											<span>${review.memReviewRegDate }</span>
											<p class="overflow-ellipsis">${review.memReviewContent }</p>
										</div>
									</li>
								</c:forEach>
							</ul>
			  				<button id="closeReviewModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
		  				</div>
					</div>
				</c:if>
			</div>
		</div>


		<!-- Sidebar ================================================== -->
		
		<div class="col-lg-4 col-md-4 margin-top-75 sticky" id="sideBar">
			<!-- Book Now -->
			<div id="booking-widget-anchor" class="boxed-widget booking-widget margin-top-35" style="border-radius: 10%;">
				<div style="display: flex; justify-content: space-between; border-bottom: 1px solid #e8e8e8; margin: 0 0 2% 0;">
					<h3><fmt:formatNumber value="${acommodation.accPrice }" type="currency"/>/박</h3>
					<h3>${fn:length(reviewList) }개</h3>
				</div>
				
				<div style="">
					<div style="display: flex; justify-content: space-between;">
						<input type="text" placeholder="날짜 추가" readonly id="checkIn" style="margin: 0 0 0 0;">
						<input type="text" placeholder="날짜 추가" readonly id="checkOut" style="margin: 0 0 0 0;">
					</div>
					<div class="panel-dropdown" style="width: 100%; margin: 0.5% 0 0 0; font-weight: 0;">
						<a href="#" style="display: flex;">
							<span style="margin: 0 3% 0 0;" id="guestCount">게스트 <span> 1</span></span>
							<span style="display: none;" id="childCount">, 유아<span> 0</span></span>
						</a>
						<div class="panel-dropdown-content">

							<!-- Quantity Buttons -->
							<div class="qtyButtons">
								<div class="qtyTitle">성인</div>
								<div><i class="fa-solid fa-minus"></i></div>
								<input type="text" name="qtyInput" value="1">
								<div><i class="fa-solid fa-plus"></i></div>
							</div>
							<div class="qtyButtons">
								<div class="qtyTitle">어린이</div>
								<div><i class="fa-solid fa-minus"></i></div>
								<input type="text" name="qtyInput" value="0">
								<div><i class="fa-solid fa-plus"></i></div>
							</div>
							<div class="qtyButtons">
								<div class="qtyTitle">유아</div>
								<div><i class="fa-solid fa-minus"></i></div>
								<input type="text" name="qtyInput" value="0">
								<div><i class="fa-solid fa-plus"></i></div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- Book Now -->
				<div id="reservationBox">
					<div style="display: block;">
						<a href="" class="button book-now fullwidth margin-top-5" id="checkAvailabilityBtn">예약 가능 여부 보기</a>
						<div>예약 확정 전에는 요금이 청구되지 않습니다.</div>
					</div>
					<div style="display: none;">
						<form action="/main/accommodation/reservation" method="post" id="reservationForm">
							<input type="hidden" id="accNo" name="accNo" value="${acommodation.accNo}">
							<input type="hidden" name="aresCheckinDate" id="aresCheckinDate" value="">
							<input type="hidden" name="aresCheckoutDate" id="aresCheckoutDate" value="">
							<input type="hidden" name="aresGuestCount" id="aresGuestCount" value="1">
							<input type="hidden" name="aresExtraGuest" id="aresExtraGuest" value="0">
							<input type="hidden" name="aresExtraGuest" id="aresExtraGuest" value="0">
							<input type="hidden" name="aresTotalPrice" id="aresTotalPrice" value="">
							<input type="hidden" name="aresExtraPrice" id="aresExtraPrice" value="0">
							<input type="hidden" name="aresDiscountPrice" id="discountPrice" value="0">
							<sec:csrfInput/>
						</form>
						<a href="" class="button book-now fullwidth margin-top-5" id="reservationBtn">예약 하기</a>
						<div>예약 확정 전에는 요금이 청구되지 않습니다.</div>
						<div style="display: flex; justify-content: space-between;">
							<div><%-- <fmt:formatNumber value="${acommodation.accPrice }" type="currency"/> --%><span id="perPrice"></span> x <span id="nights">1</span>박 </div>
							<div id="basePrice"></div>
						</div>
						<div style="display: flex; justify-content: space-between; display: none;">
							<div>할인 금액</div>
							<div id="discountedAmount" style="text-align: right; display: none;">0</div>
						</div>
						<div id="extraGuest" style="display: none;">
						    <div style="display: flex; justify-content: space-between;">
						        <div>추가인원 요금</div>
						        <div id="extraGuestFee">0</div>
						    </div>
 						</div>
						<div style="display: flex; justify-content: space-between;">
							<div>트레블메이커 서비스 수수료</div>
							<div id="serviceFee"></div>
						</div>
						<div style="display: flex; justify-content: space-between; margin: 2% 0 0 0; border-top: 1px solid rgb(171, 170, 170);">
							<h3 style="margin: 5% 0 0 0;">총 합계</h3>
							<h3 id="totalPrice" style="margin: 5% 0 0 0;"></h3>
						</div>
					</div>
				</div>
			</div>
			<div style="display: flex; justify-content: center; align-items: center;" id="reportModalBtn">
				<i class="fa-solid fa-flag" style="margin: 0 1% 0 0;"></i>
				<div>신고하기</div>
			</div>
			<!-- Book Now / End -->

		</div>
		<!-- Sidebar / End -->
		<div id="reportModal" class="modal" style="display: none;">
			<div id="reportModalContent">
				<h3 style="margin: 0 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">신고 사유</h3>
				<button id="closeReportModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
				
				
				<div style="display: flex; justify-content: center; margin: 7% 0; border-top: 1px solid #8e8e8e; border-bottom: 1px solid #8e8e8e;">
					<ul style="list-style: none; margin: 10% 0 10% -5%;">
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason1" value="욕설이 포함되어 있습니다." style="position: absolute;" />
							<label for="blameReason1" style="position: relative; margin-left: 27px; transform: translateY(-6px);">욕설이 포함되어 있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason2" value="타 사이트 홍보글이 게재되어 있습니다." style="position: absolute;" />
							<label for="blameReason2" style="position: relative; margin-left: 27px; transform: translateY(-6px);">타 사이트 홍보글이 게재되어 있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason3" value="잘못된 정보가 기입되어있습니다." style="position: absolute;" />
							<label for="blameReason3" style="position: relative; margin-left: 27px; transform: translateY(-6px);">잘못된 정보가 기입되어있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason4" value="기타" style="position: absolute;" />
							<label for="blameReason4" style="position: relative; margin-left: 27px; transform: translateY(-6px);">기타</label>
							<textarea rows="" cols="" id="blameReasonTxt" style="display:none;"></textarea>
						</li>
					</ul>	
				</div>
			
				
				<div style="justify-content: right; margin: 5% 0; display: flex;" id="reportBtn"><span style="border-bottom: 1px solid #8e8e8e;">신고하기</span></div>
			</div>
		</div>
	</div>
	<div>
		<div>
			<!-- Location -->
			<div id="listing-location" class="listing-section">
				<h2 class="listing-desc-headline margin-top-60 margin-bottom-30" style="font-size: 30px; font-weight: bold;">호스팅 지역</h2>
				<div id="map" style="height: 50rem; width: 100%;"></div>
			</div>
		</div>
		
		<br>
		
		<div style="width: 100%;">
			<div style="display: flex; margin: 3rem 0;">
				<img alt="#" src="${member.memProfilePath }" style="" class="profileImage">
				<div style="">
					<div><h2 style="font-weight: bold;">호스트 : ${member.memName } 님</h2></div>
					<div><h5>회원 가입일 : ${member.memRegDate }</h5></div>
					<a class="read-more"><button id="chatBtn" style="border: none; background: none; font-weight: 700;">채팅하기 <i class='fa fa-angle-right'></i></button></a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="daterangepicker ltr show-ranges show-calendar opensleft calendar-animated bordered-style calendar-hidden" style="display: none; top: 253px; right: 69.9999px; left: auto;">
	<div class="drp-calendar left">
		<div class="calendar-table">
			<table class="table-condensed">
				<thead>
					<tr>
						<th class="prev available"><span></span></th>
						<th colspan="5" class="month">07 2023</th>
						<th></th>
					</tr>
					<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="weekend off available" data-title="r0c0">28</td>
						<td class="off available" data-title="r0c1">29</td>
						<td class="off available" data-title="r0c2">30</td>
						<td class="off available" data-title="r0c3">31</td>
						<td class="available" data-title="r0c4">1</td>
						<td class="active start-date available" data-title="r0c5">2</td>
						<td class="weekend in-range available" data-title="r0c6">3</td>
					</tr>
					<tr>
						<td class="weekend in-range available" data-title="r1c0">4</td>
						<td class="in-range available" data-title="r1c1">5</td>
						<td class="in-range available" data-title="r1c2">6</td>
						<td class="in-range available" data-title="r1c3">7</td>
						<td class="in-range available" data-title="r1c4">8</td>
						<td class="in-range available" data-title="r1c5">9</td>
						<td class="weekend in-range available" data-title="r1c6">10</td>
					</tr>
					<tr>
						<td class="weekend in-range available" data-title="r2c0">11</td>
						<td class="in-range available" data-title="r2c1">12</td>
						<td class="in-range available" data-title="r2c2">13</td>
						<td class="in-range available" data-title="r2c3">14</td>
						<td class="in-range available" data-title="r2c4">15</td>
						<td class="in-range available" data-title="r2c5">16</td>
						<td class="weekend in-range available" data-title="r2c6">17</td>
					</tr>
					<tr>
						<td class="weekend in-range available" data-title="r3c0">18</td>
						<td class="in-range available" data-title="r3c1">19</td>
						<td class="in-range available" data-title="r3c2">20</td>
						<td class="in-range available" data-title="r3c3">21</td>
						<td class="in-range available" data-title="r3c4">22</td>
						<td class="in-range available" data-title="r3c5">23</td>
						<td class="weekend in-range available" data-title="r3c6">24</td>
					</tr>
					<tr>
						<td class="weekend in-range available" data-title="r4c0">25</td>
						<td class="in-range available" data-title="r4c1">26</td>
						<td class="in-range available" data-title="r4c2">27</td>
						<td class="in-range available" data-title="r4c3">28</td>
						<td class="in-range available" data-title="r4c4">29</td>
						<td class="in-range available" data-title="r4c5">30</td>
						<td class="today weekend off active end-date in-range available"
							data-title="r4c6">1</td>
					</tr>
					<tr>
						<td class="weekend off available" data-title="r5c0">2</td>
						<td class="off available" data-title="r5c1">3</td>
						<td class="off available" data-title="r5c2">4</td>
						<td class="off available" data-title="r5c3">5</td>
						<td class="off available" data-title="r5c4">6</td>
						<td class="off available" data-title="r5c5">7</td>
						<td class="weekend off available" data-title="r5c6">8</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="calendar-time" style="display: none;"></div>
	</div>
	<div class="drp-calendar right">
		<div class="calendar-table">
			<table class="table-condensed">
				<thead>
					<tr>
						<th></th>
						<th colspan="5" class="month">08 2023</th>
						<th class="next available"><span></span></th>
					</tr>
					<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="weekend off in-range available" data-title="r0c0">25</td>
						<td class="off in-range available" data-title="r0c1">26</td>
						<td class="off in-range available" data-title="r0c2">27</td>
						<td class="off in-range available" data-title="r0c3">28</td>
						<td class="off in-range available" data-title="r0c4">29</td>
						<td class="off in-range available" data-title="r0c5">30</td>
						<td class="today weekend active end-date in-range available"
							data-title="r0c6">1</td>
					</tr>
					<tr>
						<td class="weekend available" data-title="r1c0">2</td>
						<td class="available" data-title="r1c1">3</td>
						<td class="available" data-title="r1c2">4</td>
						<td class="available" data-title="r1c3">5</td>
						<td class="available" data-title="r1c4">6</td>
						<td class="available" data-title="r1c5">7</td>
						<td class="weekend available" data-title="r1c6">8</td>
					</tr>
					<tr>
						<td class="weekend available" data-title="r2c0">9</td>
						<td class="available" data-title="r2c1">10</td>
						<td class="available" data-title="r2c2">11</td>
						<td class="available" data-title="r2c3">12</td>
						<td class="available" data-title="r2c4">13</td>
						<td class="available" data-title="r2c5">14</td>
						<td class="weekend available" data-title="r2c6">15</td>
					</tr>
					<tr>
						<td class="weekend available" data-title="r3c0">16</td>
						<td class="available" data-title="r3c1">17</td>
						<td class="available" data-title="r3c2">18</td>
						<td class="available" data-title="r3c3">19</td>
						<td class="available" data-title="r3c4">20</td>
						<td class="available" data-title="r3c5">21</td>
						<td class="weekend available" data-title="r3c6">22</td>
					</tr>
					<tr>
						<td class="weekend available" data-title="r4c0">23</td>
						<td class="available" data-title="r4c1">24</td>
						<td class="available" data-title="r4c2">25</td>
						<td class="available" data-title="r4c3">26</td>
						<td class="available" data-title="r4c4">27</td>
						<td class="available" data-title="r4c5">28</td>
						<td class="weekend available" data-title="r4c6">29</td>
					</tr>
					<tr>
						<td class="weekend available" data-title="r5c0">30</td>
						<td class="available" data-title="r5c1">31</td>
						<td class="off available" data-title="r5c2">1</td>
						<td class="off available" data-title="r5c3">2</td>
						<td class="off available" data-title="r5c4">3</td>
						<td class="off available" data-title="r5c5">4</td>
						<td class="weekend off available" data-title="r5c6">5</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="calendar-time" style="display: none;"></div>
	</div>
	<div class="drp-buttons">
		<span class="drp-selected">07/01/2023 - 07/01/2023</span>
		<button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button>
		<button class="applyBtn btn btn-sm btn-primary" type="button">Apply</button>
	</div>
</div>
<form action="/member/chatStart" method="post" id="chatStart">
	<input type="hidden" id="accNum" name="accNo" value="${acommodation.accNo}"/>
	<sec:csrfInput/>
</form>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=917c14ec538dd01b6e336a6f65cec511&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/daterangepicker.js"></script>
<script
src="https://maps.googleapis.com/maps/api/js?key=구글키 넣으세용&callback=initAutocomplete&libraries=places&v=weekly"
defer></script>
<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	
	$(function() {
		var reportModalBtn = $('#reportModalBtn');

		reportModalBtn.on('click', function(){
			console.log("!reportModalBtn!");
		});

		$(document).on('click', '#reportModalBtn', function() {
			$('#reportModal').css('display', 'block');
		});
		$(document).on('click', '#closeReportModalBtn', function() {
			$('#reportModal').css('display', 'none');
		});


		$('#blameReason4').on('click', function() {
            if ($(this).prop('checked')) {
                $('#blameReasonTxt').css('display', 'block');
				$('#reportModalContent').css('height', '65%');
            } else {
                $('#blameReasonTxt').css('display', 'none');
            }
        });

		$('input[name="blameReason"]').not('#blameReason4').on('click', function() {
        	$('#blameReasonTxt').css('display', 'none');
			$('#reportModalContent').css('height', '50%');
        });
		
		$('#reportBtn').on('click', function() {
			var selectedReason = $('input[name="blameReason"]:checked').val();
            var additionalReason = $('#blameReasonTxt').val();
			
			var reportReason = $('#blameReason4').prop('checked') ? additionalReason : selectedReason;

			if(confirm("신고 하시겠습니까?")) {
				$.ajax({
					url: '/main/blame',
					type: 'post',
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data: JSON.stringify({
						"accNo": '${acommodation.accNo}',
						"blameReason": reportReason,
						"memNo": '${member.memNo}'
					}),
					dataType: 'text',
					contentType: 'application/json',
					success: function(res) {
						console.log("success -> " + res);
						if(res == "SUCCESS") {
							swal("신고되었습니다.","","success");
							$('#reportModal').css('display', 'none');
						} else {
							swal("다시시도해주세요.","","FAILED");
						}
					},
					error: function(err) {
						console.log('AJAX 요청 실패 -> ', err);
					}
				});

				console.log("reason -> ", reportReason);
			} else {
				return false;
			}

        });

	});
	

	function toggleWishStatus(isWished) {
		console.log('!isWished -> ', Number(isWished));
		if (isWished > 0) {
			console.log('if에 속함');
			$('#showWishListBtn').hide();
			$('#deleteWishBtn').show();
		} else {
			console.log('else에 속함');
			$('#showWishListBtn').show();
			$('#deleteWishBtn').hide();
		}
	}

	var accNo = '${acommodation.accNo}';
	
	// console.log("accNoㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ -> " + accNo);
	function selectCategoryList(wishlistCategoryNo){
		$.ajax({
			url: '/main/selectCategoryList',
			type: 'post',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data: JSON.stringify({
				"wishlistCategoryNo": wishlistCategoryNo,
				"accNo": accNo
			}),
			dataType: 'json',
			contentType: 'application/json',
			success: function(res) {
				console.log("success -> " + res);

				$('#createWishListmodal').css('display', 'none');
				$('#wishListModal').css('display', 'none');
				
				isWished = res;
				toggleWishStatus(isWished);
			},
			error: function(err) {
				console.log('AJAX 요청 실패 -> ', err);
			}
		});
	}

	$(function() {
		// 숙소 리스트 모달
		$(document).on('click', '#showWishListBtn', function() {
			$('#wishListModal').css('display', 'block');
		});
		$(document).on('click', '#closeWishListModalBtn', function() {
			$('#wishListModal').css('display', 'none');
		});
		
		// 숙소 모달
		$(document).on('click', '#createWishListBtn', function() {
			$('#createWishListmodal').css('display', 'block');
			$('#wishListModal').css('display', 'none');
		});
		$(document).on('click', '#closeCreateWishModalBtn', function() {
			$('#createWishListmodal').css('display', 'none');
			$('#wishListModal').css('display', 'block');
		});


		// 위시리스트 목록 생성하기
		var showWishBtn = $('#showWishBtn');
		showWishBtn.on('click', function(){
			console.log('!showWishBtn Click!');
		});
		
		
		var createWishListBtn = $('#createWishListBtn');
		createWishListBtn.on('click', function(){
			console.log('!createWishListBtn Click!');
		});
		
		var addWishListBtn = $('#addWishListBtn');
		var wishListContent = $('#wishListContent');

		wishListContent.on('keyup', function() {
			if (wishListContent.val().trim() !== '') {
				addWishListBtn.prop('disabled', false);
			} else {
				addWishListBtn.prop('disabled', true);
			}
		});

		var isWished = "${isWished}";
		toggleWishStatus(isWished);

		addWishListBtn.on('click', function(){
			console.log('!addWishListBtn Click! ' + "wishListContent" + wishListContent.val());

			if(wishListContent.val().trim() != ''){
				$.ajax({
					url: '/main/createWishList',
					type: 'post',
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header,token);
					},
					data: {
						"wishlistCategoryName": wishListContent.val(),
						"accNo": accNo
					},
					dataType: 'json',
					success: function(res){
						console.log("success -> " + res);
						
						$('#createWishListmodal').css('display', 'none');
						$('#wishListModal').css('display', 'none');
						
						wishListContent.val('');
						addWishListBtn.prop('disabled', true);

						isWished = res;
						toggleWishStatus(isWished);
					},
					error: function(err){
						console.log('위시리스트 등록 실패 -> ', err);
					}
				});
			} else {
				return false;
			}
		});

		var deleteWishBtn = $('#deleteWishBtn');
		deleteWishBtn.on('click', function(){
			console.log("!deleteWishBtn Click");

			$.ajax({
				url: '/main/deleteWishList',
				type: 'post',
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data: {
					"accNo": accNo
				},
				dataType: 'json',
				success: function(res) {
					console.log("Delete success -> " + res);
					if (res === 1) {
						// 삭제된 상태로 변경
						toggleWishStatus(0);
					} else {
						// 삭제되지 않은 상태로 변경
						toggleWishStatus(1);
					}
				},
				error: function(err) {
					console.log('위시리스트 삭제 실패 -> ', err);
				}
			});
		});

	});

	function hideReservation() {
		$('#reservationBox > div:first-child').css('display', 'block');
		$('#reservationBox > div:last-child').css('display', 'none');
	}
	function showReservation() {
		$('#reservationBox > div:first-child').css('display', 'none');
		$('#reservationBox > div:last-child').css('display', 'block');
	}
	
	$(function() {
	    var start = moment(); // 오늘 날짜로 초기화
		var end = moment().add(1, 'week'); // 오늘 날짜에서 1주일 후로 초기화
	    
	    
	    function cb(start, end) {
			var checkInData = start.format('YYYY-MM-DD');
			var checkOutData = end.format('YYYY-MM-DD');
			
			$('#checkIn').val(checkInData);
			$('#checkOut').val(checkOutData);

			$('#aresCheckinDate').val(checkInData);
			$('#aresCheckoutDate').val(checkOutData);
			
			var nights = end.diff(start, 'days');
			$('#nights').text(nights);
// 			console.log("박 -> " + nights);
			
			calculateTotalPrice();
			
			if (nights > 0) {
				showReservation();
			} else {
				hideReservation();
			}
	    }
	    
		var unavailableDates = [];
		<c:forEach var="invalidDate" items="${acommodation.invalidDate }">
			unavailableDates.push("${invalidDate }");
		</c:forEach>
		<c:forEach var="reservationDate" items="${acommodation.accReservationList }">
			var checkIn = "${reservationDate.aresCheckinDate }";
			var checkOut = "${reservationDate.aresCheckoutDate }";
			console.log("In -> " + checkIn + " Out -> " + checkOut);
			
			var currentDay = moment(checkIn);
	        var endDay = moment(checkOut);
			console.log("currentDay -> " + currentDay + " endDay -> " + endDay);
	        while (currentDay.isBefore(endDay)) {
	        	unavailableDates.push(currentDay.format("YYYY-MM-DD"));
	        	currentDay.add(1, "days");
	        }
		</c:forEach>
		console.log("invalid Date ", unavailableDates);
	
		$('#checkIn').daterangepicker({
			"opens": "left",
			"autoUpdateInput": false,
			"alwaysShowCalendars": true,
			startDate: start,
			endDate: end,
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " - ",
				"applyLabel": "적용",
				"cancelLabel": "취소",
				"fromLabel": "시작일",
				"toLabel": "종료일",
				"customRangeLabel": "사용자 지정",
				"weekLabel": "주",
				"daysOfWeek": ["일","월","화","수","목","금","토"],
				"monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
				"firstDay": 0
			},
				/* ! 과거 데이터 집어넣으려면 잠시 막아야함 ! */
 				isInvalidDate: function(date) {
 					// 예약 불가능한 날짜 목록을 설정합니다.
 			        // var unavailableDates = ["2023-07-22", "2023-07-25", "2023-07-28"];

 			        // 선택 가능한 날짜는 X 표시가 없이 활성화되도록 설정합니다.
 			        if (date.isAfter(moment(), 'day') && !unavailableDates.includes(date.format("YYYY-MM-DD"))) {
 			            return false;
 			        }
 			        
//  			        if (!unavailableDates.includes(date.format("YYYY-MM-DD"))) {
//  			            return false;
//  			        }

 			        // 그 외의 날짜들은 불가능한 날짜로 처리합니다.
 			        return true;
 				}
		    }, 
		    function(start, end) {
			startDay = start;
			endDay = end;
			cb(start, end);
		});
	});

	// 예약 가능 여부를 클릭했을 때 이동 막고 데이트피커 실행
	$('#checkAvailabilityBtn').on('click', function(){
		event.preventDefault();
		console.log("event.preventDefault");
		
		$('#checkIn').trigger('click', 'show.daterangepicker');
	});
	
	
	// Calendar animation and visual settings
	$('#checkIn').on('show.daterangepicker', function(ev, picker) {
		$('.daterangepicker').addClass('calendar-visible calendar-animated bordered-style');
		$('.daterangepicker').removeClass('calendar-hidden');
	});

	$('#checkIn').on('hide.daterangepicker', function(ev, picker) {
		$('.daterangepicker').removeClass('calendar-visible');
		$('.daterangepicker').addClass('calendar-hidden');
	});

	var extraGuestFee = 0;
	
	$(function() {
		var accContent = $('#accContent');
		var showMoreBtn = $('#showMoreBtn');
		
// 		console.log("html -> " + accContent.html());
		if (accContent.html().length > 300) {
			var shortenedContent = accContent.html().substring(0, 300);
// 			console.log("short -> " + shortenedContent);
			accContent.empty().append(shortenedContent);
			showMoreBtn.css('display', 'inline-block');
		}
		
		// 내용 모달
		$('#showMoreBtn').on('click', function() {
			$('#modal').css('display', 'block');
		});
		$('#closeModalBtn').on('click', function() {
			$('#modal').css('display', 'none');
		});
		
		// 옵션 모달
		$('#showOptionMoreBtn').on('click', function() {
			$('#optionModal').css('display', 'block');
		});
		$('#closeOptionModalBtn').on('click', function() {
			$('#optionModal').css('display', 'none');
		});
		
		// 이미지 모달
		$('#showMoreImagesBtn').on('click', function() {
			$('#imagesModal').css('display', 'block');
		});
		$('#closeImagesModalBtn').on('click', function() {
			$('#imagesModal').css('display', 'none');
		});

		// 후기 모달
		$('#showReviewMoreBtn').on('click', function(){
			$('#reviewModal').css('display', 'block');
		});
		$('#closeReviewModalBtn').on('click', function(){
			$('#reviewModal').css('display', 'none');
		});
		
		// 모달 밖 클릭 시 모달 닫기
		$(window).on('click', function(event) {
			if (event.target === document.querySelector('#modal')) {
				$('#modal').css('display', 'none');
			}
			if (event.target === document.querySelector('#optionModal')) {
				$('#optionModal').css('display', 'none');
			}
			if (event.target === document.querySelector('#imagesModal')) {
				$('#imagesModal').css('display', 'none');
			}
			if (event.target === document.querySelector('#wishListModal')) {
				$('#wishListModal').css('display', 'none');
			}
			if (event.target === document.querySelector('#createWishListmodal')) {
				$('#createWishListmodal').css('display', 'none');
			}
			if (event.target === document.querySelector('#reportModal')) {
				$('#reportModal').css('display', 'none');
			}
			if (event.target === document.querySelector('#reviewModal')) {
				$('#reviewModal').css('display', 'none');
			}
		});
		
		
// 		console.log("경도 ? " + accLogitide);
// 		console.log("위도 ? " + accLatitude);
		
		var guestTotalCount = 1;
		var guestMaxCount = parseInt('${guestMaxCount}');
		// 성인 수량 증가/감소 처리
		$('.qtyButtons:eq(0) i.fa-plus').on('click', function() {
			// console.log("guestMaxCount -> " + guestMaxCount);
			var guestCount = parseInt($('input[name="qtyInput"]').eq(0).val());
			guestCount++;
			guestTotalCount++;

			updateExtraGuestDisplay();
			
			$('#guestCount span').text(' ' + guestTotalCount);
			$('input[name="qtyInput"]').eq(0).val(guestCount);
		});
		
		if(guestTotalCount > guestMaxCount){
			console.log("guestTotalCount > guestMaxCount");
			$('#extraGuest').css('display', 'block');
		} 
		$('.qtyButtons:eq(0) i.fa-minus').on('click', function() {
			var guestCount = parseInt($('input[name="qtyInput"]').eq(0).val());
			if (guestCount > 1) {
				guestCount--;
				guestTotalCount--;
				$('#guestCount span').text(' ' + guestTotalCount);
				$('input[name="qtyInput"]').eq(0).val(guestCount);
			} else {
				return false;
			}

			updateExtraGuestDisplay();
		});
		
		// 어린이 수량 증가/감소 처리
		$('.qtyButtons:eq(1) i.fa-plus').on('click', function() {
			var guestCount = parseInt($('input[name="qtyInput"]').eq(1).val());
			guestCount++;
			guestTotalCount++;
			$('#guestCount span').text(' ' + guestTotalCount);
			$('input[name="qtyInput"]').eq(1).val(guestCount);

			updateExtraGuestDisplay();
		});
		
		$('.qtyButtons:eq(1) i.fa-minus').on('click', function() {
			var guestCount = parseInt($('input[name="qtyInput"]').eq(1).val());
			if (guestCount >= 1) {
				guestCount--;
				guestTotalCount--;
				$('#guestCount span').text(' ' + guestTotalCount);
				$('input[name="qtyInput"]').eq(1).val(guestCount);

				updateExtraGuestDisplay();
			} else {
				return false;
			}
		});
		  
		  // 유아 수량 증가/감소 처리
		$('.qtyButtons:eq(2) i.fa-plus').on('click', function() {
			var childCount = parseInt($('#childCount span').text());
			childCount++;
			$('#childCount').css('display', 'block');
			
			$('#childCount span').text(' ' + childCount);
			$('input[name="qtyInput"]').eq(2).val(childCount);
			
			$('#aresExtraGuest').val(childCount);
		});
		
		$('.qtyButtons:eq(2) i.fa-minus').on('click', function() {
			var childCount = parseInt($('#childCount span').text());
			if (childCount > 0) {
				childCount--;
				$('#childCount span').text(' ' + childCount);
				$('input[name="qtyInput"]').eq(2).val(childCount);
			}
			
			if (childCount == 0) {
				$('#childCount').css('display', 'none');
			}
			
			$('#aresExtraGuest').val(childCount);
		});
		
		function updateExtraGuestDisplay() {
			var extraGuestCount =  (parseInt($('#childCount span').text()) + parseInt($('#guestCount span').text()) + 1) - guestMaxCount;
			// console.log("extraGuestCount -> " + extraGuestCount);
			$('#aresGuestCount').val(guestTotalCount);
			// console.log("guestTotalCount -> " + guestTotalCount);

			if (guestTotalCount > guestMaxCount) {
				console.log("guestTotalCount > guestMaxCount");
				$('#extraGuest').css('display', 'block');
				
				
				var nights = parseInt($('#nights').text());
				extraPrice = (parseInt('${acommodation.accPrice }') * nights * extraGuestCount) * 0.1;
				console.log("extraPrice ----> " + extraPrice);
    			$('#extraGuestFee').text("₩" + extraPrice.toLocaleString());

				// console.log("guestMaxCount -> " + guestMaxCount);
				// console.log("###extraGuestCount -> " + extraGuestCount);
			} else {
				extraGuestCount = 0;
				extraPrice = 0;
				// console.log("extraGuestCount -> " + extraGuestCount);
				$('#extraGuest').css('display', 'none');
    			$('#extraGuestFee').text(0);
			}

			calculateTotalPrice();
		}

		// 예약하기 버튼을 클릭했을 때
		$('#reservationBtn').on('click', function(e){
			e.preventDefault();

			$('#reservationForm').submit();
		});
	});

	var extraPrice = 0;

	function calculateTotalPrice(){
		var nights = parseInt($('#nights').text());
		/* var basePrice = parseInt('${acommodation.accPrice}');
		var subtotal = nights * basePrice;
		//$('#basePrice').html("₩" + subtotal.toLocaleString()); */

		let adminEvent = 0;
		var eventList = [];

		<c:forEach var="event" items="${acommodation.eventList}">
			var newEvent = {
				discountType: '${event.discountType}',
				accNo: '${event.accNo}',
				discountRate: parseInt('${event.discountRate}')
			};
			eventList.push(newEvent);
		</c:forEach>
		<c:if test="${not empty acommodation.adminEvent}">
			adminEvent = "${acommodation.adminEvent.eventDiscountRate}";
		</c:if>
		console.log(adminEvent);
		console.log("eventList -> ", eventList);

		var discountRate = 0;
		if(nights >= 7 && nights < 28){
			for(var i=0; i<eventList.length; i++){
				var event = eventList[i];
				if(event.discountType === 'WEEK'){
					discountRate = event.discountRate;
					break;
				}
			}
		} else if(nights >= 28) {
			console.log("탐탐탐?")
			for(var i=0; i<eventList.length; i++){
				var event = eventList[i];
				if(event.discountType === 'MONTH'){
					discountRate = event.discountRate;

					break;
				}
			}
		}

		var basePrice = 0;
		if(discountRate != 0) {
			basePrice = parseInt('${acommodation.accPrice}') * (1 - (discountRate / 100));
		} else {
			basePrice = parseInt('${acommodation.accPrice}');
		}

		var subtotal = nights * basePrice;
		console.log("박수 : ", nights);
		console.log("할인율 : ", discountRate);
		console.log("1박가격: ", basePrice);
		console.log("총 가격: ", subtotal);
		$("#perPrice").html("₩" + basePrice.toLocaleString());
		$('#basePrice').html("₩" + subtotal.toLocaleString());
		
		let discountPrice = 0;

		if(adminEvent != 0) {
			discountPrice = subtotal * (adminEvent / 100);
			$('#discountedAmount').css('display', 'block');
			$("#discountedAmount").html("- ₩" + discountPrice.toLocaleString());
		} else {
			$('#discountedAmount').css('display', 'none');
			$("#discountedAmount").html("- ₩" + discountPrice.toLocaleString());
		}

		console.log("discountRate -> " + discountRate);
		
		var serviceFeeRate = 0.06;
		var serviceFee = Math.round((subtotal - discountPrice) * serviceFeeRate);
		$('#serviceFee').text("₩" + serviceFee.toLocaleString());
		
		
		$('#totalPrice').text("₩" + (subtotal - discountPrice + extraPrice + serviceFee).toLocaleString());
		console.log("subtotal", subtotal);
		console.log("discountPrice", discountPrice);
		console.log("extraPrice", extraPrice);
		console.log("serviceFee", serviceFee);
		$('#aresTotalPrice').val(subtotal);
		$('#aresExtraPrice').val(extraPrice);
		$('#discountPrice').val(discountPrice);
	}


	
// ====================================  지도  ========================================================
var kakao_longitude = "${acommodation.accLogitide }";
var kakao_latitude = "${acommodation.accLatitude }";

kakao_longitude = Number(kakao_longitude);
kakao_latitude = Number(kakao_latitude);
var map;
function initAutocomplete() {
	var accLocation = { lat: kakao_longitude, lng: kakao_latitude };
	var defaultOptions = {
		zoom : 15,
		center : accLocation,
		mapTypeId : "roadmap",
		zoomControl : true,
	}
	map = new google.maps.Map(document.querySelector("#map"), defaultOptions);
	var marker = new google.maps.Marker({position: accLocation, map: map});
}

window.initAutocomplete = initAutocomplete;
// ========================================== 채팅 =================================================
var chatBtn = document.querySelector("#chatBtn");
var chatStart = document.querySelector("#chatStart");

chatBtn.addEventListener("click",function(){
	chatStart.submit();
});
</script>