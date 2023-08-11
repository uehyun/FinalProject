<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/chat.css">

<div class="dashboard-wrapper">
	<div class="dashboard-content">
	    <div class="messages-container">
	        <div class="messages-headline">
	            <h4>채팅 목록</h4>
	            <a href="#" class="message-action" id="detail" style="display: none;">
	                <i class="im im-icon-Address-Book"></i> <span style="text-decoration: underline; font-weight: bold;">세부 정보 보기</span>
	            </a>
	        </div>
	
	         <div class="messages-container-inner">
	            <!-- Messages -->
	            <div class="messages-inbox">
	                <ul>
						<c:forEach items="${chatList}" var="chat">
							<li class="unread" data-chatroom="${chat.chatroomNo}" data-accno="${chat.accNo}">
								<!-- 이거 비동기 처리 가능할 듯 -->
								<a>
								<div class="message-avatar">
									<!-- 상대방 프로필 사진 -->
									<c:if test="${chat.memNo eq memNo}">
										<img src="${pageContext.request.contextPath}${chat.hostProfilePath}" alt="" />
									</c:if>
									<c:if test="${chat.hostNo eq memNo}">
										<img src="${pageContext.request.contextPath}${chat.memProfilePath}" alt="" />
									</c:if>
								</div>

								<div class="message-by">
									<c:if test="${chat.hostNo eq memNo}">
										<div class="message-by-headline">
											<h5>${chat.memNo}</h5>
											<span>${chat.chatroomRegDate}</span>
										</div>
										<p id="msgArea">${chat.chatMessageContent}</p>
									</c:if>
									<c:if test="${chat.memNo eq memNo}">
										<div class="message-by-headline">
											<h5>${chat.hostNo }</h5>
											<span>${chat.chatroomRegDate}</span>
										</div>
										<p id="msgArea">${chat.chatMessageContent}</p>
									</c:if>
								</div>
								</a>
							</li>
						</c:forEach>
	                </ul>
	            </div>
	            <!-- Messages / End -->
	
	            <!-- Message Content -->
	            <div class="message-content" style="height: 650px;">
	                <div id="messageTextArea" style="height: 420px; overflow-y: scroll;"></div>
	
	                <!-- Reply Area -->
	                <div class="clearfix"></div>
						<div class="message-reply">
							<textarea cols="40" rows="3" placeholder="Your Message" id="chatContent"></textarea>
							<button class="button" id="send" style="float: right;">메세지 보내기</button>
						</div>
						
					</div>
	            <!-- Message Content -->
	        </div>
	    </div>
	</div>
	
	<!-- 예약 현황 div -->
	<div class="reservation-div">
    </div>
</div>

<!-- Content / End -->
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
let webSocket = null;
// 채팅방 정보
var chatroomNo = "${chatroomNo}";
var memNo = "${memNo}";		// 현재 세션 저장
var accNo;
var msgArea = document.querySelector("#msgArea");
var messageTextArea = document.querySelector("#messageTextArea");

var chatList = document.querySelectorAll(".unread");
// li 누르면 채팅 화면 바뀌게
chatList.forEach(function(element){
	element.addEventListener("click", function(){
		chatroomNo = this.dataset.chatroom;
		accNo = this.dataset.accno;
		messageTextArea.innerHTML = "";
		$("#detail").show();
		getMsg(chatroomNo, memNo);
	});
});

// 처음 들어왔을 때 해당 이용자랑 채팅하는거 해주기
$(function() {
    connect();
    
	$("#send").on("click", sendMessage);
    $("#chatContent").on("keydown", enter);
});

function connect() {
	webSocket = new WebSocket("ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/echo");
  
	webSocket.onopen = function(message) {
		
	    let key = {
		    chatroomNo : chatroomNo,
		    memNo : memNo,
			accNo : accNo,
			state : 0
	    };

		if(chatroomNo != null || chatroomNo != "") {
	    	getMsg(chatroomNo,memNo);
	    }
    
    	webSocket.send(JSON.stringify(key));
    };
    
  	webSocket.onclose = function(message) {};
	webSocket.onerror = function(message) {};
  
	webSocket.onmessage = function(message) {
	  
    let messageTextArea = document.getElementById("messageTextArea");

		messageTextArea.innerHTML += message.data;
		$('#messageTextArea').scrollTop($('#messageTextArea').prop('scrollHeight'));
		$('.message-bubble').each(function() {
			
			var userId = $(this).data('memno');
		
		    if (userId == memNo) {
				$(this).addClass(' me');
				$(this).css("float","right");
			}
		});
	};
}

