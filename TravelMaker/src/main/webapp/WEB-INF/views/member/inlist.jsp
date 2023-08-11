<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:csrfMetaTags/>
<style>
html,body {
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
  overflow: hidden;
  /* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
  왜? 닫기 버튼을 누를 때 변화가 티남 */
  transition: all 1s;
}

#btn-all-close {
  margin-bottom: 10px;
  background-color: #726996;
  border: none;
  color: #fff;
  cursor: pointer;
  padding: 10px 25px;
  float: right;
}
#btn-all-close:hover {
  background-color: #966E96;
  color: #000;
  transition: all 0.35s;
}
.active {
  display: block;
  /* 높이를 정해줘야지만 transition이 적용됨 */
  height: 300px;
}

th {
    text-align: center; 
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

</style>
<div class="dashboard-content" style="margin-left: 50px;">
<div class="container">
    <h3 style="text-align: center; padding-top: 50px;">
		문의사항 게시판
      <small class="text-muted">&nbsp; 문의사항</small>
    </h3>
    <br>
    <!-- 글 검색창	-->
    <form method="post" id="searchForm" class="input-group input-group-sm" style="width: 440px;">
		<input type="hidden" name="page" id="page" />
		<sec:csrfInput/>
	<div style="display: flex; justify-content: space-between; align-items: center;">
		<select id="searchType" name="searchType" style="height: 40px; width:110px; padding: 0px 8px;">
			<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
			<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
			<option value="memNo" <c:if test="${searchType eq 'memNo' }">selected</c:if>>회원번호</option>
		</select>
		<input type="text" name="searchWord"  id="quickFilter"  value="${searchWord }" placeholder="검색어를 입력해주세요." style="width:74%; height:40px; margin-left:3px;"/>
		<input type="submit" id="searchBtn" value="검색" style= "width:15%; height:40px; background-color:white; border:1px solid lightgray; border-radius: 3px; margin-left: 5px; color: gray; padding: 0;"/>
	</div>
	</form>
	<!-- 검색창 끝	-->
    <table class="table table-bordered table-striped table-dark table-hover">
      <thead class="thead-light text-center">
        <tr>
          <th>글번호</th>
          <th>제목</th>
          <th>작성일자</th>
          <th>작성자</th>
          <th>회원번호</th>
          <th>처리상태</th>
        </tr>
      </thead>
      
      <tbody class="text-center">
      	<c:set value="${pagingVO.dataList }" var="inquiryList"/>
      	<c:forEach var="inquiry" items="${inquiryList }">
	        <tr style="background-color: white;">
	          <td>${inquiry.inqBoardNo}</td>
	          <td class="text-left" width="50%">
	            <div class="panel-faq-container">
	            <c:choose>
    				<c:when test="${pagingVO.memNo eq inquiry.inqBoardWriter}">
		              <p class="panel-faq-title"><a href="indetail?inqBoardNo=${inquiry.inqBoardNo }">${inquiry.inqBoardTitle }</a></p>
    				</c:when>
    				<c:otherwise>
    				  <p class="panel-faq-secret">비밀글입니다</p>
    				</c:otherwise>
    			</c:choose>
	            </div>
	          </td>
	          <td>${inquiry.inqBoardRegDate}</td>
	          <td>${inquiry.memName}</td>
	          <td>${inquiry.inqBoardWriter}</td>
	          <c:choose>
		          <c:when test="${inquiry.inqRepYN eq '답변대기'}">
		          	<td>${inquiry.inqRepYN }</td>
		          </c:when>
		          <c:otherwise>
		      		<td style="background-color: gray; color: white;">${inquiry.inqRepYN }</td>
		          </c:otherwise>
	          </c:choose>
	        </tr>
        </c:forEach>
      </tbody>
	</table>
	<input type="button" id="newBtn" value="글쓰기" style="float:right; width:90px; height:40px; background-color:white; border:1px solid lightgray; border-radius: 10px; color: gray; text-align: center; padding-top: 3px;">
	<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12" style="text-align: center;">
				<nav class="pagination" id="pagingArea">${pagingVO.getPagingHTML()}</nav>
			</div>
	</div>
  </div>	
</div>




<script>
$(function(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var newBtn = $("#newBtn");
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var inqBoardWriter = '${inquiry.inqBoardWriter}';
	console.log("iii", inqBoardWriter);
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		console.log(this)
		var pageNo = $(this).data("page");	//페이지 번호가 넘어옴
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	newBtn.on("click", function(){
		location.href = "/member/inregister";
	});
	
});
	
	
	

$(document).on("click", ".panel-faq-secret", function() {
    const title = $(this).data("inquiry-secret");
    alert("작성자만 조회가능합니다");
});

</script>
