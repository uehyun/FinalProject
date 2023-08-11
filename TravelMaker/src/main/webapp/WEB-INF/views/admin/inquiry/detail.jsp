<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
/* 새로추가한 css */
section.comments {
    background-color: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding : 15px;
	border-radius: 8px;
}
.reply {
	background-color : ghostwhite;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}
.comment-by {
	padding-bottom : 0px;
	padding-top : 0px;
}
.day {
	color : #888;
	font-weight: 300;
}
.comment-content {
	height : auto;
	padding:15px 0 0 120px;
}
.btn {
	border: none;
	background-color: ghostwhite;
	font-size: 15px;
	color : gray;
	font-weight: bold;
	text-decoration: underline;
}
.btn:hover {
	color : red;
}
.writerImg {
	border-radius: 50%;
	border : 3px white solid;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	width:75px;
	height:75px;
	margin: 5px 5px 5px 5px;
}
.about-description {
	margin: 0px 0 0 25px;
}
#modBtn,
#delBtn {
	background-color: white;
	text-decoration: underline;
	color: gray;
	font-size: 17px;
}
#modBtn:hover,
#delBtn:hover {
	color: red;
}
/* 댓글 수정폼 */
.reply .comment-content #replyContent {
	width : 300px;
}
#dateContainer {
	overflow-x : scroll;
}
#dateContainer::-webkit-scrollbar {
	display:none;
}

/* 예약된 숙소 */
.placeSubBoxCont {
	height: 100%;
}
#accCont {
	height: 85%;
}
.content-div {
	overflow-y: scroll;
	height: 100%;
	padding : 30px;
	margin-top : 10px;
	margin-left : 10px;
}
.content-div::-webkit-scrollbar {
	display: none;
}
.acc-content {
	margin-left : 30px;
	display: inline-block;
}
.acc-img {
	width: 310px;
	border-radius:8px;
	height: 220px;
}



/* 끝 */
 #ModBtn,#DelBtn,#ListBtn{ 
     color: black; 
     background-color: white; 
     border-color: black;
     padding: 10px; 
     margin-top: 5px; 
 } 


</style>
<sec:csrfMetaTags/>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<!-- 새로갖고온부분 -->
<div class="dashboard-content">
<div class="container">
    <div class="blog-page">
	    <div class="row">
    		<div class="col-lg-12 col-md-12 padding-right-30" style="width:100%">
                <div class="blog-post single-post">
                	<div class="post-content" style="height: 100%;">
						<div style="display: flex; align-items: center;">
							<h2 style="font-weight:bold;">${inquiry.inqBoardTitle}</h2>
						<div style="margin-left:55%;"></div>
						<div style="display: flex; flex-direction: column; align-items: flex-end; margin-right:10px;">
							<h4 style="color: black; font-size: 20px; font-weight: bold;">${member.memName}</h4>
							<span style="font-size: 13px; color: red;">${member.memEmail}</span>
						</div>
							<!-- <img class="writerImg" src="${pageContext.request.contextPath}${member.memProfilePath}"> -->
                            <img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70">
						</div>
							<ul class="post-meta">
						 		<li>${inquiry.inqBoardRegDate}</li>
							</ul>
							<hr/>
						<div>${inquiry.inqBoardContent}</div>
						<form method="post" action="/admin/inquiry/delete" id="inboard">
							<div class="widget" style="float:right; margin : 10px 10px">
								<input type="hidden" value="${inquiry.inqBoardNo }" name="inqBoardNo" id="inqBoardNo"/>
								<sec:csrfInput/>
					          	<c:if test="${member.memNo eq me}">
					               <button class="button" id="ModBtn"> 수정</button>
					               <button class="button" id="DelBtn"> 삭제</button>
					          	</c:if>
				               <button class="button" id="ListBtn"> 목록</button>
				          	</div>
			          	</form>
                </div>

                <div class="margin-top-20"></div>
                
                <!-- 댓글 영역 -->
                <div id="commentArea"></div>

                <div class="clearfix"></div>

                <div id="add-review" class="add-review-box" style="margin-top: 25px; margin-bottom: 30px; padding: 20px; padding-bottom: 20px;">
                    <fieldset>
                        <div>
                            <label>댓글 작성:</label>
                            <textarea id="replyContent" style="max-height: 90px; min-height: 90px;" cols="20" rows="2"></textarea>
                        </div>
                    </fieldset>
                    <button id="replyBtn" class="button" style="float : right;">작성</button>
                    <div class="clearfix"></div>
                </div>
	        </div>
	</div>
