<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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

<div class="dashboard-content" style="background-color: white;">
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
			<input type="button" id="selectDelBtn" value="선택삭제" style="width: 100px; height: 40px; background-color: white; border: 1px solid lightgray; border-radius: 3px; color: gray; display: flex; justify-content: center; align-items: center; line-height: 20px;">
		</div>
		<!-- 뉴 검색창 끝 -->
		<table class="table table-bordered table-striped table-dark table-hover">
			<thead class="thead-light text-center">
				<tr>
					<th class="center-align" style="vertical-align: middle; padding-top:20px;">
					 	<input type="checkbox" id="chkAll" name="chkAll" style="height: 15px; width: 15px; line-height: 20px;">
					</th>
					<th style="vertical-align: middle;">글번호</th>
					<th style="vertical-align: middle;">제목</th>
					<th style="vertical-align: middle;">작성일</th>
					<th style="vertical-align: middle;">작성자</th>
					<th style="vertical-align: middle;"></th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:set value="${pagingVO.dataList }" var="faqList" />
				<c:forEach var="faq" items="${faqList }">
					<tr style="background-color: white;">
						<td style="vertical-align: middle;"><input type="checkbox" name="chkBox" value="${faq.faqBoardNo }" style="height: 15px; width:15px;"></td>
						<td>${faq.faqBoardNo}</td>
						<td class="text-left" width="50%">
							<div class="panel-faq-container">
								<p class="panel-faq-title">${faq.faqBoardTitle }</p>
								<div class="panel-faq-answer">
									<p>${faq.faqBoardContent }</p>
								</div>
							</div>
						</td>
						<td>${faq.faqBoardRegDate}</td>
						<td>${faq.faqBoardWriter}</td>
						<td id="btnBox" style="width: 140px;" class="modify-button-td">
							<form method="post" action="/admin/faq/delete" id="delForm">
								<input type="hidden" name="faqBoardNo" value="${faq.faqBoardNo}" />
								<sec:csrfInput />
								<span style="justify-content: flex-end;">
									<input type="button" name="delBtn" class="mybtn" value="삭제"
									style="background-color: #66676b; border: none; color: white; padding: 0; height: 30px; width: 45px; margin-right: 5px; border-radius: 10px;" />
									<input type="button" name="modBtn" class="mybtn" value="수정"
									style="background-color: #66676b; border: none; color: white; padding: 0; height: 30px; width: 45px; border-radius: 10px;" />
								</span>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<input type="button" id="newBtn" value="글쓰기" style="float:right; width:90px; height:40px; background-color:white; border:1px solid lightgray; border-radius: 10px; color: gray; text-align: center; padding-top: 3px;">
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
	  const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); 
	  
	  // panel-faq-answer
	  let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");
	  
	  // 반복문 순회하면서 해당 FAQ제목 클릭시 콜백 처리
	  for( let i=0; i < panelFaqContainer.length; i++ ) {
	    panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
	    	console.log($(document).find(this).attr('class'))
	    
	      // FAQ 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
	      panelFaqAnswer[i].classList.toggle('active');
	      console.log("상세보기"); 
	      
	     for (let j = 0; j < panelFaqContainer.length; j++) {
	         if (j !== i) {
	            panelFaqAnswer[j].classList.remove('active');
	         }
	     }
	     
	    });
	  };
	  
	  // form 태근
	  const damiForms = document.querySelectorAll("#delForm");
	
	  //수정버튼 눌렀을때!!
	  const modBtns = document.querySelectorAll(".mybtn[name='modBtn']");
	  for (let i = 0; i < modBtns.length; i++) {
	    modBtns[i].addEventListener('click', function(event) {
	    	// 제이쿼리 엄마들중 tr 찾고 자식중td 찾아서 0번쨰에 있는 텍스트 값 가져오는 문장
	    	let faqBoardNo = $(this).parents('tr').find('td').eq(0).text()
	    	
	    	// 오 다미 그래도 잘 나왔네
// 	      event.stopPropagation();
	    	
 	      // 수정 버튼 클릭 시 페이지v 이동을 위한 URL 설정			
// 		  const faqBoardNo = this.parentNode.previousElementSibling.textContent;
		  damiForms[i].action="/admin/faq/modify?faqBoardNo="+faqBoardNo
		  damiForms[i].method = "get";
		  damiForms[i].submit();
	    });
	  }
	  
	  //삭제버튼 눌렀을때!!
	  const delBtns = document.querySelectorAll(".mybtn[name='delBtn']");
	  for (let i = 0; i < delBtns.length; i++) {
    	delBtns[i].addEventListener('click', function(event) {
      	  event.stopPropagation();
		  var chk = confirm("정말 삭제하시겠습니까?");
		  console.log("Delbtn clicked!");
		  if(chk) {
			damiForms[i].submit();
			alert("삭제되었습니다")
		  }      	  
        });
		
	  }
}	  

$(function(){
	var newBtn = $("#newBtn");
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	//체크박스들
	var chkObj = document.getElementsByName("chkBox");
	var rowCnt = chkObj.length;
	
	$("input[name='chkAll']").click(function(){
		var chk_listArr = $("input[name='chkBox']");
		for(var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	
	$("input[name='chkBox']").click(function(){
		if($("input[name='chkBox']:checked").length == rowCnt){
			$("input[name='chkAll']")[0].checked = true;
		}
		else{
			$("input[name='chkAll']")[0].checked = false;
		}
	});
	
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		console.log(this)
		var pageNo = $(this).data("page");	//페이지 번호가 넘어옴
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	newBtn.on("click", function(){
		location.href = "/admin/faq/register";
	});
	
});


var selectDelBtn = $("#selectDelBtn");
selectDelBtn.on("click", function() {
	  var url = "/admin/faq/selectDelete"; // Controller로 보내고자 하는 URL
	  var valueArr = [];
	  var list = $("input[name='chkBox']:checked");

	  list.each(function() {
	    valueArr.push($(this).val());
	  });

	  if (valueArr.length === 0) {
	    alert("선택된 글이 없습니다");
	  } else {
	    var chk = confirm("정말 삭제하시겠습니까?");
	    if (chk) {
	      $.ajax({
	        url: url,
	        type: "post",
	        beforeSend: function(xhr) {
	          xhr.setRequestHeader(header, token);
	        },
	        contentType: "application/json; charset=utf-8", // JSON 데이터 전송을 명시
	        data: JSON.stringify(valueArr), // JSON 형태로 변환하여 전송
	        dataType: "text",
	        success: function(data) {
	        	console.log(data)
	          if (data == valueArr.length) {
	            alert("삭제되었습니다");
	            location.replace("/admin/faq/list"); //~로 페이지 새로고침
	          } else {
	            alert("삭제에 실패했습니다");
	          }
	        }
	      });
	    }
}
});
</script>
