<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:csrfMetaTags/>
<style>
.dashboard-content {
	padding: 15px 45px;
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
#sign-in-dialog {
	max-width: 650px;
	height: 650px;
	color: black;
}

#okBtn:hover,
#updateBtn:hover,
#cancelBtn:hover,
#clickAll:hover,
#ableBtn:hover,
#disableBtn:hover,
#addEventBtn:hover {
	color : red;
}
#okBtn,
#updateBtn,
#cancelBtn,
#ableBtn,
#disableBtn,
#clickAll,
#addEventBtn {
	border : none;
	font-weight: 700;
	margin-bottom: 14px;
	color: black;
	text-decoration: underline;
	background-color: #f7f7f7;
}
#memImg {
	border: 2px solid white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	width: 80px;
	height: 80px;
	border-radius: 50%;
}
.memName {
	margin-top: 55px;
	margin-left: 20px;
	font: 17px "Fira Sans", sans-serif;
	font-weight: 700;
}
.memInfo {
	background-color: #8080801f;
    width: 150px;
}
.centered-header .ag-header-cell-text {
    text-align: center;
}
#searchName {
	font: 15px "Fira Sans", sans-serif;
    font-weight: 700;
    margin-bottom: 13px;
}
#clickAll {
	margin-bottom: 5px;
}	
</style>
<div class="dashboard-content">
	<div class="dashboard-content" style="margin-left: 0px;">
		<div class="row">
			<div style="text-align: left; margin-bottom: 25px;">
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<div style="width: 500px; display: flex">
						<div>
							<h2 style="margin-top: 5px; margin-bottom: 20px; font-weight:700;">이벤트 목록</h2>
							<button id="clickAll">전체선택</button>&nbsp;&nbsp;&nbsp;
							<button id="ableBtn">활성화</button>&nbsp;&nbsp;
							<button id="disableBtn">비활성화</button>
						</div>
					</div>
					<div style="width: 650px; display: flex; justify-content: space-between; align-items: center; margin-top: 40px;">
						<div>
							<button id="updateBtn">수정</button>
							<button id="cancelBtn">삭제</button>
						</div>
						<button id="addEventBtn">이벤트 등록</button>
						<span id="searchName">통합검색</span>
						<input style="width: 50%; height: 40px;" type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력해주세요."/>
					</div>
				</div>
				<div id="myGrid" class="ag-theme-alpine" style="height: 730px;"></div>
			</div>
		</div>
	</div>
</div>
<a id="modal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim"></a>
<div id="memCont"></div>
<script>
var addEventBtn = $("#addEventBtn");
var pageContext = "${pageContext.request.contextPath}";
addEventBtn.on("click", function(){
	location.href = "/admin/manage/detailEvent";
});
</script>
<script src="${pageContext.request.contextPath}/resources/scripts/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-enterprise/dist/ag-grid-enterprise.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/admin/event-manage.js"></script>