<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<title>Insert title here</title>
<style>
.input-form {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div id="background"></div>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<div style="display: flex; justify-content: center;">
					<a href="/main/home"><img src="${pageContext.request.contextPath}/resources/images/logo.png" style="width: 300px; height: 100px;"/></a>
				</div>
				<br/><br/>
				<form action="/login" method="post">
					<div class="mb-3">
						<label for="username">아이디</label>
						<input type="text" class="form-control" id="username" name="username" value="">
					</div>

					<br>
					<div class="mb-3">
						<label for="password">비밀번호</label>
						<input type="password" class="form-control" id="password" name="password" value="">
					</div>
					
					<div>
						<input id="remember-me" type="checkbox" name="check">
                        <label for="remember-me">로그인 상태 유지</label>
					</div>
					
					<div class="mb-4"></div>
					
					<sec:csrfInput/>
					
					<button class="btn btn-primary btn-lg btn-block" type="button" id="login" style="background-color: #e69d7c; border: none;">로그인</button>
				</form>
				<br><br>
				<div style="text-align: center; color: black;">
					<a href="/forget" class="signinfind">아이디 찾기</a>&nbsp;&nbsp; |&nbsp;
					<a href="/forget" class="signinfind">비밀번호 찾기</a>&nbsp;&nbsp; |&nbsp;
					<a href="/signup" class="signinfind">회원가입</a>
				</div>
				<br><br>
				<div style="text-align: center;">
					<a href="${naverUrl}">
						<img src="${pageContext.request.contextPath}/resources/images/loginNaver.png" style="height: 60px; width: 300px;">
					</a>
					<br><br>
					<a href="${kakaoUrl}">
						<img src="${pageContext.request.contextPath}/resources/images/loginKakao.png" style="height: 60px; width: 300px;">
					</a>
					<br><br>
					<a href="${googleUrl}">
						<img src="${pageContext.request.contextPath}/resources/images/loginGoogle.png" style="height:60px; width:300px;">
					</a>
					<br><br>
					<select id="role">
						<option value="">역할선택</option>
						<option value="guest">신규회원</option>
						<option value="host">호스트</option>
						<option value="admin">관리자</option>
					</select>
				</div>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1" style="color: white;">&copy; TravelMaker</p>
		</footer>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/login/signin.js"></script>
</body>
<script type="text/javascript">
const username = $("#username");
const password = $("#password");
let role = $("#role");
let res = "${result}";
let error = "${error}";
if(res != "") {
	swal(res, "", 'success');
}

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

role.on("change",function(){

	if($(this).val() == "guest") {
		username.val("a031");
		password.val("aaa111!!");
	}
	if($(this).val() == "host") {
		username.val("a001");
		password.val("aaa111!!");
	}
	if($(this).val() == "admin") {
		username.val("a003");
		password.val("aaa111!!");
	}
});

</script>
</html>