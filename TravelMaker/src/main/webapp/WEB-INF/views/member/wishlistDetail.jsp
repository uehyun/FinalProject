<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:csrfMetaTags/>

<style>
	.slick-dots { bottom: 2%; }
	
	.slick-prev { left: 30%; }
	.slick-next { right: 30%; }
	.slick-prev:before, .slick-next:before { font-size: 20px; }
	
	.slick-dotted.slick-slider { margin-bottom: 2%; }
	
	#historyBackBtn, #categoryEditBtn, .addMemoBtn, .editMemoBtn { cursor: pointer; }
	
	.modal {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.5);
		z-index: 9999;
	}
	.modal-content {
		position: absolute;
		top: 50%;
		left: 50%;
		width : 40%;
		height : 43%;
		transform: translate(-50%, -50%);
		background-color: white;
		padding: 2% 1.5%;
		border-radius: 3%;
		overflow: auto;
		transition: opacity 0.3s ease-in-out;
	}
	.close-modal-btn {
		position: absolute;
		top: 3%;
	    right: 3%;
	    font-size: x-large;
		cursor: pointer;
	}
	
</style>

<div class="container" style="height: 100rem;">
	<div style="width: 100%; height: 100%;">
		<div style="display: flex; justify-content: space-between; margin-left: -2.5%; width: 98%;">
			<div style="display: flex; align-items: center; margin: 0 0 0 2%;">
				<i class="fa-solid fa-arrow-left" style="margin-right: 0; font-size: large;" id="historyBackBtn"></i>
				<h1 style="display: inline;">${category.wishlistCategoryName }</h1>
			</div>
			<div style="display: flex; align-items: center;">
				<i class="fa-solid fa-ellipsis" style="font-size: x-large;" id="categoryEditBtn"></i>
			</div>
		</div>
		
		<div style="height: 70%; width: 100%; display: flex; flex-wrap: wrap;">
			<c:forEach var="wish" items="${wishlist }">
				<div style="margin: 1%; width: 30.5%; height: 20%;">
					<div class="slider">
						<c:forEach var="file" items="${wish.files }">
							<div style="height: 25rem;" onclick="goAccommodationDetail('${file.attGroupNo}')">
								<img alt="#" src="${file.attPath }" style="width: 100%; height: 100%; border-radius: 30px;">
							</div>
						</c:forEach>
					</div>
					
					
					<c:choose>
						<c:when test="${not empty wish.wishlistMemo }">
							<div style="display: flex;" class="memoContainer" data-attgroupno="${wish.files[0].attGroupNo}">
								<div style="font-weight: bold; margin-right: 3%;" class="memoValue" data-attgroupno="${wish.files[0].attGroupNo}">
									${wish.wishlistMemo }
								</div>
								<div style="font-weight: bold; border-bottom: 1px solid black;">
									<div class="editMemoBtn" data-attgroupno='${wish.files[0].attGroupNo}'>수정하기</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<span class="addMemoBtn" style="border: none; background: none; border-bottom: 1px solid black; font-weight: bold;" onclick="addMemo('${wish.files[0].attGroupNo}', this)">메모 추가하기</span>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<div id="addMemoModal" class="modal" style="display: none;">
	<div id="addMemoModalContent" class="modal-content">
		<div>
			<h3 style="margin: 0 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">메모 추가하기</h3>
			<button id="closeAddMemoModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
		</div>
		
		<textarea rows="" cols="" id="memoArea" style="margin: 6% 0; resize: none;"></textarea>
		
		<div style="display: flex; justify-content: right; align-items: center; height: 10%;">
	        <button id="saveMemoBtn" style="border: none; border-bottom: 1px solid black; background: none; font-weight: bold;">저장</button>
	    </div>
	</div>
</div>

<div id="editMemoModal" class="modal" style="display: none;">
	<div id="editMemoModalContent" class="modal-content">
		<div>
			<h3 style="margin: 0 0; padding-bottom: 3%; border-bottom: 1px solid #e8e8e8; text-align: center;">메모 수정하기</h3>
			<button id="closeEditMemoModalBtn" class="close-modal-btn" style="border: none; background: none;">X</button>
		</div>
		
		<textarea rows="" cols="" id="editMemoArea" style="margin: 6% 0; resize: none;"></textarea>
		
		<div style="display: flex; justify-content: right; align-items: center; height: 10%;">
	        <button id="editMemoBtn" style="border: none; border-bottom: 1px solid black; background: none; font-weight: bold;">저장</button>
	    </div>
	</div>
