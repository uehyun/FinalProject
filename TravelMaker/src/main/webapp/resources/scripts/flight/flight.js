var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

document.addEventListener('DOMContentLoaded', function() {
	var departAirport = document.querySelector('#departAirport');   // 출발공항 id값
	var arriveAirport = document.querySelector('#arriveAirport');   // 도착공항 id값
	var airportModal = document.querySelector('#airportModal');   // 츫발공항 모달
	var airportModal2 = document.querySelector('#airportModal2');   // 도착공항 모달
	var departList = document.querySelectorAll('.departP');      // 각 출발공항 p태그
	var arriveList = document.querySelectorAll('.arriveP');      // 각 도착공항 p태그
	
	var flightItemWrapper = document.querySelector('.flight_search_item_wrappper');	// 비행기 리스트 div

	var oneway = document.querySelector('#oneway');
	var twoway = document.querySelector('#twoway');
	var dateOne = document.querySelector('#date-picker');
	var dateTwo = document.querySelector('#date-picker2');

	// 왕복 버튼 클릭 이벤트
	twoway.addEventListener("click", function() {
		dateOne.style.display = 'none';
		dateTwo.style.display = 'block';

		departAirport.value = '';
		arriveAirport.value = '';

		console.log('a',flightItemWrapper);
		flightItemWrapper.style.display = 'none';
		
	});
	
	// 편도 버튼 클릭 이벤트
	oneway.addEventListener("click", function() {
		dateOne.style.display = 'block';
		dateTwo.style.display = 'none';

		departAirport.value = '';
		arriveAirport.value = '';
	});
  
	departAirport.addEventListener('click', function() {
		airportModal.style.display = 'block';
		airportModal2.style.display = 'none';
	});
	arriveAirport.addEventListener('click', function() {
		airportModal2.style.display = 'block';
		airportModal.style.display = 'none';
	});
  
	departAirport.addEventListener('input',function(){
		airportModal.style.display = 'none';
	});
	arriveAirport.addEventListener('input',function(){
		airportModal2.style.display = 'none';
	});

	// =================================================================
	arriveList.forEach(function(airport) {
		airport.addEventListener('click', function(event) {
			var airportName = this.innerText.trim();
			if (airportName != departAirport.value.trim()) {
				arriveAirport.value = airportName;
				airportModal2.style.display = 'none';
			} else {
				alert("출발 공항과 도착 공항은 같을 수 없습니다.");
				arriveAirport.value = '';
			}
		});
	});
	
	departList.forEach(function(airport) {
		airport.addEventListener('click', function(event) {
			var airportName = this.innerText.trim();
			if (airportName != arriveAirport.value.trim()) {
				departAirport.value = airportName;
				airportModal.style.display = 'none';
			} 
		});
	});

});

