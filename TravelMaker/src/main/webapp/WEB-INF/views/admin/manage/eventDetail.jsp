<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:csrfMetaTags/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<style>
	/* 컨테이너 CSS 화면은 무조건 80%로 봐야함 */
	.con {
		opacity: 0; /* 초기에는 투명하게 설정 */
    	animation: fade-in-animation 1s ease-in forwards; /* 애니메이션 속성 설정 */
	}
	
	@keyframes fade-in-animation {
      from {
        opacity: 0; /* 시작 시 투명 */
      }
      
      to {
        opacity: 1; /* 끝나는 시점에 불투명 */
      }
    }
    
	/* 컨테이너 CSS 끝 */

	/* footer CSS */
	footer {
		height: 1vh;
		background-color: white;
		position: fixed;
		left: 0;
		bottom: 0;
		width: 79vw;
		margin-bottom: 5rem;
		z-index: 10;
		margin-left: 260px;
	}
	@media screen and (max-height: 600px) {
		footer {
			position: static;
		}
	}
	/* footer CSS End */
	
	.button-container {
		display: flex;
		justify-content: space-between;
		background-color: white;
		z-index: 20;
		margin: 0;
		height: 5.5rem;
	}

	.button-container > div {
		margin: 1rem 0 1rem 5rem;
	}

	.button-container > div:last-child {
		justify-content: flex-end;
		align-items: center;
		margin-right: 5rem;
	}

	.button-container button {
		width: 6rem;
		height: 3rem;
	}
	#dashboard{
		min-height: 65vh;
		background-color: white;
	}
	
	/* Session0 CSS */
	#container0 {
		width: 65%;
		margin: 5% auto;
	}
	
	#container0  div i {
		font-size: 1.5rem;
		margin: 1rem 6.5rem 0.5rem 0;
	}
	
	#container0 .categoryItem {
		display: inline-block;
		margin: 0.1rem 1rem 1rem 0;
	}
	
	#container0 .categoryItem button{
		width: 11rem;
		height: 6rem;
	}
	
	#container0 > div:nth-child(1) {
		margin-bottom: 30%;
	}
	
	#container0 .categoryItem button > div:nth-child(2) {
		float: left;
	}
	
	#container0 .w3-button.checked {
		background-color: #d5d5d5 !important;
	}
	/* Session0 CSS end */

	/* The Close Button */
	.close {
		color: #aaaaaa;
		float: right;
		margin: 0 0 0 0;
		font-size: 1.5rem;
		font-weight: bold;
	}

	.close:hover,
	.close:focus {
		color: #000;
		text-decoration: none;
		cursor: pointer;
	}
	
	.representative {
		border: 1px dotted black;
		width: 98.5%;
		height: 15rem;
		max-width: 95%;
		max-height: 25rem;
		display: inline-block;
		position: relative;
	}
</style>

˙
<div class="dashboard-content">
	<div id="container0" class="con">
		<div>
			<h1>이벤트를 등록할 숙소 카테고리</h1>
			<div>
				<c:forEach var="cotOption" items="${cotOptions }">
					<div class="categoryItem">
						<button class="w3-button w3-white w3-border w3-border-gray w3-round-large" data-item="${cotOption.optionNo }">
							<div><i class="${cotOption.attGroupNo }"></i></div>
							<div>${cotOption.optionName }</div>
						</button>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div id="container1" class="con">
		<div>
			<div>
				<div class="add-listing-section">
					<div class="add-listing-headline">
						<h3><i class="sl sl-icon-doc"></i> 이벤트 등록</h3>
					</div>

					<div class="row with-forms">
						<div class="col-md-12">
							<h5>이벤트 명</h5>
							<input id="eventTitle" class="search-field" type="text" value="">
						</div>
					</div>

					<div class="row with-forms">
						<div class="col-md-6">
							<h5>이벤트 시작일자 <i class="tip" data-tip-content="호스트 승인을 위해 여유있는 날짜를 선택해주세요."><div class="tip-content"></div></i></h5>
							<input type="date" id="eventStartDate">
						</div>
						<div class="col-md-6">
							<h5>이벤트 종료일자 <i class="tip" data-tip-content="시작일자 이후로 설정해주세요."><div class="tip-content"></div></i></h5>
							<input type="date" id="eventEndDate">
						</div>
						
						<div class="col-md-6">
							<h5>할인율 <i class="tip" data-tip-content="할인율은 %단위로 적용됩니다."><div class="tip-content"></div></i></h5>
							<input type="number" id="eventDiscountRate" placeholder="할인율을 입력해주세요.">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>

<footer>
	<div class="w3-border">
	</div>
	<div>
		<div class="button-container">
			<div>
				<button id="prevBtn" class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">뒤로</button>
				<button id="cancelBtn" class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">메인이동</button>
			</div>
			<div>
				<button id="autoBtn" class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">입력</button>
				<button id="nextBtn" class="w3-btn w3-white w3-border w3-border-black w3-text-black w3-round-large">다음</button>
			</div>
		</div>
	</div>
</footer>

