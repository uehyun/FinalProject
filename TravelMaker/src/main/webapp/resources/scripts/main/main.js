function getList(data) {
	$(".slider").slick("unslick");
	
	$(".slick-slide").each(function() {
		$(this).css("display", "none");
	});
	
    $.ajax({
        url : "/main/search",
        type : "get",
        data :data,
        dataType : "json",
        contentType : "application/json; charset=utf-8",
        success : function(res) {
            var tblStr = "";
            for(let i=0; i<res.length; i++) {
                var price = Number(res[i].accPrice).toLocaleString(); 
                tblStr += `<div class="acc-div">
                            <div class="slider">`;
                            for(let j=0; j<res[i].files.length; j++) {
                                tblStr += `<img class="accImages" alt="#" src="${pageContext}${res[i].files[j].attPath }" style="border-radius: 10%; height: 20rem; width: 11%;">`;
                            }
                            tblStr += `</div>
                            <div style="cursor: pointer;" onclick="goAcommodationDetail('${res[i].accNo}')">
                                <div style="display: flex; justify-content: space-between;">
                                    <span class="acc-title">${res[i].accName }</span>
                                    <div>`;
                                    if(res[i].accScore != 0.0) {
                                        tblStr += `<h4>
                                                        <i class="fa-solid fa-star"></i>
                                                        ${res[i].accScore }
                                                    </h4>`;
                                    }
                                    
                                  tblStr += `</div>
                                </div>
                                <div>
                                    <div class="acc-content">${res[i].accLocation }</div>
                                    <span class="acc-price">￦${price}/박</span>
                                </div>
                            </div>
                        </div>`;
            }
            accBox.innerHTML += tblStr;
            slickJs();
        }
    });
}

function getTopCategory() {
    $.ajax({
        url: "/main/selectTopCategory",
        type: "get",
        success: function(res) {
            console.log(res);
            let popularCategory = $(".popularCategory");
            for(let i = 0; i < popularCategory.length; i++) {
                popularCategory.eq(i).empty();
            }

            let cateZone = $(".cate-zone");
            for(let i = 0; i < cateZone.length; i++) {
                for(let j = 0; j < res.length; j++) {
                    if(cateZone.eq(i).data("cate") == res[j].OPTIONNO) {
                        cateZone.eq(i).find(".popularCategory").append("<i class='fa-solid fa-fire'></i>");
                    }
                }
            }
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
}

categories.forEach(function (element) {
    element.addEventListener("click", function () {
        $(".cate-zone").css("background-color","white");
        element.style.backgroundColor = "rgb(231, 230, 230)";
        var cateNum = this.dataset.cate;
        categoryNum.val(cateNum);
        console.log(this.dataset.cate);
        // getAcc(cateNum);
        data = {
            "juso" : "",
            "checkIn" : "",
            "checkOut" : "",
            "guest" : 1,
            "category" : categoryNum.val(),
            "pageCount" : 1
        };
        accBox.innerHTML = "";
        getList(data);
    });
});

accBox.addEventListener("scroll", function(){
    fchk(data);
});

function fchk(data) {
    var scrollTop = accBox.scrollTop;
    var clientHeight = accBox.clientHeight;
    var scrollHeight = accBox.scrollHeight;

    var tunningVal = 20;
    console.log(scrollTop + clientHeight);
    console.log(scrollHeight - tunningVal);
    throttle(() => {
        if((scrollTop + clientHeight) >= (scrollHeight - tunningVal)) {
            data.pageCount = data.pageCount + 1;
            getList(data);
        }
    }, 1500); // 1초로 스로틀링 설정
}

function throttle(callback, delay) {
    if (!isScrolling) {
      isScrolling = true;
      setTimeout(() => {
        callback();
        isScrolling = false;
      }, delay);
    }
} 