</div>
                                                                                                  

 
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<script src="https://kit.fontawesome.com/77ad8525ff.js"></script>
<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$(function() {
		$('#historyBackBtn').on('click', function(){
			window.history.back();
		});
		
		$(".slider").slick({
			dots: true,
		    arrows: true,
		    infinite: true,
		    speed: 500,
		    fade: true,
		    slidesToShow: 1,
		    pauseOnHover: true
		});

		
		$('#closeAddMemoModalBtn').on('click', function() {
			$('#addMemoModal').css('display', 'none');	
		});
		$('#closeEditMemoModalBtn').on('click', function() {
			$('#editMemoModal').css('display', 'none');	
		});
		
		
		
	});
	
	function addMemo(attGroupNo, addMemoBtn) {
		console.log('addMemo Click! -> ' + attGroupNo + '${wishlist[0].wishlistCategoryNo}');
		
		$('#addMemoModal').css('display', 'block');
		
		$('#saveMemoBtn').on('click', function() {
			var memoArea = $('#memoArea').val();
			
			if (memoArea == null || memoArea.trim() == '') {
				alert("메모를 입력해주세요.");
				return false;
			}
			
			
			$.ajax({
				url: '/member/wishlist/detail/addMemo',
				type: 'post',
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					'wishlistCategoryNo': '${wishlist[0].wishlistCategoryNo}', 
					'accNo': attGroupNo,
					'wishlistMemo': memoArea
				}),
				dataType: 'text',
				contentType: 'application/json',
				success: function(res) {
					console.log("success -> " + res);
					if (res == "SUCCESS") {
						swal("성공적으로 등록되었습니다.","","success");
						var html = `<div style='display: flex;' class='memoContainer' data-attgroupno='\${attGroupNo}'>
                        				<div class='memoValue' data-attgroupno='\${attGroupNo}' style='font-weight: bold; margin-right: 3%;'>\${memoArea}</div>
                       					<div style='font-weight: bold; border-bottom: 1px solid black;'>
                       						<div class="editMemoBtn" data-attgroupno='\${attGroupNo}'>수정하기</div>
                     					</div>
                       				</div>`;
                        
                       	console.log("this -> ", addMemoBtn);
                       	$(addMemoBtn).replaceWith(html);
                    	
                    	$('#memoArea').val('');
						$('#addMemoModal').css('display', 'none');
					} else {
						swal("다시시도해주세요.","","FAILED");
					}
				},
				error: function(err) {
					console.log('error -> ', err);
				}
			});
		});
		
	}
	
	$(document).on('click', '.editMemoBtn', function() {
		$('#editMemoModal').css('display', 'block');
		var attGroupNo = $(this).data('attgroupno');
		var memoValueElement = $(`.memoValue[data-attgroupno=\${attGroupNo}]`);
		console.log("memoValueElement -> ", memoValueElement);

		// 이벤트 off 안해주면 문제생김
		$('#editMemoBtn').off('click');

		$('#editMemoBtn').on('click', function(){
			var editMemoArea = $('#editMemoArea').val();

			console.log("edit -> " + attGroupNo + " editMemoArea -> " + editMemoArea + '     ${wishlist[0].wishlistCategoryNo} -> ');
			$.ajax({
				url: '/member/wishlist/detail/editMemo',
				type: 'post',
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					'wishlistCategoryNo': '${wishlist[0].wishlistCategoryNo}', 
					'accNo': attGroupNo,
					'wishlistMemo': editMemoArea
				}),
				dataType: 'text',
				contentType: 'application/json',
				success: function(res) {
					console.log("success -> " + res);
					if (res == "SUCCESS" && editMemoArea.trim() != '') {
						console.log("공백아닙니다.");
						swal("성공적으로 수정되었습니다.","","success");
						memoValueElement.text(editMemoArea);
						
						$('#editMemoArea').val('');
						$('#editMemoModal').css('display', 'none');
					} else if(res == "SUCCESS" && editMemoArea.trim() == ''){
						console.log("공백입니다.");
						swal("성공적으로 수정되었습니다.","","success");

						var memoValue = $(`.memoContainer[data-attgroupno='\${attGroupNo}']`);
						var html = `<span class="addMemoBtn" style="border: none; background: none; border-bottom: 1px solid black; font-weight: bold;" onclick="addMemo('\${attGroupNo}', this)">메모 추가하기</span>`;
						memoValue.replaceWith(html);
						$('#editMemoModal').css('display', 'none');
					} else {
						swal("다시시도해주세요.","","FAILED");
					}
				},
				error: function(err) {
					console.log('error -> ', err);
				}
			});
		});

	});
	
	
	function goAccommodationDetail(attGroupNo) {
		location.href = "/main/detail/" + attGroupNo;
	}
	
</script>




































