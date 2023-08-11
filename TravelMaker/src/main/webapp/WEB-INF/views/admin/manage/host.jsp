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
	color: black;
}

#okBtn:hover,
#cancelBtn:hover,
#clickAll:hover {
	color : red;
}
#okBtn,
#cancelBtn,
#clickAll {
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
.read-more:hover {
	color : red;
}
</style>
<div class="dashboard-content">
	<div class="dashboard-content" style="margin-left: 0px;">
		<div class="row">
			<div style="text-align: left; margin-bottom: 25px;">
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<div style="width: 700px; display: flex">
						<div>
							<h2 style="margin-top: 5px; margin-bottom: 20px; font-weight:700;">호스트 관리</h2>
							<button id="clickAll">전체선택</button>&nbsp;&nbsp;&nbsp;
						</div>
						<div style="margin-left: 45px; margin-top: 10px;">
							<button id="okBtn">승인</button>
							<button id="cancelBtn">거절</button>
						</div>
						<div style="width: 300px; margin-left: 15px;">
							<select id="reasonSelect" style="height: 35px; margin-top: 5px; padding: 0px 8px;">
								<option value="">사유를 선택하세요</option>
								<option value="숙소이름이 부적절합니다.">숙소이름이 부적절합니다.</option>
								<option value="숙소내용이 부적절합니다.">숙소내용이 부적절합니다.</option>
								<option value="주소정보가 불일치합니다.">주소정보가 불일치합니다.</option>
								<option value="편의시설이 부족합니다.">편의시설이 부족합니다.</option>
								<option value="잘못된 사진이 게시되었습니다.">잘못된 사진이 게시되었습니다.</option>
								<option value="부가정보가 부족합니다.">부가정보가 부족합니다.</option>
								<option value="허위사실이 기재되어 있습니다.">허위사실이 기재되어 있습니다.</option>
							</select>
						</div>
					</div>
					<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px;">
						<span id="searchName">통합검색</span>
						<input style="width: 72%; height: 40px;" type="text" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="검색어를 입력해주세요."/>
					</div>
				</div>
				<div id="myGrid" class="ag-theme-alpine" style="height: 730px;"></div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 -->
<a id="modal" href="#sign-in-dialog" class="sign-in popup-with-zoom-anim"></a>
<div id="memCont"></div>
<script>
var pageContext = "${pageContext.request.contextPath}";

function slickJs() {

	$(".slider").not('.slick-initialized').slick();

    $('.slider').slick({
        dots: false,			// 스크롤 바 아래 점 표시
        arrows: false,		// 화살표
        infinite: true,		// 무한 반복 옵션
        speed: 500,			// 넘어갈 속도
        fade: true,			// 페이드 효과 적용
        slidesToShow: 1,		// 한 화면에 보여질 컨텐츠 개수
        pauseOnHover : true,
        adaptiveHeight: true
      });
  
      $('.slider').on('mouseenter', function() {
          $(this).slick('slickSetOption', 'dots', true);
          $(this).slick('slickSetOption', 'arrows', true);
          $(this).slick('refresh');
          $(this).find('.slick-slide').slideDown(500);
      });

      $('.slider').on('mouseleave', function() {
          $(this).slick('slickSetOption', 'dots', false);
          $(this).slick('slickSetOption', 'arrows', false);
          $(this).slick('refresh');
      });
      
      var sliders = document.querySelectorAll('.slider');
      for(var i=0; i<sliders.length; i++){
          var slider = sliders[i];
          slider.addEventListener('click', function(){
              if (event.target.classList.contains('slick-prev') || event.target.classList.contains('slick-next')) {
                  event.stopPropagation();
              }
          });
      }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-enterprise/dist/ag-grid-enterprise.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/admin/host-manage.js"></script>