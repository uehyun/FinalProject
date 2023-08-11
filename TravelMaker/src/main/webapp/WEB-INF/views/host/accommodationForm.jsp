<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<sec:csrfMetaTags />
<style>
#container0 {
   display: flex; 
   flex-wrap: nowrap;
   margin-top: 7%;
   margin-left: 28%;
 }
  .acc_create1,
  .acc_create3 {
    flex: 1; 
  }

  .acc_create2 {
    flex: 2; 
    margin-bottom: 20px;
  }
</style>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/host/register.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" type="text/css"> --%>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=917c14ec538dd01b6e336a6f65cec511&libraries=services"></script>
<div style="display: inline-block; width: 100%; text-align: right;">
	<!-- 	<button id="saveBtn" class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-xxlarge" style="overflow:visible; margin: 7% 1.5% 0 0; height: 3rem;">저장 후 나가기</button> -->
	<button id="saveBtn"
		class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-xxlarge">저장
		후 나가기</button>
</div>
<div class="dashboard-content">
	<!-- Session0안내 시작 -->
	<div id="container0" class="con">
		<!-- 		<h1>안내 페이지 작성하는 부분</h1> -->
		<div class="acc_create1">
			<div class="acc_create2">
				<h1 class="acc_font1" tabindex="-1">간단하게 TravelMaker 호스팅을 시작할 수 있습니다</h1>
			</div>
		</div>
		<div class="acc_create3">
			<img alt="acc_create" src="${pageContext.request.contextPath}/resources/images/acc_create.png">
		</div>
	</div>

	<!-- Session1 시작 -->
	<div id="container1" class="con container1">
		<div>
			<div>
				<h3>이제 타워에 이름을 지어주세요.</h3>
				<div>숙소 이름은 짧을수록 효과적입니다. 나중에 언제든지 변경할 수 있으니, 너무 걱정하지 마세요.</div>
			</div>
			<div>
				<textarea id="accName">${acommodation.accName}</textarea>
				<div id="nCharacterCount">0/500</div>
			</div>
		</div>
		<div>
			<div>
				<h3>숙소 설명 작성하기</h3>
				<div>숙소의 특징과 장점을 알려주세요.</div>
			</div>
			<div>
				<textarea id="accContent">${acommodation.accContent}</textarea>
				<div id="dCharacterCount">0/5000</div>
			</div>
		</div>
		<button id="autoBtn" style="float:right; margin-right: 115px; border:none; background-color:white; text-decoration: underline; font-weight: 700;">자동완성</button>
	</div>

	<!-- Session2 시작 -->
	<div id="container2" class="con">
		<div id="map" style="width: 100%; height: 30rem;"></div>
		<input type="hidden" id="sample5_address"><br> <input
			type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"
			style="width: 100%;">
	</div>

	<!-- Session3 시작 -->
	<div id="container3" class="con">
		<div>
			<h2>타워 사진 추가하기</h2>
		</div>
		<div class="description">숙소 등록을 시작하려면 사진 5장을 제출하셔야 합니다. 나중에
			추가하거나 변경하실 수 있습니다.</div>

		<div class="upload-container" id="dragContainer"
			style="display: block;">
			<div>
				<i class="fa-regular fa-image"></i>
			</div>
			<div>
				<h3>여기로 사진을 끌어다 놓으세요.</h3>
			</div>
			<div>
				<p>5장 이상의 사진을 선택하세요.</p>
			</div>
			<div>
				<input type="file" id="accImage" multiple="multiple"
					accept="image/*" style="display: none;">
				<div>
					<button id="accImageBtn">기기에서 업로드</button>
				</div>
			</div>
		</div>
		<div class="upload-container2" style="display: none;">
			<!-- 
			잠시 처리 안함
			
			<div id="mainThumbnailContainer">
			</div>
			 -->
			<div id="ThumbnailContainer"></div>
			<div id="addImgBtn" style="display: inline-block;">
				<i class="fa-regular fa-plus"></i>
			</div>
		</div>
	</div>

	<!-- =================================================================================================================================================== -->
	<!-- Session4 시작 -->
	<div id="container4" class="con">
		<div>
			<h2>게스트가 사용할 숙소 유형</h2>
		</div>

		<c:forEach var="typeOption" items="${typeOptions}">

			<c:set value="accommodationTypeItem" var="typeClass" />

			<c:forEach items="${acommodation.accOption}" var="accOption">
				<c:if test="${accOption.optionNo eq typeOption.optionNo}">
					<c:set value="accommodationTypeItem checked" var="typeClass" />
				</c:if>
			</c:forEach>

			<div class="${typeClass}" data-item="${typeOption.optionNo}">
				<div>
					<h3>${typeOption.optionName}</h3>
					<div>게스트가 숙소 전체를 단독으로 사용합니다.</div>
				</div>
				<div class="right-align">
					<i class="${typeOption.attGroupNo}"></i>
				</div>
			</div>

		</c:forEach>
	</div>

	<!-- Session5 시작 -->
	<c:set var="guset" value="1" />
	<c:set var="bedRoom" value="1" />
	<c:set var="bed" value="1" />
	<c:set var="bathRoom" value="1" />
	<c:if test="${not empty acommodation}">
		<c:forEach var="accOption" items="${acommodation.accOption}">
			<c:if test="${accOption.optionNo eq 'con_001'}">
				<c:set var="guset" value="${accOption.optionCount}" />
			</c:if>
			<c:if test="${accOption.optionNo eq 'con_002'}">
				<c:set var="bedRoom" value="${accOption.optionCount}" />
			</c:if>
			<c:if test="${accOption.optionNo eq 'con_003'}">
				<c:set var="bed" value="${accOption.optionCount}" />
			</c:if>
			<c:if test="${accOption.optionNo eq 'con_004'}">
				<c:set var="bathRoom" value="${accOption.optionCount}" />
			</c:if>
		</c:forEach>
	</c:if>
	<div id="container5" class="con">
		<div>
			<h1>숙소 기본 정보를 알려주세요</h1>
			<div>침대 유형과 같은 세부 사항은 나중에 추가하실 수 있습니다.</div>
			<div class="row5">
				<div>게스트</div>
				<div>
					<div>
						<button id="guestMBtn">
							<i class="fa-solid fa-circle-minus"></i>
						</button>
					</div>
					<div>
						<span id="guestCount" data-item="con_001">${guset}</span>
					</div>
					<div>
						<button id="guestPBtn">
							<i class="fa-solid fa-circle-plus"></i>
						</button>
					</div>
				</div>
			</div>
			<hr>
			<div class="row5">
				<div>침실</div>
				<div>
					<div>
						<button id="bedRoomMBtn">
							<i class="fa-solid fa-circle-minus"></i>
						</button>
					</div>
					<div>
						<span id="bedRoomCount" data-item="con_002">${bedRoom}</span>
					</div>
					<div>
						<button id="bedRoomPBtn">
							<i class="fa-solid fa-circle-plus"></i>
						</button>
					</div>
				</div>
			</div>
			<hr>
			<div class="row5">
				<div>침대</div>
				<div>
					<div>
						<button id="bedMBtn">
							<i class="fa-solid fa-circle-minus"></i>
						</button>
					</div>
					<div>
						<span id="bedCount" data-item="con_003">${bed}</span>
					</div>
					<div>
						<button id="bedPBtn">
							<i class="fa-solid fa-circle-plus"></i>
						</button>
					</div>
				</div>
			</div>
			<hr>
			<div class="row5">
				<div>욕실</div>
				<div>
					<div>
						<button id="roomMBtn">
							<i class="fa-solid fa-circle-minus"></i>
						</button>
					</div>
					<div>
						<span id="roomCount" data-item="con_004">${bathRoom}</span>
					</div>
					<div>
						<button id="roomPBtn">
							<i class="fa-solid fa-circle-plus"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Session6 시작 -->
	<div id="container6" class="con">
		<div>
			<h1>다음 중 숙소를 가장 잘 설명한 것은 무엇인가요?</h1>
			<div>
				<c:forEach var="cotOption" items="${cotOptions}">
					<c:choose>
						<c:when test="${acommodation.accCategory eq cotOption.optionNo}">
							<div class="categoryItem">
								<button
									class="w3-button w3-white w3-border w3-border-gray w3-round-large checked"
									data-item="${cotOption.optionNo}">
									<div>
										<i class="${cotOption.attGroupNo}"></i>
									</div>
									<div>${cotOption.optionName}</div>
								</button>
							</div>
						</c:when>
						<c:otherwise>
							<div class="categoryItem">
								<button
									class="w3-button w3-white w3-border w3-border-gray w3-round-large"
									data-item="${cotOption.optionNo}">
									<div>
										<i class="${cotOption.attGroupNo}"></i>
									</div>
									<div>${cotOption.optionName}</div>
								</button>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- Session7 시작 -->
	<div id="container7" class="con">
		<div>
			<h1>숙소 편의시설 정보를 추가하세요</h1>
			<div>여기에 추가하려는 편의시설이 보이지 않더라도 걱정하지 마세요! 숙소를 등록한 후에 편의시설을 추가할 수
				있습니다.</div>
			<div>
				<c:forEach var="facOption" items="${facOptions}" varStatus="status">
					<c:set
						value="w3-button w3-white w3-border w3-border-gray w3-round-large"
						var="facClassName"></c:set>

					<c:forEach items="${acommodation.accOption}" var="accOption">
						<c:if test="${accOption.optionNo eq facOption.optionNo}">
							<c:set
								value="w3-button w3-white w3-border w3-border-gray w3-round-large checked"
								var="facClassName" />
						</c:if>
					</c:forEach>

					<div class="facilityItem">
						<button class="${facClassName}" data-item="${facOption.optionNo}">
							<div>
								<i class="${facOption.attGroupNo}"></i>
							</div>
							<div style="float: left;">${facOption.optionName }</div>
						</button>
					</div>

					<c:if test="${status.count == 8}">
						<div>
							<h3>특별히 내세울 만한 편의시설이 있나요?</h3>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div>
			<div></div>
		</div>
		<div>
			<h3>다음과 같은 안전 관련 물품이 있나요?</h3>
			<c:forEach var="secOption" items="${secOptions}">
				<c:set
					value="w3-button w3-white w3-border w3-border-gray w3-round-large"
					var="secClassName" />

				<c:forEach items="${acommodation.accOption}" var="accOption">
					<c:if test="${accOption.optionNo eq secOption.optionNo}">
						<c:set
							value="w3-button w3-white w3-border w3-border-gray w3-round-large checked"
							var="secClassName" />
					</c:if>
				</c:forEach>

				<div class="securityItem">
					<button class="${secClassName}" data-item="${secOption.optionNo}">
						<div>
							<i class="${secOption.attGroupNo}"></i>
						</div>
						<div style="float: left;">${secOption.optionName}</div>
					</button>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- Session8시작 -->
	<div id="container8" class="con">
		<div>
			<h1>이제 요금을 설정하세요</h1>
		</div>
		<div>언제든지 변경하실 수 있습니다.</div>
		<div>
			<div>
				<span><i class="fa-solid fa-won-sign"></i></span>
				<c:set value="50000" var="accPrice" />
				<c:if test="${not empty acommodation.accPrice}">
					<c:set value="${acommodation.accPrice}" var="accPrice" />
				</c:if>
				<div style="display: inline-block;">
					<input type="text" value="${accPrice}"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						id="accPrice">
				</div>
			</div>
		</div>
		<div>
			<div>
				<h1>체크인, 체크아웃 시간을 설정하세요</h1>
			</div>
			<div>
				<div>시작 시간 선택</div>
				<div>
					<select name="checkIn" id="checkIn" class="checkSelect">
						<option disabled selected>조정 가능</option>
						<option value="오전 8:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 8:00'}">selected</c:if>>오전
							8:00</option>
						<option value="오전 9:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 9:00'}">selected</c:if>>오전
							9:00</option>
						<option value="오전 10:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 10:00'}">selected</c:if>>오전
							10:00</option>
						<option value="오전 11:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 11:00'}">selected</c:if>>오전
							11:00</option>
						<option value="오전 12:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 12:00'}">selected</c:if>>오전
							12:00</option>

						<option value="오후 1:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 1:00'}">selected</c:if>>오후
							1:00</option>
						<option value="오후 2:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 2:00'}">selected</c:if>>오후
							2:00</option>
						<option value="오후 3:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 3:00'}">selected</c:if>>오후
							3:00</option>
						<option value="오후 4:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 4:00'}">selected</c:if>>오후
							4:00</option>
						<option value="오후 5:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 5:00'}">selected</c:if>>오후
							5:00</option>
						<option value="오후 6:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 6:00'}">selected</c:if>>오후
							6:00</option>
						<option value="오후 7:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 7:00'}">selected</c:if>>오후
							7:00</option>
						<option value="오후 8:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 8:00'}">selected</c:if>>오후
							8:00</option>
						<option value="오후 9:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 9:00'}">selected</c:if>>오후
							9:00</option>
						<option value="오후 10:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 10:00'}">selected</c:if>>오후
							10:00</option>
						<option value="오후 11:00"
							<c:if test="${acommodation.accStandardCheckin eq '오후 11:00'}">selected</c:if>>오후
							11:00</option>
						<option value="오전 12:00"
							<c:if test="${acommodation.accStandardCheckin eq '오전 12:00'}">selected</c:if>>오전
							12:00</option>
						<option value="오전 1:00(다음 날)"
							<c:if test="${acommodation.accStandardCheckin eq '오전 1:00(다음 날)'}">selected</c:if>>오전
							1:00(다음 날)</option>
					</select>
				</div>
			</div>
			<div>
				<div>종료 시간 선택</div>
				<div>
					<select name="checkOut" id="checkOut" class="checkSelect">
						<option disabled selected>조정 가능</option>
						<option value="오후 5:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 5:00'}">selected</c:if>>오후
							5:00</option>
						<option value="오후 6:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 6:00'}">selected</c:if>>오후
							6:00</option>
						<option value="오후 7:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 7:00'}">selected</c:if>>오후
							7:00</option>
						<option value="오후 8:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 8:00'}">selected</c:if>>오후
							8:00</option>
						<option value="오후 9:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 9:00'}">selected</c:if>>오후
							9:00</option>
						<option value="오후 10:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 10:00'}">selected</c:if>>오후
							10:00</option>
						<option value="오후 11:00"
							<c:if test="${acommodation.accStandardCheckout eq '오후 11:00'}">selected</c:if>>오후
							11:00</option>
						<option value="오전 12:00"
							<c:if test="${acommodation.accStandardCheckout eq '오전 12:00'}">selected</c:if>>오전
							12:00</option>
						<option value="오전 1:00(다음 날)"
							<c:if test="${acommodation.accStandardCheckout eq '오전 1:00(다음 날)'}">selected</c:if>>오전
							1:00(다음 날)</option>
						<option value="오전 2:00(다음 날)"
							<c:if test="${acommodation.accStandardCheckout eq '오전 2:00(다음 날)'}">selected</c:if>>오전
							2:00(다음 날)</option>
					</select>
				</div>
			</div>
		</div>
	</div>

	<!-- Session9시작 -->
	<div id="container9" class="con">
		<div>
			<div>
				<h2>예약 메시지 등록</h2>
			</div>
			<div>
				<h5>예약 시 게스트에게 보낼 메시지를 입력해주세요.</h5>
			</div>
			<div style="width: 25vw;">
				<textarea cols="7" rows="7" id="reservationMessage">숙소를 예약해 주신 것에 대해 감사드립니다!</textarea>
			</div>
		</div>
		<div style="margin: 5rem 0 0 0;">
			<h2>마지막 단계입니다!</h2>
		</div>
		<div>
			<span style="font-size: 1.3rem;">숙소에 다음 물품이 있나요?</span>
			<div style="display: inline-block; margin: 0;" id="securityModalBtn">
				<button style="border: none; background: none;">
					<i class="fa-regular fa-circle-question"></i>
				</button>
			</div>
			<div style="width: 25vw">
				<c:forEach var="danOption" items="${danOptions}">

					<c:set value="" var="isCheck" />

					<c:forEach items="${acommodation.accOption}" var="accOption">
						<c:if test="${accOption.optionNo eq danOption.optionNo}">
							<c:set value="checked" var="isCheck" />
						</c:if>
					</c:forEach>

					<div style="display: flex; justify-content: space-between;">
						<h5>${danOption.optionName}</h5>
						<label style="display: inline-block;"> <input
							type="checkbox" name="dangerItems" ${isCheck}
							value="${danOption.optionNo}"
							style="width: 2rem; height: 2rem; border-radius: 10px;">
						</label>
					</div>
				</c:forEach>
				<hr>
			</div>
		</div>
	</div>
