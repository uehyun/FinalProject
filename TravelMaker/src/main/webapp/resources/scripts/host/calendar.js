let accData = {};
let eventNo = "";
let ownDiscount = [];
window.addEventListener('DOMContentLoaded', function() {
	$("#shgAccSelect").on("change", function() {
		getAccReservation($(this).val());
	});

	let date = new Date();
	let accNo = document.querySelector("#shgAccSelect").value;

	let percentSpan = $(".shgcalendarspan");

	getAccReservation(accNo);
	
	function getAccReservation(accNo) {
		let header = document.querySelector("meta[name='_csrf_header']").content;
		let token = document.querySelector("meta[name='_csrf']").content;
		
		let data = {
			accNo: accNo
		};

		console.log(accNo);
		var xhr = new XMLHttpRequest();
		xhr.open("post", "/host/getAllReservation", true);
		xhr.setRequestHeader(header, token);
		xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
		xhr.onreadystatechange = function() {
			if(xhr.status == 200 && xhr.readyState == 4) {
				let result = JSON.parse(xhr.responseText);

				accData = result;
				eventNo = "";
				ownDiscount = result.eventList;

				if(result.eventNo) {
					eventNo = result.eventNo;
					$("#eventModalDiv").show();	
				} else {
					$("#eventModalDiv").hide();
				}

				for(let i = 0; i < result.accReservationList.length; i++) {
					let r = Math.floor(Math.random() * 256);
					let g = Math.floor(Math.random() * 256);
					let b = Math.floor(Math.random() * 256);
					result.accReservationList[i].COLOR = `rgba(${r}, ${g}, ${b}, 0.5)`;
				}

				if(result.eventList[0].discountRate == 0) {
					percentSpan.eq(0).text(result.eventList[0].discountRate + "%");
					$(".eventPrice").eq(0).text("할인을 설정해보세요.");
				} else {
					percentSpan.eq(0).text(result.eventList[0].discountRate + "%");
					let discountWeekPrice = Number(Math.round((100 - result.eventList[0].discountRate) / 100 * 7 * result.accPrice)).toLocaleString();
					$(".eventPrice").eq(0).text("주 평균 요금은 ￦" + discountWeekPrice + "입니다.");
				}

				if(result.eventList[1].discountRate == 0) {
					percentSpan.eq(1).text(result.eventList[1].discountRate + "%");
					$(".eventPrice").eq(1).text("할인을 설정해보세요.");
				} else {
					percentSpan.eq(1).text(result.eventList[1].discountRate + "%");
					let discountMonthPrice = Number(Math.round((100 - result.eventList[1].discountRate) / 100 * 28 * result.accPrice)).toLocaleString();
					$(".eventPrice").eq(1).text("월 평균 요금은 ￦" + discountMonthPrice + "입니다.");
				}

				makeCalendar(date);
			}
		}

		xhr.send(JSON.stringify(data));
	}

	function makeCalendar(date) {
		const today = moment();

		const currentYear = new Date(date).getFullYear();
		const currentMonth = new Date(date).getMonth() + 1;

		const firstDay = new Date(date.setDate(1)).getDay();
		const lastDay = new Date(currentYear, currentMonth, 0).getDate();

		const limitDay = firstDay + lastDay;
		const nextDay = Math.ceil(limitDay / 7) * 7;
	
		let str = "";
		
		for(let i = 0; i < firstDay; i++) {
			str += "<div class='noCurrent'></div>";
		}
		
		for(let i = 1; i <= lastDay; i++) {
			let myDate = moment(new Date(currentYear, currentMonth - 1, i));
			
			let isScheduled = false;
			let invalid = false;

			for(let j = 0; j < accData.accReservationList.length; j++) {
				let checkinDate = moment(accData.accReservationList[j].aresCheckinDate);
			    let checkoutDate = moment(accData.accReservationList[j].aresCheckoutDate);
				
			    if(myDate.isBetween(checkinDate, checkoutDate, null, '[]')) {
			        isScheduled = true;
			    	
			    	if(myDate.isBefore(moment())) {
					    classNames = 'noCurrent';
					} else {
						classNames = "day";
					}
			    	
			    	let scheduleHTML = `
						<div class="schedule" data-aresno="${accData.accReservationList[j].aresNo}" style="background: ${accData.accReservationList[j].COLOR};">
			    			예약됨
			    		</div>
			    	`;
			    	
					if (str.includes(`<font>${i}</font>`)) {
						str = str.replace(`<font>${i}</font>`, `<font>${i}</font>${scheduleHTML}`);
					} else {
						str += `
							<div class="${classNames}">
								<font>${i}</font>
								${scheduleHTML}
							</div>
						`;
					}
  			    }
			}

			for(let j = 0; j < accData.invalidDate.length; j++) {
				if(accData.invalidDate[j].includes(myDate.format("YYYY-MM-DD"))) {
					invalid = true;
				}
			}
			
			//스케줄이 아니고 불가능날짜일때
			if (!isScheduled && invalid) {
				if(myDate.isBefore(moment())) {
					str += "<div class='noCurrent invalid'><font>" + i + "</font></div>";
				} else {
					str += "<div class='day invalid'><font>" + i + "</font></div>";
				}
			} else if(!isScheduled) {	//불가능날짜는아니고 스케줄날짜도 아닐때
				if(myDate.isBefore(moment())) {
					str += "<div class='noCurrent'><font>" + i + "</font></div>";
				} else {
					str += "<div class='day'><font>" + i + "</font></div>";
				}
			}

			if(today.isSame(myDate, 'day')) {
				str = str.replace(`<font>${i}</font>`, `<font>${i} <span style="font-size: 1.5rem;">&nbsp;&nbsp;&nbsp;오늘</span></font>`)
			}
		} 
		
		for(let i = limitDay; i < nextDay; i++) {
			str += "<div class='noCurrent'></div>";
		}

		document.querySelector(".dateBoard").innerHTML = str;
		document.querySelector(".dateTitle").innerText = currentYear + "." + currentMonth;
	}
	
	document.querySelector(".prevDay").addEventListener("click", function() {
		makeCalendar(new Date(date.setMonth(date.getMonth() - 1)));
	});

	document.querySelector(".nextDay").addEventListener("click", function() {
		makeCalendar(new Date(date.setMonth(date.getMonth() + 1)));
	});

	$("#eventModalDiv").on("click", function() {
		let header = document.querySelector("meta[name='_csrf_header']").content;
		let token = document.querySelector("meta[name='_csrf']").content;
		
		var xhr = new XMLHttpRequest();
		xhr.open("get", "/host/selectEvent?eventNo=" + eventNo, true);
		xhr.setRequestHeader(header, token);
		xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
		xhr.onreadystatechange = function() {
			if(xhr.status == 200 && xhr.readyState == 4) {
				let result = JSON.parse(xhr.responseText);
				console.log(result);

				let str = ``;

				if(result != null) {
					str += `
					<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
						<div class="small-dialog-header" style="display:flex; flex-direction: column;">
							<span style="color: red; font-weight: 1000;">${result.eventTitle}</span>
						</div>
						<div id="eventDateInfo">
							<span style="font-weight: 700; text-align: center; font-size: 23px;">이벤트의 할인율은 Travel Maker에서 지원해드립니다.</span>
							<div id="countdown" class="margin-top-10 margin-bottom-35">
							</div>
						</div>
						<div class="sign-in-form style-1" style="display: flex; justify-content: center;">
							<table style="width:60%">
								<tr>
									<td colspan="2">
										<span class="memName">이벤트 정보</span>
									</td>
								</tr
								<tr>
									<td class="memInfo">시작일</td>
									<td>${result.eventStartDate}</td>
								</tr>
								<tr>
									<td class="memInfo">종료일</td>
									<td>${result.eventEndDate}</td>
								</tr>
								<tr>
									<td class="memInfo">할인율</td>
									<td>${result.eventDiscountRate}%</td>
								</tr>
								<tr>
									<td colspan="2"><button id="participateEvent">이벤트 참여하기</button></td>
								</tr>
							</table>
						</div>
					</div>
					`;

					$("#eventContent").html(str);
					$("#eventModal").click();
					createCountDown(result.eventEndDate);
				}
			}
		};
	
		xhr.send();
	});

	function createCountDown(endDate) {
		$("#countdown").countdown(endDate, function(event) {
			var $this = $(this).html(event.strftime(''
				+ '<div style="display: flex; align-items: center"><span>%D</span>  <i>일</i></div>'
				+ '<div style="display: flex; align-items: center"><span>%H</span> <i>시간</i></div> '
				+ '<div style="display: flex; align-items: center"><span>%M</span> <i>분</i></div> '
				+ '<div style="display: flex; align-items: center"><span>%S</span> <i>초</i></div>'
			));
		});
	}

	$(document).on("click", "#participateEvent", function() {
		console.log(accData.accNo);
		console.log(eventNo);

		if(accData.accNo == null || accData.accNo == "") {
			return false;
		}

		if(eventNo == null || eventNo == "") {
			return false;
		}

		let header = document.querySelector("meta[name='_csrf_header']").content;
		let token = document.querySelector("meta[name='_csrf']").content;
		
		let data = {
			accNo: accData.accNo,
			eventNo: eventNo
		};

		var xhr = new XMLHttpRequest();
		xhr.open("post", "/host/participateEvent", true);
		xhr.setRequestHeader(header, token);
		xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
		xhr.onreadystatechange = function() {
			if(xhr.status == 200 && xhr.readyState == 4) {
				let result = JSON.parse(xhr.responseText);
				console.log(result);

				if(result == "OK") {
					swal("이벤트에 참여하셨습니다.", "", "success");
					$(".mfp-close").click();
				} else {
					swal("이미 이벤트에 참여중이거나 마감된 이벤트입니다.", "", "error");
					$(".mfp-close").click();
				}
			}
		}
		xhr.send(JSON.stringify(data));
	});
});

