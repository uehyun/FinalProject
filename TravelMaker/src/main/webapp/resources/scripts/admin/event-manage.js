var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var modal = document.querySelector("#modal");
var memCont = document.querySelector("#memCont");
var clickAll = document.querySelector("#clickAll");
var updateBtn = document.querySelector("#updateBtn");
var cancelBtn = document.querySelector("#cancelBtn");
var ableBtn = document.querySelector("#ableBtn");
var disableBtn = document.querySelector("#disableBtn");

var okBtn;
var flag = false;
var option;
var selectedRows = [];

getCategory();
const columnDefs = [
	{
		flex:0.2,
		checkboxSelection: true,
		showDisabledCheckboxes: true,
	},
	{ field: "eventNo",  headerName:"번호", cellStyle: { textAlign: "center" }},
	{ field: "eventTitle", headerName:"제목", cellStyle: { textAlign: "center", color : "red", fontWeight : "700", textDecoration : "underline", cursor : "pointer" }},
	{ field: "eventRegDate", headerName:"등록일자", cellStyle: { textAlign: "center" }},
	{ field: "eventStartDate", headerName:"시작일자", cellStyle: { textAlign: "center" }},
	{ field: "eventEndDate", headerName:"종료일자", cellStyle: { textAlign: "center" }},
	{ field: "eventDiscountRate", headerName:"할인율", cellStyle: { textAlign: "center" }},
	{ field: "optionName", headerName:"이벤트 카테고리", cellStyle: { textAlign: "center" }},
	{ 
		field: "eventStatus", 
		headerName:"이벤트 상태", 
		cellStyle: params => {
			var eventStatus = params.value;
	  
			let backgroundColor = "";
			let fontWeight = "700";
			let color = "black";
			let textAlign = "center";
	  
			switch (eventStatus) {
			  case "활성":
				backgroundColor = "rgb(153, 221, 153)";
				break;
			  case "비활성":
				backgroundColor = "#ef3737b5";
				break;
			  case "삭제":
				backgroundColor = "rgb(255 0 0)";
				color = "white";
				break;
			  default:
				backgroundColor = "";
				break;
			}
	  
			return { 
				backgroundColor: backgroundColor,
				fontWeight: fontWeight,
				color: color,
				textAlign : textAlign
			};
		}
	},
];

const rowData = [];

function getData() {
	var xhr = new XMLHttpRequest();
	xhr.open("get","/admin/manage/eventList",true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let rslt = JSON.parse(xhr.responseText);
			console.log(rslt)
			gridOptions.api.setRowData(rslt);
		}
	}
	xhr.send();
}

const gridOptions = {
	columnDefs: columnDefs,
	rowData: rowData,
	defaultColDef: {
		flex:1,
		filter:true,
		resizable:true,
		sortable: true,
	},
	pagination:true,
	paginationPageSize:15,
	rowSelection: 'multiple',
	rowMultiSelectWithClick : true,
	isRowSelectable: (params) => {
		return params.data.eventStatus === '활성' || params.data.eventStatus === '비활성';
	},
	onCellClicked: params => {
		const { colDef, data } = params;
		if (colDef.field === "eventTitle") {
			params.node.setSelected(!params.node.isSelected());
			flag = true;
			memModal(params.data, option, flag);
		}
  	},
};

document.addEventListener('DOMContentLoaded', () => {
  const gridDiv = document.querySelector('#myGrid');
  new agGrid.Grid(gridDiv, gridOptions);

	ableBtn.addEventListener("click",function(){
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();
		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("활성화 하겠습니까?")) {
				selectedRows[0].flag = "ok";
				updateData(selectedRows);
			} else {
				return false;
			}
		}
	});
	
	disableBtn.addEventListener("click",function(){
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();
		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("비활성화 하겠습니까?")) {
				selectedRows[0].flag = "no";
				updateData(selectedRows);
			} else {
				return false;
			}
		}
  	});

	cancelBtn.addEventListener("click",function(){
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();

		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("삭제 하시겠습니까?")) {
				selectedRows = [];
				selectedRows = gridOptions.api.getSelectedRows();
				deleteEvent(selectedRows);
			} else {
				return false;
			}
		}
	});

  getData();
});

clickAll.addEventListener("click",toggleSelectAll);

let isAllSelected = false;

function toggleSelectAll() {
    if (!isAllSelected) {
        gridOptions.api.selectAllFiltered();
    } else {
        gridOptions.api.deselectAll();
    }
    
    isAllSelected = !isAllSelected;
}

function onQuickFilterChanged() {
	gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
}

// ==================================== 수정, 삭제 ================================================
var selectedRows = [];



updateBtn.addEventListener("click", function(){
	flag = false;
	selectedRows = [];
	selectedRows = gridOptions.api.getSelectedRows();
	console.log(selectedRows);
	if(selectedRows.length < 1) {
		swal("1개 이상 선택해주세요.","","error");
	} else if(selectedRows.length > 1) {
		swal("1개만 선택해주세요.","","error");
	} else {
		memModal(selectedRows[0], option, flag);
	}
});

