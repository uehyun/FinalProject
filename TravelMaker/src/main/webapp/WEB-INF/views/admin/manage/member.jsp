<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#memCont {
	display: none;
}

#sign-in-dialog {
	max-width: 650px;
	color: black;
}
.dashboard-content {
	padding: 10px 45px;
}
table {
	border: 1px #a39485 solid;
	font-size: .9em;
	box-shadow: 0 2px 5px rgba(0, 0, 0, .25);
	width: 100%;
	border-collapse: collapse;
	border-radius: 5px;
	overflow: hidden;
}

th {
	text-align: left;
}

thead {
	font-weight: bold;
	color: #fff;
	background: #73685d;
}

td, th {
	padding: 1em .5em;
	vertical-align: middle;
}

td {
	border-bottom: 1px solid rgba(0, 0, 0, .1);
	background: #fff;
	padding-left : 25px;
	font-weight: 700;
}

a {
	color: #73685d;
}

@media all and (max-width: 768px) {
	table, thead, tbody, th, td, tr {
		display: block;
	}
	th {
		text-align: right;
	}
	table {
		position: relative;
		padding-bottom: 0;
		border: none;
		box-shadow: 0 0 10px rgba(0, 0, 0, .2);
	}
	thead {
		float: left;
		white-space: nowrap;
	}
	tbody {
		overflow-x: auto;
		overflow-y: hidden;
		position: relative;
		white-space: nowrap;
	}
	tr {
		display: inline-block;
		vertical-align: top;
	}
	th {
		border-bottom: 1px solid #a39485;
	}
	td {
		border-bottom: 1px solid #e5e5e5;
	}
}

.memName {
	margin-top: 55px;
	margin-left: 20px;
	font: 17px "Fira Sans", sans-serif;
	font-weight: 700;
}

#memImg {
	border: 2px solid white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	width: 80px;
	height: 80px;
	border-radius: 50%;
}
.memInfo {
	background-color: #8080801f;
}
.centered-header .ag-header-cell-text {
    text-align: center;
}
#searchName {
	font: 15px "Fira Sans", sans-serif;
    font-weight: 700;
    margin-bottom: 15px;
}
</style>
<div class="dashboard-content">
	<div class="dashboard-content" style="margin-left: 0px;">
		<div class="row">
			<div style="text-align: left; margin-bottom: 25px;">
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<h2 style="margin-top: 5px; margin-bottom: 20px; font-weight:700;">회원 조회</h2>
					<div style="display: flex; justify-content: space-between; align-items: center;">
						<span id="searchName">통합검색</span>
						<input style="width: 73%; height: 40px;" type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력해주세요."/>
					</div>
				</div>
				<div id="myGrid" class="ag-theme-alpine" style="height: 750px;"></div>
			</div>
		</div>
	</div>
</div>
<a id="modal" href="#sign-in-dialog"
	class="sign-in popup-with-zoom-anim"></a>
<div id="memCont"></div>
<script>
	var pageContext = "${pageContext.request.contextPath}";
</script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-enterprise/dist/ag-grid-enterprise.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/admin/mem-manage.js"></script>