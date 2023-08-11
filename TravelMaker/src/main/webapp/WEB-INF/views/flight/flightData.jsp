<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/data/list" method="post">
		검색날짜 : <input type="text" name="departTime"><br> 출발공항 : <input
			type="text" name="departAirport"><br> 도착공항: <input
			type="text" name="arriveAirport"><br>
		<sec:csrfInput />
		<button type="submit">전송</button>
	</form>
</body>
</html>


