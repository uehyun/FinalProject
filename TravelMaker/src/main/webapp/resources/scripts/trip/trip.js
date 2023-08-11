var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
console.log("token",token);
console.log("header",header);

const delBtn = $("#delBtn");
const btnAdd = $("#btnAdd");
const myFile = document.querySelector("#myFile");
var addTrip = $("#addTrip");
var startDay;
var endDay;
var travelName = $("#travelName");
var travelImg = $("#travelImg");
var travelStartDate = $("#travelStartDate");
var travelEndDate = $("#travelEndDate");
var files;

// 삭제 이벤트
$(document).on("click", ".button:not(.list-box-listing)",function(event){
	event.stopPropagation();
	var travelNo = this.parentElement.dataset.travelno;
	data = {
		"travelNo" : travelNo
	}
	$.ajax({
		url : "/member/delTrip",
		type : "post",
		beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
		data : JSON.stringify(data),
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(res) {
			if(res.result === "SUCCESS") {
				swal(res.msg, "", "success");
				loadTripList();
			} else {
				swal("정보가 잘못 입력 되었습니다.","","error");
			}
		}
	});
});

// 상세 페이지로 이동
$(document).on("click",".list-box-listing",function(){
	var travelNo = this.dataset.travelno;
	var travelStartDate = this.dataset.travelStartDate
	location.href=`/member/tripForm?travelNo=${travelNo}&travelDate=${travelStartDate}`;
	// console.log(this.dataset.travelno);
});

//==============================================================================

//=========================================================================
function OneFileRead(pFile) {
	var fileReader = new FileReader();  // 파일 읽어줌
	fileReader.onload = function() {    // 다 읽으면 발생하는 이벤트
		var vImg = document.createElement("img");
		vImg.src = fileReader.result;
		vImg.style.width = "100%";
		vImg.style.height = "auto";
		vImg.style.objectFit = "cover";

		vImg.addEventListener("load", function () {
			var imgHeight = vImg.height;
			myFile.style.height = imgHeight + "px";
		});
		myFile.appendChild(vImg);
	}
	fileReader.readAsDataURL(pFile);
}

window.addEventListener("dragover",function(event){
	event.preventDefault();
});
window.addEventListener("drop",function(event){
	event.preventDefault();
});


btnAdd.on("click",function(event){
	event.preventDefault();

	if(travelName.val() == "" || travelName.val() == null) {
		swal("여행 이름을 정해주세요!","","warning");
		travelName.focus();
		return false;
	}
    if(files == null) {
        swal("여행 사진을 골라 주세요","","warning");
        return false;
    }

	if(!startDay && !endDay) {
		swal("날짜를 선택해주세요.","","warning");
		return false;
	}
	var resTime = endDay._d.getTime() - startDay._d.getTime();
	if(resTime < 0) {
		swal("종료 일자는 시작 일자 이후여야 합니다.","","warning")
		return false;
	}
	var resDay = endDay.diff(startDay,'days') + 1;
	if(resDay > 15) {
		swal("전체 기간은 15일 이내로 지정해주세요","","warning")
		return false;
	}
	
	travelStartDate.val(startDay.format('YYYY-MM-DD'));
	travelEndDate.val(endDay.format('YYYY-MM-DD'));
	
	var formData = new FormData();
	var file = files[0];
	formData.append("travelImg",file);
	formData.append("travelName", travelName.val());
	formData.append("travelStartDate", travelStartDate.val());
	formData.append("travelEndDate", travelEndDate.val());
	
	$.ajax({
		url: "/member/addTrip",
		type: "POST",
		beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
		data: formData,
		processData: false,
		contentType: false,
		success: function(res) {
			// console.log(res.returnPage)
			window.location.href = res.returnPage;
		},
		error: function(xhr) {
			console.log("서버 오류: " + xhr.error);
		}
	});

	// addTrip.submit();
});

$(function() {
    var start = moment(); // 오늘 날짜로 초기화
	var end = moment().add(1, 'week'); // 오늘 날짜에서 1주일 후로 초기화
    
    
    function cb(start, end) {
    	var dateRange = start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD');
        $('#booking-date-range span').html(dateRange);
    }
    
    $('#booking-date-range').daterangepicker({
        "opens": "left",
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
        isInvalidDate: function(date) {
          return date.isBefore(moment(), 'day');
        }
      }, function(start, end) {
		startDay = start;
		endDay = end;
        cb(start, end);
	  });

});


// Calendar animation and visual settings
$('#booking-date-range').on('show.daterangepicker', function(ev, picker) {
	$('.daterangepicker').addClass('calendar-visible calendar-animated bordered-style');
	$('.daterangepicker').removeClass('calendar-hidden');
});

$('#booking-date-range').on('hide.daterangepicker', function(ev, picker) {
	$('.daterangepicker').removeClass('calendar-visible');
	$('.daterangepicker').addClass('calendar-hidden');
});

// ===============================  경로 리스트 ajax ===================================

function loadTripList() {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/member/ajaxTrip", true);
	
	xhr.onreadystatechange = function () {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var response = JSON.parse(xhr.responseText);
			console.log(response)
			
			var tripListElement = document.querySelector(".tripList");
			
			tripListElement.innerHTML = "";
			
			response.forEach(function (trip) {
				var li = document.createElement("li");

				var div = document.createElement("div");
				div.classList.add("list-box-listing");
				div.setAttribute("data-travelno", trip.travelNo);
				div.setAttribute("data-travelStartDate", trip.travelStartDate);

				var imgDiv = document.createElement("div");
				imgDiv.classList.add("list-box-listing-img");

				var img = document.createElement("img");
				img.setAttribute("src", contextPath + trip.travelImgPath);
				img.className = "travelImg";

				imgDiv.appendChild(img);

				var contentDiv = document.createElement("div");
				contentDiv.classList.add("list-box-listing-content");

				var innerDiv = document.createElement("div");
				innerDiv.classList.add("inner");

				var h3 = document.createElement("h3");
				h3.innerHTML = trip.travelName;
				h3.className = "travelTitle";

				var startDate = new Date(trip.travelStartDate);
				var endDate = new Date(trip.travelEndDate);

				var span = document.createElement("span");
				span.innerHTML = startDate.toLocaleDateString() + " - " + endDate.toLocaleDateString();

				innerDiv.appendChild(h3);
				innerDiv.appendChild(span);

				contentDiv.appendChild(innerDiv);

				var button = document.createElement("button");
				button.className = "button";
				button.innerHTML = '삭제';


				div.appendChild(imgDiv);
				div.appendChild(contentDiv);
				div.appendChild(button);

				li.appendChild(div);

				tripListElement.appendChild(li);
			});
		}
	};
	
	xhr.send();
}