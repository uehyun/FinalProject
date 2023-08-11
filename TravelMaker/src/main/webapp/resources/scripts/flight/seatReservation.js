	var seatElements = document.getElementsByClassName("available");
	var adultCount = parseInt(document.getElementById("adultCount").value);
	var childCount = parseInt(document.getElementById("childCount").value);
	var totalSeats = adultCount + childCount;

	var personModal = document.querySelector("#personModal");
	var confirmSeatBtn = document.querySelector("#confirmSeatBtn");
	var adultRadio = document.querySelector('input[name="adultPrice"]');
	var childRadio = document.querySelector('input[name="childPrice"]');
	var seatForm = document.querySelector('#seatForm');
	var nextFBtn = document.querySelector("#nextFBtn");
	var xBtn = document.querySelector("#xBtn");
	var seatInformation = [];
	var seatInfo = document.querySelector('#seatInfo');


	var selectedSeats = [];	// 선택한 좌석 수를 담을 변수
	var seatData = null;	// 모달에서 선택한 좌석의 정보를 담을 변수
	var lastClickedSeat = null;	// 이전에 클릭한 좌석을 담을 변수

	// 좌석 선택 시
	var countSeat = 0;

	for (var i = 0; i < seatElements.length; i++) {
		seatElements[i].addEventListener("mouseover", function (event) {
			event.target.classList.add("hovered");
			
			var seatNo = event.currentTarget.getAttribute("data-seatno");
			var adultPrice = event.currentTarget.getAttribute("data-adult");
			var childPrice = event.currentTarget.getAttribute("data-child");

			var tooltip = document.createElement("div");
			tooltip.className = "tooltip";
			tooltip.innerHTML = "좌석 번호: " + seatNo + "<br>성인 금액: " + adultPrice + "원" + "<br>유소년 금액: " + childPrice + "원";

			event.currentTarget.appendChild(tooltip);

			tooltip.addEventListener("mouseout", function (event) {
				event.stopPropagation();
				tooltip.remove();
			});
		});


		seatElements[i].addEventListener("mouseout", function (event) {
			event.target.classList.remove("hovered");
			var tooltip = event.currentTarget.querySelector(".tooltip");
			if (tooltip) {
				tooltip.remove();
			}
		});
		
		
		seatElements[i].addEventListener("click", function (event) {
				var seatNo = event.currentTarget.getAttribute("data-seatno");
				var adultPrice = event.currentTarget.getAttribute("data-adult");
				var childPrice = event.currentTarget.getAttribute("data-child");

				seatInfo.innerHTML = "좌석번호: " + seatNo + "<br>성인 금액: " + adultPrice + "원" +"<br>유소년 금액: " + childPrice + "원";

			if (event.currentTarget.classList.contains("selected")) {
				personModal.style.display = "none";
				countSeat--;

				console.log("ajaj",seatForm);
				// 좌석이 이미 선택되었을 때, "selected" 클래스를 제거하고 countSeat을 하나 감소시킵니다.
				event.currentTarget.classList.remove("selected");
				console.log("cc", countSeat);
				
				for(var k = 0; k < seatInformation.length; k++){
					for(var h = 0; h < selectedSeats.length; h++){
						
						if(seatInformation[k].flightSeatNo == selectedSeats[h].dataset.seatno){
							seatInformation.indexOf(seatInformation[k]);
							seatInformation.splice(index, 1);
							
							var index = selectedSeats.indexOf(selectedSeats[h]);
							selectedSeats.splice(index, 1);
						}

					}
				}
				console.log("seatForm:", seatForm);
			} else {
				// 좌석이 선택되지 않았을 때 수행됨
				countSeat++;
				if (countSeat <= totalSeats) {
					personModal.style.display = "block";
					event.currentTarget.classList.add("selected");
					selectedSeats.push(event.currentTarget);
					console.log("l", selectedSeats.length);
				} else {
					Swal.fire({
						icon: 'error',
						title: '좌석을 선택할 수 없습니다.',
						text: '[최대 좌석수 : ' + totalSeats + ']'
					});
					event.preventDefault();
					return;
				}
			}

			// xBtn.addEventListener("click", function(event){
			// 	personModal.style.display = 'none';
			// });

			// 라디오 버튼 하나만 선택되도록
			adultRadio.addEventListener("change", function () {
				if (adultRadio.checked) {
					childRadio.checked = false;
				}
			});
			childRadio.addEventListener("change", function () {
				if (childRadio.checked) {
					adultRadio.checked = false;
				}
			});

			seatData = {
				flightSeatNo : event.currentTarget.dataset.seatno,
				adultPrice : event.currentTarget.dataset.adult,
				childPrice : event.currentTarget.dataset.child
			};
		});
	}
	
	xBtn.addEventListener('click', function(event) {
		event.stopPropagation();
		personModal.style.display = 'none';
		countSeat--;
		for (var i = 0; i < seatElements.length; i++) {
			seatElements[i].classList.remove("selected");
		}
		
	});

	console.log("abc", selectedSeats.length);

	confirmSeatBtn.addEventListener("click", function(){
			if(adultRadio.checked) {  
				var detailEle = {};
				detailEle.adultPrice = seatData.adultPrice;
				detailEle.childPrice = 0;
				detailEle.flightSeatNo = seatData.flightSeatNo;
				seatInformation.push(detailEle);
			}
			if(childRadio.checked) {
				var detailEle = {};
				detailEle.childPrice = seatData.childPrice;
				detailEle.adultPrice = 0;
				detailEle.flightSeatNo = seatData.flightSeatNo;
				seatInformation.push(detailEle);
			}
			if(!adultRadio.checked && !childRadio.checked) {
				Swal.fire({
					icon: 'error',
					title: '성인과 유소년 중 선택해주세요.'
				});
				return;
			}
		personModal.style.display = "none";
	});

	nextFBtn.addEventListener("click", function(){
		let detailDiv = $(".detailDiv");
		console.log("ddddd", detailDiv);
		for(let o =0; o < seatInformation.length; o++) {
			detailDiv.eq(o).find(".adultPrice").val(seatInformation[o].adultPrice);
			detailDiv.eq(o).find(".childPrice").val(seatInformation[o].childPrice);
			detailDiv.eq(o).find(".flightSeatNo").val(seatInformation[o].flightSeatNo);
		}
		seatForm.submit();
	});
	