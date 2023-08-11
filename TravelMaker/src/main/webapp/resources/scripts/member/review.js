$(document).ready(function() {
	//페이징 및 탭 관리
	let tab = $(".reviewTab");
	let area = $(".pagingArea");

	let typeInput = $("#reviewType");
	let pageInput = $("#page");

	renderReview();

	let tabLi1 = $("#tabLi1");
	let tabLi2 = $("#tabLi2");
	
	let tabActive = typeInput.val();
	
	if(tabActive == "host") {
	    tabLi1.addClass("active");
	    tabLi2.removeClass("active");
	} else if(tabActive == "acc") {
	    tabLi1.removeClass("active");
	    tabLi2.addClass("active");
	}

	tab.on("click", function(event) {
		event.preventDefault();
		
		let type = $(this).data("type");
		
		typeInput.val(type);
		pageInput.val("1");

		renderReview();
	});

	area.on("click", "a", function(event) {
		event.preventDefault();
		
		let pageNo = $(this).data('page');
		
		pageInput.val(pageNo);
		renderReview();
	});
	//페이징 및 탭 관리

	$(document).on("click", ".moreContent", function() {
		let btnText = $(this).text();
		
		let content = $(this).parent().find("p");
		
		if(btnText == "더 보기") {
			content.css({
				"display": "block",
				"-webkit-line-clamp": "initial",
				"-webkit-box-orient": "vertical",
				"overflow": "initial",
				"text-overflow": "initial"
			});
			
			$(this).text("접기");
		} else if(btnText == "접기") {
			content.css({
				"display": "-webkit-box",
				"-webkit-line-clamp": "3",
				"-webkit-box-orient": "vertical",
				"overflow": "hidden",
				"text-overflow": "ellipsis"
			});
			$(this).text("더 보기")
		}
		
	}); 
	//더 보기 처리
	
	//리뷰 삭제
	$(document).on("click", ".reviewDelete", function() {
		event.preventDefault();
		
		let no = $(this).data("no");
		
		let token = $("meta[name='_csrf']").attr("content");
		let header = $("meta[name='_csrf_header']").attr("content");

		let reviewData = {accReviewNo: no};

		$.ajax({
			url: "/review/deleteAccReview",
			type: "post",
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);				
	        },
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(reviewData),
	        success: function(res) {
				console.log("결과 : " + res);
	        	if(res == "OK") {
					swal("삭제되었습니다.", "", "success");
					renderReview();
	        	} else if(res == "FORBIDDEN") {
	        		swal("해당 사용자가 아닙니다.", "", "error");
	        	} else {
	        		swal("삭제에 실패했습니다.", "", "error");
	        	}
	        },
	        error: function(xhr) {
	        	console.log(xhr.status);
	        }
		}); 
	});
	//리뷰 삭제
	
	//리뷰 수정
	let reviewModal = $("#reviewModal");
	let reviewEditNo;
	
	$(document).on("click", ".reviewEdit", function() {
		event.preventDefault();
		
		reviewEditNo = $(this).data("no");

		let myElement = $(this).parent(".comment-content").find(".reviewContent");

		drawReviewModal(myElement.text().trim());

		reviewModal.click();
	});

	//리뷰 수정
	$(document).on("click", "#updateBtn", function() {
		let updateContent = $("#updateContent");
		let clean = $("#clean");
		let location = $("#location");
		let checkin = $("#checkin");
		let valueformoney = $("#valueformoney");

		let value = updateContent.val();
		
		if(value == null || value == "") {
			swal("후기 내용을 작성해주세요.", "", "error");
			updateContent.focus();
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
			"accReviewNo": reviewEditNo,
			"accReviewContent": value,
			"clean": cleanScore,
			"location": locationScore,
			"checkin": checkinScore,
			"valueformoney": valueformoneyScore
		}
		
		console.log(data);

		$.ajax({
			url: "/review/updateAccReview",
			type: "post",
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);				
	        },
			contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(data),
	        success: function(res) {
	        	console.log(res);
	        	if(res == "OK") {
					swal("리뷰가 수정되었습니다.", "", "success");
	        		renderReview();
					$(".mfp-close").click();
	        	} else {
	        		swal("수정에 실패했습니다.", "", "error");
	        	}
	        },
	        error: function(xhr) {
	        	console.log(xhr.status);
	        }
		});
	});
	//리뷰 수정

	//신고
	$(document).on("change", "input:radio[name='blameReason']", function() {
		var checkedValue = $("input:radio[name='blameReason']:checked").val();
		if (checkedValue !== '기타') {
			$("#blameReasonTxt").css("display", "none");
			$("#blameReasonTxt").val("");
		} else {
			$("#blameReasonTxt").css("display", "block");
		}
	});


	let blameModal = $("#blameModal");
	let reviewNo = "";
	let hostNo = "";

	$(document).on("click", ".blame", function() {
		event.preventDefault();

		reviewNo = $(this).data("no");
		hostNo = $(this).data("host");

		drawBlameModal();

		blameModal.click();
	});

	$(document).on("click", "#blameSave", function() {
		let checkedValue = $("input:radio[name='blameReason']:checked").val();
		let token = $("meta[name='_csrf']").attr("content");
		let header = $("meta[name='_csrf_header']").attr("content");

		if(checkedValue == '기타') {
			checkedValue = $("#blameReasonTxt").val();
		}
		
		if(checkedValue == "" || checkedValue == null) {
			return false;
		}

		let memNo = $("#memNo").val();

		data = {
			"reviewNo": reviewNo,
			"blameReason" : checkedValue,
			"memNo" : memNo,
			"hostNo": hostNo
		};

		console.log(data);

		$.ajax({
			url: "/review/blameAcc",
			type: "post",
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);				
	        },
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(res) {
				if(res == "OK") {
					swal("신고가 정상적으로 접수되었습니다.", "", "info");
					$(".mfp-close").click();
				} else {
					swal("신고 접수가 실패했습니다.", "", "error");
				}
			},	
			error: function(xhr) {
				console.log(xhr.status);
			}
		}); 
	});
	//신고
});

