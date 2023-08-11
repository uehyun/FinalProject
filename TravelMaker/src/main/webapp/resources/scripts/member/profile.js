$(function() {
	let imgFile = $("#imgFile"); 

	imgFile.on("change", function(event) {
		let file = event.target.files[0];
		
		if(isImageFile(file)) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#profileImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
		} else { // 이미지가 아닐때
			alert("이미지 파일을 선택해주세요");
		}
	});
	
	function isImageFile(file) {
		let ext = file.name.split(".").pop().toLowerCase();
		return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
	}
	
	const phoneRegex = /^010[0-9]{8}$/;	
	const passwordRegex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	let memName = $("#memName");
	let memPhone = $("#memPhone");
	let memEmail = $("#memEmail");
	let domain = $("#domain");
	let memIntroduce = $("#memIntroduce");
	let beforeMemPhone = $("#beforeMemPhone");

	let phoneAuthBtn = $("#phoneAuthBtn");
	let phoneAuth = $("#phoneAuth");
	let phoneCheck = $("#phoneCheck");
	let phoneCheckBtn = $("#phoneCheckBtn");
	let authCode = "";
	let phoneCheckFlag = true;

	let profileForm = $("#profileForm");
	let profileBtn = $("#profileBtn");
	
	profileBtn.on("click", function() {
		let nameval = memName.val();
		let emailval = memEmail.val();
		let domainval = domain.val();
		let beforephne = beforeMemPhone.val();
		let phoneval = memPhone.val();

		if(beforephne != phoneval) {
			phoneCheckFlag = false;
		}
		
		if(nameval == null || nameval == "") {
			swal('이름은 필수 입력입니다!', "", 'error');
			memName.focus();
			return false;
		}
		
		if(emailval == null || emailval == "") {
			swal('이메일은 필수 입력입니다!', "", 'error');
			memEmail.focus();
			return false;
		}
		
		if(domainval == null || domainval == "") {
			swal("도메인을 입력해주세요.", "", "error");
			return false;
		}

		if(phoneval != "") {
			if(!phoneRegex.test(phoneval)) {
				swal('전화번호의 양식이 아닙니다!', "", 'error');
				memPhone.focus();
				return false;
			}
		}
		
		if(phoneCheckFlag == false) {
			swal('전화번호를 인증해 주세요!', "", 'error');
			return false;
		}
		
		profileForm.submit();
	});
	
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
				phoneCheckFlag = false;
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
	
	let pw1 = $("#pw1");
	let pw2 = $("#pw2");
	let pwForm = $("#pwForm");
	let changePwBtn = $("#changePwBtn");
	
	//비밀번호 정규식 체크
	pw1.on("change", function() {
		if(!passwordRegex.test(pw1.val())) {
			pw1.css("border", "1px solid red");
		} else {
			pw1.css("border", "1px solid green");
		}
	});
	
	pw1.on("change", function() {
		if(!passwordRegex.test(pw1.val())) {
			pw1.css("border", "1px solid red");
		} else {
			pw1.css("border", "1px solid green");
		}
	});
	
	pw2.on("change", function() {
		let pwval = pw1.val();
		let pw2val = pw2.val();
		
		if(pwval != pw2val) {
			pw2.css("border", "1px solid red");
		}
	});
	
	changePwBtn.on("click", function() {
		let pw1val = pw1.val();
		let pw2val = pw2.val();
		
		if(!passwordRegex.test(pw1val)) {
			swal('비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내이어야 합니다!', "", 'error');
			pw1.focus();
			return false;
		}
		
		if(pw1val != pw2val) {
			swal('비밀번호를 확인해 주세요!', "", 'error');
			pw2.focus();
			return false;
		}
		
		pwForm.submit();
	});
	
	
	//소셜 연동
	//////////////카카오//////////////
	/* Kakao.init('ad244d35ad5dfd579e6d6b8fa7ee7186');
	Kakao.Auth.createLoginButton({
	    container: '#kakao-login-btn',
	    success: function(authObj) {
	    	Kakao.API.request({
	      		url: '/v2/user/me',
	      		success: function(response) {
	        		console.log(response);
	        		var uniqueId = response.id;
	        		var email = response.kakao_account.email;
	        		var nickname = response.kakao_account.profile.nickname;
	        		
	        		let data = {socialType: "KAKAO", socialId: uniqueId, memNo: $("#memNo").val()};
	        		updateSocial(data);
	      		},
	      		fail: function(error) {
	        		console.error(error);
	      		}
	    	});
	    },
	  	fail: function(err) {
	    	console.error(err);
	    }
	}); */
	//////////////카카오//////////////
	
	/* //////////////네이버//////////////
	var naver_id_login = new naver_id_login("FGndoRqUtqYsOiejV7Da", "http://localhost/member/profile");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("green", 3, 48);
	naver_id_login.setDomain("http://localhost/member/profile");
	naver_id_login.setPopup();
	naver_id_login.setState(state);
	naver_id_login.init_naver_id_login();
	naver_id_login.get_naver_userprofile("naverSignInCallback()")
	
	function naverSignInCallback() {
		let id = naver_id_login.getProfileData('id');
		
		window.close();
		localStorage.setItem('naverSignInData', JSON.stringify({ uniqId: id }));
	}
	  
	var storedData = localStorage.getItem('naverSignInData');
		
	if(storedData) {
	    var response = JSON.parse(storedData);
		var socialId = response.uniqId;
	    
	    console.log(socialId);
		
	    let data = {socialType: "NAVER", socialId: socialId, memNo: $("#memNo").val()};
	    
	    updateSocial(data);
	}
	//////////////네이버//////////////
	
	//////////////구글//////////////
	function handleCredentialResponse(response) {
		const responsePayload = parseJwt(response.credential);
	
	    console.log("ID: " + responsePayload.sub);
	    console.log("Email: " + responsePayload.email); 
	}
	
	function parseJwt(token) {
	    var base64Url = token.split('.')[1];
	    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
	    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
	        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
	    }).join(''));
	
	    return JSON.parse(jsonPayload);
	};
	
	window.onload = function () {
	    google.accounts.id.initialize({
	        client_id: "642974686166-gtqb95f3k8fukgec9f07se4c0dgddsdl.apps.googleusercontent.com",
	        callback: handleCredentialResponse
	    });
	    
	    google.accounts.id.renderButton(
	        document.getElementById("buttonDiv"),
	        { theme: "outline", size: "large" }
	    );
	    
	    google.accounts.id.prompt();
	}
	//////////////구글////////////// */
	
	/* function updateSocial(data) {
		console.log(data);
		
		let token = $("meta[name='_csrf']").attr("content");
		let header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url: "/member/updateSocial",
			method: "post",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);				
			},
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(data),
			success: function(res) {
				if(res == "OK") {
					swal("연동되었습니다. 이제부터 해당 소셜로그인을 통해 로그인 할 수 있습니다.", "", "success");
					window.reload();
				} else {
					swal("연동에 실패하였습니다.", "", "error");
				}
				localStorage.removeItem('naverSignInData');
			},
			error: function(xhr) {
				console.log(xhr.status);
				localStorage.removeItem('naverSignInData');
			}
		});
	} */
});

