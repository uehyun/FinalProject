let myTotalPrice = document.querySelector("#myTotalPrice");
let myTotalRevenue = document.querySelector("#myTotalRevenue");
let myTotalCount = document.querySelector("#myTotalCount");
let allTotalPrice = document.querySelector("#allTotalPrice");
let allTotalCount = document.querySelector("#allTotalCount");

let shgAccSelect = document.querySelector("#shgAccSelect");
let applyBtn = document.querySelector("#applyBtn");

let chart1 = null;
let chart2 = null;

const columnDefs = [
	{ field: "ACCNO", 		headerName: "숙소번호", sortable: true  },
	{ field: "ACCNAME", 	headerName: "숙소이름"				     },
	{ field: "ARESREGDATE", headerName: "예약날짜", sortable: true  },
	{ field: "TOTAL",  		headerName: "총 매출",  sortable: true  },
	{ field: "EXTRA",  		headerName: "추가 비용",  				 },
  	{ field: "FEE", 		headerName: "수수료" 				     },
  	{ field: "EARNING", 	headerName: "순수익",  sortable: true  },
  	{ field: "MEMID", 		headerName: "예약자" 				     },
  	{ field: "CHECKIN", 	headerName: "체크인" 				     },
  	{ field: "CHECKOUT", 	headerName: "체크아웃" 				 },
];

const rowData = [];

const gridOptions = {
	columnDefs: columnDefs,
	rowData: rowData,
	defaultColDef: {
		flex: 1,
		filter: true,
		resizable: true,
		minWidth: 150,
		headerClass: "centered",
		cellStyle: { "text-align": "center" }
	},
	pagination: true,
	paginationPageSize: 5,
	onCellClicked: params => {
		openModal(params.data);
    }
};

document.addEventListener('DOMContentLoaded', function() {
	var start = moment().subtract(1, 'months');
	var end = moment(); 
    
    function cb(start2, end2) {
		start = start2;
		end = end2;

        $('#booking-date-range span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));
        
        let myData = {
    	    startDate: start.format('YYYY-MM-DD'),
    	    endDate: end.format('YYYY-MM-DD'),
    	    accNo: shgAccSelect.value
    	};
    	    
    	getAccData(myData);
    	getPieChart(myData);
    	getGraphChart(myData);
        reservationList(myData);
    } 

    cb(start, end);
    
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
            "daysOfWeek": [
                "일",
                "월",
                "화",
                "수",
                "목",
                "금",
                "토"
            ],
            "monthNames": [
                "1월",
                "2월",
                "3월",
                "4월",
                "5월",
                "6월",
                "7월",
                "8월",
                "9월",
                "10월",
                "11월",
                "12월"
            ],
            "firstDay": 0
        },
        ranges: {
           '오늘': [moment(), moment()],
           '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           '지난 1주일': [moment().subtract(6, 'days'), moment()],
           '지난 1달': [moment().subtract(29, 'days'), moment()],
           '이번 달': [moment().startOf('month'), moment().endOf('month')],
           '저번 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        isInvalidDate : function(date) {
			return date.isAfter(moment(), 'day');
		}
    }, cb);
	
	cb(start, end);
	
    $('#booking-date-range').on('show.daterangepicker', function(ev, picker) {
    	$('.daterangepicker').addClass('calendar-visible calendar-animated bordered-style');
    	$('.daterangepicker').removeClass('calendar-hidden');
    });

    $('#booking-date-range').on('hide.daterangepicker', function(ev, picker) {
    	$('.daterangepicker').removeClass('calendar-visible');
    	$('.daterangepicker').addClass('calendar-hidden');
    });
	
	shgAccSelect.addEventListener("change", function() {
		cb(start, end);
	});

	const gridDiv = document.querySelector('#myGrid');
  	new agGrid.Grid(gridDiv, gridOptions);
});

const ctx1 = document.querySelector('#myChart1').getContext('2d');
const ctx2 = document.querySelector("#myChart2");

function getAccData(data) {
	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/host/getTextData", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let myMap = JSON.parse(xhr.responseText);
			console.log("텍스트 데이터 ", myMap);

			console.log("1 ", Number(myMap.TOTALPRICE).toLocaleString());
			console.log("2 ", Number(myMap.TOTALREVENUE).toLocaleString());
			console.log("3 ", Number(myMap.TOTALCOUNT).toLocaleString());
			console.log("4 ", Number(myMap.AVGPRICE).toLocaleString());
			console.log("5 ", Number(myMap.AVGCOUNT).toLocaleString());

			myTotalPrice.innerHTML = Number(myMap.TOTALPRICE).toLocaleString();
			myTotalRevenue.innerHTML = Number(myMap.TOTALREVENUE).toLocaleString();
			myTotalCount.innerHTML = Number(myMap.TOTALCOUNT).toLocaleString();
			allTotalPrice.innerHTML = Number(myMap.AVGPRICE).toLocaleString();
			allTotalCount.innerHTML = Number(myMap.AVGCOUNT).toLocaleString();
			
		} 
  	};

    xhr.send(JSON.stringify(data));
}

