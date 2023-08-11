<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<sec:csrfMetaTags/>
<style>
.placeSubBoxCont {
	height: 100%;
}
#accCont {
	height: 85%;
}
.content-div {
	height: 420px;
}
.acc-content {
	display: inline-block;
}
.sign-in-form .button {
	float : right;
}
#img-div {
	width : 500px;
}
.memo-text {
	height: 400px;
	overflow : scoll;
}
.memo-text::-webkit-scrollbar {
	display : none;
}
.memList-img {
	cursor: pointer;
}
#tooltip {
    border-radius: 8px;
    position: absolute;
    background-color: white;
    z-index: 999;
    transform: translate(440px, 90px);
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    padding: 8px;
    display: none;
}
.acCont {
	font-weight : 700;
	font-size : 15px;
}
.slick-next,
.slick-prev {
	transform: translate3d(0, -50%, 0);
}
#accDetail {
	overflow-y: scroll; 
}
#accDetail::-webkit-scrollbar {
	display: none;
}
.addAcc {
	border : none;
	background-color: white;
}
</style>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css">
<div class="container">
	<div class="row">
	    <div class="col-lg-12 col-md-12">
	        <div class="dashboard-list-box margin-top-0">
	            <!-- 지도 시작 -->
	            <div class="map_wrap">
	                <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	                <div id="menu_wrap" class="bg_white">
	                    <div class="option">
	                        <div>
	                            <div id="searchArea">
	                                <form onsubmit="searchPlaces(); return false;">
	                                    키워드 : <input type="text" value="제주도 맛집" id="keyword" size="15"> 
	                                    <button type="submit">검색하기</button> 
	                                </form>
	                            </div>
	                        </div>
	                    </div>
	                    <hr>
	                    <ul id="placesList"></ul>
	                    <div id="pagination"></div>
	                </div>
	            </div>
	            <div style="display:flex; width:100%; margin-bottom: 15px;">
	            	<div style="display:flex; padding-top : 15px; padding-left : 15px; width:30%;">
	            		<img src="${pageContext.request.contextPath}${tripSchedule.travelImgPath }" style="align-items: center; border: 2px solid gray; border-radius: 5px; width : 150px; height : 70px;">
	            		<span style="font-size: 1.2em; font-weight: bold; margin-left: 20px; align-items: center; padding-top: 20px;">${tripSchedule.travelName }</span>
	            	</div>
	            	<div id="distance-div" style="width: 100px; text-align: center; margin-top: 30px; font-weight: 700;">
	            	</div>
					<div id="img-div">
						<c:forEach items="${mem.memList }" var="mem" varStatus="i">
							<c:choose>
								<c:when test="${mem.memProfilePath eq null }">
									<img class="memList-img" src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" style="transform : translateY(25%) translateX(${-75 + i.index * 150}%); z-index : ${i.index+1};"/>
								</c:when>
								<c:otherwise>
									<img class="memList-img" src="${pageContext.request.contextPath}${mem.memProfilePath}" style="transform : translateY(25%) translateX(${-75 + i.index * 150}%); z-index : ${i.index+1};"/>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
		            <div id="btnArea" style="display: flex;">
		                <a href="#sign-in-dialog" class="sign-in popup-with-zoom-anim" style="padding-top : 19px;"><button class="button" id="btnShare">공유하기</button></a>
		                <button class="button" id="btnSearch">편집</button>
		                <button class="button" id="btnSave">저장하기</button>
		            </div>
	            </div>
				<div class="date-container-outer">
					<div class="date-container-inner" id="dateContainer"></div>
					<div class="date-navigation">
						<button class="date-nav-button date-nav-left" id="dateNavLeft">
							<i class="fas fa-chevron-left"></i>
						</button>
						<button class="date-nav-button date-nav-right" id="dateNavRight">
							<i class="fas fa-chevron-right"></i>
						</button>
					</div>
				</div>
	            	<div id="scrollDiv">
		                <div id="placeLocation"></div>
		                <div class="cover-bar"></div>
		                <div class="placeSubBox">
		                	<div class="placeSubBoxBtn">
		                		<button class="button" id="accBtn">예약 숙소</button>
		                		<button class="button" id="memoBtn">메모</button>
		                	</div>
		                	<hr/>
		                	<div class="placeSubBoxCont">
		                		<div id="accCont">
		                			<div id="accDetail" class="content-div" style="margin: 0px 100px">
										<div style="display: flex; flex-direction: column;">
											<h3 style="font-weight: 700;">아직 예약된 숙소가 없습니다.</h3>
											<a class="read-more" href="/main/home" style="font-weight: 700;">예약하러 가기 <i class="fa fa-angle-right" aria-hidden="true"></i></a>
										</div>
									</div>
		                			<hr/>
		                			<div>
<!-- 		                				<button class="button" style="float:right; margin-right : 30px;">숙소 추가</button> -->
		                			</div>
		                		</div>
		                		<div id="memoCont" style="height:85%;">
		                			<div id="memoDiv" class="content-div">수정 버튼을 눌러 메모를 입력하세요.</div>
		                			<hr/>
		                			<div>
		                				<button class="button" id="memoModBtn" style="float:right; margin-right : 30px;">수정</button>
		                				<button class="button" id="memoOkBtn" style="float:right; margin-right : 30px; display: none;">확인</button>
		                			</div>
		                		</div>
		                	</div>
		                </div>
	            	</div>
	            </div>
	        </div>
	    </div>	
	</div>
	
<!-- 여행 공유 멤버 -->
<div id="tooltip">
	<table>
		<tr style="text-align: center; font-weight: bold;"><td style="border-bottom: 1px solid rgb(221,221,221);">여행 멤버</td></tr>
	<c:forEach items="${mem.memList}" var="mem">
		<tr>
			<td style="text-align: center">
				<span style="font-weight: bold;">${mem.memId}</span>
			</td>
<!-- 			<td> -->
<!-- 				<button class="button" data-memno="${mem.memNo }">삭제</button> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
	</table>
</div>
<!-- 공유하기 div -->
<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">

	<div class="small-dialog-header">
		<h3>여행 공유</h3>
	</div>

	<div class="sign-in-form style-1">
		<div class="tabs-container alt">
			<!-- Login -->
			<div class="tab-content" id="tab1" style="display: none;">
				<p class="form-row form-row-wide">
					<label for="username">공유할 상대:
						<i class="im im-icon-Male"></i>
						<input type="text" class="input-text" id="memId" value="" placeholder="상대방 아이디를 입력해주세요."/>
					</label>
				</p>
				<div class="form-row">
					<button class="button" id="addMem">추가하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" value="${tripSchedule.travelNo}" id="travelNo"/>
<input type="hidden" value="${tripSchedule.travelStartDate }" id="travelStartDate" />
<script>
var targets = document.querySelectorAll(".img-div");
var toolFlag = true;

for (var i = 0; i < targets.length; i++) {
  targets[i].addEventListener("mouseover", function() {
	var tooltip = document.querySelector("#tooltip");
    tooltip.style.display = "block";
    if(toolFlag) {
	    this.appendChild(tooltip);
	    toolFlag = false;
    }
  });
  
  targets[i].addEventListener("mouseout", function() {
    var tooltip = this.querySelector("#tooltip");
    tooltip.style.display = "none";
  });
}


// 날짜 데이터
var startDateStr = "${tripSchedule.travelStartDate }";
var endDateStr = "${tripSchedule.travelEndDate }";
var pageContext = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=카카오키 넣으세용&libraries=services"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/trip/kakaomap.js"></script>