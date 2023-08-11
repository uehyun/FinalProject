var modal = document.querySelector("#modal");
var memCont = document.querySelector("#memCont");

const columnDefs = [
	{ field: "memNo",  headerName:"회원 번호", cellStyle: { textAlign: "center" }},
	{ field: "memId", headerName:"아이디", cellStyle: { textAlign: "center", color : "red", fontWeight : "700", textDecoration : "underline", cursor : "pointer" }},
	{ field: "memName", headerName:"이름", cellStyle: { textAlign: "center" }},
	{ field: "memRegDate", headerName:"가입일자", cellStyle: { textAlign: "center" }},
	{ 
		field: "memDel", 
		headerName:"삭제여부", 
		cellStyle: params => {
			var memStatus = params.value;

			let fontWeight = "700";
			let textAlign = "center";
			let color = "";
			
			switch (memStatus) {
			  	case "삭제":
					color = "red";
					break;
			}

			return {
				color : color,
				fontWeight : fontWeight,
				textAlign : textAlign
			};
		}
	},
	{ field: "memBlameCount", headerName:"신고횟수", cellStyle: { textAlign: "center" }},
	{ 
		field: "memStopStatus", 
		headerName:"정지여부", 
		cellStyle: params => {
			var accStatus = params.value;
	  
			let backgroundColor = "";
			let fontWeight = "700";
			let color = "black";
			let textAlign = "center";
	  
			switch (accStatus) {
			  case "정상회원":
				backgroundColor = "#99dd99";
				break;
			  case "정지회원":
				backgroundColor = "#ef3737b5";
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
	}
];

const rowData = [];


function getData() {
	var xhr = new XMLHttpRequest();
	xhr.open("get","/admin/manage/memberList",true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let rslt = JSON.parse(xhr.responseText);
			for(let i=0; i<rslt.length; i++) {
				if(rslt[i].memDel == 'N') {
					rslt[i].memDel = '정상'
				} else {
					rslt[i].memDel = '삭제'
				}
				if(rslt[i].memBlameCount<10) {
					rslt[i].memStopStatus = '정상회원'
				} else {
					rslt[i].memStopStatus = '정지회원'
				}
				
			}
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
	onCellClicked: params => {
		const { colDef, data } = params;
		if (colDef.field === "memId") {
			memModal(params.data);
		}
  	},
};

document.addEventListener('DOMContentLoaded', () => {
  const gridDiv = document.querySelector('#myGrid');
  new agGrid.Grid(gridDiv, gridOptions);
  getData();
});

function onQuickFilterChanged() {
	gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
}


function memModal(data) {

	memCont.innerHTML = "";

	var modalCont = `
		<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
			<div class="small-dialog-header" style="display:flex;">
				<img id="memImg" src="${pageContext}${data.memProfilePath}">
				<span class="memName">${data.memName}님 정보</span>
			</div>
			<div class="sign-in-form style-1">
				<table style="width:100%">
					<tr>
						<td colspan="2">
							<span class="memName">회원 정보</span>
						</td>
					</tr
					<tr>
						<td class="memInfo">회원 번호</td>
						<td>${data.memNo}</td>
					</tr>
					<tr>
						<td class="memInfo">회원 아이디</td>
						<td>${data.memId}</td>
					</tr>
					<tr>
						<td class="memInfo">회원 이름</td>
						<td>${data.memName}</td>
					</tr>
					<tr>
						<td class="memInfo">회원 전화번호</td>
						<td>${data.memPhone}</td>
					</tr>
					<tr>
						<td class="memInfo">회원 이메일</td>
						<td>${data.memEmail}</td>
					</tr>
					<tr>
						<td class="memInfo">가입일자</td>
						<td>${data.memRegDate}</td>
					</tr>
					<tr>
						<td class="memInfo">신고당한 횟수</td>
						<td>${data.memBlameCount}</td>
					</tr>
					<tr>
						<td class="memInfo">개인정보 동의여부</td>
						<td>${data.memAgree == "Y" ? '동의' : '미동의'}</td>
					</tr>
					<tr>
						<td class="memInfo">삭제 여부</td>
						<td>${data.memDel == 'N' ? '정상' : '삭제'}</td>
					</tr>
				</table>
			</div>
		</div>
	`;
	memCont.innerHTML = modalCont;
	modal.click();
}