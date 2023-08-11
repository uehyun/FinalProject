<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css">
<sec:csrfMetaTags/>
<style>
section.comments {
    background-color: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding : 15px;
	border-radius: 8px;
}
.reply {
	background-color : ghostwhite;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}
.comment-by {
	padding-bottom : 0px;
	padding-top : 0px;
}
.day {
	color : #888;
	font-weight: 300;
}
.comment-content {
	height : auto;
	padding:15px 0 0 120px;
}
.btn {
	border: none;
	background-color: ghostwhite;
	font-size: 15px;
	color : gray;
	font-weight: bold;
	text-decoration: underline;
}
.btn:hover {
	color : red;
}
.writerImg {
	border-radius: 50%;
	border : 3px white solid;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	width:75px;
	height:75px;
	margin: 5px 5px 5px 5px;
}
.about-description {
	margin: 0px 0 0 25px;
}
#modBtn,
#delBtn {
	background-color: white;
	text-decoration: underline;
	color: gray;
	font-size: 17px;
}
#modBtn:hover,
#delBtn:hover {
	color: red;
}
/* 댓글 수정폼 */
.reply .comment-content #replyContent {
	width : 300px;
}
#dateContainer {
	overflow-x : scroll;
}
#dateContainer::-webkit-scrollbar {
	display:none;
}

/* 예약된 숙소 */
.placeSubBoxCont {
	height: 100%;
}
#accCont {
	height: 85%;
}
.content-div {
	height: 420px;
}
.acc-img {
	width: 310px;
	border-radius:8px;
	height: 220px;
}
#blameBtn {
	font-weight: 700;
	background: none;
    border: none;
	cursor: pointer;
}
#blameBtn:hover {
	color : red;
}
#blameSave {
	background: none;
    float: right;
    color: gray;
    border: none;
    text-decoration: underline;
    font-weight: 700;
}
#blameSave:hover {
	color : red;
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
</style>

<!-- 신고하기 모달 -->
<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">

	<div class="small-dialog-header">
		<h3>신고 사유</h3>
	</div>

	<!--Tabs -->
	<div class="sign-in-form style-1">


		<div class="tabs-container alt">

			<!-- Login -->
			<div class="tab-content" id="tab1" style="display: none;">

				<ul>
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
				<hr/>
				<div class="form-row">
					<input type="hidden" name="travelStartDate" id="travelStartDate" value=""/>
					<input type="hidden" name="travelEndDate" id="travelEndDate" value=""/>
					<sec:csrfInput/>
					<button class="addButton" id="blameSave" style="float:right;">신고하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //신고하기 모달 -->

<div class="container" style="margin-top : 15px; margin-bottom : 15px;">
    <div class="blog-page">
	    <div class="row">
    		<div class="col-lg-12 col-md-12 padding-right-30" style="width:100%">
                <div class="blog-post single-post">
                	<div class="post-content" style="height: 100%;">
						<div style="display: flex; align-items: center;">
							<div style="width: 50%;">
								<h2 style="font-weight:bold;">${tBoard.tboardTitle}</h2>
							</div>
							<div style="margin-left:30%;"></div>
						<div style="display: flex; flex-direction: column; align-items: flex-end; margin-right:10px;">
							<h4 style="color: black; font-size: 20px; font-weight: bold;">${member.memName}</h4>
							<span style="font-size: 13px; color: red;">${member.memEmail}</span>
						</div>
							<img class="writerImg" src="${pageContext.request.contextPath}${member.memProfilePath}">
						</div>
						<div style="display: flex; justify-content: space-between; margin: 0 5px;">
							<div>
								<ul class="post-meta">
									<li>${tBoard.tboardRegDate}</li>
									<li><i class='sl sl-icon-eye'></i>&nbsp;${tBoard.tboardHit }</li>
								</ul>
							</div>
							<c:if test="${member.memNo ne me}">
								<a href="#sign-in-dialog" class="sign-in popup-with-zoom-anim"><button id="blameBtn" style="margin-top: 10px;"><i class="sl sl-icon-bell"></i> 신고하기</button></a>
							</c:if>
						</div>
							<hr/>
						<div>${tBoard.tboardContent}</div>
						<div class="widget" style="float:right; margin : 10px 10px">
				          	<c:if test="${member.memNo eq me}">
				               <button class="button" id="modBtn"> 수정</button>
				               <button class="button" id="delBtn"> 삭제</button>
				          	</c:if>
			          	</div>
						<div class="clearfix"></div>
							<hr/>
							<h3 style="font-weight:bold;">나의 여행경로</h3>
						</div>
            
                    <!-- 지도 출력 구간 -->
                    <div class="map_wrap" style="width:100%;height:500px;">
						<div id="map" style="width:100%;height:100%;position:relative;"></div>
					</div>
                    <div style="display:flex; width:100%; margin-bottom: 10px; margin-top: 10px;">
                        <div style="display:flex; padding-top : 15px; padding-left : 15px; width:85%;">
                            <img src="${pageContext.request.contextPath}${tBoard.travelList[0].travelImgPath }" style="align-items: center; border: 2px solid gray; border-radius: 5px; width : 150px; height : 70px;">
                            <span style="font-size: 1.2em; font-weight: bold; margin-left: 20px; align-items: center; padding-top: 20px;">${tBoard.travelList[0].travelName }</span>
                        </div>
                        <div id="distance-div" style="width: 100px; text-align: center; margin-top: 30px; font-weight: 700;">
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

                    <div id="scrollDiv" style="height: 430px; width : 100%; border-bottom: 1px solid gainsboro; overflow:hidden;">
                        <div id="placeLocation" style="height : 428px;"></div>
                        <div class="cover-bar"></div>
                        <div class="placeSubBox">
		                	<div class="placeSubBoxCont">
		                		<div id="accCont">
		                			<div class="content-div" id="accDetail" style="margin: 0px 100px"></div>
		                		</div>
		                	</div>
		                </div>
                    </div>
                    <!-- 지도 출력 끝 -->
                </div>

                <div class="margin-top-20"></div>
                
                <!-- 댓글 영역 -->
                <div id="commentArea"></div>

                <div class="clearfix"></div>

                <div id="add-review" class="add-review-box" style="margin-top: 25px; margin-bottom: 30px; padding: 20px; padding-bottom: 20px;">
                    <fieldset>
                        <div>
                            <label>댓글 작성:</label>
                            <textarea id="replyContent" style="max-height: 90px; min-height: 90px;" cols="20" rows="2"></textarea>
                        </div>
                    </fieldset>
                    <button id="replyBtn" class="button" style="float : right;">작성</button>
                    <div class="clearfix"></div>
                </div>
	        </div>
	</div>