</div>

<!-- 모달 띄어주는 부분 -->
<div id="securityModal" class="modal">
	<div class="modal-content">
		<div style="margin-bottom: 2rem;">
			<span class="close">X</span>
		</div>
		<div>보안 카메라</div>
		<p>호스트는 숙소에 설치된 모든 보안 카메라와 기타 기록 장치를 공개해야 합니다. 기록 장치를 의도적으로 숨기거나
			침실과 욕실 내부를 기록하는 장치를 설치하는 것은 금지됩니다.</p>
		<br>
		<div>무기류</div>
		<p>호스트는 숙소에 무기가 있는 경우 이 사실을 명확히 공개하고 무기를 안전하게 보관해야 합니다.</p>
		<br>
		<div>위험 동물</div>
		<p>숙소에 위험 동물(사람이나 다른 동물에게 심각한 위해를 가할 수 있는 동물)이 있는 경우, 호스트는 이 사실을
			명확히 공개해야 하며 해당 동물을 안전하게 분리할 수 있도록 위험 동물 전용 공간이 따로 마련되어 있어야 합니다.</p>
	</div>
</div>

<footer>
	<div class="w3-border">
		<div id="statusBar" class="w3-black w3-animate-width"
			style="height: 5px; width: 0%;"></div>
	</div>
	<div>
		<div class="button-container">
			<div>
				<button id="prevBtn"
					class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">뒤로</button>
				<button
					class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">메인이동</button>
			</div>
			<div>
				<button id="nextBtn"
					class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">다음</button>
			</div>
		</div>
	</div>