function sendMessage() {
	let message = document.getElementById("chatContent");
	
	let key = {
	    chatroomNo : chatroomNo,
	    memNo : memNo,
		accNo : accNo,
	    message : message.value,
		state : 1
	};
	
	msgArea.innerHTML = message.value;

	webSocket.send(JSON.stringify(key));
	message.value = "";
}

function enter() {
	if (event.keyCode === 13) {
		sendMessage();
		return false;
	}
	
	return true;
};

function getMsg(chatroomNo,memNo) {
	$.ajax({
		url : "/member/getMsg",
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		data : JSON.stringify({
			"chatroomNo" : chatroomNo
		}),
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(res) {
			let messageTextArea = document.getElementById("messageTextArea");
			messageTextArea.innerHTML = res.msg;
			$('#messageTextArea').scrollTop($('#messageTextArea').prop('scrollHeight'));
			$('.message-bubble').each(function() {
				
				var userId = $(this).data('memno');
				if (userId == memNo) {
					$(this).addClass(' me');
					$(this).css("float","right");
				}
			});
		}
	});
}

// ===================================== 숙소 예약 div ==================================================
const messageActionLink = document.querySelector('.message-action');
const reservationDiv = document.querySelector('.reservation-div');
const reservationDivContent = reservationDiv.querySelector('.content');
const dashboardContent = document.querySelector('.dashboard-content');

messageActionLink.addEventListener('click', function (event) {
    event.preventDefault();
  	reservationDiv.style.width = '30%';
  	dashboardContent.classList.add('reservation-div-open');
  	adjustWidths();
});

document.addEventListener('click', function (event) {
    const target = event.target;
  	const isReservationDiv = target.closest('.reservation-div');
  	const isMessageActionLink = target.closest('.message-action');

    if(!isReservationDiv && !isMessageActionLink) {
    	reservationDiv.style.width = '0';
    	dashboardContent.classList.remove('reservation-div-open');
    	adjustWidths();
  	}
});

function adjustWidths() {
    const isReservationDivOpen = dashboardContent.classList.contains('reservation-div-open');

    if(isReservationDivOpen) {
	    dashboardContent.style.width = '70%';
	    reservationDiv.style.right = '0';
	    reservationDivContent.classList.remove('hidden');
    } else {
	    dashboardContent.style.width = '100%';
	    reservationDiv.style.right = '-30%';
	    reservationDivContent.classList.add('hidden');
    }
}
  
