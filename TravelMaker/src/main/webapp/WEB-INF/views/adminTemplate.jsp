<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<title>Travel Maker</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main-color.css" id="colors">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/travel_airplane.png">
</head>
<body>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-migrate-3.3.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/mmenu.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/chosen.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/slick.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/rangeslider.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/magnific-popup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/waypoints.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/counterup.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/tooltips.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/custom.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/ckeditor/ckeditor.js"></script>
<!-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/scripts/adminlte.min.js"></script> -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<div id="wrapper">
	<div id="dashboard">
		<tiles:insertAttribute name="adminHeader"/>
		
		<tiles:insertAttribute name="adminSidebar"/>
			
		<tiles:insertAttribute name="content"/>
	</div>
</div>
</body>
</html>