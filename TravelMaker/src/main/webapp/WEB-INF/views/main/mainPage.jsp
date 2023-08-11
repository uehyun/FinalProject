<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<style>
.popularCategory {
	position: absolute;
    top: -5px; 
    right: 30px;
    color: red;
    font-size: 3rem;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

<div class="main-search-container plain-color">
	<div class="background-image"></div>
	<div class="main-search-inner">
		<div class="container" style="display: flex; justify-content: center;">
			<div class="row">
				<div class="col-md-12">
					<div class="main-search-headlines">
						<h2>
							모두의 <span class="typed-words"></span>
						</h2>
						<h4>당신의 여행 설계사 Travel Maker</h4>
					</div>
					<div class="main-search-input">
						<div class="main-search-input-item location">
							<div id="autocomplete">
								<input id="autocomplete-input" style="cursor:pointer;" type="text" placeholder="버튼을 눌러 검색조건을 선택해주세요." readonly>
							</div>
						</div>
						<button class="button" id="searchBtn" style="background-color: #5177dc;">검색</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<section class="fullwidth margin-top-0 padding-top-0 padding-bottom-20">
	<div class="container" style="height: 100%; width: 90%;">
		<div class="row">

			<div class="col-md-12" style="margin-top: 25px;">
				<div id="categoryDiv" class="cate-box" style="overflow-x: scroll; display: flex; overflow-y: hidden;">
					<div style="display: inline">
						<div class="cate-zone" style="cursor:pointer;" data-cate="">
							<i class="fa-solid fa-border-all fa-2x" style="color : #5177dc;"></i>
							<span style="font-size:12px; color:#5177dc; font-weight:700;">전체</span>
						</div>
					</div>
					<c:forEach items="${option}" var="opt" varStatus="i">
						<div style="display: inline">
							<div class="cate-zone" style="cursor:pointer; position: relative;" data-cate="${opt.optionNo}">
								<div class="popularCategory"></div>
								<i class="${opt.attGroupNo} fa-2x" style="color : #5177dc;"></i>
								<span style="font-size:12px; color:#5177dc; font-weight:700;">${opt.optionName}</span>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="date-container-outer">
					<div class="date-navigation">
						<button class="date-nav-button date-nav-left" id="dateNavLeft">
							<i class="fas fa-chevron-left"></i>
						</button>
						<button class="date-nav-button date-nav-right" id="dateNavRight">
							<i class="fas fa-chevron-right"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Listings -->
<div id="accBox" class="container margin-top-20" style="display: flex; flex-wrap: wrap; height: 900px; width: 100%;">
</div>
<!-- Listings / End -->

<!-- 캘린더 모달 -->
<div class="drp-calendar left single" style="display: none;">
	<div class="calendar-table">
		<table class="table-condensed">
			<thead>
				<tr>
					<th class="prev available"><span></span></th>
					<th colspan="5" class="month">Jul 2023</th>
					<th class="next available"><span></span></th>
				</tr>
				<tr>
					<th>Su</th>
					<th>Mo</th>
					<th>Tu</th>
					<th>We</th>
					<th>Th</th>
					<th>Fr</th>
					<th>Sa</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="weekend off available" data-title="r0c0">25</td>
					<td class="off available" data-title="r0c1">26</td>
					<td class="off available" data-title="r0c2">27</td>
					<td class="off available" data-title="r0c3">28</td>
					<td class="off available" data-title="r0c4">29</td>
					<td class="off available" data-title="r0c5">30</td>
					<td
						class="today weekend active start-date active end-date available"
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
<!-- 캘린더 모달 -->

<!-- 지역 선택 modal -->
<div class="modal" id="regionModal">
	<div class="modal-content">
	  <div style="display: flex; flex-direction: column; width:180px; border-right: 1px solid rgb(221,221,221);">
		<button class="btn-tab" id="doBtn">도 단위</button>
		<button class="btn-tab" id="siBtn">시 단위</button>
	  </div>
	  <div id="do-box" class="map-box">
			<div class="lc-img-box">
				<img data-juso="충북" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/South_Korea-North_Chungcheong.svg/227px-South_Korea-North_Chungcheong.svg.png"/>
				<span>충청북도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="충남" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/South_Korea-South_Chungcheong.svg/227px-South_Korea-South_Chungcheong.svg.png"/>
				<span>충청남도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="강원" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/South_Korea-Gangwon.svg/227px-South_Korea-Gangwon.svg.png"/>
				<span>강원도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="경기" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/South_Korea-Gyeonggi.svg/227px-South_Korea-Gyeonggi.svg.png"/>
				<span>경기도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="경북" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/South_Korea-North_Gyeongsang.svg/227px-South_Korea-North_Gyeongsang.svg.png"/>
				<span>경상북도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="경남" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/South_Korea-South_Gyeongsang.svg/227px-South_Korea-South_Gyeongsang.svg.png"/>
				<span>경상남도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="전북" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/South_Korea-North_Jeolla.svg/227px-South_Korea-North_Jeolla.svg.png"/>
				<span>전라북도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="전남" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/South_Korea-South_Jeolla.svg/227px-South_Korea-South_Jeolla.svg.png"/>
				<span>전라남도</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="제주" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/South_Korea-Jeju_alt.svg/193px-South_Korea-Jeju_alt.svg.png"/>
				<span>제주도</span>
			</div>
		</div>
		<div id="si-box" class="map-box">
			<div class="lc-img-box">
				<img data-juso="서울" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Seoul_South_Korea_location_map.svg/2560px-Seoul_South_Korea_location_map.svg.png"/>
				<span>서울</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="대전" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Map_Daejeon-gwangyeoksi.svg/2310px-Map_Daejeon-gwangyeoksi.svg.png"/>
				<span>대전</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="부산" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Map_Busan-gwangyeoksi.svg/800px-Map_Busan-gwangyeoksi.svg.png"/>
				<span>부산</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="대구" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/b/b2/Map_Daegu-gwangyeoksi.svg"/>
				<span>대구</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="인천" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Map_Incheon-gwangyeoksi.svg/400px-Map_Incheon-gwangyeoksi.svg.png"/>
				<span>인천</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="광주" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gwangju_Map.svg/2560px-Gwangju_Map.svg.png"/>
				<span>광주</span>
			</div>
			<div class="lc-img-box">
				<img data-juso="울산" class="location-img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/South_Korea_Ulsan_adm_location_map.svg/400px-South_Korea_Ulsan_adm_location_map.svg.png"/>
				<span>울산</span>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="categoryNum" value=""/>
<script src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/daterangepicker.js"></script>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<script>
function goAcommodationDetail(accNo) {
	location.href = "/main/detail/" + accNo;
}

var juso = "";	
var startDay = "";
var endDay = "";
var pageCount = 1;
var guestTotalCount = 1;
var categoryNum = $("#categoryNum");
var data = {
	"juso" : juso,
	"checkIn" : startDay,
	"checkOut" : endDay,
	"guest" : guestTotalCount,
	"category" : categoryNum.val(),
	"pageCount" : pageCount
};

const accBox = document.querySelector("#accBox");
const categories = document.querySelectorAll(".cate-zone");
let isScrolling = false;

var doBox = $("#do-box");
var siBox = $("#si-box");
var doBtn = $("#doBtn");
var siBtn = $("#siBtn");

doBtn.on("click",function(){
	siBox.css("display", "none");
    doBox.css("display", "flex");
});
siBtn.on("click",function(){
	siBox.css("display", "flex");
    doBox.css("display", "none");
});


// Calendar Init
$(function() {
	getList(data);
	getTopCategory();
	setInterval(getTopCategory, 180000);
});

// 이현 부분 ====================================>> 카테고리 출력 및 메인 사진 로드	
var imageUrls = [
    "/resources/images/ocean.jpg",
    "/resources/images/ocean1.jpg",
    "/resources/images/ocean3.jpg",
    "/resources/images/tree.jpg",
    "/resources/images/jeju.jpg",
    "/resources/images/tree1.jpg",
    "/resources/images/mountain.jpg",
    "/resources/images/mountain1.jpg"
  ];

var mainSearchContainer = document.querySelector(".main-search-container.plain-color");
var backgroundElement = document.querySelector(".background-image");

function changeBackgroundImage() {
  var randomImageUrl = imageUrls[Math.floor(Math.random() * imageUrls.length)];

  backgroundElement.style.opacity = 0; // 자식 요소가 아닌 부모 요소의 opacity를 설정합니다.

  setTimeout(function() {
      backgroundElement.style.backgroundImage = "url(" + randomImageUrl + ")";
      backgroundElement.style.opacity = 1;
  }, 1000);
}

// changeBackgroundImage();
setInterval(changeBackgroundImage, 8000);

var categoryDiv = document.querySelector("#categoryDiv");
var dateNavLeft = document.querySelector("#dateNavLeft");
var dateNavRight = document.querySelector("#dateNavRight");

// 좌우 스크롤 버튼 이벤트 처리
dateNavLeft.addEventListener("click", function () {
  scrollSmoothly(categoryDiv, -800); // 스크롤 왼쪽으로 이동
});

dateNavRight.addEventListener("click", function () {
  scrollSmoothly(categoryDiv, 800); // 스크롤 오른쪽으로 이동
});

function scrollSmoothly(element, scrollAmount) {
    var start = element.scrollLeft;
    var target = start + scrollAmount;
    var duration = 1000; // 스크롤 지속 시간 (밀리초)
    var startTime = null;

    function animation(currentTime) {
    if (startTime === null) {
        startTime = currentTime;
    }
    var elapsedTime = currentTime - startTime;
    var scrollValue = easeInOutCubic(elapsedTime, start, target - start, duration);
    element.scrollLeft = scrollValue;
    if (elapsedTime < duration) {
        requestAnimationFrame(animation);
    }
    }

    function easeInOutCubic(t, b, c, d) {
    t /= d / 2;
    if (t < 1) return c / 2 * t * t * t + b;
    t -= 2;
    return c / 2 * (t * t * t + 2) + b;
    }

    requestAnimationFrame(animation);
}
// ================================================ 검색창 ==========================================================
$(document).ready(function () {
  	var mainSearchInputContent = $(".main-search-input").html(); // 기존 내용 
	var flag = true;

	$(".main-search-input").click(function(event){
		event.stopPropagation();
		if(flag) {
			searchAni.call(this,event);
			flag = false;
		}
	});

	$(document).on("click", function (event) {
		if (
			event.target.id != "autocomplete-input" && 
			event.target.id != "dateP"				&&
			event.target.id != "chosenSelect"		&&
			event.target.id != "guestCount"			&&
			event.target.id != "panelDiv"			&&
			event.target.classList.value != "qt"								&&
			event.target.classList.value != "qtyTitle" 							&&
			event.target.classList.value != "qtyButtons" 						&&
			event.target.classList.value != "swal-modal" 						&&
			event.target.classList.value != "swal-title" 						&&
			event.target.classList.value != "panel-dropdown" 					&&
			event.target.classList.value != "fa-solid fa-plus" 					&&
			event.target.classList.value != "fa-solid fa-minus" 				&&
			event.target.classList.value != "main-search-input" 				&&
			event.target.classList.value != "fa fa-map-marker" 					&&
			event.target.classList.value != "main-search-input-item location" 	&&
			event.target.classList.value != "panel-dropdown-content" 			&&
			event.target.classList.value != "main-search-input expanded" 		&&
			event.target.classList.value != "main-search-input-item"	 		&&
			event.target.classList.value != "applyBtn btn btn-sm btn-primary"	&&
			event.target.classList.value != "swal-button swal-button--confirm"	&&
			event.target.classList.value != "swal-icon swal-icon--warning"		&&
			event.target.classList.value != "cancelBtn btn btn-sm btn-default"
		) {
			flag = true;
			$(".main-search-headlines").removeClass("hide-headlines");
			$(".main-search-input").removeClass("expanded");
			$(".main-search-input-item.location").remove();
			$(".main-search-input").html(mainSearchInputContent);
		}

		// 모달 닫기
		var regionModalClicked = $(event.target).closest("#regionModal").prevObject.length > 0;
		var clickCheck = event.target.id == "autocomplete-input";
		if (!regionModalClicked || !clickCheck) {
			$("#regionModal").css("display", "none");
		}
	});

	$(".modal-content").on("click",function(event){
		event.stopPropagation();
	});
});

function cb(start, end) {
	var dateRange = start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD');
	$('#dateP').val(dateRange);
}

function createDatePicker() {
	var start = moment();
	var end = moment().add(1, 'week');
	
	
	$('#date-picker').daterangepicker
	({
			"opens" : "left",
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
			isInvalidDate : function(date) {
				return date.isBefore(moment(), 'day');
			}
		},function(start, end){
			startDay = start.format('YYYY-MM-DD');
			endDay = end.format('YYYY-MM-DD');
			cb(start,end);
			setTimeout(function() {
				$("#panelDiv").addClass("panel-dropdown active");
			}, 0);
	});

	// Calendar animation
	$('#date-picker').on('showCalendar.daterangepicker', function(ev, picker) {
		$('.daterangepicker').addClass('calendar-animated');
	});
	$('#date-picker').on('show.daterangepicker', function(ev, picker) {
		$('.daterangepicker').addClass('calendar-visible');
		$('.daterangepicker').removeClass('calendar-hidden');
	});
	$('#date-picker').on('hide.daterangepicker', function(ev, picker) {
		$('.daterangepicker').removeClass('calendar-visible');
		$('.daterangepicker').addClass('calendar-hidden');
	});
}

function searchAni() {
	$(".main-search-headlines").addClass("hide-headlines");
	$(this).addClass("expanded");
	
	$(".main-search-input").empty();
	$(".main-search-input").append(`
	<div class="main-search-input-item location">
		<div id="autocomplete-container">
			<input id="autocomplete-input" style="cursor:pointer;" type="text" value="지역">
		</div>
		<a href="#"><i class="fa fa-map-marker"></i></a>
	</div>
			
	<div class="main-search-input-item" id="date-picker">
		<input id="dateP" type="text" style="cursor:pointer;" value="날짜"/>
	</div>
				
	<div class="main-search-input-item">
		<div id="panelDiv" class="panel-dropdown" style="width: 100%; margin: 0.5% 0 0 0; font-weight: 0;">
			<a id="chosenSelect" href="#" style="display: flex; margin-top: 5px;">
				<span style="margin: 0 3% 0 0;" id="guestCount">게스트 <span class="qt"> 1</span></span>
			</a>
			<div class="panel-dropdown-content" style="width: 230px;">

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
			</div>
		</div>
	</div>
	<button id="searchBtn" class="button" style="background-color: #5177dc;">검색</button>
	`);
	createDatePicker()

	$("#chosenSelect").on("click",function(event){
		event.stopPropagation();
		setTimeout(function() {
			$("#panelDiv").addClass("panel-dropdown active");
		}, 0);
	})
	
	$('.panel-dropdown-content').on('click', function(event) {
		event.preventDefault();
		setTimeout(function() {
			$("#panelDiv").addClass("panel-dropdown active");
		}, 0);
	});

	$("#autocomplete-container").on("click", function () {
		createLocation();
	});

	// ================================================= 인원 수 체크 =========================================================
	// 성인 수량 증가/감소 처리
	$('.qtyButtons:eq(0) i.fa-plus').on('click', function() {
		var guestCount = parseInt($('input[name="qtyInput"]').eq(0).val());
		guestTotalCount++;
		guestCount++;
		$('#guestCount span').text(' ' + guestTotalCount);
		$('input[name="qtyInput"]').eq(0).val(guestCount);
	});
	
	$('.qtyButtons:eq(0) i.fa-minus').on('click', function() {
		var guestCount = parseInt($('input[name="qtyInput"]').eq(0).val());
		if (guestCount > 1) {
			guestCount--;
			guestTotalCount--;
			$('#guestCount span').text(' ' + guestTotalCount);
			$('input[name="qtyInput"]').eq(0).val(guestCount);
		} else {
			swal("인원 수를 제대로 입력해주세요.","","warning");
			return false;
		}
	});
	
	// 어린이 수량 증가/감소 처리
	$('.qtyButtons:eq(1) i.fa-plus').on('click', function() {
		var guestCount = parseInt($('input[name="qtyInput"]').eq(1).val());
		guestCount++;
		guestTotalCount++;
		$('#guestCount span').text(' ' + guestTotalCount);
		$('input[name="qtyInput"]').eq(1).val(guestCount);
	});
	
	$('.qtyButtons:eq(1) i.fa-minus').on('click', function() {
		var guestCount = parseInt($('input[name="qtyInput"]').eq(1).val());
		if (guestCount >= 1) {
			guestCount--;
			guestTotalCount--;
			$('#guestCount span').text(' ' + guestTotalCount);
			$('input[name="qtyInput"]').eq(1).val(guestCount);
		} else {
			swal("인원 수를 제대로 입력해주세요.","","warning");
			return false;
		}
	});
	//=============================================== 인원 수 체크 =========================================================

	$("#searchBtn").on("click",function(){
		pageCount = 1;
		data = {
			"juso" : juso,
			"checkIn" : startDay,
			"checkOut" : endDay,
			"guest" : guestTotalCount,
			"category" : categoryNum.val(),
			"pageCount" : pageCount
		}
		console.log(data);
		accBox.innerHTML = "";
		getList(data);
		// ajax 호출
		flag = true;
	});
}

function createLocation() {
	var locationDiv = $("#autocomplete-container");
	var regionModal = $("#regionModal");

	var modalWidth = regionModal.outerWidth();
	var modalHeight = regionModal.outerHeight();

	var offset = locationDiv.offset();
	var topPosition = offset.top + locationDiv.outerHeight() + 10;
	var leftPosition = offset.left + (locationDiv.outerWidth() - modalWidth) / 2;

	regionModal.css({
		top: (topPosition + 5) + "px",
		left: (leftPosition + 314) + "px",
	});

	regionModal.css("display","block"); // 모달 창을 보이도록 클래스 추가

	var limg = $(".location-img");
	
	limg.each(function(index,element){
		$(element).on("click",function(){
			var autocompleteInput = $("#autocomplete-input");
			limg.css("border", "1px solid rgb(221, 221, 221)");
    
    		$(this).css("border", "1px solid black");
			juso = $(this).data("juso");
			autocompleteInput.val(juso);
    
			regionModal.css("display","none");
			$("#date-picker").click();
		});
	});
}

const slickOption = {
    dots: true,
    arrows: true,
    infinite: true,
    speed: 500,
    fade: true,
    slidesToShow: 1,
    pauseOnHover: true,
    adaptiveHeight: true
};
    
function slickJs() {
    /* $(".slider").each(function() {
        var $this = $(this);
        $this.slick(slickOption);
        $this.on('mouseenter', function () {
            $this.slick('slickSetOption', 'dots', true);
            $this.slick('slickSetOption', 'arrows', true);
            $this.slick('refresh');
            $this.find('.slick-slide').slideDown(500);
        });

        $this.on('mouseleave', function () {
            $this.slick('slickSetOption', 'dots', false);
            $this.slick('slickSetOption', 'arrows', false);
            $this.slick('refresh');
        });

        $this.on('click', function (event) {
            if (event.target.classList.contains('slick-prev') || event.target.classList.contains('slick-next')) {
                event.stopPropagation();
            }
        });
    }); */
    $(".slider").slick(slickOption);
}
var pageContext = "${pageContext.request.contextPath}";
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/main/main.js"></script>