var payBtn = $('#payBtn');
var kakaoBtn = $('#kakaoBtn');
var memNo = $('#memNo').val();
var memEmail = $('#memEmail').val();
var memName = $('#memName').val();
var memPhone = $('#memPhone').val();
var freservationNo = $('#freservationNo').val();
var totalPrice = parseInt($('#freservationTotalPrice').val());
var flightNo = $('#flightNo').val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

console.log("memNo", memNo);
console.log("memEmail", memEmail);
console.log("memName", memName);
console.log("memPhone", memPhone);
console.log("totalPrice: ", totalPrice);
console.log("freservation", freservationNo);
console.log("totalPrice", totalPrice);


// payBtn.addEventListener("click",nicePay());
$(function (){
    payBtn.on('click',nicePay);
    kakaoBtn.on('click',kakaoPay);
});

function nicePay() {
  IMP.init("");
    IMP.request_pay(
        {
        pg: "nice.nictest04m",
        pay_method: "card",
        merchant_uid: freservationNo,
        name: uuidId,
        amount: totalPrice,
        buyer_email: memEmail,
        buyer_name: memName,
        buyer_tel: memPhone,
        },
        function (rsp) {
          if(rsp.success) {
            console.log(rsp)
          } else {
            console.log(rsp)
          }
        }
    );
}
var count = 0;
function kakaoPay() {

  let paymentInfo = {
      memNo : memNo,
      freservationNo : freservationNo,
      paymentTotalPrice : totalPrice
  }

  var uuidId = $('#uuidId').val();
  // console.log("uuidId = " + uuidId);
  
  // console.log("fres : ", freservationNo);
  // console.log("uuidId: ", uuidId);
  IMP.init("");
    IMP.request_pay(
        {
        pg: "kakaopay.TC0ONETIME",
        pay_method: "card",             // 결제방식
        merchant_uid: freservationNo,         // 상품 번호
        name: uuidId,           // 상품이름
        amount: totalPrice,
        customer_uid : memNo,           // 회원 Id
        buyer_email: memEmail,          // 구매자 email
        buyer_name: memName,            // 구매자 이름
        buyer_tel: memPhone,            // 구매자 전화번호
        },
        function (rsp) { 
          if(rsp.success) {
              console.log("rsp: ",rsp);
              $.ajax({
                  url: '/flight/insertPayment',
                  type : 'POST',
                  beforeSend: function(xhr){
                    xhr.setRequestHeader(header, token);
                  },
                  data : JSON.stringify(paymentInfo),
                  dataType : 'json',
                  contentType: "application/json; charset=utf-8",
                  success : function(res){
                    if(res.result === "SUCCESS") {
                      console.log("url: ", res.url);
                      // Swal.fire({
                      //   position: "top-end",
                      //   icon: "success",
                      //   title: "결제가 완료되었습니다.",
                      //   showConfirmButton: false,
                      //   timer: 1500,
                      // }).then(function () {
                      //   location.href = res.url;
                      // });
                      location.href = res.url;
                    }
                  },
                  error : function(xhr){
                    console.log(xhr);
                  }
              });
          } else {
            console.log("error : ", rsp);
          }
        }
    );
}