</footer>

<input type="hidden" id="accNo" value="${acommodation.accNo}">
<input type="hidden" id="isUpdate" value="${status}">
<input type="hidden" id="accCount" value="${accCount}">

<script>
$(function(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	let accCount = 0;
	// accCount = $("#accCount").val();

	console.log("accCount -> " + accCount);

	var accommodationTypeItemBtn = document.querySelectorAll('.accommodationTypeItem');
	for(var i=0; i<accommodationTypeItemBtn.length; i++){
		accommodationTypeItemBtn[i].addEventListener('click', function(){
			
			var checkedTypeItems = document.querySelectorAll('.accommodationTypeItem.checked');
			for(var j=0; j<checkedTypeItems.length; j++){
				checkedTypeItems[j].classList.remove('checked');
			}

			this.classList.add('checked');
		})
	}


	var buttons = document.querySelectorAll('#container6 button');
	// console.log("컨테이너6 버튼 요소 체크", buttons);
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].addEventListener('click', function() {
	    // 기존에 checked 클래스를 가진 버튼들에서 checked 클래스 제거
	    var checkedButtons = document.querySelectorAll('.categoryItem button.checked');
	    for (var j = 0; j < checkedButtons.length; j++) {
	      checkedButtons[j].classList.remove('checked');
	    }
	    
	    // 클릭한 버튼에 checked 클래스 추가
	    this.classList.add('checked');
	  });
	}

	/* 편의시설 및 안전장비 check Toggle 생성 */
	var facilityItems = document.querySelectorAll('.facilityItem');
	// console.log("편의시설 체크 : ", facilityItems);
	
	for(var i=0; i<facilityItems.length; i++){
		var buttons = facilityItems[i].getElementsByTagName('button');
		for(var j=0; j<buttons.length; j++){
			buttons[j].addEventListener('click', facilityToggleChecked);
		}
	}

	function facilityToggleChecked(){
		if(this.classList.contains('checked')){
			this.classList.remove('checked');
		} else {
			this.classList.add('checked');
		}
	}

	
	var securityItems = document.querySelectorAll('.securityItem');

	for(var i=0; i<securityItems.length; i++){
		var buttons = securityItems[i].getElementsByTagName('button');
		for(var j=0; j<buttons.length; j++){
			buttons[j].addEventListener('click', securityToggleChecked);
		}
	}

	function securityToggleChecked(){
		if(this.classList.contains('checked')){
			this.classList.remove('checked');
		} else {
			this.classList.add('checked');
		}
	}

	
	var accName = document.querySelector('#accName');
	var nCharacterCount = document.querySelector('#nCharacterCount');
	var accContent = document.querySelector('#accContent');
	var dCharacterCount = document.querySelector('#dCharacterCount');
	
	accName.addEventListener('input', function() {
		var text = this.value;
		var accCount = text.length;
		if (accCount > 500) {
	        this.value = text.slice(0, 500); // 입력된 값이 500자를 넘으면 500자까지 자르기
	        accCount = 500; // 글자 수를 500으로 설정
	    }
		nCharacterCount.innerHTML = accCount + '/500';
	});
	
	CKEDITOR.on('instanceReady', function() {
	    CKEDITOR.instances.accContent.on('change', function(event) {
	        var editor = event.editor;
	        var accContent = editor.getData();
	        var accCount = accContent.length;
	        if (accCount > 5000) {
	            accContent = accContent.slice(0, 5000);
	            editor.setData(accContent);
	            accCount = 5000;
	        }
	        dCharacterCount.innerHTML = accCount + '/5000';
	    });
	});

	var autoBtn = $("#autoBtn");

	autoBtn.on("click",function(event){
		event.preventDefault();
		console.log(CKEDITOR.instances.accContent.getData());
		accName.value = "마운틴뷰 A206호 디아크 선라이즈";
		CKEDITOR.instances.accContent.setData(`<p>안녕하세요. 저희는 다양한 휴식 공간을 연구하고 제공하는 Onda입니다. 이 곳에서 머무르실 모든 분들께서 편안하고 행복한 시간을 보내시길 바랍니다.<br />
<br />
[숙소 소개]<br />
여수에 위치한 깔끔하고 쾌적한 공간입니다.<br />
여수 바다를 보며 힐링 할 수 있는 여행을 준비해 보세요.<br />
<br />
[객실 유형]<br />
원룸형(더블1)+화장실 / East Mountain View</p>

<h3>숙소</h3>

<p>[추가침구요금]<br />
ㅁ 추가 침구 1SET : 2만원(현장결제)<br />
ㅁ 추가 침구는 인원추가요금과 별도로 과금됩니다.<br />
* 해당 숙소는 리조트입니다.<br />
* 객실 호수에 따라 뷰가 상이할 수 있습니다.<br />
<br />
[객실 이용 시 주의 사항]<br />
저희 숙소는 대나무 숲이 가까이에 있고, 뷰를 중요시하는 건축 설계상 객실 내 외부 곤충 유입이 발생될 수 있습니다.<br />
유입 곤충을 박멸할 수 있는 인체 무해하고, 국내 사용이 허가된 전용 퇴치 약품이 현존하고 있지 않아 객실 내 사전 약품 처리가 불가한 점 안내 드립니다. 안전한 객실 제공을 위해 별도 화학 약품 처리를 진행하고 있지 않은 점 안내드립니다.<br />
만일 투숙 중 객실 내 곤충(*지네)이 발견되실 경우, 바로 프런트로 연락주시면 리조트 직원이 직접 방문하여 해결해드리도록 하겠습니다.<br />
<br />
[수영장]<br />
* 수영장 크기<br />
가로 42미터 * 세로 8미터(수심 1.0 ~ 1.2M)<br />
<br />
* 수영장 위치<br />
① 스카이피니티(상시운영) : 스퀘어 패밀리동 앞<br />
② 치엘로 : 호텔동 앞<br />
※ 치엘로 수영장 변경사항 : 1월 2일까지 사용가능하나 동절기로 인한 타일바닥 살얼음으로 인하여 고객님의 안전을 위해 동선을 축소합니다.<br />
<br />
* 수영장 운영시간<br />
- 스카이인피니티 : 15:00 ~ 20:00 (상시개장)<br />
- 치엘로 : 15:00 ~ 20:00 (동계 기간 미운영)<br />
※ 치엘로는 동계기간중 운영하지 않습니다.<br />
※ &#39;스카이피니티&#39;는 상시 운영되오니 착오 없으시길 바랍니다.<br />
<br />
* 8월 1일 극성수기 수영장 관련 대여 비용<br />
① 비치타올 1장 당 2천원 대여<br />
② 수영가운 1장 당 5천원 대여<br />
③ 선베드 1개 당 1만원 대여(1박 요금)<br />
④ 데이베드 1개 당 3만원 대여(1박 요금)<br />
⑤ 수영장 팔찌 분실 시 1천원 판매<br />
<br />
※ 수영장 이용 주의사항 ※<br />
- 무료서비스 : 히노끼사우나, 튜브공기주입장치<br />
- 유료서비스(현장결제) : 구명 조끼(성인 10,000원 유아 8,000원)<br />
- 히노끼 사우나 : 체온유지를 위해 건식사우나를 함께 운영하고 있습니다.<br />
- 수영장 이용 전 지정된 부스에서 복장확인, 안전수칙전달, 손목띠(브레이스릿) 착용, 객실 호수 및 인원 확인이 진행됩니다.<br />
- 동절기에는 갑작스런 외부 기상 변화로 인해 충분한 온도가 확보되지 못 할 수도 있습니다. 이는 외부 수영장이 가지는 특징으로 투숙 고객님들의 양해 부탁드립니다.<br />
<br />
[바베큐장]<br />
① 가막비치클럽<br />
* 위치 : 로비(S)동 1층<br />
* 이용 시간<br />
- 1부 : 18:30 ~ 20:30)<br />
- 2부 : 19:30 ~ 21:30)<br />
※ 가막비치클럽은 세트상품만 이용 가능합니다.<br />
<br />
② 노을(Noel) 카바나<br />
* 위치 : 아크동 B1층<br />
* 이용 시간<br />
- 1부 : 18:00 ~ 20:00<br />
- 2부 : 20:00 ~ 22:00<br />
※ 노을 카바나는 날씨의 영향으로 운영이 중단 될수 있습니다.</p>`);
	});
	
	var guestCountElement = document.querySelector("#guestCount");
    var guestMBtn = document.querySelector("#guestMBtn");
    var guestPBtn = document.querySelector("#guestPBtn");
	var bedRoomCountElement = document.querySelector("#bedRoomCount");
    var bedRoomMBtn = document.querySelector("#bedRoomMBtn");
    var bedRoomPBtn = document.querySelector("#bedRoomPBtn");
	var bedCountElement = document.querySelector("#bedCount");
    var bedMBtn = document.querySelector("#bedMBtn");
    var bedPBtn = document.querySelector("#bedPBtn");
	var roomCountElement = document.querySelector("#roomCount");
    var roomMBtn = document.querySelector("#roomMBtn");
    var roomPBtn = document.querySelector("#roomPBtn");

    var guestCount = guestCountElement.innerHTML;
    var bedRoomCount = bedRoomCountElement.innerHTML;
    var bedCount = bedCountElement.innerHTML;
    var roomCount = roomCountElement.innerHTML;

    guestMBtn.addEventListener("click", function() {
	if (guestCount <= 1){
		return; // 1 이하일 경우 작동 중지
	}
		guestCount--;
		guestCountElement.innerHTML = guestCount;
    });
    guestPBtn.addEventListener("click", function() {
		guestCount++;
		guestCountElement.innerHTML = guestCount;
    });

    bedRoomMBtn.addEventListener("click", function() {
	if (bedRoomCount <= 1){
		return; // 1 이하일 경우 작동 중지
	}
		bedRoomCount--;
		bedRoomCountElement.innerHTML = bedRoomCount;
    });
    bedRoomPBtn.addEventListener("click", function() {
    	bedRoomCount++;
    	bedRoomCountElement.innerHTML = bedRoomCount;
    });
    
    bedMBtn.addEventListener("click", function() {
	if (bedCount <= 1){
		return; // 1 이하일 경우 작동 중지
	}
		bedCount--;
		bedCountElement.innerHTML = bedCount;
    });
    bedPBtn.addEventListener("click", function() {
    	bedCount++;
    	bedCountElement.innerHTML = bedCount;
    });

    roomMBtn.addEventListener("click", function() {
	if (roomCount <= 1){
		return; // 1 이하일 경우 작동 중지
	}
		roomCount--;
		roomCountElement.innerHTML = roomCount;
    });
    roomPBtn.addEventListener("click", function() {
    	roomCount++;
    	roomCountElement.innerHTML = roomCount;
    });
    
    
    /* 이미지 처리, 이미지 처리, 이미지 처리, 이미지 처리, 이미지 처리, 이미지 처리, 이미지 처리 */
	var uploadContainer = document.querySelector('.upload-container');
	var thumbnailContainer = document.querySelector('.upload-container2');
    var accImageBtn = document.querySelector('#accImageBtn');
    var accImage = document.querySelector('#accImage');
	var addImgBtn = document.querySelector('#addImgBtn');
	var selectedImage = [];		// 이미지 담을 배열
	var imageCount = 0;
	
	var dragContainer = document.querySelector('#dragContainer');

	function handleContainerDragOver(e) {
		e.preventDefault();
	}
	
	function handleContainerDrop(e) {
		e.preventDefault();		/* 동작 막기  */
		var files = e.dataTransfer.files;	/* 드롭된 파일 목록 가져오기 */
		accImage.files = files;		/* accImage input 요소의 files 속성에 드롭된 파일들을 할당 */
		accImage.dispatchEvent(new Event('change'));	/* change 이벤트 강제로 발생시켜 동일한 기능을 하게함 */
	}
	
	dragContainer.addEventListener('dragover', handleContainerDragOver);
	dragContainer.addEventListener('drop', handleContainerDrop);
	
	/* 파일을 누르면 저기로 실행되게... */
	accImageBtn.addEventListener('click', function() {
		accImage.click();
	});
	
	addImgBtn.addEventListener('click', function() {
		accImage.click();
	});

	/* imgDeleteBtn 클릭 시 처리 */
	function handleDeleteBtnClick(index){
		console.log("기존배열",selectedImage);
		return function(e){
			// var thumbnailImg = document.querySelector('.ThumbnailImg[data-index="' + index + '"]');
			// var thumbnailImg = document.querySelector('.ThumbnailImg:nth-child('+ (index+1) +')');
			e.target.parentElement.remove();
			selectedImage.splice(index, 1);	// 배열 제거
			console.log("지워보자 : ", selectedImage);

			if(selectedImage.length <= 0) {
				uploadContainer.style.display = 'block';
				thumbnailContainer.style.display = 'none';
			}
			
			imageCount--;
			
			if(selectedImage.length < 10){
				addImgBtn.style.display = 'block';
			}
		}
	}

	accImage.addEventListener('change', async function() {
		var files = this.files;

		uploadContainer.style.display = 'none';
		thumbnailContainer.style.display = 'block';

		for (let i = 0; i < files.length; i++) {
			var file = files[i];
			var reader = new FileReader();
	
			await new Promise((resolve, reject) => {
				reader.onload = function(e) {
					var thumbnailImg = document.createElement('div');
					thumbnailImg.style.backgroundImage = 'url(' + e.target.result + ')';
				    thumbnailImg.style.backgroundSize = 'cover'; // 이미지를 요소에 맞게 자르기
				    thumbnailImg.style.backgroundRepeat = 'no-repeat';
				    thumbnailImg.style.backgroundPosition = 'center';
	
					var imgDeleteBtn = document.createElement('span');
					imgDeleteBtn.innerHTML = 'X';
					imgDeleteBtn.className = 'imgDeleteBtn';
					thumbnailImg.appendChild(imgDeleteBtn);
	
					imgDeleteBtn.addEventListener('click', handleDeleteBtnClick(i));
					thumbnailImg.classList.add('ThumbnailImg');
	
					if (imageCount != 0) {
						thumbnailImg.style.border = '1px dotted black';
						thumbnailImg.style.width = '47%';
						thumbnailImg.style.height = '15rem';
						thumbnailImg.style.margin = '1.25% 1.25% 0 0';
						thumbnailImg.style.display = 'inline-block';
						thumbnailImg.style.position = 'relative';
					}
	
					// thumbnailImg[i].setAttribute('data-index', i);
					document.querySelector('#ThumbnailContainer').appendChild(thumbnailImg);
	
					selectedImage.push(files[i]);
					console.log("selectedImage Check -> ", selectedImage);
	
					resolve();
				};
				reader.onerror = function(e) {
					eject(e);
				};
				reader.readAsDataURL(file);
			});
			
			imageCount++;
		}
		
		console.log(selectedImage.length);
		if(selectedImage.length >= 10){
			addImgBtn.style.display = 'none';
		}
	});

    var prevBtn = document.querySelector('#prevBtn');
	var nextBtn = document.querySelector('#nextBtn');
	var container = document.querySelectorAll('.con');
	var statusBar = document.querySelector('#statusBar');
	var hostDiv = document.querySelector('#hostDiv');
	
	toggleContainer();
	
	/* 중복 insert 하는 걸 방지 한다 */
	var accRegProcess = true;

	prevBtn.addEventListener('click', function() {
		accRegProcess = false;
		console.log("prev -> " + accRegProcess + " num -> " + accCount)

		accCount--;
		nextBtn.innerHTML = "다음";
		
		// getForm(accCount);
		toggleContainer();
		statusBar.style.width = ((accCount) * 10.0) + '%';
	});
	
	var dataNo = "";
	dataNo = $("#accNo").val();
	let isUpdate = $("#isUpdate").val();
	
	CKEDITOR.replace("accContent");
	nextBtn.addEventListener('click', function() {
		var data = {};
		
		// if(isUpdate == "u") {
		// 	data.isUpdate = "true";
		// }
		
		if(accCount != 0) {
			accRegProcess = false;
		}

		if(accCount == 0) {
			// console.log("next -> " + accRegProcess + " num -> " + accCount)

		} else if(accCount == 1) {
			
			var accContent = CKEDITOR.instances.accContent.getData();
			var ext = accContent.replace(/(&nbsp;|<p>|<\/p>|\s+)/g, "");
			if(accName.value.trim() == "" || accName.value == null || ext=='' || ext == 0){
				alert("이름과 설명을 작성해주세요.");
				return false;
			}

			data.accNo = dataNo;
			data.accName = accName.value;
			data.accContent = accContent;
			
		} else if(accCount == 2) {
			if(accLatitude == null || accLogitide == null){
				alert("위치를 선택해주세요.");
				return false;
			}
			console.log(accLogitide);
			console.log(accLatitude);
			
			data.accNo = dataNo;
			data.accLatitude = accLatitude;
			data.accLogitide = accLogitide;
			data.accLocation = addr;
			data.accPostcode = postCode;

		} else if(accCount == 3){
			if(selectedImage.length < 1){
				alert("1장 이상의 사진을 선택해주세요");

				return false;
			}

			var formData = new FormData();

			for(let i=0; i<selectedImage.length; i++){
				formData.append('files', selectedImage[i]);	// 배열 이미지를 꺼내 폼 객체에 담음
			}
			
			if(isUpdate == "u") {
				formData.append('isUpdate', "true");
			}
			
			formData.append('accNo', dataNo);
			formData.append('accCount', accCount);
			
			$.ajax({
				url: '/host/imgRegister',
				type: 'post',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header,token);
				},
				data: formData,
				processData : false,
				contentType : false,
				success : function(res) {
					dataNo = res;
				}
				
			})
		} else if(accCount == 4){
			
			var checkedTypeItem = document.querySelector('.accommodationTypeItem.checked');
			/* 값이 없으면 null값 던짐 */
			var item = checkedTypeItem ? checkedTypeItem.getAttribute('data-item') : null;

			if(item == null || item == ""){
				alert("유형을 선택해주세요.");
				return false;
			}

			console.log("item -> " + item);

			var optionData = {
				'accNo' : dataNo,
				'accCount' : accCount,
				accOption: [
					{
						'accNo' : dataNo,
						'optionNo' : item,
						'optionCount' : 0
					}
				]
			}
			
			if(isUpdate == "u") {
				optionData.isUpdate = "true";
			}
			
			sendAccommodationData(optionData);
		} 
		else if(accCount == 5){

			var optionData = {
				'accNo' : dataNo,
				'accCount' : accCount,
				accOption: [
					{
						'accNo' : dataNo,
						'optionNo' : guestCountElement.getAttribute('data-item'),
						'optionCount' : guestCount
					},
					{
						'accNo' : dataNo,
						'optionNo' : bedRoomCountElement.getAttribute('data-item'),
						'optionCount' : bedRoomCount
					},
					{
						'accNo' : dataNo,
						'optionNo' : bedCountElement.getAttribute('data-item'),
						'optionCount' : bedCount
					},
					{
						'accNo' : dataNo,
						'optionNo' : roomCountElement.getAttribute('data-item'),
						'optionCount' :roomCount
					}
				]
			};
			
			if(isUpdate == "u") {
				optionData.isUpdate = "true";
			}
			
			sendAccommodationData(optionData);
		} else if(accCount == 6){
			var checkCategoryItem = document.querySelector('.categoryItem > .checked');

			var item = checkCategoryItem ? checkCategoryItem.getAttribute('data-item') : null;
			if(item == null || item == ""){
				alert("숙소의 유형을 선택해주세요.");
				return false;
			}
			
			data.accNo = dataNo;
			data.accCategory = item;
			
		} else if(accCount == 7){
			var checkedFacilityItems = document.querySelectorAll('.facilityItem .checked');
			var checkedFacilityArray = [];
			
			for(var i=0; i<checkedFacilityItems.length; i++){
				var checkedFacilityItem = checkedFacilityItems[i];

				var item = checkedFacilityItem ? checkedFacilityItem.getAttribute('data-item') : null;
				checkedFacilityArray.push(item);

			}
			console.log(checkedFacilityArray);
			
			var checkedSecurityItems = document.querySelectorAll('.securityItem .checked');
			var checkedSecurityArray = [];
			
			for(var i=0; i<checkedSecurityItems.length; i++){
				var checkedSecurityItem = checkedSecurityItems[i];

				var item = checkedSecurityItem ? checkedSecurityItem.getAttribute('data-item') : null;
				checkedSecurityArray.push(item);
			}
			console.log(checkedSecurityArray);

			console.log("1 -> " + checkedFacilityArray.length + " 2 -> " + checkedSecurityArray.length);
			if(checkedFacilityArray.length <= 0 || checkedSecurityArray.length <= 0){
				alert("편의시설, 안전시설을 1개 이상 선택해주세요.");
				return false;
			}

			var optionsData = {
				'accNo' : dataNo,
				'accCount' : accCount,
				accOption: [
				]
			};

			for(var i=0; i<checkedFacilityArray.length; i++){
				var option = {
					'accNo' : dataNo,
					'optionNo' : checkedFacilityArray[i],
					'optionCount' : 0
				}
				optionsData.accOption.push(option);
			}
			
			for(var i=0; i<checkedSecurityArray.length; i++){
				var option = {
					'accNo' : dataNo,
					'optionNo' : checkedSecurityArray[i],
					'optionCount' : 0
				}
				optionsData.accOption.push(option);
			}
			
			if(isUpdate == "u") {
				optionsData.isUpdate = "true";
			}
			
			console.log(optionsData);
			sendAccommodationData(optionsData);

		} else if(accCount == 8){
			var accPrice = document.querySelector('#accPrice');
			var checkIn = document.querySelector('#checkIn');
			var checkOut = document.querySelector('#checkOut');

			if(checkIn.value == "조정 가능" || checkOut.value == "조정 가능"){
				alert("올바른 시간을 선택해주세요.");
				return false;
			}

			console.log(accPrice.value);
			console.log(checkIn.value);
			console.log(checkOut.value);

			data.accNo = dataNo;
			data.accPrice = accPrice.value;
			data.accStandardCheckin = checkIn.value;
			data.accStandardCheckout = checkOut.value;
			
		} else if(accCount == 9){
			/* 최종 업데이트 하는 부분 */
			var reservationMessage = document.querySelector('#reservationMessage');

			if(reservationMessage.value == null || reservationMessage.value.trim() == ""){
				alert("예약 메시지를 등록해주세요.");
				return false;
			}

			console.log("reserVationMessage -> " + reservationMessage.value);

			var checkedDangerArray = [];

			var checkedDangerItems = document.querySelectorAll('input[name=dangerItems]:checked');
			for(var i=0; i<checkedDangerItems.length; i++){
				checkedDangerArray.push(checkedDangerItems[i].value);
			}

			console.log(checkedDangerArray);
			var optionsData = {
				'accNo' : dataNo,
				'accCount' : accCount,
				'accReservationMessage' : reservationMessage.value,
				accOption: [
				]
			};

			for(var i=0; i<checkedDangerArray.length; i++){
				var option = {
					'accNo' : dataNo,
					'optionNo' : checkedDangerArray[i],
					'optionCount' : 0
				}
				optionsData.accOption.push(option);
			}
			
			if(isUpdate == "u") {
				optionsData.isUpdate = "true";
			}
			
			console.log(optionsData);
			sendAccommodationData(optionsData);
		}
		
		if (accCount != 3 && accCount != 4 && accCount != 5 && accCount != 7 && accCount != 9) {
			data.accCount = accCount;
			data.accRegProcess = accRegProcess.toString();
			sendAccommodationData(data);
		}

		accCount++;
		
		toggleContainer();
		statusBar.style.width = ((accCount) * 10.0) + '%';
	});

	function sendAccommodationData(data){
		$.ajax({
			url: '/host/register',
			type: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success: function(res){
				console.log("성공", res);
				if(res == "success"){
					location.href = "/host/main";
				}

				dataNo = res;
			},
			error: function(error){
				console.log("error", error);
			}
		});
	}
	
	function toggleContainer() {
		if(accCount == 0) {
			prevBtn.style.visibility = "hidden";
		} else {
			prevBtn.style.visibility = "visible";
		}

		if (accCount == 9) {
			nextBtn.innerHTML = "완료";
		} else {
			nextBtn.innerHTML = "다음";
		}

		console.log("accCount i : ", accCount);
		for(var i=0; i<container.length; i++){
			/* console.log("accCount i", i); */
			if(i == accCount){
				container[i].style.display = 'block';
			} else{
				container[i].style.display = 'none';
			}
		}
		
		statusBar.style.width = ((accCount) * 10.0) + '%';
	}
});


