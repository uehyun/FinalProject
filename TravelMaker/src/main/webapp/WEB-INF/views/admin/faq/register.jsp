<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib
 uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
#btnAtuo:hover{
	background-color: none;
}
</style>
<div class="dashboard-content"> 
<!-- Container -->
<form:form modelAttribute="faq" id="faqboard" action="/admin/faq/register" method="post">
	<input type="hidden" name="faqBoardNo" value="${faq.faqBoardNo}">
	<c:if test="${status eq 'u' }">
		<input type="hidden" name="faqBoardWriter" value="${faq.faqBoardWriter }">
	</c:if>
<sec:csrfInput/>
<div class="container">
		<div class="row">
			<div class="col-lg-12">
			
				<div id="add-listing" class="separated-form">

					<!-- Section -->
					<div class="add-listing-section">

						<!-- Headline -->
						<div class="add-listing-headline"> 
							<h3><i class="sl sl-icon-doc"></i> FAQ 등록 </h3>
						</div>

						<!-- Title -->
						<div class="row with-forms">
							<div class="col-md-12">
								<h5>제목</h5>
								<input class="search-field" type="text" id="faqBoardTitle" name="faqBoardTitle" placeholder="제목을 입력하세요" value="${faq.faqBoardTitle }"/>
							</div>
						</div>

						<!-- Row -->
						<div class="row with-forms">
							<div class="col-md-12">
							<h5>내용</h5>
							<textarea class="WYSIWYG" name="faqBoardContent" cols="40" rows="3" id="faqBoardContent" spellcheck="true" placeholder="내용을 입력하세요">${faq.faqBoardContent }</textarea>
							</div>
						</div>
							<c:set value="등록" var="btnText"/>
							<c:if test="${status eq 'u' }">
								<c:set value="수정" var="btnText"/>
							</c:if>
							<a class="button add-pricing-list-item" id="btnRegister">${btnText }</a>
							<a class="button add-pricing-submenu" id="btnList">목록</a>
							<a class="button add-pricing-submenu" id="btnAtuo" style="float: right; hover:none;">자동완성</a>
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
	CKEDITOR.replace('faqBoardContent');
	
	var faqboard = $("#faqboard");
	var btnRegister = $("#btnRegister");
	var btnList = $("#btnList");
	var btnAtuo = $("#btnAtuo");
	
	btnRegister.on("click", function(){
		var title = $("#faqBoardTitle").val();	//제목을 가져온다
		var content = CKEDITOR.instances.faqBoardContent.getData();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		if($(this).text() == "수정"){
			faqboard.attr("action", "/admin/faq/modify");
		}
		
		faqboard.submit();	//submit 이벤트를 날려 서버로 데이터를 전송한다.
	});
	
	//목록 버튼 클릭 시 이벤트
	btnList.on("click", function(){
		location.href = "/admin/faq/list";
	})
	
	btnAtuo.on("click", function() {
	  console.log("gdgd");
	  // 미리 정해놓은 내용을 변수에 저장합니다.
	  var preTitle = "관련성 높고 편향되지 않은 후기 작성하기";
	  var preContent =
	    "에어비앤비는 플랫폼에 게시되는 후기가 진정성 있고 신뢰할 수 있으며 유용하다는 믿음을 줄 수 있는 환경을 만들고자 합니다. 후기는 작성자가 자신의 경험을 정확하게 설명하고 긍정적이든 부정적이든 솔직하게 의견을 밝힐 때만 진정으로 유용하기 때문입니다. 허용되지 않는 사항 후기 조작: 위협을 가하거나 보상을 제공하여 게스트나 호스트가 작성하는 후기에 영향을 미치려는 행위는 에어비앤비에서 엄격히 금지됩니다. 경쟁자가 작성한 후기: 특정 호스트와 공공연한 경쟁 관계에 있는 사람은 게스트가 해당 호스트의 숙소나 체험을 예약하는 것을 저지할 목적으로 부정적인 후기를 작성할 수 없습니다. 이해충돌: 가짜 후기나 평점을 이용해 후기 시스템을 조작할 목적으로 숙소나 체험을 예약하는 것은 허용되지 않습니다. 관련성이 없거나 편견이 담긴 후기: 편견에 기반하거나, 상대방에게 보복할 목적으로 작성되었거나, 관련성이 낮거나, 유용한 정보를 담고 있지 않은 후기는 삭제될 수 있습니다. 정책에 위배되는 콘텐츠: 에어비앤비 콘텐츠 정책을 준수하지 않는 모든 콘텐츠는 에어비앤비에서 엄격히 금지됩니다.";
	
	  // 입력 필드에 미리 정해놓은 내용을 채웁니다.
	  $("#faqBoardTitle").val(preTitle);
	  
	// CKEDITOR 에디터 인스턴스를 참조하여 preContent 값을 적용합니다.
	  CKEDITOR.instances.faqBoardContent.setData(preContent);
	
	});
	
})


</script>