//토글 버튼
const toggle = document.querySelector(".toggleSwitch");

toggle.addEventListener("click", function() {
	let invalidDate = document.querySelector("#dayH4").innerText;
	let accNo = document.querySelector("#shgAccSelect").value;

	if(accNo == null || accNo == "") {
		swal("숙소를 선택해주세요.", "", "error");
		return false;
	}

	if(invalidDate == null || invalidDate == "") {
		swal("날짜를 선택해주세요.", "", "error");
		return false;
	}

	this.classList.toggle("active");

	let data = {
		accNo: accNo,
		invalidDate: invalidDate
	};

	//active ==> 불가능
	let fontEle = this.querySelector("font");
	if(this.classList.contains("active")) {
	    fontEle.innerText = "예약 차단";
	    fontEle.style.color = "black";
		data.status = "invalid";
	} else {
		fontEle.innerText = "예약 가능";
		fontEle.style.color = "white";
		data.status = "valid";
	}

	updateInvalid(data);
});

function updateInvalid(data) {
	console.log("inv", data);
	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

	var xhr = new XMLHttpRequest();
	xhr.open("post", "/host/updateInvalid", true);
	xhr.setRequestHeader(header, token);
	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let res = JSON.parse(xhr.responseText);

			if(res == "OK") {
				swal("업데이트 되었습니다.", "", "success");

				let yearMonth = $(".dateTitle").text();
				let days = $(".day");
	
				for(let i = 0; i < days.length; i++) {
					let day = days.eq(i).find("font").text();
					let formattedDate = moment(`${yearMonth}-${day.toString().padStart(2, '0')}`, 'YYYY.MM-DD').format('YYYY-MM-DD');
	
					if(data.invalidDate == formattedDate) {
						if(data.status == "invalid") {
							days.eq(i).addClass("invalid");
						} else {
							days.eq(i).removeClass("invalid");
						}
					}
				}
			} else {
				swal("업데이트를 실패했습니다.", "", "error");
			}
		}
	}

	xhr.send(JSON.stringify(data));
}
//토글 버튼


