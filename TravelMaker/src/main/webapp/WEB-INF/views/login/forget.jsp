<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags/>
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
				<br/>
				<div id="findDiv">
					<div class="mb-3">
						<label for="memName">이름</label>
						<input type="text" class="form-control" id="memName" name="memName">
					</div>
	
					<br>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="memEmail">이메일</label>
							<input type="email"	class="form-control" id="memEmail" name="memEmail">
						</div>

						<div class="col-md-6 mb-3" id="domainOption">
							<label for="domain1">&nbsp;</label>
							<select	class="custom-select d-block w-100" id="domain1" name="domain1">
								<option value="" selected="selected">선택</option>
								<option value="@naver.com">@naver.com</option>
								<option value="@daum.net">@daum.net</option>
								<option value="@gmail.com">@gmail.com</option>
							</select>
						</div>
					</div>
					
					<br>
					<button class="btn btn-primary btn-lg btn-block" type="button" id="findId" style="background-color: #e69d7c; border: none;">아이디 찾기</button>
					
					<br><br>
					<hr class="mb-4">
					<br><br>
					
					<ul class="nav nav-tabs" id="authenticationTab" role="tablist">
					    <li class="nav-item">
					    	<a class="nav-link active" id="email-tab" data-toggle="tab" href="#emailAuth" role="tab" aria-controls="emailAuth" aria-selected="true">이메일로 인증하기</a>
					  	</li>
					  	<li class="nav-item">
					    	<a class="nav-link" id="phone-tab" data-toggle="tab" href="#phoneAuth" role="tab" aria-controls="phoneAuth" aria-selected="false">전화번호로 인증하기</a>
					  	</li>
					</ul>
					
					<br><br>
					<!-- 이메일 인증 -->
					<div class="tab-content" id="authenticationTabContent">
					  	<div class="tab-pane fade show active" id="emailAuth" role="tabpanel" aria-labelledby="email-tab">
							<br>
							<div class="mb-3">
								<label for="memId">아이디</label>
								<input type="text" class="form-control" id="memId" name="memId">
							</div>
							
							<br>
							<div class="row">
								<div class="col-md-6 mb-3">
									<label for="memEmail2">이메일</label>
									<input type="email"	class="form-control" id="memEmail2" name="memEmail2">
								</div>
		                     
								<div class="col-md-6 mb-3" id="domainOption">
									<label for="domain2">&nbsp;</label>
									<select	class="custom-select d-block w-100" id="domain2" name="domain2">
										<option value="" selected="selected">선택</option>
										<option value="@naver.com">@naver.com</option>
										<option value="@daum.com">@daum.com</option>
										<option value="@gmail.com">@gmail.com</option>
									</select>
								</div>
							</div>
					    	
					    	<button class="btn btn-primary btn-lg btn-block" type="button" id="findPw1" style="background-color: #e69d7c; border: none;">비밀번호 찾기</button>
					  	</div>
					  	
					  	<!-- 전화번호 인증 -->
					  	<div class="tab-pane fade" id="phoneAuth" role="tabpanel" aria-labelledby="phone-tab">
							<br>
							<div class="mb-3">
								<label for="memId2">아이디</label>
								<input type="text" class="form-control" id="memId2" name="memId2">
							</div>
							
							<br>
							<div class="row">
								<div class="col-md-9 mb-3">
									<label for="memPhone">전화번호</label>
									<input type="text" class="form-control" id="memPhone" name="memPhone" placeholder="- 없이 번호만 입력해 주세요.">
								</div>
								<div class="col-md-3 mb-3">
									<label for="phoneAuthBtn">&nbsp;</label><br>
									<button type="button" class="btn btn-primary" id="phoneAuthBtn" name="phoneAuthBtn" style="width: 100%;">인증번호발송</button>
								</div>
							</div>
							
							<div class="row" id="myPhoneAuth" style="display: none;">
								<div class="col-md-6 mb-3">
									<label for="phoneCheck">인증번호</label>
									<input type="text" class="form-control" id="phoneCheck" name="phoneCheck">
								</div>
								<div class="col-md-3 mb-3">
									<label for="phoneCheckBtn">&nbsp;</label><br>
									<button type="button" class="btn btn-primary" id="phoneCheckBtn" name="phoneCheckBtn" style="width: 100%;">인증하기</button>
								</div>
							</div>
					    	<button class="btn btn-primary btn-lg btn-block" type="button" id="findPw2" style="background-color: #e69d7c; border: none;">비밀번호 찾기</button>
					  	</div>
					</div>
					
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
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/login/forget.js"></script>
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