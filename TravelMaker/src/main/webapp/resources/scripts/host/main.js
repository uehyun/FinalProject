let content = $("#reservationContent");
let accFilter = $(".accFilter");
let tableBlock = $("#tableBlock");
let reservationDetail = $("#reservationDetail");

tableBlock.hide();

accFilter.eq(0).css("border", "2px solid black");
getAres("checkout");

accFilter.on("click", function() {
	let text = $(this).text();
	
	resetBorder();
	$(this).css("border", "2px solid black");	
	
    let type = "";

    if(text.includes("체크아웃")) {
        type = "checkout";
    } else if(text.includes("체크인")) {
        type = "checkin";
    } else {
        type = "hosting";
    }

    getAres(type);
});

function resetBorder() {
	for(let i = 0; i < accFilter.length; i++) {
		accFilter.eq(i).css("border", "1px solid rgb(221, 221, 221)");
	}
}

function getAres(type) {
	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;
	
    let data = {type: type};

    var xhr = new XMLHttpRequest();
    xhr.open("post", "/host/selectAres", true);
    xhr.setRequestHeader(header, token);
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onreadystatechange = function() {
        if(xhr.status == 200 && xhr.readyState == 4) {
            let result = JSON.parse(xhr.responseText);
            console.log(result);
            let str = "";

            if(result.length > 0) {
            	str += `
					<table>
						<thead>
							<tr>
								<th>예약 숙소</th>
								<th>게스트 이름</th>
								<th>게스트 전화번호</th>
								<th>게스트 이메일</th>
								<th>체크 인 날짜</th>
								<th>체크 아웃 날짜</th>
							</tr>
						</thead>
						<tbody>`;
					
            	for(let i = 0; i < result.length; i++) {
            		str += `
	            			<tr>
								<td class="accNameInfo">${result[i].accName}</td>
								<td>${result[i].memName}</td>
								<td>${result[i].memPhone}</td>
								<td>${result[i].memEmail}</td>
								<td>${result[i].aresCheckinDate}</td>
								<td>${result[i].aresCheckoutDate}</td>
							</tr>
            		`;
            	}
            	
            	str += `</tbody></table>`;
            	
            	reservationDetail.hide();
            	
            	tableBlock.empty();
            	tableBlock.html(str);
            	tableBlock.show();
            } else {
				str += "<span>";

				if(type == "checkout") {
					str += "오늘 또는 내일은 체크아웃하는 게스트가 없습니다.";
				} else if(type == "checkin") {
					str += "오늘 또는 내일 체크인하는 게스트가 없습니다.";
				} else {
					str += "현재 숙박 중인 게스트가 없습니다.";
				}
				str += "</span>";

            	tableBlock.hide();
				content.html(str);
            	reservationDetail.show();
            }
        }
    }

    xhr.send(JSON.stringify(data));
}