function memModal(data,option,flag) {

	memCont.innerHTML = "";

	if(flag) {
		var modalCont = `
			<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
				<div class="small-dialog-header" style="display:flex;">
				</div>
				<div class="sign-in-form style-1">
					<table style="width:100%">
						<tr>
							<td colspan="2">
								<span class="memName">이벤트 명 : ${data.eventTitle}</span>
							</td>
						</tr
						<tr>
							<td class="memInfo">이벤트 번호</td>
							<td>${data.eventNo}</td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 등록일자</td>
							<td>${data.eventRegDate}</td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 시작일자</td>
							<td>${data.eventStartDate}</td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 종료일자</td>
							<td>${data.eventEndDate}</td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 수정일자</td>
							<td>`;
							if(data.eventModDate == null || data.eventModDate == "") {
								modalCont += "수정되지 않았습니다.";
							} else {
								modalCont += `${data.eventModDate}`;
							}
						modalCont += `</td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 삭제일자</td>
							<td>`;
							if(data.eventDelDate == null || data.eventDelDate == "") {
								modalCont += "삭제되지 않았습니다.";
							} else {
								modalCont += `${data.eventDelDate}`;
							}
						modalCont += `</td>
						</tr>
						<tr>
							<td class="memInfo">카테고리 번호</td>
							<td>${data.optionNo}</td>
						</tr>
						<tr>
							<td class="memInfo">카테고리 이름</td>
							<td>${data.optionName}</td>
						</tr>
					</table>
				</div>
			</div>
		`;
	} else {
		var modalCont = `
			<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
				<div class="small-dialog-header" style="display:flex;">
				</div>
				<div class="sign-in-form style-1">
					<table style="width:100%">
						<tr>
							<td colspan="2">
								이벤트 명 : <input type="text" id="eventTitle" value="${data.eventTitle}" style="height: 40px; margin-bottom: 0px;">
								<input type="hidden" id="eventNo" value="${data.eventNo}"/>
							</td>
						</tr
						<tr>
							<td class="memInfo">이벤트 시작일자</td>
							<td><input type="date" id="eventStartDate" style="margin: 0px;"></td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 종료일자</td>
							<td><input type="date" id="eventEndDate" style="margin: 0px;"></td>
						</tr>
						<tr>
							<td class="memInfo">이벤트 할인율</td>
							<td><input type="number" id="eventDiscountRate" value="${data.eventDiscountRate}" style="margin: 0px;"></td>
						</tr>
						<tr>
							<td class="memInfo">카테고리</td>
							<td>
								<select id="option" style="margin : 0px;">`;
									for(let i=0; i<option.length; i++) {
										modalCont += `<option value="${option[i].optionNo}">${option[i].optionName}</option>`;
									}
							modalCont += `</select>
							</td>
						</tr>
					</table>
				</div>
				<button id="okBtn" style="margin: 40px 15px; float:right; background-color: white;">확인</button>
			</div>
		`;
	}
	memCont.innerHTML = modalCont;
	modal.click();

	okBtn = document.querySelector("#okBtn");
	okBtn.addEventListener("click",function(){
		var data = {};

		var eventTitle = document.querySelector("#eventTitle");
		var eventStartDate = document.querySelector('#eventStartDate');
		var eventEndDate = document.querySelector('#eventEndDate');
		var eventDiscountRate = document.querySelector('#eventDiscountRate');
		var option = document.querySelector("#option");
		var eventNo = document.querySelector("#eventNo");

		if(eventTitle.value == "") {
			swal("이벤트 제목을 입력해주세요.","","error");
			return false;
		}
		if(eventStartDate.value == "" || eventEndDate.value == "") {
			swal("날짜를 선택해주세요.","","error");
			return false;
		}
		if(eventDiscountRate.value == "") {
			swal("할인율을 정해주세요.","","error");
			return false;
		}
		if (eventStartDate.value > eventEndDate.value) {
			swal("종료일은 시작일 이후로 입력해주세요.","","error");
			eventEndDate.value = "";
			return false;
		}
		if(option.value == "") {
			swal("카테고리를 지정해주세요.","","error");
			return false;
		}

		data.eventNo = eventNo.value;
		data.eventTitle = eventTitle.value;
		data.eventStartDate = eventStartDate.value;
		data.eventEndDate = eventEndDate.value;
		data.eventDiscountRate = eventDiscountRate.value;
		data.optionNo = option.value;

		console.log(data)
		var xhr = new XMLHttpRequest();
		xhr.open("post","/admin/manage/updateEvent",true);
		xhr.setRequestHeader(header,token);
		xhr.setRequestHeader("Content-Type" ,"application/json; charset=utf-8");
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				let rslt = JSON.parse(xhr.responseText);
				console.log(rslt)
				if(rslt.result === "SUCCESS") {
					swal(rslt.msg,"","success");
				} else {
					swal(rslt.msg,"","error");
				}
				var closeButton = document.querySelector('.mfp-close');
                closeButton.click();
				gridOptions.api.setRowData(rslt.list);
			}
		}
		xhr.send(JSON.stringify(data));
	});
}

function getCategory() {
	$.ajax({
		url : "/admin/manage/cateList",
		type : "get",
		success : function(res) {
			option = res;
		}
	});
}

function deleteEvent(data) {
	$.ajax({
		url : "/admin/manage/deleteEvent",
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(res) {
			if(res.result === "SUCCESS") {
				swal(res.msg,"","success");
			} else {
				swal(res.msg,"","error");
			}
			var rslt = res.list;
			gridOptions.api.setRowData(rslt);
		}
	});
}

function updateData(selectedRows) {
	$.ajax({
		url : "/admin/manage/eventUpdate",
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		data : JSON.stringify(selectedRows),
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(res) {
			if (res.result === "SUCCESS") {
				swal(res.msg,"","success");
                var rslt = res.list;
				gridOptions.api.setRowData(rslt);
			}
		}
	});
}