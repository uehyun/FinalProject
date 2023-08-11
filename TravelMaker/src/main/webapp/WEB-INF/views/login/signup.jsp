<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<sec:csrfMetaTags/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<title>Insert title here</title>
<style type="text/css">
button {
	border: none;
	background-color: #e69d7c;	
}
.input-form {
	margin-top: 15px;
}

#autoComplete:hover {
	color: blue;
	cursor: pointer;
}
</style>
</head>
<body>
<div id="background"></div>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h2 class="mb-3">회원가입</h2>
				<div style="display: flex; justify-content: space-between;">
					<span style="float: right;">회원가입을 진행하여 TravelMaker의 회원이 되어보세요.</span>
					<a id="autoComplete" style="float: left;">자동완성</a>
				</div>
				<hr class="mb-3">

				<form action="/signup" method="post">
					<div class="mb-3">
						<label for="memId">아이디</label><span class="errorspan" id="idError">${idError}</span>
						<div id="info_id">
							<input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력해주세요." value="${member.memId}">
							<button type="button" id="idCheck">중복 확인</button>
						</div>
					</div>

					<br>
					<div class="mb-3">
						<label for="memPw">비밀번호</label><span class="errorspan" id="pw1Error">${pwError}</span>
						<input type="password" class="form-control" id="memPw" name="memPw" placeholder="비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내이어야 합니다." value="${member.memPw}">
					</div>

					<br>
					<div class="mb-3">
						<label for="memPw2">비밀번호 확인</label><span class="errorspan" id="pw2Error"></span>
						<input type="password" class="form-control" id="memPw2" name="memPw2" value="">
					</div>

					<br>
					<div class="mb-3">
						<label for="memName">이름</label><span class="errorspan" id="nameError">${nameError}</span>
						<input type="text" class="form-control" id="memName" name="memName" value="${member.memName}">
					</div>

					<br>
					<div class="row">
						<div class="col-md-9 mb-3">
							<label for="memPhone">전화번호</label><span class="errorspan" id="phoneError">${phoneError}</span>
							<input type="text" class="form-control" id="memPhone" name="memPhone" value="${member.memPhone}" placeholder="- 없이 번호만 입력해 주세요.">
						</div>
						<div class="col-md-3 mb-3">
							<label for="phoneAuthBtn">&nbsp;</label><br>
							<button type="button" class="btn btn-primary" id="phoneAuthBtn" name="phoneAuthBtn" style="width: 100%;">인증번호발송</button>
						</div>
					</div>
					
					<div class="row" id="phoneAuth" style="display: none;">
						<div class="col-md-6 mb-3">
							<label for="phoneCheck">인증번호</label>
							<input type="text" class="form-control" id="phoneCheck" name="phoneCheck">
						</div>
						<div class="col-md-3 mb-3">
							<label for="phoneCheckBtn">&nbsp;</label><br>
							<button type="button" class="btn btn-primary" id="phoneCheckBtn" name="phoneCheckBtn" style="width: 100%;">인증하기</button>
						</div>
					</div>
					
					<br>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="memEmail">이메일</label><span class="errorspan" id="emailError">${emailError}</span>
							<input type="email"	class="form-control" id="memEmail" name="memEmail" value="${member.memEmail}">
						</div>

						<div class="col-md-6 mb-3" id="domainOption">
							<label for="domain">&nbsp;</label><span class="errorspan" id="domainError">${domainError}</span>
							<select	class="custom-select d-block w-100" id="domain" name="domain">
								<option value="" selected="selected">선택</option>
								<option value="@naver.com">@naver.com</option>
								<option value="@daum.net">@daum.net</option>
								<option value="@gmail.com">@gmail.com</option>
							</select>
						</div>
					</div>

					<hr class="mb-4">
					<div class="custom-control custom-checkbox" style="padding-left: 5px;"><span class="errorspan" id="agreeError">${agreeError}</span>
						<input type="checkbox" class="custom-control-input" id="memAgree" name="memAgree" value="Y">
						<label class="custom-control-label"	for="memAgree">개인정보 수집 및 이용에 동의합니다.</label>
					</div>
					
					<div class="mb-4"></div>
					
					<sec:csrfInput/>
					
					<button class="btn btn-primary  btn-lg btn-block" type="button" id="register" style="background-color: #e69d7c; border: none;">가입 완료</button>
				</form>
				<br>
				<br>
				<a href="/login">혹시 회원이신가요?</a>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1" style="color: white;">&copy; TravelMaker</p>
		</footer>
	</div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/login/signup.js"></script>
</body>
<script type="text/javascript">
let error = "${error}";

if(error != "") {
	swal(error, "", "error");
}

var imageUrls = [
  "/resources/images/ocean.jpg",
  "/resources/images/ocean1.jpg",
  "/resources/images/ocean3.jpg",
  "/resources/images/tree.jpg",
  "/resources/images/jeju.jpg",
  "/resources/images/tree1.jpg",
  "/resources/images/mountain.jpg",
  "/resources/images/mountain1.jpg"
];

var backgroundElement = document.getElementById("background"); // 배경이 될 div 요소를 선택합니다.

function changeBackgroundImage() {
  var randomImageUrl = imageUrls[Math.floor(Math.random() * imageUrls.length)];

  backgroundElement.style.opacity = 0; // 배경이 될 div 요소의 opacity를 설정합니다.

  setTimeout(function() {
    backgroundElement.style.backgroundImage = "url(" + randomImageUrl + ")";
    backgroundElement.style.backgroundSize = "cover"; // Ensure the image always covers the whole body
    backgroundElement.style.opacity = 1;
  }, 1000);
}

changeBackgroundImage();
setInterval(changeBackgroundImage, 8000);

$("#autoComplete").on("click", function() {
	$("#memId").val("a031");
	$("#memPw").val("aaa111!!");
	$("#memPw2").val("aaa111!!");
	$("#memName").val("신현근");
	$("#memPhone").val("01053900978");
	$("#memEmail").val("gusrms722");
	$("#domain").val("@naver.com");
	$("#memAgree").prop("checked", "true");
});
</script>
</html>