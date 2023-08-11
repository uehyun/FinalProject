//아이디
let memId = $("#memId");
//비밀번호
let memPw = $("#memPw");
//비밀번호 확인
let memPw2 = $("#memPw2");
//이름
let memName = $("#memName");
//전화번호
let memPhone = $("#memPhone");
//이메일
let memEmail = $("#memEmail");
//도메인주소
let domain = $("#domain");
//개인정보 동의
let memAgree = $("#memAgree");


//중복확인버튼
let idCheckBtn = $("#idCheck");
//제출버튼
let submitBtn = $("#register");


//인증번호발송 누르면 나타나는 div
let phoneAuth = $("#phoneAuth");
//인증번호발송 버튼
let phoneAuthBtn = $("#phoneAuthBtn");
//인증번호 입력란
let phoneCheck = $("#phoneCheck");
//인증번호 체크 버튼
let phoneCheckBtn = $("#phoneCheckBtn");
//인증번호 저장할 변수
let authCode = "";

//아이디 체크 여부
let idCheckFlag = false;
//전화번호 체크 여부
let phoneCheckFlag = false;

const phoneRegex = /^010[0-9]{8}$/;	
const passwordRegex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

//인증번호발송 버튼 클릭 시
phoneAuthBtn.on("click", function() {
	let phoneval = memPhone.val();
	if(phoneval == null || phoneval == "") {
        swal("전화번호를 입력해주세요.", "", "error");
        memPhone.focus();
        return false;
    }
    
	if(!phoneRegex.test(phoneval)) {
		swal("전화번호 형식이 아닙니다", "", "error");
		memPhone.focus();
		return false;
	} 
	
	let data = {
		memPhone: phoneval,
		isFind: "N"
	};

	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url: "/sendCertification",
		type: "post",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);				
		},
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		success: function(res) {
			if(res.fail != null) {
				swal(res.fail, "", "error");
				return false;
			}
			
			phoneAuth.show();
			console.log(res.str);
			authCode = res.str;
		},
		error: function(xhr) {
			console.log(xhr.status);
		}
	});
});

//인증번호 확인 버튼
phoneCheckBtn.on("click", function() {
	let authval = phoneCheck.val();
	if(authval == "" || authval == null) {
		swal("인증번호를 입력해주세요", "", "error");
		return false;
	}

	if(authCode == authval) {
		swal("인증이 완료되었습니다.", "", "success");
		phoneCheckFlag = true;
	} else {
		swal("인증번호를 확인해주세요.", "", "error");
	}
});

//전화번호 정규식 체크
memPhone.on("change", function() {
	if(!phoneRegex.test(memPhone.val())) {
		memPhone.css("border", "1px solid red");
	} else {
		memPhone.css("border", "1px solid green");
	}
});

//비밀번호 정규식 체크
memPw.on("change", function() {
	if(!passwordRegex.test(memPw.val())) {
		memPw.css("border", "1px solid red");
	} else {
		memPw.css("border", "1px solid green");
	}
});

//비밀번호 확인
memPw2.on("change", function() {
	let pwval = memPw.val();
	let pw2val = memPw2.val();
	
	if(pwval != pw2val) {
		memPw2.css("border", "1px solid red");
		$("#pw2Error").text("비밀번호가 다릅니다.");
	} else {
		memPw2.css("border", "1px solid green");
		$("#pw2Error").text("");
	}
});

//아이디 확인
memId.on("change", function() {
	idCheckFlag = false;
	memId.css("border", "1px solid red");
	
	$("#idError").css("color", "red");
	$("#idError").text("아이디 중복확인을 해주세요.");
});

//중복체크 클릭 시
idCheckBtn.on("click", function() {
	let idval = memId.val();
	
	if(idval == "" || idval == null) {
		swal('아이디를 입력해 주세요!', "", 'error');
		memId.focus();
		return false;
	}
	
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	let data = {memId : idval};
	
	$.ajax({
		url: "/idCheck",
		type: "post",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);				
		},
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		success: function(res) {
			console.log(res);
			
			if(res == "NOTEXIST") {
				swal('사용가능한 아이디 입니다!', "", 'success');
				memId.css("border", "1px solid green");
				
				$("#idError").css("color", "green");
				$("#idError").text("사용가능한 아이디 입니다.");
				idCheckFlag = true;
			} else {
				swal('중복된 아이디 입니다!', "", 'error');
				memId.css("border", "1px solid red");
				
				$("#idError").css("color", "red");
				$("#idError").text("중복된 아이디 입니다.");
			}
		}
	}); 
});

//제출 버튼
submitBtn.on("click", function() {
	let idval = memId.val();
	let pwval = memPw.val();
	let pw2val = memPw2.val();
	let nameval = memName.val();
	
	let phoneval = memPhone.val();
	
	let emailval = memEmail.val();
	let domainval = domain.val();
	
	if(idval == "" || idval == null) {
		swal('아이디를 입력해 주세요!', "", 'error');
		memId.focus();
		return false;
	}	
	
	if(pwval == "" || pwval == null) {
		swal('비밀번호를 입력해 주세요!', "", 'error');
		memPw.focus();
		return false;
	}
	
	if(pwval != pw2val) {
		swal('비밀번호를 확인해 주세요!', "", 'error');
		memPw2.focus();
		return false;
	}	
	
	if(nameval == "" || nameval == null) {
		swal('이름을 입력해 주세요!', "", 'error');
		memName.focus();
		return false;
	}
	
	if(phoneval == "" || phoneval == null) {
		swal('전화번호를 입력해 주세요!', "", 'error');
		memPhone.focus();
		return false;
	}
	
	if(emailval == "" || emailval == null) {
		swal('이메일을 입력해 주세요!', "", 'error');
		memEmail.focus();
		return false;
	}
	if(domainval == "" || domainval == null) {
		swal('이메일 주소를 선택해 주세요!', "", 'error');
		domain.focus();
		return false;
	}
	
	if(!memAgree.prop("checked")) {
		swal('개인정보를 동의해 주세요!', "", 'error');
		return false;
	}
	
	if(phoneCheckFlag == false) {
		swal('전화번호를 인증해 주세요!', "", 'error');
		return false;
	}

	if(idCheckFlag == false) {
		swal('아이디 중복체크를 해주세요!', "", 'error');
		return false;
	}

	//정규식 비교------------------------------------------------------------------
	if(!passwordRegex.test(pwval)) {
		swal('비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내이어야 합니다!', "", 'error');
		memPw.focus();
		return false;
	}
	
	if(!phoneRegex.test(phoneval)) {
		swal('전화번호의 양식이 아닙니다!', "", 'error');
		memPhone.focus();
		return false;
	}
	
	$("form").submit();
});