//시커바
const myCircle = document.querySelector("#circle");
dragElement(myCircle);

function dragElement(elmnt) {
  	let clientX_gab = 0, clientX = 0;
  	let leftVal = 0;
  	
  	elmnt.onmousedown = dragMouseDown;
  	
  	function dragMouseDown(e) {
	    e = e || window.event;
	    e.preventDefault();
	    clientX = e.clientX;
	    document.onmouseup = closeDragElement;
	    document.onmousemove = elementDrag;
	}

  	function elementDrag(e) {
	    e = e || window.event;
	    e.preventDefault();
	    
	    clientX_gab = e.clientX - clientX;
	    clientX = e.clientX;
	    
	    let parentElmnt = elmnt.parentNode;
	    
	    if((elmnt.offsetLeft + clientX_gab) < 0 || clientX < parentElmnt.offsetLeft) {
	        leftVal = 0;
	    } else if((elmnt.offsetLeft + clientX_gab) > parentElmnt.clientWidth || clientX - 50 > (parentElmnt.offsetLeft + parentElmnt.clientWidth)) {
	    	leftVal = parentElmnt.clientWidth;
	    } else {
	        leftVal = (elmnt.offsetLeft + clientX_gab);
	    } 
		
		var percentage = Math.round((leftVal / parentElmnt.clientWidth) * 50);

	    inputDiv.innerText = percentage;
	    elmnt.style.left = leftVal + "px";
	}

	function closeDragElement() {
	    document.onmouseup = null;
	    document.onmousemove = null;
	}
}

