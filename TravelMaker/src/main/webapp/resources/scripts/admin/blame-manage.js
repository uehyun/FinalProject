var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var modal = document.querySelector("#modal");
var memCont = document.querySelector("#memCont");
var clickAll = document.querySelector("#clickAll");
var okBtn = document.querySelector("#okBtn");
var cancelBtn = document.querySelector("#cancelBtn");

const columnDefs = [
    {
		flex:0.2,
		checkboxSelection: true,
		showDisabledCheckboxes: true,
	},
	{ field: "memNo",  headerName:"회원 번호", cellStyle: { textAlign: "center" }},
	{ field: "blameType", headerName:"신고 유형", cellStyle: { textAlign: "center", color : "red", fontWeight : "700", textDecoration : "underline", cursor : "pointer" }},
	{ field: "blameReason", headerName:"신고 내용", cellStyle: { textAlign: "center" }},
	{ field: "blameDate", headerName:"신고 일자", cellStyle: { textAlign: "center" }},
	{ 
        field: "blameStatus", 
        headerName:"신고 상태", 
        cellStyle: params => {
			var blameStatus = params.value;
	  
			let backgroundColor = "";
			let fontWeight = "700";
			let color = "black";
			let textAlign = "center";
	  
			switch (blameStatus) {
			  case "대기":
				backgroundColor = "rgb(225 241 76)";
				break;
			  case "승인":
				backgroundColor = "rgb(153, 221, 153)";
				break;
			  case "거절":
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
    },
];

const rowData = [];


function getData() {
	var xhr = new XMLHttpRequest();
	xhr.open("get","/admin/manage/blameList",true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let rslt = JSON.parse(xhr.responseText);
			gridOptions.api.setRowData(rslt);
            console.log(rslt)
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
		return !!params.data && params.data.blameStatus === '대기';
	},
    onCellClicked: params => {
    const { colDef, data } = params;
    if (colDef.field === "blameType") {
      params.node.setSelected(!params.node.isSelected());
      memModal(params.data);
    }
  },
};
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
var selectedRows = [];
document.addEventListener('DOMContentLoaded', () => {
    const gridDiv = document.querySelector('#myGrid');
    new agGrid.Grid(gridDiv, gridOptions);

    okBtn.addEventListener('click', () => {
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();

		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("승인 하시겠습니까?")) {
                selectedRows[0].flag = "ok";
				updateData(selectedRows);
			} else {
				return false;
			}
		}
	});
	
	cancelBtn.addEventListener('click', () => {
		selectedRows = [];
		selectedRows = gridOptions.api.getSelectedRows();

		if(selectedRows.length == 0) {
			swal("1개 이상 선택해주세요.","","error");
		} else {
			if(confirm("거절 하시겠습니까?")) {
                selectedRows[0].flag = "no";
				updateData(selectedRows);
			} else {
                return false;
            }
		}
	});
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
			</div>
			<div class="sign-in-form style-1">
				<table style="width:100%">
					<tr>
						<td colspan="2">
							<span class="memName">${data.memNo} 신고 내역</span>
						</td>
					</tr>`;
					if(data.reviewNo == null) {
					modalCont += `<tr>
						<td class="memInfo">신고 상세보기</td>`;
						if(data.accNo != null) {
							modalCont += `<td><a class="read-more" href="/main/detail/${data.accNo}">페이지 이동 <i class='fa fa-angle-right'></i></a></td>`;
						} else if(data.boardNo != null) {
							modalCont += `<td><a class="read-more" href="/tripBoard/detail?tboardNo=${data.boardNo}">페이지 이동 <i class='fa fa-angle-right'></i></a></td>`;
						}
					modalCont += `</tr>`;
					}
					modalCont += `<tr>
						<td class="memInfo">신고 번호</td>
						<td>${data.blameNo}</td>
					</tr>
					<tr>
						<td class="memInfo">신고자</td>
						<td>${data.blameMem}</td>
					</tr>
					<tr>
						<td class="memInfo">신고 유형</td>
						<td>${data.blameType}</td>
					</tr>
					<tr>
						<td class="memInfo">신고 유형 번호</td>
						<td>`;
					if(data.boardNo != null) {
						modalCont += `${data.boardNo}`;
					} else if(data.replyNo != null) {
						modalCont += `${data.replyNo}`;
					} else if(data.reviewNo != null) {
						modalCont += `${data.reviewNo}`;
					} else if(data.accNo != null) {
						modalCont += `${data.accNo}`;
						console.log(data.accNo)
                    }
                    modalCont += `</td>
					</tr>
                    <tr>
						<td class="memInfo">신고 일자</td>
						<td>${data.blameDate}</td>
					</tr>
                    <tr>
						<td class="memInfo">처리 일자</td>
						<td>`;
                    if(data.blameApprovalDate == null || data.blameApprovalDate == "") {
                        modalCont += "아직 처리 대기중입니다.";
                    } else {
                        modalCont += `${data.blameApprovalDate}`;
                    }
                       modalCont += `</td>
					</tr>`;
					if(data.reviewNo != null) {
                    modalCont += `<tr>
						<td class="memInfo">리뷰 내용</td>
						<td>${data.memReviewContent}</td>
					</tr>`;
					}
                    modalCont += `<tr>
						<td class="memInfo">신고된 내용</td>
						<td>${data.blameReason}</td>
					</tr>
                    <tr>
						<td class="memInfo">신고 상태</td>
						<td>${data.blameStatus}</td>
					</tr>
				</table>
			</div>
		</div>
	`;
	memCont.innerHTML = modalCont;
	modal.click();
}

// ==================================== 승인 / 거절 버튼 이벤트 ===============================================
function updateData(selectedRows) {
	$.ajax({
		url : "/admin/manage/blameUpdate",
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