$(function(){
	// 도착, 출발지 검색
	$("#departAirport").off("keyup").on("keyup", function() {
		var text = $(this).val();
		  $.ajax({
			url: "/flight/searchAirport",
			type: "get",
			beforeSend: function(xhr) {
			  xhr.setRequestHeader(header, token);
			},
			data: { flightName: text },
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(result) {
			  var airportList = result.airport;
			  var modalContent = $("#airportModal").find(".modal-content");

			  if (airportList.length === 0) {
				  $("#airportModal").css("display", "none");
			  } else {
				  modalContent.empty(); // 기존 내용 지우기
				  $.each(airportList, function(index, airport) {
					var airportText = airport.airportName + " (" + airport.airportCode + ")";
					var pElement = $("<p>").addClass("departP").text(airportText);
					modalContent.append(pElement);
				});
				$("#airportModal").css("display", "block");
				adjustModalHeight();
			  }
			},
			error: function(xhr, status, error) {
			  console.log("Error:", error);
			}
		});
	});

	$(document).on("click", ".departP", function() {
		var airportName = this.innerText.trim();
		var flightType = $('.flight_tablinks.active').attr('id');
		if (airportName != departAirport.value.trim()) {
			departAirport.value = airportName;
			airportModal.style.display = 'none';
		}
		if(flightType === 'twoway'){
			departAirport.val('');
		}
	});

	$(document).on("click", ".arriveP", function() {
		var airportName = this.innerText.trim();
		var flightType = $('.flight_tablinks.active').attr('id');
		if (airportName != arriveAirport.value.trim()) {
			arriveAirport.value = airportName;
			airportModal2.style.display = 'none';
		}
		if(flightType === 'twoway'){
			arriveAirport.val('');
		}
	});

	$("#arriveAirport").off("keyup").on("keyup", function() {
		var text = $(this).val();
		  $.ajax({
			url: "/flight/searchAirport",
			type: "get",
			beforeSend: function(xhr) {
			  xhr.setRequestHeader(header, token);
			},
			data: { flightName: text },
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(result) {
			  var airportList = result.airport;
			  var modalContent = $("#airportModal2").find(".modal-content");

			  if (airportList.length === 0) {
				  $("#airportModal2").css("display", "none");
			  } else {
				  modalContent.empty(); // 기존 내용 지우기
				  $.each(airportList, function(index, airport) {
					var airportText = airport.airportName + " (" + airport.airportCode + ")";
					var pElement = $("<p>").addClass("arriveP").text(airportText);
					modalContent.append(pElement);
				});
				$("#airportModal2").css("display", "block");
				adjustModalHeight2();
			  }
			},
			error: function(xhr, status, error) {
			  console.log("Error:", error);
			}
		});
	});

	function adjustModalHeight() {
		var modalContent = $("#airportModal").find(".modal-content");
		var pElements = modalContent.find("p");
		var totalHeight = 0;
		pElements.each(function() {
		  totalHeight += $(this).outerHeight(true);
		});
		modalContent.css("max-height", totalHeight + "px");
	}

	function adjustModalHeight2() {
		var modalContent = $("#airportModal2").find(".modal-content");
		var pElements = modalContent.find("p");
		var totalHeight = 0;
		pElements.each(function() {
		  totalHeight += $(this).outerHeight(true);
		});
		modalContent.css("max-height", totalHeight + "px");
	}
	// ================================================================= 


	// 비행기 편도 검색
	let flightListBtn = $('#flightListBtn');
	let sortOptionSelect = $('#sortOption');
	let selectedOption = "";
	var startNo = 1; 		// 현재 페이지
	var itemsPerPage = 10;	// 한번에 보여줄 개수
	var isLoading = true;		// 데이터를 불러오는중인지 저장하는 변수
	var loadingIcon3 = document.querySelector('#loadingIcon3');
	var searchFlag = true;

	// 필터처리
	sortOptionSelect.on('change', function() {
		selectedOption = $(this).val();
		console.log("selectedOption: " ,selectedOption);
		resetFlightList();
	});

	// 검색버튼 누를시 비행기 목록리스트
	flightListBtn.on('click', function(){
		showFlight();
		if(searchFlag){
			$(window).scroll(function(){
				// alert("동작!");
				var windowHeight = $(window).height();
				var documentHeight = $(document).height();
				var scrollTop = $(window).scrollTop();
				
				if (scrollTop + windowHeight >= documentHeight - 50) {
					console.log("스크롤 위치가 문서의 끝 부근입니다. 추가 작업을 수행하세요.");
					setTimeout(function() {
						showFlight(); // 추가 작업 수행 (데이터 로딩 등)
						isLoading = false; // 추가 데이터 로딩 완료 표시
					}, 1000); 
				}
			});
		}
		
	})
 
	function showFlight(){
		if(!isLoading){
			return;
		}

		let departAirport = $('#departAirport').val();
		departAirport = departAirport.split('(');
		departAirport = departAirport[0];

		let arriveAirport = $('#arriveAirport').val();
		arriveAirport = arriveAirport.split('(');
		arriveAirport = arriveAirport[0];

		let datePicker = $('#date-picker').val();

		datePicker = moment(datePicker).format('YYYYMMDD');

		console.log("selectedOption: ", selectedOption);

		let fListObject = {
			departAirport : departAirport,
			arriveAirport : arriveAirport,
			flightDepartTime : datePicker,
			sortOption: selectedOption,
			startNo : startNo,
			itemsPerPage : itemsPerPage
		}
		console.log("object : ", fListObject);
		console.log("loading icon:", loadingIcon3);
		$.ajax({
			type: 'post',
			url: '/flight/flightList',
			beforeSend: function(xhr) {
				loadingIcon3.style.display = 'block';
				xhr.setRequestHeader(header, token);
			},
			data: JSON.stringify(fListObject),
			dataType: 'json',
			contentType: "application/json; charset=utf-8",
			success: function(response){
				let flightList = response;
				let flightItemWrapper = $('.flight_search_item_wrappper');
				let flightItem = "";
				let airlineImage = "";
				if(flightList.length > 0){
					flightList.forEach(function(flight){
						if(flight.flightAirline === "대한항공"){
							airlineImage = "../resources/images/daehan.png";
						}else if(flight.flightAirline === "제주항공"){
							airlineImage = "../resources/images/jeju.png";
						}else if(flight.flightAirline === "진에어"){
							airlineImage = "../resources/images/jinair.jpg";
						}else if(flight.flightAirline === "에어로케이"){
							airlineImage = "../resources/images/aerok.png";
						}else if(flight.flightAirline === "아시아나"){
							airlineImage = "../resources/images/asiana.jpg";
						}else if(flight.flightAirline === "에어부산"){
							airlineImage = "../resources/images/airbusan.jpg";
						}else if(flight.flightAirline === "이스타항공"){
							airlineImage = "../resources/images/eastar.jpg";
						}else if(flight.flightAirline === "하이에어"){
							airlineImage = "../resources/images/hiair.jpg";
						}else if(flight.flightAirline === "티웨이항공"){
							airlineImage = "../resources/images/tway.jpg";
						}else if(flight.flightAirline === "에어서울"){
							airlineImage = "../resources/images/airseoul.jpg";
						}
						
						flightItem += `
							<div class="flight_search_items">
								<div class="flight_multis_area_wrapper">
									<div class="flight_search_left">
										<div class="flight_logo">
											<img src="${airlineImage}" alt="${flight.flightAirline}" class="airlineImg">
											<p>${flight.flightAirline}</p>
										</div>
										<div class="flight_search_destination">
											<p>출발</p>
											<h4>${flight.flightDepartTime}</h4>
											<h4>${flight.departAirport}</h4>
										</div>
									</div>
									<div class="flight_search_middel">
										<div class="flight_right_arrow">
											<img src="../resources/images/arrow3.png" alt="arrow3" id="arrow3Img">
											<h6>직항</h6>
											<p>0${flight.durationHour}시간${flight.durationMinute}분</p>
										</div>
										<div class="flight_search_destination">
											<p>도착</p>
											<h4>${flight.flightArriveTime}</h4>
											<h4>${flight.arriveAirport}</h4>
										</div>
									</div>
								</div>
								<div class="flight_search_right">
									<div class="flight_reservation_price">
										<h3>₩${flight.adultPrice.toLocaleString()}</h3>
										<a href="/flight/reservation/${flight.flightNo}" class="btn btn_theme btn_sm">예약하기</a>
									</div>		
								</div>
							</div>
						`;
					});
					console.log("fList : -> ", flightList.length);
					flightItemWrapper.append(flightItem);
					startNo += flightList.length;
					console.log("startNo : ",startNo);

					console.log("icon :" , loadingIcon3);
					loadingIcon3.style.display = 'none';

					if(flightList.length === 0){
						loadingIcon3.style.display = 'none';
						isLoading = false;
					}

					if($(window).height() >= $(document).height()){
						showFlight();	// 스크롤이 없는경우 추가 데이터를 가져오기 위해
					}
				}
			},
			error: function(error) {
				console.log('Error:', error);
				isLoading = false;
			}  
		}); 
	}
	
	showFlight();

	// 필터 처리 위한 초기화 메소드
	function resetFlightList() {
		startNo = 1; // 페이지 초기화
		isLoading = true;
		$('.flight_search_item_wrappper').empty(); // 기존 비행기 목록 비우기
		showFlight(); // 새로운 검색 실행
	}

});

























