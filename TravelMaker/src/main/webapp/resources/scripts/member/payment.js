document.addEventListener("DOMContentLoaded", function() {
    var start = moment().subtract(1, 'months');
	var end = moment(); 
    
    let filter = $("#filterType");
    
    function cb(start2, end2) {
        $('#booking-date-range span').html(start2.format('YYYY-MM-DD') + ' - ' + end2.format('YYYY-MM-DD'));

        start = start2;
        end = end2;

        let data = {
            filterType: filter.val(), 
            startDate: start2.format("YYYY-MM-DD"),
            endDate: end2.format("YYYY-MM-DD")
        }
        
        getList(data);
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

    filter.on("change", function() {
        let val = filter.val();
        
        let data = {
            filterType: val, 
            startDate: start.format("YYYY-MM-DD"),
            endDate: end.format("YYYY-MM-DD")
        }
    
        getList(data);
    });
    
    let dataObj = {
        filterType: filter.val(), 
        startDate: start.format("YYYY-MM-DD"),
        endDate: end.format("YYYY-MM-DD")
    }
    
    getList(dataObj);
    

    //리뷰 수정
    let accNo = "";
    let aresNo = "";

    $(document).on("click", ".registerReview", function() {
        accNo = $(this).data("acc");
        aresNo = $(this).data("no");

        drawModal();
        $("#reviewModal").click();
    });
    
    //리뷰 작성
    $(document).on("click", "#register", function() {
        let clean = $("#clean");
        let location = $("#location");
        let checkin = $("#checkin");
        let valueformoney = $("#valueformoney");
        let registerContent = $("#registerContent");

        let value = registerContent.val();
        
        if(value == null || value == "") {
            swal("후기 내용을 작성해주세요.", "", "error");
            registerContent.focus();
            return false;
        } 
        
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        
        let cleanScore = getRating(clean);
        let locationScore = getRating(location);
        let checkinScore = getRating(checkin);
        let valueformoneyScore = getRating(valueformoney);
        
        if(cleanScore == 0) {
            swal("최소 1점입니다.", "", "error");
            return false;
        }
        if(locationScore == 0) {
            swal("최소 1점입니다.", "", "error");
            return false;
        }
        if(checkinScore == 0) {
            swal("최소 1점입니다.", "", "error");
            return false;
        }
        if(valueformoneyScore == 0) {
            swal("최소 1점입니다.", "", "error");
            return false;
        }

        let data = {
            "accNo": accNo,
            "aresNo": aresNo,
            "accReviewContent": value,
            "clean": cleanScore,
            "location": locationScore,
            "checkin": checkinScore,
            "valueformoney": valueformoneyScore
        }
        
        console.log(data);
        
        $.ajax({
            url: "/review/insertAccReview",
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);				
            },
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data),
            success: function(res) {
                console.log(res);
                if(res == "OK") {
                    swal("리뷰가 작성되었습니다.", "", "success");
                    $(".mfp-close").click();
                } else {
                    swal("리뷰 작성에 실패했습니다.", "", "error");
                }
            },
            error: function(xhr) {
                console.log(xhr.status);
            }
        });
    });
    //리뷰 작성
});

$('#booking-date-range').on('show.daterangepicker', function(ev, picker) {
	$('.daterangepicker').addClass('calendar-visible calendar-animated bordered-style');
	$('.daterangepicker').removeClass('calendar-hidden');
});

$('#booking-date-range').on('hide.daterangepicker', function(ev, picker) {
	$('.daterangepicker').removeClass('calendar-visible');
	$('.daterangepicker').addClass('calendar-hidden');
});

