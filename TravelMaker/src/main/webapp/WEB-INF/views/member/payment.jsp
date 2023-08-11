<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/payment.css">

<div style="width: auto; margin-top: 15px; margin-bottom: 15px; min-height: 500px;">
	<div class="container">
		<div class="col-lg-12 col-md-12">
			<div class="dashboard-list-box margin-top-0">
				<div class="booking-requests-filter">
					<div class="sort-by">
						<div class="sort-by-select">
							<select data-placeholder="Default order" id="filterType" class="chosen-select-no-single" style="display: none;">
								<option value="all">전체 예약 내역</option>
								<option value="ares">숙소 예약 내역</option>
								<option value="freservation">비행기 예약 내역</option>
							</select>
						</div>
					</div>
	
					<div id="booking-date-range">
						<span></span>
					</div>
				</div>
	
				<div id="small-dialog" class="zoom-anim-dialog mfp-hide">
					<div class="small-dialog-header">
						<h3>Send Message</h3>
					</div>
					<div class="message-reply margin-top-0">
						<textarea cols="40" rows="3" placeholder="Your Message to Kathy"></textarea>
						<button class="button">Send</button>
					</div>
				</div>
	
				<h4>결제 내역</h4>
				<ul id="paymentUL">
				</ul>
			</div>
		</div>
	</div>
</div>

<a id="reviewModal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim" style="display: none;"></a>
<div id="reviewModalContent" style="display: none;"></div>

<div class="daterangepicker ltr show-ranges show-calendar opensleft calendar-animated bordered-style calendar-hidden" style="display: none; top: 253px; right: 69.9999px; left: auto;">
	<div class="ranges">
		<ul>
			<li data-range-key="오늘">오늘</li>
			<li data-range-key="어제">어제</li>
			<li data-range-key="지난 1주일">지난 1주일</li>
			<li data-range-key="지난 1달">지난 1달</li>
			<li data-range-key="이번 달" class="active">이번 달</li>
			<li data-range-key="저번 달">저번 달</li>
			<li data-range-key="직접 입력">사용자 지정</li>
		</ul>
	</div>
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
<script src="${pageContext.request.contextPath}/resources/scripts/member/payment.js"></script>