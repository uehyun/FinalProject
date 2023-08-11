<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/review.css">

<div style="width: auto; margin-top: 15px; margin-bottom: 15px; min-height: 500px;">
	<div class="container">
		<div class="style-1">
			<ul class="tabs-nav">
				<li class="" id="tabLi1">
					<a class="reviewTab" data-type="host" href="" style="font-weight: bold;">호스트가 남긴 리뷰</a>
				</li>
				<li class="active" id="tabLi2">
					<a class="reviewTab" data-type="acc" href="" style="font-weight: bold;">내가 쓴 리뷰</a>
				</li>
			</ul>
	
			<div class="tabs-container">
				<div class="tab-content" id="mytab1" style="display: none; display: flex; justify-content: center; align-items: center;">
					<div class="col-lg-8 col-md-8">
						<div class="dashboard-list-box margin-top-0">
							<ul>
								<li>
									<div class="comments listing-reviews" id="hostReview">
										<!-- 호스트가 남긴 리뷰 -->
									</div>
								</li>
							</ul>
						</div>
						<div class="clearfix"></div>
						<div class="pagination-container margin-top-30 margin-bottom-0">
							<nav class="pagination pagingArea">
								<!-- 여기도 그리기 -->
							</nav>
						</div>
					</div>
				</div>
				
				<div class="tab-content" id="mytab2" style="display: none; display: flex; justify-content: center; align-items: center;">
					<div class="col-lg-8 col-md-8">
						<div class="dashboard-list-box margin-top-0">
							<ul>
								<li>
									<div class="comments listing-reviews" id="myReview">
									
									</div>
								</li>
							</ul>
						</div>
						<div class="clearfix"></div>
						<div class="pagination-container margin-top-30 margin-bottom-0">
							<nav class="pagination pagingArea">
								
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="memId" value="${member.memId}">
<input type="hidden" id="memNo" value="${member.memNo}">
<input type="hidden" id="memProfilePath" value="${member.memProfilePath}">
<input type="hidden" name="type" id="reviewType" value="host">
<input type="hidden" name="page" id="page" value="1">

<!-- <a id="reviewModal" href="#small-dialog" class="sign-in popup-with-zoom-anim" style="display: none;"></a> -->
<a id="reviewModal" href="#small-dialog" class="send-message-to-owner button popup-with-zoom-anim" style="display: none;"></a>
<div id="reviewModalContent" style="display: none;"></div>

<a id="blameModal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim" style="display: none;"></a>
<div id="blameModalContent" style="display: none;"></div>

<!-- <div id="small-dialog" class="zoom-anim-dialog" style="display: none;">
	<div class="small-dialog-header">
		<h3>후기 수정</h3>
	</div>
	<div class="sub-ratings-container">
		<div class="add-sub-rating">
			<div class="sub-rating-title">청결도 
				<i class="tip" data-tip-content="숙소가 깨끗했나요?"></i>
			</div>
			<div class="sub-rating-stars" id="clean">
				<div class="clearfix"></div>
				<div class="leave-rating">
					<input type="checkbox" name="rating" id="rating-1" value="1">
					<label for="rating-1" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-2" value="2">
					<label for="rating-2" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-3" value="3">
					<label for="rating-3" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-4" value="4">
					<label for="rating-4" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-5" value="5">
					<label for="rating-5" class="fa fa-star"></label>
				</div>
			</div>
		</div>

		<div class="add-sub-rating">
			<div class="sub-rating-title">위치 
				<i class="tip" data-tip-content="위치가 마음에 드셨나요?">
					<div class="tip-content">위치가 마음에 드셨나요?</div>
				</i>
			</div>
			<div class="sub-rating-stars" id="location">
				<div class="clearfix"></div>
				<div class="leave-rating">
					<input type="checkbox" name="rating" id="rating-11" value="1">
					<label for="rating-11" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-12" value="2">
					<label for="rating-12" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-13" value="3">
					<label for="rating-13" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-14" value="4">
					<label for="rating-14" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-15" value="5">
					<label for="rating-15" class="fa fa-star"></label>
				</div>
			</div>
		</div>

		<div class="add-sub-rating">
			<div class="sub-rating-title">체크인
				<i class="tip" data-tip-content="체크인 시간이 좋았나요?">
					<div class="tip-content">체크인 시간이 좋았나요?</div>
				</i>
			</div>
			<div class="sub-rating-stars" id="checkin">
				<div class="clearfix"></div>
				<div class="leave-rating">
					<input type="checkbox" name="rating" id="rating-21" value="1">
					<label for="rating-21" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-22" value="2">
					<label for="rating-22" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-23" value="3">
					<label for="rating-23" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-24" value="4">
					<label for="rating-24" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-25" value="5">
					<label for="rating-25" class="fa fa-star"></label>
				</div>
			</div>
		</div>
		
		<div class="add-sub-rating">
			<div class="sub-rating-title">가성비 
				<i class="tip" data-tip-content="가성비가 좋다고 생각하시나요?">
					<div class="tip-content">가성비가 좋다고 생각하시나요?</div>
				</i>
			</div>
			<div class="sub-rating-stars" id="valueformoney">
				<div class="clearfix"></div>
				<div class="leave-rating">
					<input type="checkbox" name="rating" id="rating-31" value="1">
					<label for="rating-31" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-32" value="2">
					<label for="rating-32" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-33" value="3">
					<label for="rating-33" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-34" value="4">
					<label for="rating-34" class="fa fa-star"></label>
					<input type="checkbox" name="rating" id="rating-35" value="5">
					<label for="rating-35" class="fa fa-star"></label>
				</div>
			</div>
		</div>	
	</div>
	
	<div class="message-reply margin-top-0">
		<textarea cols="40" rows="3" id="updateContent"></textarea>
		<button class="button" id="updateBtn">수정</button>
	</div>
	<button title="닫기" type="button" class="mfp-close" id="closeBtn"></button>
</div> -->

 
<!-- <div id="sign-in-dialog" class="zoom-anim-dialog" style="display: none;">
	<div class="small-dialog-header">
		<h3>신고 사유</h3>
	</div>

	<div class="sign-in-form style-1">
		<div class="tabs-container alt">
			<div class="tab-content">
				<ul>
					<li>
						<input type="radio" class="input-radio" name="blameReason" id="blameReason1" value="욕설이 포함되어 있습니다." style="position: absolute;" />
						<label for="blameReason1" style="position: relative; margin-left: 27px; transform: translateY(-6px);">욕설이 포함되어 있습니다.</label>
					</li>
					<li>
						<input type="radio" class="input-radio" name="blameReason" id="blameReason2" value="타 사이트 홍보글이 게재되어 있습니다." style="position: absolute;" />
						<label for="blameReason2" style="position: relative; margin-left: 27px; transform: translateY(-6px);">홍보글이 게재되어 있습니다.</label>
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
				<hr/>
				<button id="blameSave" style="float:right;">신고하기</button>
			</div>
		</div>
		<button title="닫기" type="button" class="mfp-close" id="closeBtn2"></button>
	</div>
</div> -->


<script src="${pageContext.request.contextPath}/resources/scripts/member/review.js"></script>