let inputDiv = document.getElementById("inputDiv");

inputDiv.oninput = function () {
    let percentage = parseInt(this.innerText);
    
    if(isNaN(percentage) || percentage < 0) {
        percentage = 0;
    } else if (percentage > 50) {
        percentage = 50;
    }
    
    updatePosition(percentage); 
};

function updatePosition(percentage) {
	let parentElmnt = myCircle.parentNode;
	
	if(percentage == 50) {
		leftVal = parentElmnt.clientWidth;
	} else if(percentage == 0) {
		leftVal = 0;
	} else {
		let parentWidth = parentElmnt.clientWidth;
		let circleWidth = myCircle.clientWidth;
		leftVal = (parentWidth * (percentage / 50)) - (circleWidth / 2);
	}

	myCircle.style.left = leftVal + "px";
}
//시커바

//블록 보여주기
let bigBlock = $("#bigBlock");
let myEventBlock = $("#myEventBlock");
let eventDiv = $(".eventDiv");

let discountBlock = $("#discountBlock");
let discountName = $("#discountName");
let discountTip = $("#discountTip");

let basicBlock = $("#basicBlock");

let reservationBlock = $("#reservationBlock");

let cancelBtn = $(".cancel");
let okBtn = $(".ok");

bigBlock.show();
reservationBlock.hide();

$(document).on("click", ".day", function() {
	let yearMonth = $(".dateTitle").text();
	let day = $(this).find("font").text();
	
	let formattedDate = moment(`${yearMonth}-${day.toString().padStart(2, '0')}`, 'YYYY.MM-DD').format('YYYY-MM-DD');
	
	$("#dayH4").text(formattedDate);
	
	resetBorder();
	$(this).css("border", "3px solid black");

	let toggleFont = toggle.querySelector("font");

	console.log(toggleFont);

	if($(this).attr("class") == "day invalid") {
		toggle.classList.add("active");
		toggleFont.innerText = "예약 차단";
	    toggleFont.style.color = "black";
	} else {
		toggle.classList.remove("active");
		toggleFont.innerText = "예약 가능";
	    toggleFont.style.color = "white";
	}

	bigBlock.show();
	reservationBlock.hide();
});

function resetBorder() {
	let daysDiv = $(".day");

	for(let i = 0; i < daysDiv.length; i++) {
		daysDiv.eq(i).css("border", "1px solid #eee");
	}
}

