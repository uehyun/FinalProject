<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/host/manage.css">
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>

<div id="dashboard">
	<div class="dashboard-content"
		style="margin-left: 10%; margin-right: 10%;">
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-md-12">
				<div>
					<div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
						<h2 style="margin: 0;">${member.memName}, 반갑습니다.</h2>
						<div style="display: flex; align-items: center; justify-content: center; padding: 3px;">
							<button type="button" style="align-items: center;" id="addAcc">
								<span>
									<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
										style="height: 100%; width: 16px; fill: #222222; margin-right: 0; margin-bottom: 5px; vertical-align: middle;"
										aria-hidden="true" role="presentation" focusable="false">
										<path d="M18 4v10h10v4H18v10h-4V18H4v-4h10V4z"></path>
									</svg>
									숙소 새로 등록하기
								</span>
							</button>
						</div>
					</div>
					<div style="padding: 3px;">
						<div style="float: right;">
							<button type="button" style="align-items: center;" id="accInactive">
								<span>
									숙소 비활성화
								</span>
							</button>
						</div>
						<div style="float: right; margin-right: 10px;">
							<button type="button" style="align-items: center;" id="accActive">
								<span>
									숙소 활성화
								</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row" style="margin-bottom: 30px;">
			<div class="col-md-12" style="display: flex;">
			
				<div class="input-container">
					<div style="margin-left: 10px;">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
							aria-hidden="true" role="presentation" focusable="false" id="searchIcon">
			          		<path fill="none" d="M13 24a11 11 0 1 0 0-22 11 11 0 0 0 0 22zm8-3 9 9"></path>
			        	</svg>
					</div>
					<div style="height: 30px;">
						<div>
							<input aria-label="검색" id="search" type="text"	placeholder="숙소 검색" value="">
						</div>
					</div>
				</div>
				
				<div class="input-container filter">
					<span class="filterName">침실 및 침대</span>
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
						aria-hidden="true" role="presentation" focusable="false"
						style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
						<path fill="none" d="M28 12 16.7 23.3a1 1 0 0 1-1.4 0L4 12"></path>
					</svg>
					<div class="filterOption room">
						<div class="qtyButtons">
							<div class="qtyTitle">침실</div>
							<div class="minusBtn"><i class="fa-solid fa-minus"></i></div>
							<input type="text" id="qtyBedRoom" value="1">
							<div class="plusBtn"><i class="fa-solid fa-plus"></i></div>
						</div>
						<div class="qtyButtons">
							<div class="qtyTitle">침대</div>
							<div class="minusBtn"><i class="fa-solid fa-minus"></i></div>
							<input type="text" id="qtyBed" value="1">
							<div class="plusBtn"><i class="fa-solid fa-plus"></i></div>
						</div>
						<div class="qtyButtons">
							<div class="qtyTitle">욕실</div>
							<div class="minusBtn"><i class="fa-solid fa-minus"></i></div>
							<input type="text" id="qtyBathRoom" value="1">
							<div class="plusBtn"><i class="fa-solid fa-plus"></i></div>
						</div>
						<hr>
						<button type="button" id="roomApply">적용하기</button>
					</div>
				</div>
				
				<div class="input-container filter">
					<span class="filterName">편의시설</span>
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
						aria-hidden="true" role="presentation" focusable="false"
						style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
						<path fill="none" d="M28 12 16.7 23.3a1 1 0 0 1-1.4 0L4 12"></path>
					</svg>
					<div class="filterOption convenience">
						<div style="float: left;">
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_001" data-type="무선 인터넷">
								<span>무선 인터넷</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_002" data-type="TV">
								<span>TV</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_003" data-type="주방">
								<span>주방</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_004" data-type="세탁기">
								<span>세탁기</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_005" data-type="건물 내 무료 주차">
								<span>건물 내 무료 주차</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_007" data-type="에어컨">
								<span>에어컨</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_009" data-type="수영장">
								<span>수영장</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_010" data-type="온수 욕조">
								<span>온수 욕조</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_011" data-type="파티오">
								<span>파티오</span>
							</div>
						</div>
						
						<div style="float: right;">
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_012" data-type="바비큐 그릴">
								<span>바비큐 그릴</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_013" data-type="야외 식사 공간">
								<span>야외 식사 공간</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_014" data-type="화로">
								<span>화로</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_015" data-type="당구대">
								<span>당구대</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_016" data-type="실내 벽난로">
								<span>실내 벽난로</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_018" data-type="운동 기구">
								<span>운동 기구</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_019" data-type="호수로 연결됨">
								<span>호수로 연결됨</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_020" data-type="해변과 인접">
								<span>해변과 인접</span>
							</div>
							<div style="display: flex; justify-content: stretch; align-items: center;">
								<input type="checkbox" class="convenienceCheck" value="fac_021" data-type="스키를 탄 채로 출입">
								<span>스키를 탄 채로 출입</span>
							</div>
						</div>
						<div style="display: block;">
							<hr style="margin-top: 260px;">
							<button type="button" id="convenienceApply">적용하기</button>
						</div>
					</div>
				</div>
				
				<div class="input-container filter">
					<span class="filterName">숙소상태</span>
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
						aria-hidden="true" role="presentation" focusable="false"
						style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
						<path fill="none" d="M28 12 16.7 23.3a1 1 0 0 1-1.4 0L4 12"></path>
					</svg>
					<div class="filterOption accStatus">
						<div style="display: flex; justify-content: stretch; align-items: center;">
							<input type="checkbox" name="status" class="accStatusCheck" value="활성">
							<span>운영 중</span>
						</div>
						<div style="display: flex; justify-content: stretch; align-items: center;">
							<input type="checkbox" name="status" class="accStatusCheck" value="비활성">
							<span>운영 중지</span>
						</div>
						<div style="display: flex; justify-content: stretch; align-items: center;">
							<input type="checkbox" name="status" class="accStatusCheck" value="미완성">
							<span>등록 중</span>
						</div>
						<hr>
						<button type="button" id="statusApply">적용하기</button>
					</div>
				</div>
				
				<span id="resetFilter">필터 초기화</span>
			</div>
		</div>
		
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-md-12">
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheck"></th>
							<th><span>숙소</span></th>
							<th>상태</th>
							<th style="width: 13%;">필요한 조치</th>
							<th>침실</th>
							<th>침대</th>
							<th>욕실</th>
							<th>위치</th>
							<th>등록 일자</th>
						</tr>
					</thead>
					<tbody id="tbodyObj">
						
					</tbody>
				</table>
				
				<div style="margin-top: 50px; display: none;" id="noResult"></div>
				
				<div class="loading-icon" style="display: none; text-align: center; margin-top: 50px;">
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/host/manage.js"></script>
