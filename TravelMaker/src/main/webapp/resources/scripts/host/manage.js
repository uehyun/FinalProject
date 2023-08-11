$(document).on("click", ".accTR:not(.accCheck)", function(event) {

	if ($(event.target).hasClass('accCheck')) {
        return;
    }
    
    let trCount = $(this).data("acccount");
    
    if(trCount < 10) {
        return false;
    }
    
    let trAccNo = $(this).data("accno");
    console.log(trCount, trAccNo);

    location.href = `/host/update?accNo=${trAccNo}&accCount=1`;
});

$(document).on("click", ".registerAcc", function() {
    event.stopPropagation();

    let btnStatus = $(this).data("status");
    let rejectComment = $(this).data("reject");
    let btnAccNo= $(this).data("accno");

    let btnCount = 1;
    if(btnStatus == "거절") {
        if(rejectComment.includes("주소")) {
            btnCount = 2;
        } else if(rejectComment.includes("편의시설")) {
            btnCount = 7;
        } else if(rejectComment.includes("사진")) {
            btnCount = 3;
        } else if(rejectComment.includes("부가정보")) {
            btnCount = 5;
        }

        location.href = `/host/update?accNo=${btnAccNo}&accCount=${btnCount}`;
    } else {
        location.href = `/host/update?accNo=${btnAccNo}&accCount=1`;
    }
});

let addAcc = $("#addAcc");
addAcc.on("click", function() {
	location.href = "/host/register";
});

//방 옵션
let minusBtn = $(".minusBtn");
let plusBtn = $(".plusBtn");
let roomApply = $("#roomApply");
let roomArray = [];

minusBtn.on("click", function(event) {
    event.stopPropagation();

    let textEle = $(this).parent(".qtyButtons").find("input");

    if(parseInt(textEle.val()) < 1) {
        return false;
    }
    
    let count = parseInt(textEle.val()) - 1;
    textEle.val(count); 
});

plusBtn.on("click", function(event) {
    event.stopPropagation();

    let textEle = $(this).parent(".qtyButtons").find("input");

    let count = parseInt(textEle.val()) + 1;
    textEle.val(count); 
});

roomApply.on("click", function(event) {
    event.stopPropagation();
    hideModal();
    renderAcc();
});
//방 옵션


//편의시설
let convenienceApply = $("#convenienceApply");
let convenienceCheck = $(".convenienceCheck");
let checkArray = [];

convenienceApply.on("click", function(event) {
    event.stopPropagation();
    hideModal();
    renderAcc();
});

convenienceCheck.on("change", function() {
    event.stopPropagation();
    renderAcc();
});
//편의시설


//숙소상태
let statusApply = $("#statusApply");
let accStatusCheck = $(".accStatusCheck");
let statusArray = [];

statusApply.on("click", function(event) {
    event.stopPropagation();
    hideModal();
    renderAcc();
});

accStatusCheck.on("change", function() {
    event.stopPropagation();
    renderAcc();
})
//숙소상태

//검색창
let input = document.querySelector("#search");
let searchIcon = document.getElementById('searchIcon');
let div = document.querySelector(".input-container");
let accName = "";

input.addEventListener('focus', function() {
	hideModal();
	searchIcon.style.stroke = 'black';
	div.style.border = "2px solid black";
});

input.addEventListener("input", function() {
    accName = this.value; 
    renderAcc();
});

input.addEventListener('blur', function() {
	searchIcon.style.stroke = 'currentcolor';
	div.style.border = "1px solid rgb(221, 221, 221)";
});
//검색창

//필터링
let filter = $(".filter");
let filterOption = $(".filterOption");
let resetFilter = $("#resetFilter");

resetFilter.on("click", function() {
    let checkbox = filterOption.find("input[type='checkbox']"); 

    for(let i = 0; i < checkbox.length; i++) {
        checkbox[i].checked = false;
    }

    $("#qtyBedRoom").val("1");
    $("#qtyBed").val("1");
    $("#qtyBathRoom").val("1");

    accName = "";
    input.value = "";

    renderAcc();
});

filter.on("click", function() {
	hideModal();
	$(this).find(".filterOption").show();
})

function hideModal() {
	for(let i = 0; i < filterOption.length; i++) {
		filterOption.eq(i).hide();
	}
}
//필터링

//활성화 및 비활성화 버튼
let accActive = $("#accActive");
let accInactive = $("#accInactive");

accActive.on("click", function() {
    let accCheck = $(".accCheck");
    let accArray = [];

    for(let i = 0; i < accCheck.length; i++) {
        if(accCheck[i].checked == true) {
            let checkAccNo = accCheck.eq(i).data("accno");
            let checkAccCount = accCheck.eq(i).data("count");
            let checkAccStatus = accCheck.eq(i).data("status");
    
            let acc = {};
            acc.accNo = checkAccNo;
            acc.accCount = checkAccCount;
            acc.accStatus = checkAccStatus;

            accArray.push(acc);
        }
    }

    active(accArray, "활성");
});

accInactive.on("click", function() {
    let accCheck = $(".accCheck");
    let accArray = [];

    for(let i = 0; i < accCheck.length; i++) {
        if(accCheck[i].checked == true) {
            let checkAccNo = accCheck.eq(i).data("accno");
            let checkAccCount = accCheck.eq(i).data("count");
            let checkAccStatus = accCheck.eq(i).data("status");
    
            let acc = {};
            acc.accNo = checkAccNo;
            acc.accCount = checkAccCount;
            acc.accStatus = checkAccStatus;

            accArray.push(acc);
        }
    }

    active(accArray, "비활성");
});
//활성화 및 비활성화 버튼

//테이블 이벤트 및 렌더링
let tbodyObj = $("#tbodyObj");
let noResult = $("#noResult")
let allCheck = $("#allCheck");

