<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sec:csrfMetaTags/>

<div style="width: auto; margin-top: 15px; margin-bottom: 15px;">
	<div class="container">
		<div class="col-lg-6 col-md-6">
			<div class="dashboard-list-box margin-top-0">
				<div>
					<h4 class="gray">프로필 상세</h4>
				</div>
				<div class="dashboard-list-box-static">
					<form action="/member/profile" method="post" id="profileForm" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<input type="hidden" name="memNo" id="memNo" value="${member.memNo}">
						
						<!-- Avatar -->
						<div class="edit-profile-photo">
							<!-- 회원 프로필 이미지가 없으면 기본 이미지 -->
							<c:choose>
								<c:when test="${empty member.memProfilePath}">
									<img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" id="profileImg">
								</c:when>
								<c:otherwise>
									<img src="${member.memProfilePath}" alt="" id="profileImg">
								</c:otherwise>
							</c:choose>
							
							
							<div class="change-photo-btn">
								<div class="photoUpload">
									<span>
										<i class="fa fa-upload"></i>프로필 이미지 변경
									</span>
									<input type="file" name="imgFile" class="upload" id="imgFile">
								</div>
							</div>
						</div>
	
						<!-- Details -->
						<div class="my-profile">
	
							<label>아이디</label>
							<input type="text" name="memId" value="${member.memId}" readonly="readonly" disabled="disabled">
							
							<label>이름</label>
							<input type="text" name="memName" id="memName" value="${member.memName}" placeholder="이름을 입력해주세요.">
							
							<div>
								<label>전화</label>
								<input type="text" name="memPhone" id="memPhone" value="${member.memPhone}" placeholder="- 없이 번호만 입력해 주세요.">
								<button type="button" class="button" id="phoneAuthBtn" name="phoneAuthBtn" style="width: 30%;">인증번호발송</button>
							</div>
							<input type="hidden" id="beforeMemPhone" name="beforeMemPhone" value="${member.memPhone}">
							<div id="phoneAuth" style="display: none;">
								<label for="phoneCheck">인증번호</label>
								<input type="text" class="form-control" id="phoneCheck" name="phoneCheck">
								<button type="button" class="button" id="phoneCheckBtn" name="phoneCheckBtn" style="width: 30%;">인증하기</button>
							</div>
							
							<label for="memEmail" style="display: block; margin-bottom: 5px;">이메일</label>
							<div style="display: flex;">
								<input type="text" class="form-control" id="memEmail" name="memEmail" value="${member.memEmail}" style="width: 50%;">
								<select	class="custom-select d-block w-100" id="domain" name="memDomain" style="width: 50%;">
									<option value="">선택</option>
									<option value="@naver.com" <c:if test="${member.memDomain eq '@naver.com'}"> selected </c:if>>@naver.com</option>
									<option value="@daum.net" <c:if test="${member.memDomain eq '@daum.net'}"> selected </c:if>>@daum.net</option>
									<option value="@gmail.com" <c:if test="${member.memDomain eq '@gmail.com'}"> selected </c:if>>@gmail.com</option>
								</select>
							</div>
							
							<label>자기소개</label>
							<textarea id="notes" cols="30" rows="10" name="memIntroduce" id="memIntroduce">${member.memIntroduce}</textarea>
						</div>
						<button type="button" id="profileBtn" class="button margin-top-15">프로필 저장</button>
					</form>
				</div>
			</div>
		</div>
		
		<div class="col-lg-6 col-md-6">
			<div class="dashboard-list-box margin-top-0">
				<h4 class="gray">비밀번호 변경</h4>
				<div class="dashboard-list-box-static">
					<div class="my-profile">
						<c:forEach items="${member.socialList}" var="social">
							<c:if test="${social.socialType eq 'KAKAO'}">
								<label><img src="${pageContext.request.contextPath}/resources/images/kakao.png" style="width: 20px; height: 20px;"> 카카오톡</label>
								<c:choose>
									<c:when  test="${social.socialId ne 'N'}">
										<input type="password" value="${social.socialId}" disabled="disabled">
									</c:when>
									<c:otherwise>
										<div id="kakao-login-btn" style="width: 250px; height: 50px;"></div>
									</c:otherwise>
								</c:choose>
							</c:if>
													
							<c:if test="${social.socialType eq 'NAVER'}">
								<label><img src="${pageContext.request.contextPath}/resources/images/naver.png" style="width: 20px; height: 20px;"> 네이버</label>
								<c:choose>
									<c:when  test="${social.socialId ne 'N'}">
										<input type="password" value="${social.socialId}" disabled="disabled">
									</c:when>
									<c:otherwise>
										<div id="naver_id_login"></div>
									</c:otherwise>
								</c:choose>
							</c:if>
													
							<c:if test="${social.socialType eq 'GOOGLE'}">
								<label><img src="${pageContext.request.contextPath}/resources/images/google.png" style="width: 20px; height: 20px;"> 구글</label>
								<c:choose>
									<c:when  test="${social.socialId ne 'N'}">
										<input type="password" value="${social.socialId}" disabled="disabled">
									</c:when>
									<c:otherwise>
										<div id="buttonDiv"></div>
									</c:otherwise>
								</c:choose>
							</c:if>						
						</c:forEach>	
					</div>
				</div>
			</div>
		</div>
		<br><br>
		<div class="col-lg-6 col-md-6">
			<div class="dashboard-list-box margin-top-0">
				<h4 class="gray">비밀번호 변경</h4>
				<div class="dashboard-list-box-static">
					<div class="my-profile">
						<form action="/member/changePassword" method="post" id="pwForm">
							<input type="hidden" name="memNo" value="${member.memNo}">
						
							<label class="margin-top-0">현재 비밀번호</label>
							<input type="password" value="${member.memPw}">
							
							<label>새 비밀번호</label>
							<input type="password" name="memPw" id="pw1">
							
							<label>새 비밀번호 확인</label>
							<input type="password" id="pw2">
							
							<sec:csrfInput/>
							<button type="button" id="changePwBtn" class="button margin-top-15">비밀번호 변경</button>
						</form>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/member/profile.js"></script>
<script type="text/javascript">
let message = "${message}";
let error = "${error}";
if(message != "") {
	swal(message, "", 'success');
}

if(error != "") {
	swal(error, "", 'error');
}

Kakao.init('');
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
});

//////////////네이버//////////////
var naver_id_login = new naver_id_login("", "");
var state = naver_id_login.getUniqState();
naver_id_login.setButton("green", 3, 48);
naver_id_login.setDomain("");
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
    
    let data = {
    	socialType: "GOOGLE",
    	socialId: responsePayload.sub,
    	memNo: $("#memNo").val()
    }
    
    updateSocial(data);
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
        client_id: "",
        callback: handleCredentialResponse
    });
    
    google.accounts.id.renderButton(
        document.getElementById("buttonDiv"),
        { theme: "outline", size: "large" }
    ); 
    
    google.accounts.id.prompt();
}
//////////////구글//////////////

function updateSocial(data) {
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
			if(res.result == "OK") {
				swal("연동되었습니다.", "", "success");
				location.href = "/member/profile?token=" + res.token;
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
}
</script>