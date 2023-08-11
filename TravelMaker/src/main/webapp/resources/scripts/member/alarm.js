let alarmUL = document.querySelector("#alarmUL");

document.addEventListener('DOMContentLoaded', function() {
	getList();

	$(document).on("click", ".alarmdelete", function(event) {
		event.stopPropagation();
		let alarmNo = $(this).data("no");
		deleteAlarm(alarmNo);
	});
});

function getList() {
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/alarm/getAlarmList", true);
  	xhr.setRequestHeader(header, token);
  	//xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let array = JSON.parse(xhr.responseText);
			
			let str = "";
			
			if(array.length > 0) {
				for(let i = 0; i < array.length; i++) {
					str += 
					`
						<li class="list-group-item myAlarmLi" data-url="${array[i].alarmUrl}">
							${array[i].alarmContent}<br>
							${array[i].alarmDate}
							<div class="buttons-to-right" style="opacity: 1;">
								<a href="#" class="button gray reject alarmdelete" data-no="${array[i].alarmNo}" style="background: red; color: white;">
									<i class="sl sl-icon-close"></i> 삭제
								</a>
							</div>
						</li>
					`;
				}
			} else {
				str += "<h4>알림이 없습니다.</h4>";
			}
			
			alarmUL.innerHTML = str;
		}
	}
	xhr.send();
}

function deleteAlarm(alarmNo) {
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

	var xhr = new XMLHttpRequest();
  	xhr.open("get", "/alarm/deleteAlarm?alarmNo=" + alarmNo, true);
  	xhr.setRequestHeader(header, token);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let res = JSON.parse(xhr.responseText);
			if(res == "FORBIDDEN") {
				swal("본인이 아닙니다.", "", "error");
			}
			getList();
		}
	}
	
	xhr.send();
}

$(document).on("click", ".myAlarmLi", function() {
	location.href = $(this).data("url");
});