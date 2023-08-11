<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
</head>
<body>
<div id="background"></div>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h2 class="mb-3">TravelMaker</h2>
				<hr class="mb-3">
				<div id="updateDiv">
					<form action="/updatePassword" method="post">
						<input type="hidden" name="memNo" id="memNo" value="${memNo}">
						
						<div class="mb-3">
							<label for="memPw">새 비밀번호</label>
							<input type="password" class="form-control" id="memPw" name="memPw" placeholder="비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내이어야 합니다." value="${member.memNo}">
						</div>
						
						<br>
						<div class="mb-3">
							<label for="checkPw">비밀번호 확인</label>
							<input type="password" class="form-control" id="checkPw" name="checkPw">
						</div>
						
						<sec:csrfInput/>
						
						<br>
						<button class="btn btn-primary btn-lg btn-block" type="button" id="updatePw" style="background-color: #e69d7c; border: none;">비밀번호 변경</button>
					</form>
					<br><br>
					<hr class="mb-4">
					<a href="/login" style="display: flex; justify-content: center; align-items: center;">로그인하러 가기</a>
				</div>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1" style="color: white;">&copy; TravelMaker</p>
		</footer>
	</div>
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/login/updatePassword.js"></script>
<script>
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
</script>
</body>
</html>