<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<div class="dashboard-content"> 
<!-- Container -->
<form:form modelAttribute="inquiry" id="inqboard" action="/admin/inquiry/register" method="post">
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="inqBoardNo" value="${inquiry.inqBoardNo}">
	</c:if>
<sec:csrfInput/>
<c:set value="등록" var="btnText"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="btnText"/>
	</c:if>
<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div id="add-listing" class="separated-form">
					<!-- Section -->
					<div class="add-listing-section">
				<!-- 다미 10시까지 남아! -->
				<!-- 내 맘이야! -->
						<!-- Headline -->
						<div class="add-listing-headline"> 
							<h3><i class="sl sl-icon-doc"></i> 문의사항 ${btnText} </h3>
						</div>

						<!-- Title -->
						<div class="row with-forms">
							<div class="col-md-12">
								<h5>제목</h5>
								<input class="search-field" type="text" id="inqBoardTitle" name="inqBoardTitle" placeholder="제목을 입력하세요" value="${inquiry.inqBoardTitle }"/>
							</div>
						</div>

						<!-- Row -->
						<div class="row with-forms">
							<div class="col-md-12">
							<h5>내용</h5>
							<textarea class="WYSIWYG" name="inqBoardContent" cols="40" rows="3" id="inqBoardContent" spellcheck="true" placeholder="내용을 입력하세요">${inquiry.inqBoardContent }</textarea>
							</div>
						</div>
							<a class="button add-pricing-list-item" id="btnRegister">${btnText }</a>
							<a class="button add-pricing-submenu" id="btnList">목록</a>
						<!-- Row / End -->
					</div>
					<!-- Section / End -->
				</div>
			</div>
			
			
		</div>
	</div>
	</form:form>
	<!-- Content / End -->
</div>
<script>
$(function(){
	CKEDITOR.replace('inqBoardContent');
})

$(function(){
	var inqboard = $("#inqboard");
	var btnRegister = $("#btnRegister");
	var btnList = $("#btnList");
	
	btnRegister.on("click", function(){
		var title = $("#inqBoardTitle").val();	//제목을 가져온다
		var content = CKEDITOR.instances.inqBoardContent.getData();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		console.log($(this).text());
		if($(this).text() == "수정"){
			inqboard.attr("action", "/admin/inquiry/modify");
		}
		
		inqboard.submit();	//submit 이벤트를 날려 서버로 데이터를 전송한다.
	});
	
	//목록 버튼 클릭 시 이벤트
	btnList.on("click", function(){
// 		alert("나는야 전다미!!!!!! 까불지 마라 내가 코딩 제일 잘한다.")
// 		console.log("나는야 전다미!!!!!! 까불지 마라 내가 코딩 제일 잘한다.")
		location.href = "/admin/inquiry/list";
	})
})
</script>