let typeInput = $("#reviewType");
let pageInput = $("#page");

let hostReview = $("#hostReview");
let myReview = $("#myReview");
let pagination = $(".pagination");

let mytab1 = $("#mytab1");
let mytab2 = $("#mytab2");

function renderReview() {
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

	hostReview.empty();
	myReview.empty();
	pagination.empty();

	let memId = $("#memId").val();
	let memProfilePath = $("#memProfilePath").val();

	let page = pageInput.val();
	let type = typeInput.val();

	$.ajax({
		url: `/review/selectReview?page=${page}&type=${type}`,
		type: "get",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(res) {
			let str = "";
			console.log(res);
			if(res.dataList.length > 0) {
				str = "<ul>";
				if(type == "host") {
					console.log(res);
					for(let i = 0; i < res.dataList.length; i++) {
						let img = res.dataList[i].hostProfilePath;
						let imgTag = "";
						if(img == null || img == "") {
							imgTag = `<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">`;
						} else {
							imgTag = `<img src="${res.dataList[i].hostProfilePath}">`;
						}

						str += `
						<li>
							<div class="avatar">
								${imgTag}
							</div>
							<div class="comment-content">
								<div class="arrow-comment"></div>
								<div class="comment-by">
								
									<div class="comment-by-listing">
										<a href="#">${res.dataList[i].hostId}</a>
									</div>
									
									<span class="date">${res.dataList[i].memReviewRegDate}</span>
								</div>
								
								<div class="contentAndButton">
									<p class="reviewContent">
										${res.dataList[i].memReviewContent}
									</p>
								</div>

								<a href="" class="rate-review blame" data-no="${res.dataList[i].memReviewNo}" data-host="${res.dataList[i].hostNo}" style="background: red; color: white;">
									<i class="sl sl-icon-bell"></i> 신고
								</a>
							</div>
						</li>`;
					}
					str += "</ul>";

					mytab1.show();
					mytab2.hide();
					hostReview.html(str);

					createElement();
					pagination.eq(0).html(res.pagingHTML);

				} else if(type == "acc") {
					console.log(res);
					
					if(memProfilePath == null || memProfilePath == "") {
						memProfilePath = "http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70";
					} 
					
					for(let i = 0; i < res.dataList.length; i++) {
						str += `
						<li>
							<div class="avatar">
								<img src="${memProfilePath}">
							</div>
							<div class="comment-content">
								<div class="arrow-comment"></div>
								<div class="comment-by">
									${memId}
									<div class="comment-by-listing own-comment">
										<a href="#">${res.dataList[i].accName}</a>
									</div>
									
									<span class="date">${res.dataList[i].accReviewRegDate}</span>
									
									<div class="star-rating drawRating" data-rating="${res.dataList[i].rating}">
										<div class="myrate">
											<span class="rateCal"></span>
										</div>
									</div>
								</div>
								
								<div class="contentAndButton">
									<p class="reviewContent">
										${res.dataList[i].accReviewContent}
									</p>
								</div>
								
								<a href="" class="rate-review reviewEdit popup-with-zoom-anim" data-no="${res.dataList[i].accReviewNo}" style="background: blue; color: white;"> 
									<i class="sl sl-icon-note"></i> 수정
								</a>
								
								<a href="" class="rate-review reviewDelete" data-no="${res.dataList[i].accReviewNo}" style="background: red; color: white;">
									<i class="sl sl-icon-close"></i> 삭제
								</a>
							</div>
						</li>`;
					}
				}
				str += "</ul>";
					
				mytab1.hide();
				mytab2.show();

				myReview.html(str);
				createElement();
				pagination.eq(1).html(res.pagingHTML); 
			} else {
				if(page == "1") {
					let str = "<ul><li><h4>리뷰가 없습니다.</h4></li></ul>";

					if(type == "host") {
						hostReview.html(str);
						mytab1.show();
						mytab2.hide();
					} else {
						myReview.html(str);
						mytab1.hide();
						mytab2.show();
					}
				} else {
					pageInput.val(page - 1);
					renderReview();
				}
			}
		},
		error: function(xhr) {
			console.log(xhr.status);
		}
	}); 
}