</div>
</div>
</div>
</div>
<!-- 끝 -->


<script>
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

var inboard = $("#inboard");
var ModBtn = $("#ModBtn");
var DelBtn = $("#DelBtn");
var ListBtn = $("#ListBtn");
var replyCnt = $("#replyCnt");
	
//목록 버튼 클릭 시 이벤트
ListBtn.on("click", function(){
	inboard.attr("action", "/admin/inquiry/list")
	inboard.attr("method", "get")
	console.log("체킁 : ",inboard)
	//location.href = "/admin/inquiry/list";
});

//수정 버튼 클릭 시 이벤트
ModBtn.on("click",function(){
	inboard.attr("action", "/admin/inquiry/modify")
	inboard.attr("method", "get")
	//console.log("체킁 : ",inboard)
	if(confirm("수정 하시겠습니까?")) {
		inboard.submit();
	} else {
		return false;
	}
});

//삭제 버튼 클릭 시 이벤트
DelBtn.on("click",function(){
	event.preventDefault();
	console.log("난 삭제버튼")
	
	data = {
		"inqBoardNo" : inqBoardNo.val()
	}
	console.log("inqBoardNo:", inqBoardNo.val())
	
	if(confirm("삭제 하시겠습니까?")) {
		data = 
		$.ajax({
			url : "/admin/inquiry/delete",	
			type : "post",
			beforeSend : function(xhr) {
                xhr.setRequestHeader(header,token);
            },
            data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json; charset=utf-8",
            success : function(res){
                if(res.result === "SUCCESS") {
					alert("삭제가 성공했습니다.")
					inboard.submit();
					location.href="/admin/inquiry/list";
                } else {
                    alert(res.result);
                }
            }
		});
	} else {
		return false;
	}
});


//댓글 부분
var replyBtn = $("#replyBtn");
var replyContent = $("#replyContent");
var inqBoardNo = $("#inqBoardNo"); 
var commentArea = $("#commentArea");

replyList();
$(document).on("click",".btn",function(){
    var btnName = $(this).data("btnname");
    var liElement = $(this).closest("li.reply");
	var ireplyNo;
   
    if(btnName == "delBtn") {
        if(confirm("삭제 하시겠습니까?")) {
            ireplyNo = this.parentElement.dataset.ireplyno;
            data = {
                "ireplyNo" : ireplyNo,
            }
            $.ajax({
                url : "/admin/reply/deleteReply",
                type : "post",
                beforeSend : function(xhr) {
                    xhr.setRequestHeader(header,token);
                },
                data : JSON.stringify(data),
                dataType : "json",
                contentType : "application/json; charset=utf-8",
                success : function(res){
                    if(res.result === "SUCCESS") {
                        replyList();
                    } else {
                        alert(res.result);
                    }
                }
            });
        } else {
            return false;
        }
    } else if(btnName == "modBtn") {
        ireplyNo = this.parentElement.dataset.ireplyno;
        // 댓글 수정 버튼 동작
        var existingContent = liElement.find(".comment-content p").html();
        existingContent = existingContent.replaceAll("<br>", "\n");
        var avatarHeight = liElement.find(".avatar").height();

        var textareaElement = $("<textarea>")
        .attr("id", "replyContent")
        .css({ 
            "width": "calc(100% - 85px)", // 이미지 우측에서 버튼 직전까지
            "max-height": "90px",
            "min-height": "90px",
            "flex": "1"
        })
        .val(existingContent);

        liElement.find(".comment-content p").replaceWith(textareaElement);

        var okButton = $("<button>")
        .addClass("btn")
        .attr("data-btnName", "okBtn")
        .text("확인");

        var cancelButton = $("<button>")
        .addClass("btn")
        .attr("data-btnName", "cancelBtn")
        .text("취소");

        console.log("체킁3",ireplyNo)
        var buttonsDiv = $("<div>")
        .addClass("buttons-to-right")
        .attr("data-ireplyNo", ireplyNo)
        .css("display", "flex")
        .css("flex-direction", "column")
        .append(okButton)
        .append($("<div>").css("margin-top", "10px"))
        .append(cancelButton);

        liElement.find(".buttons-to-right").replaceWith(buttonsDiv);

        // .reply div의 높이 조정
        var replyDiv = liElement.find(".reply");
        replyDiv.css("height", avatarHeight + "px");
    } else if(btnName == "okBtn") {
        ireplyNo = this.parentElement.dataset.ireplyno;
        var ireplyContent = liElement.find(".comment-content textarea").val();
        data = {
            "ireplyNo" : ireplyNo,
            "ireplyContent" : ireplyContent,
        }
        console.log("체킁2", data)
        $.ajax({
            url : "/admin/reply/updateReply",
            type : "post",
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header,token);
            },
            data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json; charset=utf-8",
            success : function(res){
                if(res.result === "SUCCESS") {
                    replyList();
                } else {
                    alert(res.result);
                }
            }
        });
        
    } else if(btnName == "cancelBtn") {
        ireplyNo = this.parentElement.dataset.ireplyno;
        var existingContent = liElement.find(".comment-content textarea").val();
  
        var paragraphElement = $("<p>")
        .text(existingContent);
    
        liElement.find(".comment-content textarea").replaceWith(paragraphElement);
    
        var modButton = $("<button>")
        .addClass("btn")
        .attr("data-btnName", "modBtn")
        .text("수정");
    
        var delButton = $("<button>")
        .addClass("btn")
        .attr("data-btnName", "delBtn")
        .text("삭제");
    
        console.log("체킁4",ireplyNo)
        var buttonsDiv = $("<div>")
        .addClass("buttons-to-right")
        .attr("data-ireplyNo", ireplyNo)
        .append(modButton)
        .append(delButton);
    
        liElement.find(".buttons-to-right").replaceWith(buttonsDiv);
    }
});

