<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/faqstyle.css"> --%>

<style>
html, body {
	font-family: Helvetica, Arial, sans-serif;
	margin: 0;
}

.panel-faq-container {
	margin-bottom: -16px;
}

.panel-faq-title {
	color: black;
	cursor: pointer;
}

.panel-faq-answer {
	height: 0;
	overflow-x: hidden;
	/* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
	왜? 닫기 버튼을 누를 때 변화가 티남 */
	transition: all 1s;
}

/* .panel-faq-answer::-webkit-scrollbar { */
/*   display: none; */
/* } */

line-height : 200px ; .daterangepicker td.active.end-date.in-range.available,
	.qtyTotal, .mm-menu em.mm-counter, .option-set li a.selected,
	.category-small-box:hover, .pricing-list-container h4:after, #backtotop a,
	.chosen-container-multi .chosen-choices li.search-choice,
	.select-options li:hover, button.panel-apply, .layout-switcher a:hover,
	.listing-features.checkboxes li:before, .comment-by a.reply:hover,
	.add-review-photos:hover, .office-address h3:after, .post-img:before,
	button.button, input[type="button"], input[type="submit"], a.button, a.button.border:hover,
	table.basic-table th, .plan.featured .plan-price, mark.color, .style-4 .tabs-nav li.active a,
	.style-5 .tabs-nav li.active a, .dashboard-list-box .button.gray:hover,
	.change-photo-btn:hover, .dashboard-list-box  a.rate-review:hover,
	input:checked+.slider, .add-pricing-submenu.button:hover,
	.add-pricing-list-item.button:hover, .custom-zoom-in:hover,
	.custom-zoom-out:hover, #geoLocation:hover, #streetView:hover,
	#scrollEnabling:hover, #scrollEnabling.enabled, #mapnav-buttons a:hover,
	#sign-in-dialog .mfp-close:hover, #small-dialog .mfp-close:hover {
	background-color: #66676b;
	width: 70px;
	height: 35px;
	font-size: 1em;
	text-align: center;
	float: right;
}

.active {
	display: block;
	/* 높이를 정해줘야지만 transition이 적용됨 */
	height: 300px;
}

/* 페이징처리 css 시작 */
.page {
	text-align: center;
	width: 50%;
}

.pagination {
	list-style: none;
	display: inline-block;
	padding: 0;
	margin-top: 20px;
}

.pagination li {
	display: inline;
	text-align: center;
}

.pagination a {
	float: left;
	display: blobk;
	font-size: 14px;
	text-decoration: none;
	padding: 5px 12px;
	color: #96a0ad;
	line-height: 1.5;
}

.first {
	margin-right: 15px;
}

.last {
	margin-left: 15px;
}

.first:hover, .last:hover, .left:hover, .right:hover {
	color: #2e9cdf;
}

.pagination a.active {
	cursor: default;
	color: lightblue;
	background-color: white;
}

.pagination a:active {
	outline: none;
	background-color: white;
}

.modal .num {
	margin-left: 3px;
	padding: 0;
	width: 30px;
	height: 30px;
	line-height: 30px;
	-moz-border-radius: 100%;
	-webkit-border-radius: 100%;
	border-radius: 100%;
}

.modal .num:hover {
	background-color: #2e9cdf;
	color: #ffffff;
}

.modal .num.active, .modal .num:active {
	background-color: #2e9cdf;
	cursor: pointer;
}

.arrow-left {
	width: 0;
	height: 0;
	border-top: 10px solid transparent;
	border-bottom: 10px solid transparent;
	border-right: 10px solid blue;
}
/* 페이징 처리 css 끝 */

.center-align {
  text-align: center;
  vertical-align: middle;
}

th{
  text-align: center;
}

.toprow{
  

}



</style>

<div class="dashboard-content" style="margin-left: 50px;">
	<div class="container">
		<h3 style="text-align: center; padding-top: 50px;">
			FAQ <small class="text-muted">&nbsp; 자주 묻는 질문</small>
		</h3>
		<br>
		<!-- 뉴 검색창 -->
		<div style="display: flex; justify-content: space-between; align-items: center;">
		<form method="post" id="searchForm" class="input-group input-group-sm" style="width: 440px;">
			<input type="hidden" name="page" id="page" />
			<sec:csrfInput />
			<div class="searchBox" style="display: flex; justify-content: space-between; align-items: center;">
				<select id="searchType" name="searchType" style="height: 40px; width: 130px; padding: 0px 8px;">
					<option value="title">제목</option>
				</select> <input type="text" name="searchWord" value="${searchWord}" style="width: 74%; height: 40px; margin-left: 3px;"
					id="quickFilter" placeholder="검색어를 입력해주세요." /> 
					<input type="submit" id="searchBtn" value="검색" style="width: 15%; height: 40px; background-color: white; border: 1px solid lightgray; border-radius: 3px; margin-left: 5px; color: gray; padding: 0;" />
			</div>
		</form>
		</div>
		<!-- 뉴 검색창 끝 -->
		<table class="table table-bordered table-striped table-dark table-hover">
			<thead class="thead-light text-center">
				<tr>
					<th style="vertical-align: middle; width: 5%;">글번호</th>
					<th style="vertical-align: middle; width: 65%;">제목</th>
					<th style="vertical-align: middle; width: 13%;">작성일</th>
					<th style="vertical-align: middle; width: 7%;">작성자</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:set value="${pagingVO.dataList }" var="faqList" />
				<c:forEach var="faq" items="${faqList }">
					<tr style="background-color: white;">
						<td>${faq.faqBoardNo}</td>
						<td class="text-left" width="50%">
							<div class="panel-faq-container">
								<p class="panel-faq-title">${faq.faqBoardTitle }</p>
								<div class="panel-faq-answer">
									<p>${faq.faqBoardContent }</p>
								</div>
							</div>
						</td>
						<td>
							<fmt:parseDate var="regDate" value="${faq.faqBoardRegDate}" pattern="yyyy-MM-dd HH:mm" />
							<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd" />
						</td>
						<td>${faq.faqBoardWriter}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12" style="text-align: center;">
				<nav class="pagination" id="pagingArea">
					${pagingVO.pagingHTML}</nav>
			</div>
		</div>
	</div>
</div>
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

<script>
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

window.onload = () => {  
	  // panel-faq-container
	  const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); // NodeList 객체
	  
	  // panel-faq-answer
	  let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");

	  
	  // 반복문 순회하면서 해당 FAQ제목 클릭시 콜백 처리
	  for( let i=0; i < panelFaqContainer.length; i++ ) {
	    panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
	    	console.log($(document).find(this).attr('class'))
	    
	      // FAQ 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
	      panelFaqAnswer[i].classList.toggle('active');
	      console.log("상세보기"); 
	      
	      //console.log($(this).parents('tr').find('td').eq(0).text());
	      
	      //alert($(this).attr("dami"));
// 	     if(!$(this).attr("dami")){
// 	     	let cnt = parseInt($(this).parents('tr').find('td').eq(4).text());
// 	     	cnt = cnt + 1;
// 	     	$(this).parents('tr').find('td').eq(4).text(cnt);
// 	     	$(this).attr("dami","click");
// 	     }
         
	     for (let j = 0; j < panelFaqContainer.length; j++) {
	         if (j !== i) {
	            panelFaqAnswer[j].classList.remove('active');
	         }
	     }
	     
	    });
	  };
	  
	  }

$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		console.log(this)
		var pageNo = $(this).data("page");	//페이지 번호가 넘어옴
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
});


</script>
