//탭 활성화
let emailTab = $("#email-tab"); 
let phoneTab = $("#phone-tab");

let emailContent = $("#emailAuth");
let phoneContent = $("#phoneAuth");

$('#email-tab').addClass('active');
$('#emailAuth').addClass('show active');
$('#phoneAuth').removeClass('show active');

$('#email-tab').click(function(e) {
    e.preventDefault();
    emailTab.addClass('active');
    phoneTab.removeClass('active');
    emailContent.addClass('show active');
    phoneContent.removeClass('show active');
});

$('#phone-tab').click(function(e) {
    e.preventDefault();
  	phoneTab.addClass('active');
	emailTab.removeClass('active');
	phoneContent.addClass('show active');
	emailContent.removeClass('show active');
});
//탭 활성화

//아이디 찾기
//회원 이름
let memName = $("#memName");
//회원 이메일
let memEmail = $("#memEmail");
//도메인
let domain = $("#domain1");
//아이디 찾기 버튼
let findIdBtn = $("#findId");
//아이디 찾기

//비밀번호 찾기 ==> 이메일
//회원 아이디
let memId = $("#memId");
//회원 이메일
let memEmail2 = $("#memEmail2");
//도메인
let domain2 = $("#domain2");
//비밀번호 찾기 by 이메일
let findPwBtn1 = $("#findPw1");
//비밀번호 찾기 ==> 이메일

//비밀번호 찾기 ==> 전화번호
//회원 아이디
let memId2 = $("#memId2");
//회원 전화번호
let memPhone = $("#memPhone");
//인증번호 발송 버튼
let phoneAuthBtn = $("#phoneAuthBtn");
//인증번호 인증 div
let phoneAuth = $("#myPhoneAuth");
//인증번호 입력란
let phoneCheck = $("#phoneCheck");
//인증번호 체크 버튼
let phoneCheckBtn = $("#phoneCheckBtn");
//인증번호 담을 변수
let authCode = "";
//비밀번호 찾기 by 전화번호
let findPwBtn2 = $("#findPw2");
//전화번호 인증 여부
let phoneCheckFlag = false;
//비밀번호 찾기 ==> 전화번호

const phoneRegex = /^010[0-9]{8}$/;	

//아이디 찾기
//아이디 찾기 버튼
findIdBtn.on("click", function() {
    let nameval = memName.val();
    let emailval = memEmail.val();
	let domainval = domain.val();

	if(nameval == null || nameval == "") {
		swal("이름을 입력해 주세요.", "", "error");
		memName.focus();
		return false;
	}
	
	if(emailval == null || emailval == "") {
		swal("이메일을 입력해 주세요.", "", "error");
		memEmail.focus();
		return false;
	}

	if(domainval == null || domainval == "") {
		swal("이메일 주소를 선택해 주세요.", "", "error");
		domain.focus();
		return false;
	}

    let data = {
        memName: nameval,
        memEmail: emailval,
        domain: domainval
    }

    let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

    $.ajax({
        url: "/findId",
        type: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function(res) {
        	console.log(res.id);
        	console.log(res.social);
            
        	if(res.id != "" && res.id != null) {
        		swal("고객님의 아이디는 " + res.id + " 입니다.", res.id, "success");
        	} else {
                swal("존재하지 않은 계정입니다.", "", "error");
        	}
            
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
});
//아이디 찾기 끝

//비밀번호 찾기 ==> 이메일 버전
//비밀번호 찾기 버튼 클릭 시 by 이메일
findPwBtn1.on("click", function() {
    let idval = memId.val();
    let emailval = memEmail2.val();
	let domainval = domain2.val();

	if(idval == null || idval == "") {
		swal("아이디를 입력해 주세요.", "", "error");
		memId.focus();
		return false;
	}
	
	if(emailval == null || emailval == "") {
		swal("이메일을 입력해 주세요.", "", "error");
		memEmail2.focus();
		return false;
	}

	if(domainval == null || domainval == "") {
		swal("이메일 주소를 선택해 주세요.", "", "error");
		domain2.focus();
		return false;
	}
	
    let data = {
        memEmail: emailval,
        memId: idval,
        domain: domainval
    }

    let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

    $.ajax({
        url: "/sendMail",
        type: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function(res) {
        	console.log(res.no);
            console.log(res.social);

            if(res.res == "1") {
            	swal("이메일을 확인해 비밀번호를 변경해주세요.", "", "success");
            } else {
            	swal("이메일 보내기를 실패했습니다.", "", "error");
            }
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
});
//비밀번호 찾기 ==> 이메일 버전

//비밀번호 찾기 ==> 전화번호
//전화번호 정규식 체크
memPhone.on("change", function() {
	if(!phoneRegex.test(memPhone.val())) {
		memPhone.css("border", "1px solid red");
	} else {
		memPhone.css("border", "1px solid green");
	}
});

//인증번호 발송 버튼 클릭 시
phoneAuthBtn.on("click", function() {
    let phoneval = memPhone.val();
    let idval = $("#memId2").val();

    if(idval == null || idval == "") {
        swal("아이디를 입력해주세요.", "", "error");
        return false;
    }

    if(phoneval == null || phoneval == "") {
        swal("전화번호를 입력해주세요.", "", "error");
        memPhone.focus();
        return false;
    }

    if(!phoneRegex.test(phoneval)) {
        swal("전화번호 형식이 아닙니다.", "", "error");
        return false;
    }

    let data = {
        memId: idval,
        memPhone : phoneval,
        isFind: "Y"
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
			
			swal("인증번호를 입력해주세요.", "", "success");
			phoneAuth.show();
			console.log(res.str);
			authCode = res.str;
		},
		error: function(xhr) {
			console.log(xhr.status);
		}
	});
});

//전화번호 인증버튼 클릭 시
phoneCheckBtn.on("click", function() {
	let authval = phoneCheck.val();
	if(authval == "" || authval == null) {
		swal("전화번호를 입력해주세요", "", "error");
		return false;
	}

	if(authCode == authval) {
		swal("인증이 완료되었습니다.", "", "success");
		phoneCheckFlag = true;
	} else {
		swal("인증번호를 확인해주세요.", "", "error");
	}
});

//비밀번호 찾기 버튼 클릭 시 by 전화번호
findPwBtn2.on("click", function() {
    let idval = memId2.val();
    let phoneval = memPhone.val();
	
	if(idval == null || idval == "") {
		swal("아이디를 입력해 주세요.", "", "error");
		memId.focus();
		return false;
	}
	
	if(phoneCheckFlag == false) {
        swal("전화번호를 인증해 주세요.", "", "error");
        return false;
    }

    let data = {
        memId: idval,
        memPhone: phoneval
    }

    let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

    $.ajax({
        url: "/findPw",
        type: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);				
        },
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function(res) {
        	console.log(res.no);
            console.log(res.social);

            if(res.no != "" && res.no != null) {
                swal("비밀번호를 재설정해 주세요.", "", "success");
                location.href = "/updatePassword?memNo=" + res.no;
            } else {
                swal("존재하지 않는 계정입니다.", "", "error");
            }
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
});
//비밀번호 찾기 ==> 전화번호