eventDiv.on("click", function() {
	let text = $(this).children("h5").text();
	discountName.text(text + "할인");

	if(text == "주간") {
		discountTip.text("팁: 주 단위 숙박을 유치하려면 10%로 설정해보세요");
	} else {
		discountTip.text("팁: 월 단위 숙박을 유치하려면 20%로 설정해보세요");
	}

	let percent = $(this).find(".shgcalendarspan").text().split("%")[0];
	
	inputDiv.innerText = percent;
	setTimeout(function() { updatePosition(parseInt(percent)) }, 100);

	myEventBlock.hide();
	discountBlock.show();
});

$(document).on("click", ".schedule", function(event) {
	event.stopPropagation();
	
	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

	let aresNo = $(this).data("aresno");

	var xhr = new XMLHttpRequest();
	xhr.open("get", "/host/accReservationDetail/" + aresNo, true);
	xhr.setRequestHeader(header, token);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			
			let totalPrice = Number(result.TOTAL).toLocaleString();
			
			let str = `
				<a href=#>
					<img src="${result.attPath}"/>
				</a>
				
				<p style="text-align: center;">${result.ACCNAME}</p>
	
				<div style="margin-top: 10px; display : flex; border-top: 1px solid gainsboro; border-bottom: 1px solid gainsboro; align-items: center;">
					<div class="checkinDiv">
						<p>체크인</p>
						<div>
							${result.CHECKINDATE}<br/>
							${result.CHECKINTIME}
						</div>
					</div>
					<div class="checkoutDiv">
						<p>체크아웃</p>
						<div>
							${result.CHECKOUTDATE}<br/>
							${result.CHECKOUTTIME}
						</div>
					</div>
				</div>
	
				<h3>예약 세부정보</h3>
				<div id="reservationDetailDiv">
					<img src="${result.MEMPROFILEPATH}" style="width: 60px; height: 60px; border-radius: 50%;">
					<div style="margin-top: 10px;">
						<span>아이디: ${result.MEMID}</span><br>
						<span>이메일: ${result.MEMEMAIL}</span><br>
						<span>전화번호: ${result.MEMPHONE}</span><br>
						<span>게스트 ${result.GUESTCOUNT}명</span>
					</div>
					<a href="/main/detail/${result.ACCNO}" id="goAccDetail" style="margin-bottom: 20px; margin-top: 10px;">
						<i class="fa-solid fa-house-chimney-user"></i>&nbsp; 
						<span>숙소 바로가기</span>
					</a>
				</div>
	
				<h3>결제 정보</h3>
				<div style="display: flex; align-items: center; text-align: center; flex-direction: column;">
					<p>총 비용 : ￦${totalPrice}</p>
					<a href="/payment/receipt?paymentNo=${result.PAYMENTNO}&type=acc" id="recipt"><i class="fa-solid fa-receipt"></i>&nbsp;  <span>영수증</span></a>
					<a id="registerReview" style="margin-top: 10px;" data-memno="${result.MEMNO}" data-accno="${result.ACCNO}"><i class="sl sl-icon-note"></i> 후기 남기기</a>
				</div>`;

			reservationBlock.html(str);
		}
	}

	xhr.send();
	
	bigBlock.hide();
	reservationBlock.show();
});
//블록 보여주기

