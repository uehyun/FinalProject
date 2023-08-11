var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var modal = document.querySelector("#modal");
var memCont = document.querySelector("#memCont");
var reject = document.querySelector("#reasonSelect");
var clickAll = document.querySelector("#clickAll");
const columnDefs = [
	{
		flex:0.2,
		checkboxSelection: true,
		showDisabledCheckboxes: true
	},
	{ field: "memNo", headerName:"회원번호", flex:0.7, cellStyle: { textAlign: "center" }},
	{ field: "memId", headerName:"아이디", flex:0.7, cellStyle: { textAlign: "center" }},
	{ field: "memName", headerName:"이름", flex:0.7, cellStyle: { textAlign: "center" }},
	{ field: "accNo", headerName:"숙소번호", flex:0.7, cellStyle: { textAlign: "center", color : "red", fontWeight : "700", textDecoration : "underline", cursor : "pointer"}},
	{ field: "accName", headerName:"숙소이름", flex:1},
	{ field: "accCategory", headerName:"숙소유형", flex:1},
	{ field: "accLocation", headerName:"숙소주소", flex:2},
	{ 
		field: "accStatus", 
		headerName:"숙소 진행상태", 
		flex: 1, 
		sort: "desc",
		cellStyle: params => {
			const accStatus = params.value;
	  
			let backgroundColor = "";
			let fontWeight = "700";
			let color = "black";
	  
			switch (accStatus) {
			  case "활성":
				backgroundColor = "#99dd99";
				break;
			  case "대기":
				backgroundColor = "#e2ed31";
				break;
			  case "거절":
				backgroundColor = "#ef3737b5";
				break;
			  case "비활성":
				backgroundColor = "gray";
				break;
			  default:
				backgroundColor = "";
				break;
			}
	  
			return { 
				backgroundColor: backgroundColor,
				fontWeight: fontWeight,
				color: color
			};
		}
	},
	{ field: "facilities", headerName:"옵션갯수", flex:1, cellStyle: { textAlign: "center" }}
];

const rowData = [];

const gridOptions = {
	columnDefs: columnDefs,
	rowData: rowData,
	defaultColDef: {
		filter: true,
		resizable:true,
		sortable: true,
	},
	pagination:true,
	paginationPageSize:15,
	rowSelection: 'multiple',
	rowMultiSelectWithClick : true,
	isRowSelectable: (params) => {
		return !!params.data && params.data.accStatus === '대기';
	},
	onCellClicked: params => {
		const { colDef, data } = params;
		if (colDef.field === "accNo") {
			params.node.setSelected(!params.node.isSelected());
			memModal(params.data);
		}
	}
};

function getData() {
	var xhr = new XMLHttpRequest();
	xhr.open("get","/admin/manage/hostList",true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let rslt = JSON.parse(xhr.responseText);
			console.log(rslt);
			for (let i = 0; i < rslt.length; i++) {
				var asd = "";
				if(rslt[i].accCount == 10 && rslt[i].accStatus == "활성") {
					asd = "활성";
				} else if(rslt[i].accCount == 10 && rslt[i].accStatus == "비활성") {
					asd = "비활성";
				} else if((rslt[i].accCount == 9 && rslt[i].accStatus == "비활성") || (rslt[i].accCount == 9 && rslt[i].accStatus == "대기")) {
					asd = "대기";
				} else if(rslt[i].accCount == 9 && rslt[i].accStatus == "거절") {
					asd = "거절";
				} else if(rslt[i].accCount < 9 && rslt[i].accStatus == "비활성") {
					asd = "미완료";
				}
				rslt[i].accStatus = asd;
			}
			gridOptions.api.setRowData(rslt);
		}
	}
	xhr.send();
}

var selectedRows = [];
document.addEventListener('DOMContentLoaded', () => {
  const gridDiv = document.querySelector('#myGrid');
  new agGrid.Grid(gridDiv, gridOptions);

  const okBtn = document.querySelector('#okBtn');
  const cancelBtn = document.querySelector('#cancelBtn');

  	okBtn.addEventListener('click', () => {
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();

		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("승인 하시겠습니까?")) {
				if(selectedRows.length > 0) {
					selectedRows[0].flag = "ok";
				} else {
					return false;
				}
				updateData(selectedRows);
			} else {
				return false;
			}
		}
	});
	
	cancelBtn.addEventListener('click', () => {
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();
		console.log(reject.value);
		if(reject.value == "" || reject.value == null) {
			swal("사유를 선택해주세요.","","error");
			return false;
		} 

		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("거절 하시겠습니까?")) {
				if(selectedRows.length > 0) {
					selectedRows[0].flag = "no";
					for(let i=0; i<selectedRows.length; i++) {
						selectedRows[i].accRejectComment = reject.value;
					}
					console.log(selectedRows)
				} else {
					return false;
				}
				updateData(selectedRows);
			}
		}
	});

  getData();
});

// ================================= 전체 선택 ============================================
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
// ================================= 전체 선택 ============================================