function getPieChart(data) {
	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/host/getPieChartData", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let pieLabels = [];
			let dataArray = [];
			//let colorArray = [];
			let colorArray = ["red", "yellow", "orange", "green", "blue", "navy", "violet"];
			let responseArray = JSON.parse(xhr.responseText);
			
			console.log("파이차트 결과 ", responseArray);

			let divObj = document.querySelectorAll(".accRevenueDiv");
			
			for(let i = 0; i < divObj.length; i++) {
				var no = divObj[i].dataset["no"];
				
				let flag = false;
				
				for(let j = 0; j < responseArray.length; j++) {
					if(no == responseArray[j].ACCNO) {
						pieLabels.push(divObj[i].dataset["name"]);
						dataArray.push(responseArray[j].PIECHARTDATA);
						flag = true;
					}
				}
				
				if(!flag) {
					pieLabels.push(divObj[i].dataset["name"]);
					dataArray.push(0);
				}
				
				let r = Math.floor(Math.random() * 256);
				let g = Math.floor(Math.random() * 256);
				let b = Math.floor(Math.random() * 256);
				let str = `rgb(${r}, ${g}, ${b})`;
				
				//colorArray.push(str);
			}
			
			let pieChartData = {
			    labels: pieLabels,
			    datasets: [{
			        data: dataArray,
			        backgroundColor: colorArray
			    }]
			};

			const config = {
                type: 'pie',
                data: pieChartData,
                options: {
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            enabled: false,
                        },
                        datalabels: {
                            display: true,
                            color: 'white',
                            anchor: 'end',
                            align: 'start',
                            formatter: function (value, context) {
                                return context.chart.data.labels[context.dataIndex] + ': ' + value + '%';
                            }
                        },
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: 10 // 원하는 패딩 설정
                    },
                    title: {
                        display: true,
                        text: 'Chart.js Pie Chart'
                    }
                },
            };

			if(chart1) {
				chart1.data = pieChartData;
				chart1.update();
			} else {
				chart1 = new Chart(ctx1, {
					type: 'pie',
					data: pieChartData,
					options: config
				});
			}
		} 
  	};

    xhr.send(JSON.stringify(data));
}

function getGraphChart(data) {
	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/host/getGraphChartData", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let labels = [];
			let avgAccData = [];
			let myAccData = [];
			
			let responseArray = JSON.parse(xhr.responseText);
			
			console.log("그래프 차트 결과 ", responseArray);

			for(let i = 0; i < responseArray.length; i++) {
				labels.push(responseArray[i].AVGMONTH);
				avgAccData.push(responseArray[i].AVGPRICE);
				myAccData.push(responseArray[i].MYAVGPRICE);
			}

			let v_data = {
				labels: labels,
				datasets: [
				    {
				        label: '전체 숙소 평균 총 매출',
				        data: avgAccData,
				        borderColor: '#36a2eb',
				        backgroundColor: '#36a2eb',
				        yAxisID: 'y'
				    },
				    {
				        label: '나의 숙소 총 매출',
				        data: myAccData,
				        borderColor: '#ffb0c1',
				        backgroundColor: '#ffb0c1',
				        yAxisID: 'y1',
				        type: 'bar'
				    }
				]
			};

			const v_config = {
			    type: 'line',
			    data: v_data,
			    options: {
			    	responsive: true,
			        interaction: {
			            intersect: false,
			            mode: 'index',
			        },

			        scales: {
			            y: {
			                type: 'linear',
			                display: true,
			                position: 'left',
			                suggestedMin: 0,
			                suggestedMax: 10000000,
			            },
			            y1: {
			                type: 'linear',
			                display: true,
			                position: 'right',
			                suggestedMin: 0,
			                suggestedMax: 10000000,
			                grid: {
			                    drawOnChartArea: false,
			                }
			            }
			        }
			    }
			};
			if(chart2) {
				chart2.data = v_data;
				chart2.update();
			} else {
				chart2 = new Chart(ctx2, v_config);
			}
		} 
  	};

    xhr.send(JSON.stringify(data));
}

function reservationList(data) {
    let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/host/getReservationList", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
            let result = JSON.parse(xhr.responseText);

			for(let i = 0; i < result.length; i++) {
				result[i].TOTAL = "￦" + result[i].TOTAL.toLocaleString();
				result[i].FEE = "￦" + result[i].FEE.toLocaleString();
				result[i].EARNING = "￦" + result[i].EARNING.toLocaleString();
				result[i].EXTRA = "￦" + result[i].EXTRA.toLocaleString();
			}

			console.log("aggrid 결과 ", result);

			gridOptions.api.setRowData(result);
        }
    }

    xhr.send(JSON.stringify(data));
}

let excelBtn = document.querySelector("#excelBtn");
excelBtn.addEventListener("click", function() {
	gridOptions.api.exportDataAsExcel();
});

let modal = document.querySelector("#modal");
let revenueCont = document.querySelector("#revenueCont");

function openModal(data) {
	console.log(data);
	revenueCont.innerHTML = "";

	let modalCont = `
		<div id="sign-in-dialog" class="zoom-anim-dialog mfp-hide">
			<div class="small-dialog-header" style="display:flex;">
				<img id="memImg" src="..${data.MEMPROFILEPATH}">
				<span class="accName">${data.MEMID}</span>
			</div>
			<div class="sign-in-form style-1">
				<table style="width:100%" id="modalTable">
					<tr>
						<td colspan="2">
							<span class="accName">예약 정보</span>
						</td>
					</tr
					<tr>
						<td class="accInfo">숙소 이름</td>
						<td>${data.ACCNAME}</td>
					</tr>
					<tr>
						<td class="accInfo">예약 일자</td>
						<td>${data.ARESREGDATE}</td>
					</tr>
					<tr>
						<td class="accInfo">체크인</td>
						<td>${data.CHECKIN}</td>
					</tr>
					<tr>
						<td class="accInfo">체크인</td>
						<td>${data.CHECKOUT}</td>
					</tr>
					<tr>
						<td class="accInfo">가격</td>
						<td>${data.TOTAL}</td>
					</tr>
				</table>
			</div>
		</div>
	`;

	revenueCont.innerHTML = modalCont;

	modal.click();
}