//이벤트
function updateEvent(data) {
	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

	var xhr = new XMLHttpRequest();
	xhr.open("post", "/host/updateEvent", true);
	xhr.setRequestHeader(header, token);
	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
	xhr.onreadystatechange = function() {
		if(xhr.status == 200 && xhr.readyState == 4) {
			let result = JSON.parse(xhr.responseText); 
			console.log(result);

			let percentSpan = $(".shgcalendarspan");

			if(result == "OK") {
				swal("이벤트가 업데이트 되었습니다.", "", "success");

				if(data.discountType == "WEEK") {
					ownDiscount[0].discountRate = data.discountRate;
					if(data.discountRate == 0) {
						percentSpan.eq(0).text(data.discountRate + "%");
						$(".eventPrice").eq(0).text("할인을 설정해보세요.");
					} else {
						percentSpan.eq(0).text(data.discountRate + "%");
						let discountWeekPrice = Number(Math.round((100 - data.discountRate) / 100 * 7 * accData.accPrice)).toLocaleString();
						$(".eventPrice").eq(0).text("주 평균 요금은 ￦" + discountWeekPrice + "입니다.");
					}
				} else if(data.discountType == "MONTH") {
					ownDiscount[1].discountRate = data.discountRate;
					if(data.discountRate == 0) {
						percentSpan.eq(1).text(data.discountRate + "%");
						$(".eventPrice").eq(1).text("할인을 설정해보세요.");
					} else {
						percentSpan.eq(1).text(data.discountRate + "%");
						let discountMonthPrice = Number(Math.round((100 - data.discountRate) / 100 * 28 * accData.accPrice)).toLocaleString();
						$(".eventPrice").eq(1).text("월 평균 요금은 ￦" + discountMonthPrice + "입니다.");
					}
				} 


				myEventBlock.show();
				discountBlock.hide();	
			} else {
				swal("이벤트 업데이트를 실패했습니다.", "", "error");
			}
		}
	};

	xhr.send(JSON.stringify(data));
}

okBtn.on("click", function() {
	let accNo = document.querySelector("#shgAccSelect").value;

	if(accNo == null || accNo == "") {
		swal("숙소를 선택해주세요.", "", "error");
		return false;
	}

	if(discountName.text() == null || discountName.text() == "") {
		swal("할인 유형을 선택해주세요.", "", "error");
		return false;
	}
	
	let discountRate = parseInt(inputDiv.innerText);

	console.log(discountName.text());
	console.log("자체이벤트", ownDiscount);
	console.log(discountRate);
	
	if(discountName.text().includes("주간")) {
		if(discountRate > ownDiscount[1].discountRate) {
			swal("월간할인보다 낮게 설정해 주세요.", "", "error");
			return false;
		}
	} else {
		if(discountRate < ownDiscount[0].discountRate) {
			swal("주간할인보다 할인율이 높아야 합니다.", "", "error");
			return false;
		}
	}

	if(discountRate > 50 || discountRate < 0) {
		swal("할인율은 최소 0%에서 최대 50%까지 입니다.", "", "error");
		return false;
	}

	let data = {};
	data.accNo = accNo;
	data.discountRate = discountRate;

	if(discountName.text().includes("주간")) {
		data.discountType = "WEEK";
	} else {
		data.discountType = "MONTH";
	}

	updateEvent(data);
});

cancelBtn.on("click", function() {
	myEventBlock.show();
	discountBlock.hide();
});
//이벤트

//리뷰
let reviewModal = $("#reviewModal");
let accNoForReview = "";
let memNoForReview = "";
$(document).on("click", "#registerReview", function() {
	accNoForReview = $(this).data("accno");
	memNoForReview = $(this).data("memno");

	reviewModal.click();
});

$("#register").on("click", function() {
	let reviewContent = $("#reviewContent").val();

	if(reviewContent == null || reviewContent == "") {
		swal("내용을 작성해주세요.", "", "error");
		return false;
	}

	let data = {
		accNo: accNoForReview,
		memNo: memNoForReview,
		memReviewContent: reviewContent
	};

	console.log(data);

	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

	var xhr = new XMLHttpRequest();
	xhr.open("post", "/review/insertMemReview", true);
	xhr.setRequestHeader(header, token);
	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
	xhr.onreadystatechange = function() {
		if(xhr.status == 200 && xhr.readyState == 4) {
			let result = JSON.parse(xhr.responseText);

			if(result == "OK") {
				swal("후기가 등록되었습니다.", "", "success");
				$(".mfp-close").click();
			} else {
				swal("후기 등록이 실패했습니다.", "", "error");
			}
		}
	};

	xhr.send(JSON.stringify(data));
});