function getList(obj) {
    let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
    $.ajax({
        url: "/payment/selectList",
        type: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
        data: JSON.stringify(obj),
        contentType: "application/json; charset=utf-8",
        success: function(res) {
            let str = "";
            let today = moment();

            console.log(res);

            $.each(res, function(i, v) {
                if(v.ACCNO != "" && v.ACCNO != null) {
                    str += `
                    <li class="pending-booking paymentLiTag">
                        <div class="list-box-listing bookings">
                            <div class="list-box-listing-img">
                                <img src="${v.ATTPATH}">
                            </div>
                            <div class="list-box-listing-content">
                                <div class="inner">
                                    <h3>
                                        ${v.TYPENAME}
                                    </h3>

                                    <div class="inner-booking-list">
                                        <h5>예약 날짜</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">${v.STARTTIME} - ${v.ENDTIME}</li>
                                        </ul>
                                    </div>

                                    <div class="inner-booking-list">
                                        <h5>예약 상세</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">${v.NUMBEROFPEOPLE}명</li>
                                        </ul>
                                    </div>

                                    <div class="inner-booking-list">
                                        <h5>금액</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">$${v.PAYMENTTOTALPRICE}</li>
                                        </ul>
                                    </div>

                                    <div class="inner-booking-list">
                                        <h5>호스트:</h5>
                                        <ul class="booking-list">
                                            <li>${v.HOSTNAME}</li>
                                            <li>${v.HOSTEMAIL}</li>
                                            <li>${v.HOSTPHONE}</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="buttons-to-right">
                            <a href="/payment/receipt?paymentNo=${v.PAYMENTNO}&type=acc" class="button gray reject paymentATAG" style="background: #5177dc; color: white;">
                                <i class="im im-icon-Receipt-2"></i> 영수증
                            </a>
                        </div>`;
                    if(today.isAfter(v.ENDTIME)) {
                        str += `
                        <div class="buttons-to-right" style="margin-right: 100px;">
                            <a href="#" class="button gray reject registerReview" data-acc="${v.ACCNO}" data-no="${v.ARESNO}" style="background: #5177dc; color: white;">
                                <i class="sl sl-icon-note"></i> 리뷰 작성
                            </a>
                        </div></li>
                        `;
                    } else {
                        str += "</li>";
                    }
                    
                } else {
                    let path = findPath(v.TYPENAME);

                    str += `
                    <li class="pending-booking paymentLiTag">
                        <div class="list-box-listing bookings">
                            <div class="list-box-listing-img">
                                <img src="${path}" alt="">
                            </div>
                            <div class="list-box-listing-content">
                                <div class="inner">
                                    <h3>
                                        ${v.TYPENAME}
                                    </h3>

                                    <div class="inner-booking-list">
                                        <h5>예약 날짜</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">${v.STARTTIME} - ${v.ENDTIME}</li>
                                        </ul>
                                    </div>

                                    <div class="inner-booking-list">
                                        <h5>예약 상세</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">${v.NUMBEROFPEOPLE}명</li>
                                        </ul>
                                    </div>

                                    <div class="inner-booking-list">
                                        <h5>금액</h5>
                                        <ul class="booking-list">
                                            <li class="highlighted">$${v.PAYMENTTOTALPRICE}</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="buttons-to-right">
                            <a href="/payment/receipt?paymentNo=${v.PAYMENTNO}&type=flight" class="button gray reject paymentATAG" style="background: #5177dc; color: white;">
                                <i class="im im-icon-Receipt-2"></i> 영수증
                            </a>
                        </div>
                    </li>`;
                }
            });
            $("#paymentUL").html(str);
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
}

function findPath(str) {
    let path = "";

    if(str == "대한항공"){
		path = "../resources/images/daehan.png";
	}else if(str == "제주항공"){
		path = "../resources/images/jeju.png";
	}else if(str == "진에어"){
		path = "../resources/images/jinair.jpg";
	}else if(str == "에어로케이"){
		path = "../resources/images/aerok.png";
	}else if(str == "아시아나"){
		path = "../resources/images/asiana.jpg";
	}else if(str == "에어부산"){
		path = "../resources/images/airbusan.jpg";
	}else if(str == "이스타항공"){
		path = "../resources/images/eastar.jpg";
	}else if(str == "하이에어"){
		path = "../resources/images/hiair.jpg";
	}else if(str == "티웨이항공"){
		path = "../resources/images/tway.jpg";
	}else if(str == "에어서울"){
		path = "../resources/images/airseoul.jpg";
	}

    return path;
}

function getRating(obj) {
	let rating = obj.find("input[name='rating']");
	
	let score = 0;
	for(let i = 0; i < rating.length; i++) {
		if(rating.eq(i).prop("checked")) {
			if(i == 0) {
				score = 5;
			} else if(i == 1) {
				score = 4;
			} else if(i == 2) {
				score = 3;
			} else if(i == 3) {
				score = 2;
			} else if(i == 4) {
				score = 1;
			} 
		}
	}
	
	return score;
}

function drawModal() {
    $("#reviewModalContent").empty();
    let str = `
    <div id="sign-in-dialog" class="zoom-anim-dialog">
        <div class="small-dialog-header">
            <h3>후기 작성</h3>
        </div>
        <div class="sub-ratings-container">
            <div class="add-sub-rating">
                <div class="sub-rating-title">청결도 
                    <i class="tip" data-tip-content="숙소가 깨끗했나요?"></i>
                </div>
                <div class="sub-rating-stars" id="clean">
                    <div class="clearfix"></div>
                    <div class="leave-rating">
                        <input type="checkbox" name="rating" id="rating-1" value="1">
                        <label for="rating-1" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-2" value="2">
                        <label for="rating-2" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-3" value="3">
                        <label for="rating-3" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-4" value="4">
                        <label for="rating-4" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-5" value="5">
                        <label for="rating-5" class="fa fa-star"></label>
                    </div>
                </div>
            </div>

            <div class="add-sub-rating">
                <div class="sub-rating-title">위치 
                    <i class="tip" data-tip-content="위치가 마음에 드셨나요?">
                        <div class="tip-content">위치가 마음에 드셨나요?</div>
                    </i>
                </div>
                <div class="sub-rating-stars" id="location">
                    <div class="clearfix"></div>
                    <div class="leave-rating">
                        <input type="checkbox" name="rating" id="rating-11" value="1">
                        <label for="rating-11" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-12" value="2">
                        <label for="rating-12" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-13" value="3">
                        <label for="rating-13" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-14" value="4">
                        <label for="rating-14" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-15" value="5">
                        <label for="rating-15" class="fa fa-star"></label>
                    </div>
                </div>
            </div>

            <div class="add-sub-rating">
                <div class="sub-rating-title">체크인
                    <i class="tip" data-tip-content="체크인 시간이 좋았나요?">
                        <div class="tip-content">체크인 시간이 좋았나요?</div>
                    </i>
                </div>
                <div class="sub-rating-stars" id="checkin">
                    <div class="clearfix"></div>
                    <div class="leave-rating">
                        <input type="checkbox" name="rating" id="rating-21" value="1">
                        <label for="rating-21" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-22" value="2">
                        <label for="rating-22" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-23" value="3">
                        <label for="rating-23" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-24" value="4">
                        <label for="rating-24" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-25" value="5">
                        <label for="rating-25" class="fa fa-star"></label>
                    </div>
                </div>
            </div>
            
            <div class="add-sub-rating">
                <div class="sub-rating-title">가성비 
                    <i class="tip" data-tip-content="가성비가 좋다고 생각하시나요?">
                        <div class="tip-content">가성비가 좋다고 생각하시나요?</div>
                    </i>
                </div>
                <div class="sub-rating-stars" id="valueformoney">
                    <div class="clearfix"></div>
                    <div class="leave-rating">
                        <input type="checkbox" name="rating" id="rating-31" value="1">
                        <label for="rating-31" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-32" value="2">
                        <label for="rating-32" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-33" value="3">
                        <label for="rating-33" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-34" value="4">
                        <label for="rating-34" class="fa fa-star"></label>
                        <input type="checkbox" name="rating" id="rating-35" value="5">
                        <label for="rating-35" class="fa fa-star"></label>
                    </div>
                </div>
            </div>	
        </div>
        
        <div class="message-reply margin-top-0">
            <textarea cols="40" rows="3" id="registerContent"></textarea>
            <button class="button" id="register">등록</button>
        </div>
        <button title="닫기" type="button" class="mfp-close" id="closeBtn"></button>
    </div>`;

    $("#reviewModalContent").html(str);
}