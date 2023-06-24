<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main-color.css" id="colors">
<title>Insert title here</title>
<style type="text/css">
#loginDiv {
	display: flex;
  	justify-content: center;
  	align-items: center;
}

.signinfind:hover {
	background: lightgray;
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="loginDiv">
		<div class="mfp-content">
			<div id="sign-in-dialog" class="zoom-anim-dialog" style="border: 1px solid lightgray">
				<div class="small-dialog-header">
					<h3>TravelMaker</h3>
				</div>

				<div class="sign-in-form style-1">
					<div class="tabs-container alt">
						<div class="tab-content" id="tab1" style="">
							<form method="post" class="login">
								<p class="form-row form-row-wide">
									<label for="username">
										아이디: <i class="im im-icon-Male"></i>
										<input type="text" class="input-text" name="username" id="username" value="" placeholder="아이디">
									</label>
								</p>

								<p class="form-row form-row-wide">
									<label for="password">
										비밀번호: <i class="im im-icon-Lock-2"></i>
										<input class="input-text" type="password" name="password" id="password" placeholder="비밀번호">
									</label>
								</p>

								<div class="form-row">
									<div class="checkboxes margin-top-10">
										<input id="remember-me" type="checkbox" name="check">
										<label for="remember-me">로그인 상태 유지</label>
									</div>
									<br>
									<input type="submit" class="button border margin-top-5" name="login" value="Login" style="width: 350px">
								</div>
								
								<!-- 시큐리티 적용 -->
								<sec:csrfInput/>
								<!-- 시큐리티 적용 -->
							</form>
							<br>
							<div style="text-align: center; color: black;">
								<a href="#" class="signinfind">아이디 찾기</a>&nbsp;&nbsp; |&nbsp;
								<a href="#" class="signinfind">비밀번호 찾기</a>&nbsp;&nbsp; |&nbsp;
								<a href="#" class="signinfind">회원가입</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="text-align: center;"> 
				<a href="${naverUrl}">
					<img alt="" src="${pageContext.request.contextPath}/resources/images/naver.png" style="height:60px; width:300px;">
				</a>
				<br><br>
				<a href="${kakaoUrl}">
					<img src="${pageContext.request.contextPath}/resources/images/kakao.png" style="height:60px; width:300px;">
				</a>
				<br><br>
				<%-- <a href="${googleUrl}">
					<img alt="" src="${pageContext.request.contextPath}/resources/images/google.png" style="height:60px; width:300px;">
				</a> --%>
				<br><br>
			</div>
		</div>
	</div>
</body>
</html>