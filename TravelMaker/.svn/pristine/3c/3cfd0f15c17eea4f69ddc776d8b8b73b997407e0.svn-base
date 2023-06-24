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
</head>
<body>
	<div>
		<div class="small-dialog-header">
			<h3>Sign Up</h3>
		</div>
		<div class="sign-in-form style-1">
			<div class="tabs-container alt">
				<div class="tab-content" id="tab2">
					<form class="register" action="" method="post" enctype="multipart/form-data">
						<p class="form-row form-row-wide">
							<label for="memId">아이디:
								<i class="im im-icon-Male"></i>
								<input type="text" class="input-text" name="memId" id="memId" value="${mem.memId}" />
							</label>
						</p>

						<p class="form-row form-row-wide">
							<label for="memPw">비밀번호:
								<i class="im im-icon-Lock-2"></i>
								<input class="input-text" type="password" name="memPw" id="memPw" value="${mem.memPw}" />
							</label>
						</p>

						<p class="form-row form-row-wide">
							<label for="memPw2">비밀번호 확인:
								<i class="im im-icon-Lock-2"></i>
								<input class="input-text" type="password" name="memPw2" id="memPw2" />
							</label>
						</p>
						
						<p class="form-row form-row-wide">
							<label for="memName">이름:
								<i class="im im-icon-Male"></i>
								<input type="text" class="input-text" name="memName" id="memName" value="${mem.memName}" />
							</label>
						</p>
						
						<p class="form-row form-row-wide">
							<label for="memPhone">전화번호: 
								<i class="im im-icon-Male"></i>
								<input type="text" class="input-text" name="memPhone" id="memPhone" value="${mem.memPhone}" />
							</label>
						</p>
						
						<p class="form-row form-row-wide">
							<label for="memEmail">이메일:
								<i class="im im-icon-Mail"></i>
								<input type="text" class="input-text" name="memEmail" id="memEmail" value="${mem.memEmail}" />
							</label>
						</p>
						
						<p class="form-row form-row-wide">
							<label for="memAgree">개인정보동의여부:
								<i class="im im-icon-Mail"></i>
								<input type="checkbox" class="input-text" name="memAgree" id="memAgree" value="${mem.memAgree}" />
							</label>
						</p>
						<input type="submit" class="button border fw margin-top-10"	name="register" value="Register" />
						<sec:csrfInput/>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>