<script>
$(function(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	let accCount = 0;

	var buttons = document.querySelectorAll('#container0 button');
	// console.log("컨테이너0 버튼 요소 체크", buttons);
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].addEventListener('click', function() {
	    // 기존에 checked 클래스를 가진 버튼들에서 checked 클래스 제거
	    var checkedButtons = document.querySelectorAll('.categoryItem button.checked');
	    for (var j = 0; j < checkedButtons.length; j++) {
	      checkedButtons[j].classList.remove('checked');
	    }
	    
	    // 클릭한 버튼에 checked 클래스 추가
	    this.classList.add('checked');
	  });
	}

    var prevBtn = document.querySelector('#prevBtn');
	var nextBtn = document.querySelector('#nextBtn');
	var cancelBtn = document.querySelector('#cancelBtn');
	var container = document.querySelectorAll('.con');
	var autoBtn = document.querySelector("#autoBtn");
	
	var eventDiscountRate = document.querySelector('#eventDiscountRate');
	var eventStartDate = document.querySelector('#eventStartDate');
	var eventEndDate = document.querySelector('#eventEndDate');
	var eventTitle = document.querySelector("#eventTitle");
	
	toggleContainer();
	
	/* 중복 insert 하는 걸 방지 한다 */
	var accRegProcess = true;

	prevBtn.addEventListener('click', function() {
		accRegProcess = false;
		console.log("prev -> " + accRegProcess + " num -> " + accCount)

		accCount--;
		nextBtn.innerHTML = "다음";
		
		// getForm(accCount);
		toggleContainer();
	});
	

	cancelBtn.addEventListener('click', function() {
	    if (confirm("이벤트 등록을 취소하겠습니까?")) {
	        location.href = "/admin/manage/event";
	    }
	});
	
	var dataNo = "";
	var data = {};
	nextBtn.addEventListener('click', function() {

		if(accCount != 0) {
			accRegProcess = false;
		}

		if(accCount == 0){
			var checkCategoryItem = document.querySelector('.categoryItem > .checked');
			var item = checkCategoryItem ? checkCategoryItem.getAttribute('data-item') : null;
			if(item == null || item == ""){
				alert("숙소의 유형을 선택해주세요.");
				return false;
			}

			data.optionNo = item;
			accCount++;
			toggleContainer();
			
		} else if(accCount == 1){
			if(eventTitle.value == "") {
				swal("이벤트 명을 입력해주세요.","","error")
				return false;
			}
		    if (eventDiscountRate.value === "" || eventDiscountRate.value <= 0) {
		        swal("할인율을 입력해주세요.","","error");
		        return false;
		    }
		    if (eventStartDate.value === "") {
		        swal("이벤트 시작일을 입력해주세요.","","error");
		        return false;
		    }
		    if (eventEndDate.value === "") {
		        swal("이벤트 종료일을 입력해주세요.","","error");
		        return false;
		    }
		    if (eventStartDate.value > eventEndDate.value) {
		        swal("종료일은 시작일 이후로 입력해주세요.","","error");
		        eventEndDate.value = "";
		        return false;
		    }
		    
			data.eventTitle = eventTitle.value;
		    data.eventDiscountRate = eventDiscountRate.value;
		    data.eventStartDate = eventStartDate.value;
		    data.eventEndDate = eventEndDate.value;
		    
		    insertEvent(data);
		}
		
	});

	function insertEvent(data){
		$.ajax({
			url: '/admin/manage/insertEvent',
			type: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success: function(res){
				if(res.result == "SUCCESS"){
				    swal("이벤트 등록에 성공하였습니다.","","success");
					location.href = "/admin/manage/event";
				} else {
				    alert(res.result);
				    return false;
				}
			},
			error: function(error){
				console.log("error", error);
			}
		});
	}
	
	function toggleContainer() {
		if(accCount == 0) {
			prevBtn.style.visibility = "hidden";
		} else {
			prevBtn.style.visibility = "visible";
		}

		if (accCount == 1) {
			nextBtn.innerHTML = "등록";
		} else {
			nextBtn.innerHTML = "다음";
		}

		console.log("accCount i : ", accCount);
		for(var i=0; i<container.length; i++){
			/* console.log("accCount i", i); */
			if(i == accCount){
				container[i].style.display = 'block';
			} else{
				container[i].style.display = 'none';
			}
		}
		
	}

	autoBtn.addEventListener("click",function(){
		eventTitle.value = "여름 맞이 시원한 호캉스!";
		var sd = "2023-08-20";
		var ed = "2023-09-20";
		var sday = new Date(sd);
		var eday = new Date(ed);
		var formattedStartDate = formatDate(sday);
		var formattedEndDate = formatDate(eday);
		eventStartDate.value = formattedStartDate;
		eventEndDate.value = formattedEndDate;


		eventDiscountRate.value = 7;

	});

	function formatDate(date) {
		var year = date.getFullYear();
		var month = String(date.getMonth() + 1).padStart(2, "0");
		var day = String(date.getDate()).padStart(2, "0");
		return year + "-" + month + "-" + day;
	}
});


</script>
 