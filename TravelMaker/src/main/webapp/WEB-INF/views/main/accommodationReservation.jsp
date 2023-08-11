<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:csrfMetaTags/>
<style>
	#historyBackBtn {
		cursor: pointer;
	}

	#sideBar {
		position: sticky;
		top: 20%;
   		right: 0;
		
		border: 1px solid rgb(221, 221, 221);
		border-radius: 10px;
		
		width: 40%;
		height: 40%;
	}
</style>

<div class="container" style="height: 120rem;">
	
	<div style="display: flex; justify-content: space-between; height: 100%; margin: 5% 0;">
		<div style="width: 50%;">
			<div style="display: flex; align-items: center; margin-left: -5.5%;">
				<i class="fa-solid fa-arrow-left" style="margin-right: 2%;" id="historyBackBtn"></i>
				<h2>예약 요청</h2>
			</div>
			
			
			<div style="display: flex; border-bottom: 1px solid rgb(221, 221, 221);">
				<div style="width: 49.5%;">
					<h4 style="font-weight: bold;">날짜</h4>
					<p>${reservation.aresCheckinDate } ~ ${reservation.aresCheckoutDate }</p>
				</div>
				<div style="width: 49.5%;">
					<h4 style="font-weight: bold;">게스트</h4>
					<p>
						게스트 ${reservation.aresGuestCount }명
						<c:if test="${reservation.aresExtraGuest > 0 }">
						, 유아  ${reservation.aresExtraGuest }명
						</c:if>
					</p>
				</div>
			</div>
			
			
			<div style="width: 100%; border-bottom: 1px solid rgb(221, 221, 221); padding: 4% 0;">
				<div><h3>필수 입력 정보</h3></div>
				<div><h4>호스트에게 메시지 보내기</h4></div>
				<div>호스트에게 여행 목적과 도착 예정 시간을 알려주세요.</div>
				
				<div style="display: flex; align-items: center;">
					<div style="width: 10%; height: 10%; margin: 0 3% 0 0;"><img alt="#" style="border-radius: 50%; width: 60px; height: 60px; border: 3px white solid; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);" src="${pageContext.request.contextPath}${member.memProfilePath}" style="border-radius: 50%;"></div>
					<div>
						<div><h4>${member.memName }</h4></div>
						<div>트레블메이커 가입:${member.memRegDate }월</div>
					</div>
				</div>
				
				<div style="margin: 2% 0;"><textarea rows="" cols="" style="resize: none;" id="aresRequest"></textarea></div>
			</div>
			
			
			<div style="width: 100%; border-bottom: 1px solid rgb(221, 221, 221); padding: 4% 0;">
				<div><h3>환불 정책</h3></div>
				<div>체크인 날짜 전에 취소하면 부분 환불을 받으실 수 있습니다. 그 이후에 취소하면 예약 대금이 환불되지 않습니다. <span style="font-weight: bold;">자세히 알아보기</span></div>
			</div>
			
			
			<div style="width: 100%; border-bottom: 1px solid rgb(221, 221, 221); padding: 4% 0;">
				<div><h3>기본 규칙</h3></div>
				<ul>
					<li>숙소 이용규칙을 준수하세요.</li>
					<li>호스트의 집도 자신의 집처럼 아껴주세요.</li>
				</ul>
			</div>
			
			
			
			
			
			<div style="width: 100%; padding: 4% 0;">
				<div><h3>결제 진행</h3></div>
				<div>
					<div style="margin: 3% 0;">
					    <select id="paymentMethod">
						    <option value="none" selected disabled>=== 결제 수단 선택 ===</option>
						    <option value="creditCard">신용카드 또는 체크카드</option>
						    <option value="kakaopay">카카오페이</option>
					    </select>
					</div>
				</div>
				<div>
					<p style="font-size: 11px;">위에 결제를 진행하면 호스트가 설정한 숙소 이용규칙, 게스트에게 적용되는 기본 규칙, 트레블메이커 예약 정책에 동의하며, 피해에 대한 책임이 본인에게 있을 경우 트레블메이커가 결제 수단으로 청구의 조치를 취할 수 있다는 사실에 동의하는 것입니다.</p>
				</div>
			</div>
			
			
		</div>
		
		<div id="sideBar" style="width: 40%; height: 35%; padding: 1.5%;">
			<div style="display:flex; width: 100%; height: 25%; border-bottom: 1px solid rgb(221, 221, 221); padding-bottom: 3.5%;">
				<div style="width: 25%; height: 100%; margin-right: 3%;">
					<img alt="#" src="${accommodation.accThumbnailPath }" style="width: 100%; height: 100%; border-radius: 10px;">
				</div>
				<div style="width: 72%; height: 100%; display: flex; flex-direction: column; justify-content: space-around;">
					<div>
						<div style="font-size: 13px; line-height: 130%; font-weight: bold;">${accommodation.accName }</div>
					</div>
					<div>
						<i class="fa-solid fa-star"></i><span>(후기 2개)</span>
					</div>
				</div>
			</div>
			
			<div style="border-bottom: 1px solid rgb(221, 221, 221); padding-bottom: 3.5%;">
				<h3>요금 세부 정보</h3>
				<div style="display: flex; justify-content: space-between; margin: 1.5% 0;">
					<div><fmt:formatNumber value="${accommodation.accPrice }" type="currency"/> x <span id="nights"></span>박</div>
					<div><fmt:formatNumber value="${reservation.aresTotalPrice }" type="currency"/> </div>
				</div>
				<c:if test="${reservation.aresDiscountPrice > 0 }">
					<div style="display: flex; justify-content: space-between;">
						<div>할인 금액</div>
							<div id="discountedAmount" style="text-align: right;">
								-<fmt:formatNumber value="${reservation.aresDiscountPrice }" type="currency"/>
							</div>
					</div>
				</c:if>
				<c:if test="${reservation.aresExtraPrice > 0 }">
					<div id="extraGuest" style="">
					    <div style="display: flex; justify-content: space-between;">
					        <div>추가인원 요금</div>
					        <div id="extraGuestFee"><fmt:formatNumber value="${reservation.aresExtraPrice }" type="currency"/></div>
					    </div>
					</div>
				</c:if>
				<div style="display: flex; justify-content: space-between;">
					<div>트레블메이커 서비스 수수료</div>
					<div id="serviceFee"></div>
				</div>
			</div>
			
			<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgb(221, 221, 221); padding-bottom: 3.5%;">
				<h3>총 합계 (KRW)</h3>
				<div id="totalPrice"></div>
			</div>
			
			<div style="margin: 3% 0;">카드 발행사에서 추가 수수료를 부과할 수 있습니다.</div>
		</div>
	</div>
	<div style="width: 100%; height: 5rem;"></div>
	