replyBtn.on("click",function(){
    if(replyContent.val() == "" || replyContent.val() == null) {
        return false;
    }
    data = {
        "inqBoardNo" : inqBoardNo.val(),
        "ireplyContent" : replyContent.val()
    }
    $.ajax({
        url :"/admin/reply/registerReply",
        type : "post",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
        data : JSON.stringify(data),
        dataType : "json",
        contentType : "application/json; charset=utf-8",
        success : function(res){
            if(res.result === "SUCCESS") {
                replyList();
                replyContent.val("");
            } else {
                alert(res.result);
            }
        }
    });
});

function replyList() {
    commentArea.empty();
    $.ajax({
        url :"/admin/reply/replyList?inqBoardNo=" + inqBoardNo.val(),
        type : "get",
        success : function(res){
            if(res.result === "SUCCESS") {
                var con = res.replyList;
                console.log(con[0].ireplyRegDate)
               	console.log(con[0].ireplyContent)
               	console.log("ireplyWriter",con[0].ireplyWriter)
                console.log("me:",res.me)
                rep = ` <section class="comments">  
                <h4 class="headline margin-bottom-35">댓글 <span class="comments-amount">(\${res.repCnt})개</span></h4>
                <hr/>
                <ul>`;
                for(let i=0; i<con.length; i++) {
                    var contentText = con[i].ireplyContent;
                    //console.log(contentText)
                    contentText = contentText.replaceAll("\n", "<br/>");
                    rep += `    <li class="reply" style="margin-top: 5px;">
                                    <div class="avatar" style="left:15px; top:15px;">
                                        <img src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70"></div>
                                   <div class="comment-content">
                                        <div class="arrow-comment" style="width: 90%; padding-bottom: 10px;">
                                            <div class="comment-by">\${con[i].ireplyWriter}&nbsp;|&nbsp; <span class="day">\${con[i].ireplyRegDate}</span></div>
                                            <p>\${contentText}</p>
                                        </div>
                                    </div>`;
                                    if(res.me === con[i].ireplyWriter) {
                                        rep += `<div class="buttons-to-right" data-ireplyno="\${con[i].ireplyNo}">
                                                    <button class="btn" data-btnName="modBtn"> 수정</button>
                                                    <button class="btn" data-btnName="delBtn"> 삭제</button>
                                                </div>`;
                                    }
                                `</li>`;
                }
                rep += `    </ul>
                        </section>`;
                        // <img src="${pageContext}\${con[i].memProfilePath}" style="width:65px; height:65px;"/>
                commentArea.html(rep);
            }
        }
    });
}



</script>
