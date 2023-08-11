/* const columnDefs = [
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
}; */

$(function() {
	var start = moment().subtract(1, 'months');
	var end = moment(); 
    
    function cb(start2, end2) {
		start = start2;
		end = end2;

        $('#booking-date-range span').html(start.format('YYYY-MM-DD') + ' - ' + end.format('YYYY-MM-DD'));

		let data = {
			"category": $("#categorySelect").val(),
			"startDate": start.format('YYYY-MM-DD'),
			"endDate": end.format('YYYY-MM-DD')
		};

		getTextData(data);
        getPieChart(data);
        getGraphChart(data);
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

	$("#categorySelect").on("change", function() {
		cb(start, end);
	});
});

let totalPrice = $("#totalPrice");
let discountPrice = $("#discountPrice");
let reservationCount = $("#reservationCount");

function getTextData(data) {
	console.log(data);
	
	let header = document.querySelector("meta[name='_csrf_header']").content;
	let token = document.querySelector("meta[name='_csrf']").content;

	var xhr = new XMLHttpRequest();
	xhr.open("post", "/admin/getTextData", true);
	xhr.setRequestHeader(header, token);
	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
	xhr.onreadystatechange = function() {
		if(xhr.status == 200 && xhr.readyState == 4) {
			let result = JSON.parse(xhr.responseText); 
			console.log("텍스트 데이터 결과 ", result);

			totalPrice.html(Number(result.TOTAL).toLocaleString());
			discountPrice.html(Number(result.DISCOUNT).toLocaleString());
			reservationCount.html(Number(result.COUNT).toLocaleString());
		}
	}
	xhr.send(JSON.stringify(data));
}

let chart1 = null;
let chart2 = null;
const ctx1 = document.querySelector('#myChart1').getContext('2d');
const ctx2 = document.querySelector("#myChart2");

function getPieChart(data) {
	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/admin/getPieChartData", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let pieLabels = [];
			let dataArray = [];
			let colorArray = [];
			let responseArray = JSON.parse(xhr.responseText);
			
			console.log("파이차트 결과 ", responseArray);
            let divObj = document.querySelectorAll(".accOption");
			
			console.log("길이길이 ", divObj.length);			
			for(let i = 0; i < divObj.length; i++) {
				var no = divObj[i].dataset["no"];
				
				let flag = false;
				
				for(let j = 0; j < responseArray.length; j++) {
					console.log("bbb");
					if(no == responseArray[j].CATEGORY) {
						pieLabels.push(responseArray[j].CATEGORYNAME);
                        dataArray.push(responseArray[j].PRICE);
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
				
				colorArray.push(str);
			}
	
			console.log("1", pieLabels);
			console.log("2", dataArray);
			console.log("3", colorArray);
		
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
                        padding: 10 
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
  	xhr.open("post", "/admin/getGraphChartData", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let labels = [];
			let avgAccData = [];
			let categoryAccData = [];
			
			let responseArray = JSON.parse(xhr.responseText);
			
			console.log("그래프 차트 결과 ", responseArray);

			for(let i = 0; i < responseArray.length; i++) {
				labels.push(responseArray[i].AVGMONTH);
				avgAccData.push(responseArray[i].AVGPRICE);
				categoryAccData.push(responseArray[i].CATEGORYAVGPRICE);
			}

            console.log("카테고리 ", categoryAccData);

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
				        label: '카테고리 숙소 총 매출',
				        data: categoryAccData,
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

/* function reservationList(data) {
    let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/admin/getRevenueList", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
            let result = JSON.parse(xhr.responseText);

			for(let i = 0; i < result.length; i++) {
				
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
}); */