</div>

<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var totalPrice = 0;
	var nights = "";

	$(function() {
		$('#historyBackBtn').on('click', function(){
			// console.log("history back");
			window.history.back();
		});
		
		$('#paymentMethod').on('change', function(){
			var selectedPaymentMethod = $(this).val();
			console.log("selectedPaymentMethod -> " + selectedPaymentMethod);
			
			if(selectedPaymentMethod == 'creditCard'){
				callNicePayApi();
			} else if(selectedPaymentMethod == 'kakaopay'){
				callKakaoPayApi();
			}
			
		});
		
		nights = calculateStayDuration("${reservation.aresCheckinDate}", "${reservation.aresCheckoutDate}");
		$('#nights').html(nights);
		
		var serviceFee = Math.round((parseInt("${reservation.aresTotalPrice}") - parseInt("${reservation.aresDiscountPrice}")) * 0.06);
		$('#serviceFee').html("₩" + serviceFee.toLocaleString());

		calculateTotalPrice(serviceFee);
	});
	
	function calculateStayDuration(checkIn, checkOut) {
		const checkInDate = new Date(checkIn);
	    const checkOutDate = new Date(checkOut);

	    const timeDifference = checkOutDate - checkInDate;
	    const dayDifference = timeDifference / (1000 * 60 * 60 * 24);

	    return dayDifference;
	}
	
	function calculateTotalPrice(serviceFee) {
		totalPrice = parseInt("${reservation.aresTotalPrice}") - parseInt("${reservation.aresDiscountPrice}") + parseInt("${reservation.aresExtraPrice}") + serviceFee;
		$('#totalPrice').text("₩" + (totalPrice).toLocaleString());
	};
	
	

	// 결제수단 호출
	function callNicePayApi(){
		console.log("api1 호출함");
		IMP.init("");
		IMP.request_pay(
			{
			pg: "nice.nictest04m",
			pay_method: "card",
			merchant_uid: "dddddd",
			name: "name",
			amount: totalPrice,
			buyer_email: "email",
			buyer_name: "name",
			buyer_tel: "telNumber",
			},
			function (res) {
				if(res.success){
					console.log("성공");
				} else {
					console.log("실패");
				}
			}
		);
	};
	
	function callKakaoPayApi(){
		console.log("api 호출함");
		IMP.init("");
		IMP.request_pay({
			pg : "kakaopay.TC0ONETIME",
			pay_method : "card", // 결제방식
			merchant_uid : '${orderNo}', // 상품 번호
			name : '${orderNo}', // 상품이름
			amount : totalPrice,
			customer_uid : '${buyer.memNo}', // 회원 Id
			buyer_email : '${buyer.memEmail}', // 구매자 email
			buyer_name : '${buyer.memName}', // 구매자 이름
			buyer_tel : '${buyer.memPhone}', // 구매자 전화번호
		}, 
		function(rsp) {
			if (rsp.success) {
				var requestData = {
					accReservation: {
						accNo: "${accommodation.accNo}",
						aresCheckinDate: "${reservation.aresCheckinDate}",
						aresCheckoutDate: "${reservation.aresCheckoutDate}",
						aresGuestCount: "${reservation.aresGuestCount}",
						aresExtraGuest: "${reservation.aresExtraGuest}",
						aresRequest: $('#aresRequest').val(),
						aresAccDateCount: nights,
						aresCheckin: "${accommodation.accStandardCheckin}",
						aresCheckout: "${accommodation.accStandardCheckout}",
						aresTotalPrice: "${reservation.aresTotalPrice}",
						aresExtraPrice: "${reservation.aresExtraPrice}",
						aresDiscountPrice: "${reservation.aresDiscountPrice}",
						aresPerPrice: "${accommodation.accPrice}"
					},
					payment: {
						paymentTotalPrice: totalPrice,
						accNo: "${accommodation.accNo}"
					}
				};

				$.ajax({
					url : '/main/accommodation/insertPayment',
					type : 'POST',
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data : JSON.stringify(requestData),
					dataType : 'text',
					contentType : "application/json; charset=utf-8",
					success : function(res) {
						if (res === "SUCCESS") {
							console.log("url: ", res.url);
							location.href = "/main/home";
						}
					},
					error : function(xhr) {
						console.log("err -> ", xhr);
					}
				});
			}
		});
	};
</script>