</div>
</div>
<form action="/tripBoard/update" method="get" id="eForm" style="display:none">
	<input type="hidden" value="${tBoard.tboardNo }" name="tboardNo" id="tboardNo"/>
</form>

<input type="hidden" value="${tBoard.tboardNo }" id="tboardNo"/>
<input type="hidden" value="${tBoard.travelList[0].travelNo }" id="travelNo"/>
<input type="hidden" value="${tBoard.travelList[0].travelStartDate}" id="travelStartDate"/>
<script>
var pageContext = "${pageContext.request.contextPath}";
var startDateStr = "${tBoard.travelList[0].travelStartDate }";
var endDateStr = "${tBoard.travelList[0].travelEndDate }";

var eForm = $("#eForm");
var delBtn = $("#delBtn");
var modBtn = $("#modBtn");

var tboardTitle = $("#tboardTitle");
var tboardContent = $("#tboardContent");
var tboardNo = $("#tboardNo");

var blameBtn = $("#blameBtn");
var blameReasonTxt = $("#blameReasonTxt");
var blameSaveBtn = $("#blameSave");

delBtn.on("click",function(){
	event.preventDefault();
	data = {
		"tboardNo" : tboardNo.val()
	}
	if(confirm("삭제 하시겠습니까?")) {
		data = 
		$.ajax({
			url : "/tripBoard/delete",
			type : "post",
			beforeSend : function(xhr) {
                xhr.setRequestHeader(header,token);
            },
            data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json; charset=utf-8",
            success : function(res){
                if(res.result === "SUCCESS") {
					swal("삭제가 성공했습니다.","","success")
					location.href="/tripBoard/main";
                } else {
                    swal(res.result,"","error");
                }
            }
		});
	} else {
		return false;
	}
});

modBtn.on("click",function(){
	if(confirm("수정 하시겠습니까?")) {
		eForm.submit();
	} else {
		return false;
	}
});

blameSaveBtn.on("click", function () {
    var checkedValue = $("input:radio[name='blameReason']:checked").val();
    var memNo = '${member.memNo}';
    
    if (checkedValue === '기타') {
        checkedValue = blameReasonTxt.val();
    }
    
    data = {
    		"boardNo" : tboardNo.val(),
    		"blameReason" : checkedValue,
    		"memNo" : memNo
    	}
    	if(confirm("신고 하시겠습니까?")) {
    		$.ajax({
    			url : "/tripBoard/blame",
    			type : "post",
    			beforeSend : function(xhr) {
                    xhr.setRequestHeader(header,token);
                },
                data : JSON.stringify(data),
                dataType : "json",
                contentType : "application/json; charset=utf-8",
                success : function(res){
                    if(res.result === "SUCCESS") {
    					swal("신고되었습니다.","","success")
    					location.href="/tripBoard/main";
                    } else {
                        swal(res.msg,"","error");
                        var closeButton = document.querySelector('.mfp-close');
                        closeButton.click();
                    }
                }
    		});
    	} else {
    		return false;
    	}
});

$("input:radio[name='blameReason']").on("change", function() {
    var checkedValue = $("input:radio[name='blameReason']:checked").val();
    if (checkedValue !== '기타') {
        blameReasonTxt.css("display", "none");
        blameReasonTxt.val("");
    } else {
        blameReasonTxt.css("display", "block");
    }
});
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=카카오키 넣으세용&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/tripboard/tripboarddetail.js"></script>

