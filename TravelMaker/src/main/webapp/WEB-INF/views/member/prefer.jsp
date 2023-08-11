<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:csrfMetaTags/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prefer.css">

<div style="width: auto; margin-top: 15px; margin-bottom: 15px; min-height: 500px;">
	<input type="hidden" name="memNo" id="memNo" value="${member.memNo}">
	<div class="container">
		<div class="style-1">
			<div class="tab-content" id="shgpreDiv">
				<div class="col-md-8" style="display: inline-block;">
					<div id="preShgDiv">
						<span class="hgSpanTag" style="float: left; margin-left: 20px;">선호하는 언어</span>
						<span class="hgSpanTag" style="float: right; margin-right: 20px;"><a href="#" class="updateATag" id="preLanguageBtn">수정</a></span>
						<div style="clear: both;"></div>
						
						<div style="margin-left: 20px; margin-right: 20px; display: none;" id="languageDiv">
							<h5 style="font-weight: bold; font-size: 1.4rem;">
								선호하는 언어에 따라 TravelMaker 페이지의 내용과 커뮤니케이션 방식이 <br> 업데이트됩니다.
							</h5>

							<br>
							<select name="languageOption">
								<option value="">선택하세요..</option>
								<option value="ko" <c:if test="${member.memPreLanguage eq 'ko'}">selected</c:if>>한국어</option>
								<option value="en" <c:if test="${member.memPreLanguage eq 'en'}">selected</c:if>>영어</option>
								<option value="ja" <c:if test="${member.memPreLanguage eq 'ja'}">selected</c:if>>일본어</option>
								<option value="zh-CN" <c:if test="${member.memPreLanguage eq 'zh-CN'}">selected</c:if>>중국어</option>
							</select>
							<br>
							<button class="shgBtn" id="updateBtn1">저장</button>
						</div>
						
						<br><hr><br>
						<span class="hgSpanTag" style="float: left; margin-left: 20px;">선호하는 통화</span>
						<span class="hgSpanTag" style="float: right; margin-right: 20px;"><a href="#" class="updateATag" id="preCurrencyBtn">수정</a></span>
						<div id="currencyDiv" style="margin-left: 20px; margin-right: 20px; display: none;">
							<br>
							<br>
							<select name="currencyOption">
								<option value="">선택하세요..</option>
								<option value="won" <c:if test="${member.memPreLanguage eq 'won'}">selected</c:if>>한국 원</option>
								<option value="dollar" <c:if test="${member.memPreLanguage eq 'dollar'}">selected</c:if>>미국 달러</option>
								<option value="yen" <c:if test="${member.memPreLanguage eq 'yen'}">selected</c:if>>일본 엔</option>
								<option value="yuan" <c:if test="${member.memPreLanguage eq 'yuan'}">selected</c:if>>중국 위안</option>
							</select>
							<br>
							<button class="shgBtn" id="updateBtn2">저장</button>
						</div>
					</div>
				</div>
				<div id="myShgCurrency">
					<div class="fixedContainer">
						<div style="margin-top:32px;margin-bottom:32px">
							<svg viewBox="0 0 24 24" role="presentation" aria-hidden="true" focusable="false" style="height:40px;width:40px;display:block;fill:#FFB400">
								<path d="m21.31 5.91a1.31 1.31 0 1 1 -1.31-1.31 1.31 1.31 0 0 1 1.31 1.31zm-8.31 9.69a1.31 1.31 0 1 0 1.31 1.31 1.31 1.31 0 0 0 -1.31-1.31zm-7-11a1.31
								 1.31 0 1 0 1.31 1.31 1.31 1.31 0 0 0 -1.31-1.31z">
								</path>
								<path d="m22 6.5a2.5 2.5 0 0 1 -2 2.45v13.55a.5.5 0 0 1 -1 0v-13.55a2.5 2.5 0 0 1 0-4.9v-2.55a.5.5 0 0 1 1 0v2.56a2.44 2.44 0 0 1 .33.09.5.5 0 0 1 -.33.94h-.01a1.45 1.45 0 0 0 -.99.01
								 1.49 1.49 0 0 0 0 2.82 1.4 1.4 0 0 0 1 0 1.5 1.5 0 0 0 1-1.41 1.48 1.48 0 0 0 -.09-.52.5.5 0 0 1 .94-.35 2.5 2.5 0 0 1 .16.87zm-7.8 9.83a.5.5 0 0 0
								 -.29.64 1.48 1.48 0 0 1 .09.52 1.5 1.5 0 0 1 -1 1.41 1.4 1.4 0 0 1 -1 0 1.49 1.49 0 0 1 0-2.82 1.48 1.48 0 0 1 .5-.09 1.52 1.52 0 0 1 .5.08h.01a.5.5 0 0
								 0 .32-.94 2.46 2.46 0 0 0 -.32-.08v-13.56a.5.5 0 0 0 -1 0v13.55a2.5 2.5 0 0 0 0 4.9v2.55a.5.5 0 0 0 1 0v-2.55a2.5 2.5 0 0 0 1.84-3.32.5.5 0 0 0
								 -.64-.29zm-7-11a .5.5 0 0 0 -.29.64 1.48 1.48 0 1 1 -1.41-.98 1.47 1.47 0 0 1 .49.08h.01a.5.5 0 0 0 .33-.94 2.44 2.44 0 0 0 -.33-.09v-2.56a.5.5 0 0
								 0 -1 0v2.55a2.5 2.5 0 0 0 0 4.9v13.55a.5.5 0 0 0 1 0v-13.55a2.5 2.5 0 0 0 1.84-3.32.5.5 0 0 0 -.64-.29z" fill="#484848">
								</path>
							</svg>
							<div style="margin-top:16px;margin-bottom:16px">
								<h2 tabindex="-1" elementtiming="LCP-target" class="_14i3z6h"><div class="_1p0spma2">글로벌 환경 설정</div></h2>
							</div>
							<div class="_czm8crp">
								통화를 변경하면 요금 표시 방법이 업데이트됩니다. '결제 및 대금 수령' 설정에서 대금 수령 방법을 변경하실 수 있습니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/member/prefer.js"></script>