<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flights.css">
<sec:csrfMetaTags/>
<div class="main-search-container plain-color">
<div class="background-image"></div>
	<div class="main-search-inner">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="main-search-headlines">
						<h2>
							모두의 <span class="typed-words"></span>
						</h2>
						<h4>당신의 여행 설계사 Travel Maker</h4>
					</div>
					<c:choose>
						<c:when test="${not empty main}">
							<div class="main-search-input">
								<div id="airportModal">
								</div>
								<div class="main-search-input-item">
									<input type="text" placeholder="지역검색 조건" value="" />
								</div>
								
								<div class="main-search-input-item location">
									<div id="autocomplete-container">
										<input id="autocomplete-input" type="text"
											placeholder="날짜검색 조건">
									</div>
									<a href="#"><i class="fa fa-map-marker"></i></a>
								</div>
								<div class="main-search-input-item">
									<select data-placeholder="인간유형 조건" class="chosen-select">
										<option>여기에</option>
										<option>조건을</option>
										<option>넣는 거에용</option>
									</select>
								</div>
								<button class="button">검색</button>
							</div>
						</c:when>
						<c:otherwise>
							<div class="flight_tab_container">
								<div class="flight_tab">
									<button class="flight_tablinks" id="oneway" >편도</button>
									<button class="flight_tablinks" id="twoway" >왕복</button>
							    </div>
							</div>
							<div class="main-search-input" id="main-search-input">
								<div class="input-label-container">
									<div class="input-label">출발지</div>
									<div class="input-label" id="lArrive">도착지</div>
									<div class="input-label" id="lDepart">날짜 선택</div>
								</div>
								<div class="main-search-input-sub">
									<!-- 출발공항 목록 모달 -->
									<div id="airportModal">
										<div class="modal-content">
											<!-- 공항목록 -->
											<c:forEach items="${airport}" var="airport">
												<p class="departP">
													${airport.airportName}(${airport.airportCode})
												</p>
											</c:forEach>
										</div>
									</div>	
									<div class="main-search-input-item">
										<input type="text" placeholder="출발 공항" value="" id="departAirport" name="departAirport"/>
									</div>
									<!-- 도착공항 목록 모달 -->
									<div id="airportModal2">
										<div class="modal-content">
											<!-- 공항목록 -->
											<c:forEach items="${airport }" var="airport">
												<p class="arriveP">
													${airport.airportName }(${airport.airportCode})
												</p>
											</c:forEach>
										</div>
									</div>
									<div class="main-search-input-item">
										<input type="text" placeholder="도착 공항" value="" id="arriveAirport" name="arriveAirport"/>
									</div>
									
									<div class="main-search-input-item location">
										<div id="autocomplete-container">
											<input type="text" id="date-picker2" placeholder="날짜를 선택해주세요" readonly="readonly" style="width : 230px;">
											<input type="text" id="date-picker" placeholder="Date" readonly="readonly" name="flightDepartTime">
										</div><span class="type-and-hit-enter">type and hit enter</span>
									</div>
									
									<button class="button" id="flightListBtn">검색</button>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

</div>
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
					<td class="today weekend active start-date active end-date available"
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


<!-- 비행기 예약 리스트   -->
<div id="selectOptionFLight">
	<label for="sortOption">정렬 옵션:</label>
	<select id="sortOption">
	  <option value="depart_time">출발 시간 빠른 순</option>
	  <option value="adult_price">가격 싼 순</option>
	  <option value="duration">이동 시간 짧은 순</option>
	</select>
</div>
        
<div class="flight_search_item_wrappper">
</div>
<div id="loadingIcon3"></div>


<script src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/flight/flight.js"></script>
<script>
// Calendar Init
$(function() {
	$("#loadingIcon3").css("display", "none");
	
	var daysOfWeek = ["일","월","화", "수","목","금","토"];
	var monthNames = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"];
	$('#date-picker').daterangepicker({
		"opens" : "left",
		"locale": {
			"format": "YYYY/MM/DD",
			"applyLabel": "적용",
			"cancelLabel": "취소",
			"fromLabel": "시작일",
			"toLabel": "종료일",
			"daysOfWeek": daysOfWeek,
			"monthNames": monthNames,
			"firstDay":0
		},
		singleDatePicker : true,
		isInvalidDate : function(date) {
			return date.isBefore(moment(), 'day');
		}
	});

	$('#date-picker2').daterangepicker({
		"opens" : "left",
		"locale": {
			"format": "YYYY/MM/DD",
			"applyLabel": "적용",
			"cancelLabel": "취소",
			"fromLabel": "시작일",
			"toLabel": "종료일",
			"daysOfWeek": daysOfWeek,
			"monthNames": monthNames,
			"firstDay":0
		},
		isInvalidDate : function(date) {
			return date.isBefore(moment(), 'day');
		}

	})
	
	let start = moment().format('YYYY-MM-DD');
	$("#date-picker").attr("placeholder", start);
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

$('#date-picker2').on('showCalendar.daterangepicker', function(ev, picker) {
	$('.daterangepicker').addClass('calendar-animated');
});
$('#date-picker2').on('show.daterangepicker', function(ev, picker) {
	$('.daterangepicker').addClass('calendar-visible');
	$('.daterangepicker').removeClass('calendar-hidden');
});
$('#date-picker2').on('hide.daterangepicker', function(ev, picker) {
	$('.daterangepicker').removeClass('calendar-visible');
	$('.daterangepicker').addClass('calendar-hidden');
});

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
</script>