allCheck.on("change", function() {
    let tbrCheckbox = tbodyObj.find("input[type='checkbox']");

    if($(this).prop("checked")) {
        for(let i = 0; i < tbrCheckbox.length; i++) {
            tbrCheckbox[i].checked = true;
        }
    } else {
        for(let i = 0; i < tbrCheckbox.length; i++) {
            tbrCheckbox[i].checked = false;
        }
    }
});

renderAcc();

function renderAcc() {
    let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;
    
    let qtyBedRoom = $("#qtyBedRoom").val();
    let qtyBed = $("#qtyBed").val();
    let qtyBathRoom = $("#qtyBathRoom").val();

    checkArray = [];
    for(let i = 0; i < convenienceCheck.length; i++) {
        if(convenienceCheck[i].checked) {
            let convenience = {optionNo: convenienceCheck[i].value};
            
            checkArray.push(convenience);
        }
    };

    statusArray = [];
    for(let i = 0; i < accStatusCheck.length; i++) {
        if(accStatusCheck[i].checked) {
            let status = {accStatus: accStatusCheck[i].value};
            
            statusArray.push(status);
        }
    }

    let data = {};
    data.bedRoom = qtyBedRoom;
    data.bed = qtyBed;
    data.bathRoom = qtyBathRoom;

    data.checkArray = checkArray;
    data.statusArray = statusArray;

    data.search = accName;

    $.ajax({
    	url: "/host/selectAccWithFilter",
        type: "post",
        beforeSend: function(xhr) {
            noResult.empty();
            tbodyObj.empty();
            $('.loading-icon').show();
            xhr.setRequestHeader(header, token);
        },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        success: function(res) {
            let tableStr = "";
            console.log(res);

            if(res.length > 0) {
                $.each(res, function(i, v) {
                    let imgStr = "";
                    if( v.files == null || v.files.length == 0) {
                        imgStr += `<td><div class="accInfo"><div class="nonImg"></div> <span>${v.accName}</span></div></td>`;
                    } else {
                        imgStr += `<td><div class="accInfo"><img src="${v.files[0].attPath}"> <span>${v.accName}</span></div></td>`;
                    }

                    let isHosting = "";
                    if(v.accCount < 9) {
                        isHosting += `
                            <td>미등록 숙소</td>
                            <td><button class="registerAcc" data-accno="${v.accNo}" data-reject="${v.accRejectComment}" data-status="${v.accStatus}">등록 완료하기</button></td>`;
                    } else if(v.accCount > 9 && v.accStatus == "활성") {
                        isHosting += `
                            <td>호스팅 중</td>
                            <td>등록 완료</td>`;
                    } else if(v.accCount > 9 && v.accStatus == "비활성") {
                        isHosting += `
                            <td>호스팅 비활성화</td>
                            <td>등록 완료</td>`;
                    } else if(v.accCount == 9 && v.accStatus == "비활성") {
                        isHosting += `
                            <td>승인 대기 중</td>
                            <td><button class="registerAcc" data-accno="${v.accNo}" data-reject="${v.accRejectComment}" data-status="${v.accStatus}">숙소 수정</button></td>`;
                    } else if(v.accCount == 9 && v.accStatus == "거절") {
                        isHosting += `
                            <td>승인 거절</td>
                            <td><button class="registerAcc" data-accno="${v.accNo}" data-reject="${v.accRejectComment}" data-status="${v.accStatus}">숙소 수정</button></td>`;
                    }

                    let bedRoomQty = "0";
                    let bedQty = "0";
                    let bathRoomQty = "0";

                    for(let j = 0; j < v.accOption.length; j++) {
                        if(v.accOption[j].optionNo == "con_002") {
                            bedRoomQty = v.accOption[j].optionCount;
                        } else if(v.accOption[j].optionNo == "con_003") {
                            bedQty = v.accOption[j].optionCount;
                        } else if(v.accOption[j].optionNo == "con_004") {
                            bathRoomQty = v.accOption[j].optionCount;
                        }
                    }

                    tableStr += `
                    <tr class="accTR" data-accno="${v.accNo}" data-acccount="${v.accCount}">
                        <td><input type="checkbox" class="accCheck" data-accno="${v.accNo}" data-count="${v.accCount}" data-status="${v.accStatus}"></td>
                        ${imgStr}
                        ${isHosting}
                        <td>${bedRoomQty}</td>
                        <td>${bedQty}</td>
                        <td>${bathRoomQty}</td>
                        <td>한국</td>
                        <td>${v.accRegDate}</td>
                    </tr>
                    `;
                });
                noResult.hide();
                tbodyObj.html(tableStr);
            } else {
                tableStr += `<div style="text-align: center; font-weight: bold; color: black;">검색 결과 없음</div>`;
                noResult.show();
                noResult.html(tableStr);
            } 

            $('.loading-icon').hide();
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
}
//테이블 이벤트 및 렌더링

function active(dataArray, type) {
    let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

    for(let i = 0; i < dataArray.length; i++) {
        if(dataArray[i].accStatus == "거절") {
            swal("거절된 숙소가 존재합니다.", "해당 숙소 선택을 해제해주세요.", "info");
            return false;
        }

        if(dataArray[i].accCount < 10) {
            swal("아직 미완성인 숙소가 존재합니다.", "해당 숙소 선택을 해제해주세요.", "info");
            return false;
        }
    }

    let data = {
        data: dataArray,
        type: type
    };

    $.ajax({
        url: "/host/activeInactive",
        type: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        success: function(res) {
            console.log(res);
            if(res == "OK") {
                swal("업데이트 되었습니다.", "", "info");
                renderAcc();
            } else {
                swal("업데이트가 실패했습니다.", "", "error");
            }
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });  
}