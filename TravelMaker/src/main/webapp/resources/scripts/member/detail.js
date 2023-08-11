//모달1
let modal = $("#myModal");
let couponDiv = $("#couponDiv");
let closeBtn = $("#close");

let insertCoupon = $("#insertCoupon");
let selectCoupon = $("#selectCoupon");

let insertBtn = $("#insertBtn");
let selectBtn = $("#selectBtn");

insertCoupon.show();
selectCoupon.hide();

couponDiv.on("click", function() {
	modal.show();    		
})

closeBtn.on("click", function() {
	modal.hide();    		
})

insertBtn.on("click", function() {
	insertCoupon.show();
	selectCoupon.hide();
});

selectBtn.on("click", function() {
	insertCoupon.hide();
	selectCoupon.show();
	
	let memNo = $("#memNo").val();
	
	/* $.ajax({
		url: "/member/coupon",
		method: "get",
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
        data: {memNo: memNo},
        success: function(res) {
        	
        },
        error: function(xhr) {
        	console.log(xhr.status);
        }
	}); */
});
//모달1 끝

//결제 div, 글로벌 환경설정 div
let paymentDiv = $("#paymentDiv");
let globalDiv = $("#globalDiv");

paymentDiv.on("click", function() {
	location.href = "/member/payment";
});

globalDiv.on("click", function() {
	location.href = "/member/prefer";
});
//div끝

//모달2
let updateMember = $("#updateMember");
let modal2 = $("#myModal2");
let close2 = $("#close2");
let pwBtn = $("#pwBtn");

modal2.hide();

updateMember.on("click", function(e) {
	e.preventDefault();
	modal2.show();
});

close2.on("click", function() {
	modal2.hide();
});

pwBtn.on("click", function() {
	let memPw = $("#memPw").val();
	
	if(memPw == null || memPw == "") {
		swal("비밀번호를 입력해주세요.", "", "error");
		return false;
	}
	
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url: "/member/checkPw",
		method: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
		data: {memPw: memPw},
		success: function(res) {
			console.log(res);
            if(res.result == "FAILED") {
                swal("비밀번호를 확인해주세요.", "", "error");
                return false;
            }
            
			location.href = `/member/profile?token=${res.token}`;
		},
		error: function(xhr) {
			console.log(xhr.status);
		}
	});
});
//모달2 끝