$("#detail").on("click", function() {
	if(accNo == null || accNo == "") {
		return false;
	}
	
	$.ajax({
		url: "/member/reservationDetail?accNo=" + accNo,
		type: "get",
		beforeSend : function(xhr) {
			$(".reservation-div").empty();
			xhr.setRequestHeader(header,token);
		},
		success: function(res) {
			console.log(res);
			
			if(res.ARES_NO == null) {
				let imgTag = "";
				if(res.HOST_PROFILE_PATH == null || res.HOST_PROFILE_PATH == "") {
					imgTag = `<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				} else {
					imgTag = `<img src="\${res.HOST_PROFILE_PATH}" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				}
				let str = `
					<div class="content">
			        	<div class="reservation-detail">
				        	<a href=#>
					            <img src="\${res.accImg}"/>
				        	</a>
				        	<h3>\${res.ACC_NAME}</h3>
				        	<h4>\${res.ACC_LOCATION}  \${res.ACC_POSTCODE}</h4>
			            	<br/>
			            	<br/>
							<div style="display : flex; border-top: 1px solid gainsboro; border-bottom: 1px solid gainsboro; align-items: center;">
								<div class="checkTime">
									<p>체크인 시간</p>
									<div>
										\${res.ACC_STANDARD_CHECKIN}
									</div>
								</div>
								<div class="checkTime">
									<p>체크아웃 시간</p>
									<div>
										\${res.ACC_STANDARD_CHECKOUT}
									</div>
								</div>
							</div>
							
							<div class="line"></div>
							
							<div style="padding-left: 20px; margin-top:20px; margin-bottom:10px; display: flex; align-items: center; flex-direction: column;">
								<h2>호스트: \${res.HOST_NAME}</h2>
								<h4>이메일: \${res.HOST_EMAIL}</h4>
								<h4>전화번호: \${res.HOST_PHONE}</h4>
								<div>
									\${imgTag}
								</div>
							</div>
							
							<div class="line"></div>
							
							<div class="line"></div>
							<div class="acc-button" style="text-align: center; margin-top: 10px;" data-accno="\${res.ACC_NO}">
								<i class="im im-icon-City-Hall"></i>&nbsp;&nbsp;  <span>숙소 보기</span>
							</div>
			        	</div>
			        </div>`;
			        
				$(".reservation-div").html(str);
			} else {
				let imgTag = "";
				if(res.HOST_PROFILE_PATH == null || res.HOST_PROFILE_PATH == "") {
					imgTag = `<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				} else {
					imgTag = `<img src="\${res.HOST_PROFILE_PATH}" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				}
				
				let imgTag2 = "";
				if(res.MEM_PROFILE_PATH == null || res.MEM_PROFILE_PATH == "") {
					imgTag2 = `<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				} else {
					imgTag2 = `<img src="\${res.MEM_PROFILE_PATH}" style="width: 60px; height: 60px; border-radius: 50%; display: inline-block;">`;
				}
				
				let str = `
					<div class="content">
			        	<div class="reservation-detail">
				        	<a href=#>
					            <img src="\${res.accImg}"/>
				        	</a>
				        	<h3>\${res.ACC_NAME}</h3>
				        	<h4>\${res.ACC_LOCATION}  \${res.ACC_POSTCODE}</h4>
			            	<br/>
			            	<br/>
							<div style="display : flex; border-top: 1px solid gainsboro; border-bottom: 1px solid gainsboro; align-items: center;">
								<div class="checkTime">
									<p>체크인</p>
									<div>
										\${res.ARES_CHECKIN_DATE}<br/>
										\${res.ACC_STANDARD_CHECKIN}
									</div>
								</div>
								<div class="checkTime">
									<p>체크아웃</p>
									<div>
										\${res.ARES_CHECKOUT_DATE}<br/>
										\${res.ARES_CHECKOUT}
									</div>
								</div>
							</div>
							
							<div class="line"></div>
							
							<h3>예약 세부정보</h3>
							<div style="padding-left: 20px; display: flex; align-items: center; flex-direction: column;">
								<h2>예약자: \${res.MEM_ID}</h2>
								<h4>예약자 이메일: \${res.MEM_NAME}</h4>
								<h4>예약자 전화번호: \${res.MEM_PHONE}</h4>
								<div>
									\${imgTag2}
								</div>
							</div>
							
				           	<div class="receipt-button" style="text-align: center; margin-top: 10px;" data-paymentno="\${res.PAYMENT_NO}">
				            	<i class="im im-icon-Receipt-3"></i>&nbsp;&nbsp;  <span>영수증 버튼</span>
				           	</div>
							<div class="line"></div>
							<div class="acc-button" style="text-align: center; margin-top: 10px;" data-accno="\${res.ACC_NO}">
								<i class="im im-icon-City-Hall"></i>&nbsp;&nbsp;  <span>숙소 보기</span>
							</div>
							
							<div class="line"></div>
							
							<div style="padding-left: 20px; margin-top:20px; margin-bottom:10px; display: flex; align-items: center; flex-direction: column;">
								<h2>호스트: \${res.HOST_NAME}</h2>
								<h4>이메일: \${res.HOST_EMAIL}</h4>
								<h4>전화번호: \${res.HOST_PHONE}</h4>
								<div>
									\${imgTag}
								</div>
							</div>
							
							<div class="line"></div>
							
							<h2>결제 정보</h2>
							<div style="padding-left: 20px; align-items: center;">
								<p>총 비용</p>
								<p>$\${res.PAYMENT_TOTAL_PRICE}</p>
							</div>
			        	</div>
			        </div>`;
				$(".reservation-div").html(str);   
			}
		},
		error: function(xhr) {
			console.log(xhr.status);
		}
	});
});

$(document).on("click", ".acc-button", function() {
	let acc = $(this).data("accno");
	
	location.href = "/main/detail/" + acc;
});

$(document).on("click", ".receipt-button", function() {
	let paymentNo = $(this).data("paymentno");
	
	location.href = "/payment/receipt?paymentNo=" + paymentNo + "&type=acc";
});
</script>