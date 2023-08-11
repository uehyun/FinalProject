<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.travelImg {
	border-radius: 7px;
}
#title {
	display: none;
}
#detail {
	display: none;
}
iframe{
	display:block;
}
</style>
<c:set value="등록" var="btnName"/>
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="btnName"/>
</c:if>
<div class="container" style="padding-left: 5%; padding-right: 5%; width: 100%; margin : 15px; display: flex;">
	<div class="col-lg-12" style="display: inline-block;">
		<form action="/tripBoard/register" method="post" id="tboardForm">
			<input type="hidden" name="tboardNo" value="${tBoard.tboardNo}"/>
			<div id="add-listing" class="separated-form">
				<div class="add-listing-section">
					<div class="add-listing-headline" style="display: flex">
						<h3 style="display: inline-block;"><i class="sl sl-icon-plane"></i> 여행게시글 작성</h3>
					</div>
					<div class="row with-forms">
						<div class="col-md-12">
							<div class="input-wrapper">
								<div class="checkboxes in-row" style="margin-bottom: 15px;">
									<input id="check-a" type="checkbox" name="tboardPublicYn" value="N">
									<label for="check-a">비공개</label>
								</div>
								<input name="tboardTitle" id="tboardTitle" class="search-field" type="text" value="${tBoard.tboardTitle}"/>
								<span id="title" style="color: red">제목을 입력해주세요.</span>
							</div>
						</div>
					</div>
				</div>
				<div class="add-listing-section margin-top-45">
					<div class="add-listing-headline">
						<h3><i class="sl sl-icon-speech"></i> 상세 내용</h3>
					</div>
					<div class="form">
						<textarea name="tboardContent" id="tboardContent">${tBoard.tboardContent}</textarea>
						<span id="detail" style="color:red;">내용을 입력해주세요.</span>
					</div>
				</div>
				<input type="hidden" id="travelNo" name="travelNo" value="${tBoard.travelNo }"/>
				<button id="registerBtn" class="button preview" style="float:right;" data-val="${btnName }">${btnName }<i class="fa fa-arrow-circle-right"></i></button>
				<button id="inputBtn" class="button preview" style="float:right;" >입력</button>
				<sec:csrfInput/>
			</div>
		</form>
	</div>
	
	<c:if test="${status ne 'u' }">
		<div class="col-lg-4" style="display: inline-block;">
			<div class="dashboard-list-box">
				<ul class="tripList">
					<li style="height: 70px; align-items: center;">
						<span style="font-weight: bold; font-size: 1.3em;">여행 리스트</span>
					</li>
					<c:forEach items="${tripList }" var="trip">
					<li class="travelLi" data-travelno="${trip.travelNo }" data-traveldate="${trip.travelStartDate }">
						<div class="list-box-listing">
							<div class="list-box-listing-img">
								<img class="travelImg" src="${pageContext.request.contextPath}${trip.travelImgPath }">
							</div>
							<div class="list-box-listing-content">
								<div class="inner">
									<h3>${trip.travelName }</h3>
									<span>${trip.travelStartDate } ~ ${trip.travelEndDate }</span>
								</div>
							</div>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).on("ready",function(){
	CKEDITOR.replace("tboardContent", {
		footnotesPrefix : "a"
	});
	
	var tboardForm = $("#tboardForm");
	var tboardTitle = $("#tboardTitle");
	var tboardContent = $("#tboardContent");
	var registerBtn = $("#registerBtn");
	var inputBtn = $("#inputBtn");
	var title = $("#title");
	var detail = $("#detail");
	var travelNo = $("#travelNo");
	var checkA = $("#check-a");
	
	registerBtn.on("click",function(){
		event.preventDefault();
		var content = CKEDITOR.instances.tboardContent.getData();
		if (checkA.is(":checked")) {
			checkA.attr("check", "false");
			checkA.val("Y");
		} else {
			checkA.attr("check", "true");
			checkA.val("N");
		}
		
		if(tboardTitle.val() == null || tboardTitle.val() == "") {
			title.show();
			return false;
		}
		
		if(content == null || content == "") {
			detail.show();
			return false;
		}
		
		if(travelNo.val() == null || travelNo.val() == "") {
			alert("여행을 선택해주세요.")
			return false;
		}
		
		if(registerBtn.data("val") === "수정") {
			tboardForm.attr("action","/tripBoard/update");
		}
		
		tboardForm.submit();
	});

	inputBtn.on("click",function(event){
		event.preventDefault();
		tboardTitle.val("나의 제주도 여행기");
		CKEDITOR.instances.tboardContent.setData(`대한민국의 남서쪽에 있는 섬으로, 행정구역 상 광역자치단체인 제주특별자치도에 속한다. 한국의 섬 중에서 가장 크고 인구가 많은 섬이기도 하며, 면적은 1,833.2㎢이다. 이는 대한민국 본토에서 가장 큰 기초자치단체인 홍천군(1,820.14㎢)보다 약간 크며, 제주도 다음 두 번째로 큰 섬인 거제도(379.5㎢)의 5배 정도 된다. 인구는 약 70만 명, 세계 섬 크기 218위이다.

제주도는 동아시아 전체로 범위를 넓혀도 꽤 큰 섬에 속한다. 6,000개가 넘는 섬이 있는 일본조차도 본토로 간주되는 혼슈, 홋카이도, 시코쿠, 규슈 4개 섬을 제외한 나머지 모든 섬이 제주도보다 작다.[5] 중국도 하이난섬 한 곳만이 제주도보다 클 뿐이다.[6] 하와이에서도 최대 섬인 하와이 섬 다음으로 큰 섬인 마우이 섬이 제주도보다 약간 큰 정도이다. 미국도 본토만 따지면 제주도보다 큰 섬은 롱아일랜드 뿐이다. 프랑스도 본토에는 제주도보다 큰 섬이 코르시카 섬밖에 없고, 독일에서 가장 큰 섬인 뤼겐 섬은 제주도보다 작다. 크기에 대한 직접적인 비교를 하자면 제주도의 동서 길이 약 73km, 남 길이 약 31km를 대입하여 서울시청 기준 동서 길이로 인천광역시 서구 오류동 거첨도에서 출발하여 경기도 양평군 서종면에 도달하고 남북 길이로는 송추계곡에서 출발하여 관악산에 이르는 수준이다.[7]

정리하자면 실질적으로는 홍천군과 비슷한 면적으로[8], 서울특별시+인천광역시+부천시+의정부시가 다 들어가고도 약간 남을 정도이며 부산광역시+울산광역시가 전부 들어가고도 남는 면적이므로 제주도는 결코 작은 섬이 아니다.

화산 활동으로 형성된 화산섬이다. 이 때문에 중심에 한라산이 있고 섬 곳곳에는 200m~300m인 370개가량의 기생 화산(오름)이 있으며, 하논도 그 중 하나이다.

먼 옛날에는 탐라국이라는 국가가 있었다. 그래서 제주를 가리키는 이명으로 탐라도라고 불리기도 했다. 감귤이 많이 나서 감귤국이라는 별명도 있다.

유럽에서는 쿠웰파르트(Quelpart)라는 이름으로 알려지기도 했다. 1642년 네덜란드의 쿠웰파르트 데 브라크(Quelpaert de Brack) 호가 동아시아 지역을 항해하다가 길을 잘못 들어 우연히 제주도를 발견하고 동인도 회사에 보고하게 되면서, 발견한 배의 이름을 차용한 것이다.[9] 쿠웰파르트는 당시 네덜란드 동인도 회사 직원들의 속어로 소형 선박을 뜻하는 용어이기도 했다.`);
	});
});

var tboardForm = document.querySelector("#tboardForm");
var travelNo = document.querySelector("#travelNo");

document.addEventListener("click", function(e) {
	var targetLi = document.querySelector(".travelLi[style='background-color: gainsboro;']");
    if (targetLi !== e.target && targetLi) {
        targetLi.style.backgroundColor = "";
       	travelNo.value = "";
    }
    if (e.target.classList.contains("travelLi")) {
        var travelNum = e.target.dataset.travelno;
        if (e.target.style.backgroundColor !== "gainsboro") {
        	travelNo.value = travelNum;
            e.target.style.backgroundColor = "gainsboro";
        } else {
        	travelNo.value = "";
            e.target.style.backgroundColor = "";
        }
    }
});

</script>
