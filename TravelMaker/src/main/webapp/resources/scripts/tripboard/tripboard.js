ehyun = {};
$(function(){
    ehyun.list();
});

$(document).ready(function() {
    $('#title').keypress(function(event) {
        if (event.keyCode === 13) { 
            ehyun.list();
        }
    });
});

var searchForm = ("#searchForm");
var postDiv = $("#postDiv");
var pagingArea = $("#pagingArea");
var title = $("#title");
var page = $("#page");

$(document).on("click",".blog-post",function(){
    var tboardNo = $(this).data("tboardno");
    console.log($(this).data("tboardno"));
    location.href="/tripBoard/detail?tboardNo=" + tboardNo;
});

$(document).on("click",".pop-content",function(){
    var tboardNo = $(this).data("tboardno");
    console.log($(this).data("tboardno"));
    location.href="/tripBoard/detail?tboardNo=" + tboardNo;
});


ehyun.list = function(){
    var tval = title.val();
    var pval = page.val();
    $.ajax({
        url : "/tripBoard/list",
        type : "get",
        data : {
            "title" : tval,
            "page" : pval
        },
        contentType : "application/json; charset=utf-8",
        dataType : "json",
        success : function(res){
            if(res.result === "SUCCESS") {
                var divStr = "";
                postDiv.empty();
                pagingArea.empty();
                console.log(res.pagingVO.dataList);
                for(let i=0; i<res.pagingVO.dataList.length;i++) {
                    let con = res.pagingVO.dataList[i];
                    divStr = `
                    <div class="blog-post" data-tboardno="${con.tboardNo}">
				
                        <a href="#" class="post-im">
                            <img src="${pageContext}${con.travelImgPath}" alt="">
                        </a>
                        
                        <div class="post-content">
                            <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="#">${con.tboardTitle}</a></h3>
                            <ul class="post-meta">
                                <li>${con.tboardRegDate}</li>
                                <li>${con.tboardWriter}</li>
                                <li><i class='sl sl-icon-eye'></i> ${con.tboardHit}</li>
                            </ul>
                            <a href="#" class="read-more">게시글 보기 <i class="fa fa-angle-right"></i></a>
                        </div>
        
                    </div>
                    `
                    postDiv.append(divStr);
                }
                var pagingHTML = res.pagingVO.pagingHTML;
                pagingArea.html(pagingHTML);
            }
        },
        error : function(xhr) {
            console.log(xhr)
        }
    });
};

pagingArea.on("click", 'a', function(event){
    event.preventDefault();
    var pageNo = $(this).data("page");
    page.val(pageNo);
    console.log(page.val());
    ehyun.list();
});