function createElement() {
	$(".contentAndButton").each(function() {
	    let reviewContent = $(this).find(".reviewContent");
	    let text = reviewContent.text();

	    if (text.length > 138) {
	      	let button = $("<button>", {
	        	class: "moreContent",
	        	text: "더 보기",
	      	});
	        $(this).append(button);
	    }
	});

	//별점 그리기
	let drawRating = $(".drawRating");
	for(let i = 0; i < drawRating.length; i++) {
		let ratingScore = drawRating.eq(i).data("rating");

		let integerPart = Math.floor(ratingScore);
		let decimalPart = (ratingScore % 1).toFixed(1);
		
		width = (integerPart * 20) + (decimalPart * 20);
		
		drawRating.eq(i).find("span").css("width", width + "%");
	} 
	//별점 그리기
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

function drawReviewModal(text) {
	$("#reviewModalContent").empty();
	
    let str = `
    <div id="small-dialog" class="zoom-anim-dialog">
        <div class="small-dialog-header">
            <h3>후기 수정</h3>
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
            <textarea cols="40" rows="3" id="updateContent">${text}</textarea>
            <button class="button" id="updateBtn">등록</button>
        </div>
        <button title="닫기" type="button" class="mfp-close" id="closeBtn"></button>
    </div>`;

    $("#reviewModalContent").html(str);
}

function drawBlameModal() {
	$("#blameModalContent").empty();

	let str = `
	<div id="sign-in-dialog" class="zoom-anim-dialog">
		<div class="small-dialog-header">
			<h3>신고 사유</h3>
		</div>

		<div class="sign-in-form style-1">
			<div class="tabs-container alt">
				<div class="tab-content">
					<ul>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason1" value="욕설이 포함되어 있습니다." style="position: absolute;" />
							<label for="blameReason1" style="position: relative; margin-left: 27px; transform: translateY(-6px);">욕설이 포함되어 있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason2" value="타 사이트 홍보글이 게재되어 있습니다." style="position: absolute;" />
							<label for="blameReason2" style="position: relative; margin-left: 27px; transform: translateY(-6px);">홍보글이 게재되어 있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason3" value="잘못된 정보가 기입되어있습니다." style="position: absolute;" />
							<label for="blameReason3" style="position: relative; margin-left: 27px; transform: translateY(-6px);">잘못된 정보가 기입되어있습니다.</label>
						</li>
						<li>
							<input type="radio" class="input-radio" name="blameReason" id="blameReason4" value="기타" style="position: absolute;" />
							<label for="blameReason4" style="position: relative; margin-left: 27px; transform: translateY(-6px);">기타</label>
							<textarea rows="" cols="" id="blameReasonTxt" style="display:none;"></textarea>
						</li>
					</ul>
					<hr/>
					<button id="blameSave" style="float:right;">신고하기</button>
				</div>
			</div>
			<button title="닫기" type="button" class="mfp-close" id="closeBtn2"></button>
		</div>
	</div>`;

	$("#blameModalContent").html(str);
}