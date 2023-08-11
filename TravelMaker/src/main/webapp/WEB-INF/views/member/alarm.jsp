<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>

<div style="width: auto; margin-top: 15px; margin-bottom: 15px; min-height: 500px;">
	<div class="container">
		<div class="col-lg-12 col-md-12">
			<h2>알림</h2>
			<div class="dashboard-list-box margin-top-0">
				<ul class="list-group" id="alarmUL">
					
				</ul>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath}/resources/scripts/member/alarm.js"></script>