function updateData(selectedRows) {
	$.ajax({
		url : "/admin/manage/hostUpdate",
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		data : JSON.stringify(selectedRows),
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(res) {
			if (res.result === "SUCCESS") {
				console.log(res.msg);
				var rslt = res.list;
				for (let i = 0; i < rslt.length; i++) {
					var asd = "";
					if(rslt[i].accCount == 10 && rslt[i].accStatus == "활성") {
						asd = "활성";
					} else if(rslt[i].accCount == 10 && rslt[i].accStatus == "비활성") {
						asd = "비활성";
					} else if((rslt[i].accCount == 9 && rslt[i].accStatus == "비활성") || (rslt[i].accCount == 9 && rslt[i].accStatus == "대기")) {
						asd = "대기";
					} else if(rslt[i].accCount == 9 && rslt[i].accStatus == "거절") {
						asd = "거절";
					} else if(rslt[i].accCount < 9 && rslt[i].accStatus == "비활성") {
						asd = "미완료";
					}
					rslt[i].accStatus = asd;
				}
				gridOptions.api.setRowData(rslt);
			}
		}
	});
}



function onQuickFilterChanged() {
	gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
}


function memModal(data) {
	$.ajax({
		url : `/admin/manage/selectOne/${data.accNo}`,
		type : "get",
		success : function(res) {
			memCont.innerHTML = "";
			var modalCont = `
				<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
					<div class="small-dialog-header" style="display:flex; margin-bottom: 15px;">
						<img id="memImg" src="${pageContext}${res.memProfilePath}">
						<span class="memName">${res.memName}님의 숙소(${res.accNo}) 정보</span>
					</div>
					<div style="display: flex; justify-content: center; margin: 15px;">`;
						// <div class="slider">
						// for(let i=0; i<res.fileList.length; i++) {
						// 	modalCont += `<img style="width : 85%; height: 280px; border-radius:8px;" src="${res.fileList[i].attPath}"/>`;
						// }
						//	</div>
					modalCont += `
						</div>
					<div class="sign-in-form style-1">
						<table style="width:100%">
							<tr>
								<td colspan="2">
									<span class="memName">회원 정보</span>
								</td>
							</tr>
							<tr>
								<td class="memInfo">상세정보</td>
								<td><a class="read-more" href="/main/detail/${res.accNo}">상세내용 보기 <i class='fa fa-angle-right'></i></a></td>
							</tr>
							<tr>
								<td class="memInfo">회원 번호</td>
								<td>${res.memNo}</td>
							</tr>
							<tr>
								<td class="memInfo">회원 아이디</td>
								<td>${res.memId}</td>
							</tr>
							<tr>
								<td class="memInfo">회원 이름</td>
								<td>${res.memName}</td>
							</tr>
							<tr>
								<td class="memInfo">회원 전화번호</td>
								<td>${res.memPhone}</td>
							</tr>
							<tr>
								<td class="memInfo">숙소 번호</td>
								<td>${res.accAttGroupNo}</td>
							</tr>
							<tr>
								<td class="memInfo">숙소 이름</td>
								<td>${res.accName}</td>
							</tr>
							<tr>
								<td class="memInfo">주소</td>
								<td>${res.accLocation}</td>
							</tr>
							<tr>
								<td class="memInfo">요금정보</td>
								<td>${res.accPrice}</td>
							</tr>
							<tr>
								<td class="memInfo">체크인 시간</td>
								<td>${res.accStandardCheckin}</td>
							</tr>
							<tr>
								<td class="memInfo">체크아웃 시간</td>
								<td>${res.accStandardCheckout}</td>
							</tr>
							<tr>
								<td class="memInfo">숙소 상태</td>
								<td>${res.accStatus}</td>
							</tr>
							<tr>
								<td class="memInfo">등록일자</td>
								<td>${res.accRegDate}</td>
							</tr>
							<tr>
								<td class="memInfo">옵션 목록</td>
								<td>`;
								// 옵션부분 수정 필요
					for(let i=0; i<res.accoptionList.length; i++) {
						for(let j=0; j<res.accoptionList[i].optionList.length; j++) {
							if (j !== res.accoptionList[i].optionList.length - 1) {
								modalCont += `${res.accoptionList[i].optionList[j].optionName},&nbsp; `;
							} else {
								modalCont += `${res.accoptionList[i].optionList[j].optionName}`;
							}
						}
					}
				modalCont += `</td>
							</tr>
							<tr>
								<td class="memInfo">선호 언어</td>
								<td>`;
								if(res.memPreLanguage == null) {
									modalCont += "설정한 언어가 없습니다.";
								} else {
									modalCont += `${res.memPreLanguage}`;
								}
								modalCont += `</td>
							</tr>
							<tr>
								<td class="memInfo">선호 통화</td>
								<td>`;
								if(res.memPreLanguage == null) {
									modalCont += "설정한 통화가 없습니다.";
								} else {
									modalCont += `${res.memPreCurrency}`;
								}
								modalCont += `</td>
							</tr>
						</table>
					</div>
				</div>
			`;
			memCont.innerHTML = modalCont;
			modal.click();
			slickJs();
		}
	});
}
