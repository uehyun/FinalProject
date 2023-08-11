<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:csrfMetaTags/>
<style>
#tripList {
	display: flex;
	align-items: center;
	font-size : 2em;
}

#tripList a {
	align-items: right;
	margin-left: auto;
	width : 125px;
}
.dashboard-list-box {
	margin-bottom : 20px;
}
#myFile {
	border : 3px dashed gray;
	width: 100%; 
	height: 200px; 
	border-radius: 5px; 
	text-align: center;
	padding-top: 40px;
	align-items: center;
}
.travelTitle {
	font-size: 2.5em;
	font-weight: bold;
}
.travelImg {
	border-radius: 7px;
}
.dashboard-list-box .button {
	background-color: transparent;
	font-size: 15px;
	color : gray;
	text-decoration: underline;
}
.button:hover {
	color : red;
}
.addButton {
	border : none;
	background-color: transparent;
	font-size: 17px;
	color : gray;
	text-decoration: underline;
	font-weight : 700;
}
.addButton:hover {
	color: red;
}
</style>

<!-- Sign In Popup -->
<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">

	<div class="small-dialog-header">
		<h3>여행경로 추가</h3>
	</div>

	<!--Tabs -->
	<div class="sign-in-form style-1">


		<div class="tabs-container alt">

			<!-- Login -->
			<div class="tab-content" id="tab1" style="display: none;">
				<form method="post" action="/member/addTrip" id="addTrip" enctype="multipart/form-data">

					<p class="form-row form-row-wide">
						<input type="text" class="input-text" name="travelName" id="travelName" value="" placeholder="여행 이름" />
					</p>
						<div id="booking-date-range">
							<span>날짜를 선택해주세요</span>
						</div>
						<br/>
						<hr/>
						<div id="myFile" ondragover="fdover()" ondrop="fdrop()">
							<img src="${pageContext.request.contextPath}/resources/images/fileImg.png" style="width:70px; height: 70px;"><br/>
							<span style="color:gray; font-weight: bold;">사진을 올려주세요.</span>
						</div>
					<hr/>
					<div class="form-row">
						<input type="hidden" name="travelStartDate" id="travelStartDate" value=""/>
						<input type="hidden" name="travelEndDate" id="travelEndDate" value=""/>
						<sec:csrfInput/>
						<button class="addButton" id="btnAdd" style="float:right;">새로 만들기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- Sign In Popup / End -->

<div class="container">
	<div class="dashboard-list-box">
		<h4 id="tripList">나만의 여행 경로<a href="#sign-in-dialog" class="sign-in popup-with-zoom-anim"><button class="addButton" style="margin-left: 45px;">추가하기</button></a></h4>
		<ul class="tripList">
			<c:forEach items="${tripList }" var="trip">
				<li>
					<div class="list-box-listing" data-travelno="${trip.travelNo }" data-travelStartDate="${trip.travelStartDate }">
						<div class="list-box-listing-img">
							<img class="travelImg" src="${pageContext.request.contextPath}${trip.travelImgPath }">
						</div>
						<div class="list-box-listing-content">
							<div class="inner">
								<h3 class="travelTitle">${trip.travelName }</h3>
								<span>${trip.travelStartDate } - ${trip.travelEndDate }</span>
							</div>
						</div>
						<button class="button">삭제</button>
					</div>
				</li>
			</c:forEach>
		</ul>
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

<script src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/daterangepicker.js"></script>
<script>
var contextPath = "${pageContext.request.contextPath}";

function fdover() {
	event.preventDefault();
}

function fdrop() {
	myFile.style.paddingTop = "0px";
	myFile.style.border = "none";
	event.preventDefault();
	files = event.dataTransfer.files;
	myFile.innerHTML = "";
	for(var i=0; i<files.length; i++) {
		OneFileRead(files[i]);
	}
}
</script>
<script src="${pageContext.request.contextPath}/resources/scripts/trip/trip.js"></script>