/* 모달 영역 */
var securityModal = document.querySelector('#securityModal');
var securityModalBtn = document.querySelector('#securityModalBtn');
var modalXSpan = document.querySelectorAll('.close')[0];

securityModalBtn.addEventListener('click', function(){
	securityModal.style.display = "block";
	event.stopPropagation();	// 이벤트 전파를 중단시키는 메서드 -> window 객체에 리스너에 등록하여 동시에 전파되는 걸 방지해준다.
});

modalXSpan.addEventListener('click', function(){
	securityModal.style.display = "none";
});

window.addEventListener('click', function(event){
	securityModal.style.display = "none";
})


//주소 입력 로직
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
	    center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
    position: new daum.maps.LatLng(37.537187, 127.005476),
    map: map
});

var accLogitide; 
var accLatitude;
var addr;
var postCode;
function sample5_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
		    mapContainer.style.display = "none";
            addr = data.address; // 최종 주소 변수
			postCode = data.zonecode;

            // 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample5_address").value = addr;
            // 주소로 상세 정보를 검색
            geocoder.addressSearch(data.address, function(results, status) {
                // 정상적으로 검색이 완료됐으면
                if (status === daum.maps.services.Status.OK) {

                    var result = results[0]; //첫번째 결과의 값을 활용

                    // 해당 주소에 대한 좌표를 받아서
                    var coords = new daum.maps.LatLng(result.y, result.x);
					console.log("addr : " + addr);
					console.log("zonecode : " + postCode);
					console.log("경도 : " + coords.La);
					console.log("위도 : " + coords.Ma);
					accLatitude = coords.La;
					accLogitide = coords.Ma;
                    // 지도를 보여준다.
                    mapContainer.style.display = "block";
                    map.relayout();
                    // 지도 중심을 변경한다.
                    map.setCenter(coords);
                    // 마커를 결과값으로 받은 위치로 옮긴다.
                    marker.setPosition(coords)
                }
            });
        }
    }).open();
}

</script>
