var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var dateContainer = document.getElementById("dateContainer");

ehyun = {};

var markers = [];
var tripList = [];
var erumNum = [];

var map;
var mapContainer;
var mapOption;

var spotx;
var spoty;

var drawingFlag = false;
var clickLine;
var distanceOverlay;
var dots = {};
var travelDate = document.querySelector("#travelStartDate").value;
const accDetail = document.querySelector("#accDetail");

var enterFlag = true;

displayFormattedDates(startDateStr, endDateStr);    // 날짜 출력

// 지도 로드 하는 곳
ehyun.getData = function() {
    var disDiv = document.querySelector("#distance-div");
    disDiv.innerHTML = getTimeHTML(0);
    removeMarker();
    var travelNo = document.querySelector("#travelNo").value;
    var xhr = new XMLHttpRequest();
    xhr.open("get",`/member/tripList?travelNo=${travelNo}&travelDate=${travelDate}`,true);
    //xhr.setRequestHeader("Content-Type" ,"application/json; charset=utf-8");
    xhr.onreadystatechange = function(res) {
        if(xhr.readyState == 4 && xhr.status == 200) {
            if(enterFlag) {
                var dateElements = document.querySelectorAll(".date");
                dateElements.forEach(function(element) {
                    if(element.innerHTML == startDateStr) {
                        element.click();
                    }
                });
                enterFlag = false;
            } else {
                if(tripList.length > 0) {
                    tripList.length = 0;
                }
                var places = JSON.parse(xhr.responseText);
                if(places.trip.length == 0) {
                    createMap(33.450701,126.570667);
                    deleteClickLine();
                    deleteDistnce();
                    deleteCircleDot();
                } else {
                    createMap(places.trip[0].y,places.trip[0].x);
                    for(let i=0; i<places.trip.length; i++) {
                        ehyun.createRoute(places.trip[i]);
                    }
                    ehyun.drawMaker();
                }
                console.log(places.acc);
                if(places.acc != null) {
                    accInfo(places.acc);
                }
            }
        }
    }
    xhr.send();
}

function accInfo(acc) {
    // $(".slider").slick("unslick");
    accDetail.innerHTML = "";
    var tblStr = "";
    for(let i=0; i<acc.length; i++) {
        console.log(acc[i].imgList.length)
        tblStr += `
            <div class="acc-detail">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight: 700;">${acc[i].accName}</h3>
                <div class="slider">`;
                    for(let j=0; j<acc[i].imgList.length; j++) {
                        console.log(acc[i].imgList[j].attPath)
                        tblStr += `<img style="height:300px; border-radius:6%;" src="${acc[i].imgList[j].attPath}"/>`;
                    }
                tblStr += `</div>
                <div class="acc-content" style="display: flex; margin-top: 15px;">
                    <div style="width:70px;">
                        <img src="${acc[i].memProfilePath}" style="width:70px; height:70px; border-radius:50%; border: 2px solid white; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);"/>
                    </div>
                    <div style="margin-left: 20px; width:290px;">
                        <div class="acCont">${acc[i].memName}</div>
                        <div class="acCont" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${acc[i].accLocation}</div>
                        <div class="acCont">${acc[i].memEmail}</div>
                    </div>
                    <div style="display: flex; flex-direction: column; justify-content: center; margin-left:5%;">
                    </div>
                </div>
            </div>
        `;
    }
    accDetail.innerHTML = tblStr;
    slickJs();
}

function createMap(spoty, spotx){
    mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(spoty, spotx), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };

    map = new kakao.maps.Map(mapContainer, mapOption);
};

ehyun.drawMaker = function(){
    var placeList = document.querySelectorAll(".location");

    console.log(placeList.length);
    for(let i=0; i<placeList.length; i++) {
        // 내 마커 추가
        
        
        var obj = placeList[i].dataset.place;
        pl = JSON.parse(obj);
        tripList.push(pl)
        var placePosition = new kakao.maps.LatLng(tripList[i].y, tripList[i].x),
        marker = addMarker(placePosition, i);
        drawLine(markers[i]);
    }
    displayDot();
}

ehyun.createRoute = function(places) {
    var pla = {
            travelNo : travelNo,
            id : places.id,
            placeName : places.place_name,
            placeUrl : places.place_url,
            categoryGroupName : places.category_group_name,
            phone : places.phone,
            x : places.x,
            y : places.y
    }
    tripList.push(pla);
    var pl = JSON.stringify(pla);

    var innerDiv = document.createElement('div');
    innerDiv.style.display = "flex";
    innerDiv.style.justifyContent = "space-between";
    innerDiv.style.margin = "0 25px";
    innerDiv.style.marginTop = "0px";

    var leftDiv = document.createElement('div');
    leftDiv.style.display = "inline-block";
    leftDiv.style.textAlign = "center";
    var leftP = document.createElement('p');
    leftDiv.appendChild(leftP);

    var rightDiv = document.createElement('div');
    rightDiv.style.display = "inline-block";
    rightDiv.style.textAlign = "left";
    var rightP = document.createElement('p');
    rightDiv.appendChild(rightP);

    leftP.innerHTML = `<a class="read-more" href="${places.place_url}">${places.place_name}<i class='fa fa-angle-right'></i></a>`;
    rightP.innerHTML = places.category_group_name;

    innerDiv.appendChild(leftDiv);
    innerDiv.appendChild(rightDiv);
    
    var erum = document.createElement('div');
    erum.className = "erumNum";
    
    var spotNum = document.createElement('div');
    spotNum.className = "spotNumber";
    spotNum.style.backgroundColor = ehyun.getRandomColor();
    spotNum.innerHTML = tripList.indexOf(pla)+1;
    
    var frame = document.createElement('div');
    frame.className = "frame";
    
    var spot = document.createElement('div');
    spot.className = 'location';
    spot.dataset["place"] = pl;
    spot.id = places.id;
    
    var placeInfo = document.createElement('p');
    placeInfo.innerHTML = places.placeName;
    placeInfo.innerHTML += places.categoryGroupName;

    placeInfo.style.marginTop = "10px";
    
    erum.appendChild(spotNum);
    spot.appendChild(innerDiv);
    frame.appendChild(erum);
    frame.appendChild(spot);

    ehyun.drawConnector(erum);
    
    placeLocation.appendChild(frame);
}   

ehyun.getRandomColor = function() {
    // 16진수 색상 코드를 생성
    var letters = "0123456789ABCDEF";
    var color = "#";
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

ehyun.drawConnector = function(erum) {
    if(tripList.length > 1) {
        var connector = document.createElement('div');
        connector.className = 'connector';
        
        erum.appendChild(connector);
    }
}

function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
    return marker;
}

function drawLine(marker) {

    // 마우스로 클릭한 위치입니다 
    var clickPosition = marker.n;

    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {
        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
        deleteClickLine();
        deleteDistnce();
        deleteCircleDot();

        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new kakao.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });

        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());


        //================================= 거리계산 div ====================================
        // console.log(clickLine);
        // 거리계산
        var kmDistanse = '<div class="dotOverlay">거리 <span class="number">' + (distance / 1000).toFixed(1) + '</span>km</div>';
        for(let i=1; i<erumNum.length; i++) {
            // erumNum[i].appendChild(kmDistanse);
            console.log(erumNum[i]);
            console.log(kmDistanse);

        }
        // appendChild(kmDistance);
        //================================= 거리계산 div ====================================
        displayCircleDot(clickPosition, distance);
    }
};

function displayCircleDot(position, distance) {
    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);
    if (distance > 0) {
        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new kakao.maps.CustomOverlay({
        	content: '<div class="dotOverlay">거리 <span class="number">' + distance.toFixed(1) + '</span>km</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        

        // 지도에 표시막기
        // distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 총거리 다른 곳에 찍어주자
function showDistance(content, position) {

    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

function getTimeHTML(distance) {
	var kmDistance = distance / 1000;
	
    var content = '<span class="number" style="font-size: 24px;">' + kmDistance.toFixed(1) + '</span>km';

    return content;
}

function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }
        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

function displayDot() {
     // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
     if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
    
        // 선을 구성하는 좌표의 개수가 2개 이상이면
        if (path.length > 1) {

            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
            if (dots[dots.length-1].distance) {
                dots[dots.length-1].distance.setMap(null);
                dots[dots.length-1].distance = null;    
            }

            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다

            var disDiv = document.querySelector("#distance-div");
            disDiv.innerHTML = content;
                
            // 그려진 선의 거리정보를 지도에 표시합니다
            // showDistance(content, path[path.length-1]);  
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;          
    }
};

// 시작
ehyun.getData();

// ================================ 날짜 출력 함수 ===================================
function displayFormattedDates(startDateStr, endDateStr) {
	var startDate = new Date(startDateStr);
	var endDate = new Date(endDateStr);
	var currentDate = new Date(startDate);
  
	while (currentDate <= endDate) {
		var year = currentDate.getFullYear();
		var month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
		var day = ("0" + currentDate.getDate()).slice(-2);
		var formattedDate = year + "-" + month + "-" + day;
		
		// 날짜를 추가할 요소 생성
		var dateElement = document.createElement("div");
		dateElement.textContent = formattedDate;
		dateElement.classList.add("date"); // CSS 클래스 추가
		
		// 날짜를 추가할 컨테이너에 요소 추가
		dateContainer.appendChild(dateElement);
		
		currentDate.setDate(currentDate.getDate() + 1); // 다음 날짜로 이동
	}
}
	
// 좌우 스크롤 버튼 이벤트 처리
dateNavLeft.addEventListener("click", function () {
	dateContainer.scrollLeft -= 500; // 스크롤 왼쪽으로 이동
});

dateNavRight.addEventListener("click", function () {
	dateContainer.scrollLeft += 500; // 스크롤 오른쪽으로 이동
});

var dateElements = document.querySelectorAll(".date");
dateElements.forEach(function(element) {
    element.addEventListener("click", function() {
        dateElements.forEach(function(element){
            element.style.color = "gray";
        });
        this.style.color = "red";

        travelDate = this.innerHTML;
        placeLocation.innerHTML = "";
        tripList = [];
        // 데이터 다시 받아오기
        ehyun.getData();
    });
});

$(document).on("click",".pop-content",function(){
    var tboardNo = $(this).data("tboardno");
    console.log($(this).data("tboardno"));
    location.href="/tripBoard/detail?tboardNo=" + tboardNo;
});

// ==================================== 댓글 부분 ============================================
var replyBtn = $("#replyBtn");
var replyContent = $("#replyContent");
var tboardNo = $("#tboardNo");
var commentArea = $("#commentArea");

replyList();

$(document).on("click",".btn",function(){
    var btnName = $(this).data("btnname");
    var liElement = $(this).closest("li.reply");
    var treplyNo;
    if(btnName == "delBtn") {
        if(confirm("삭제 하시겠습니까?")) {
            treplyNo = this.parentElement.dataset.treplyno;
            data = {
                "treplyNo" : treplyNo,
            }
            $.ajax({
                url : "/tripBoard/deleteReply",
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
                        swal(res.result,"","error");
                    }
                }
            });
        } else {
            return false;
        }
    } else if(btnName == "modBtn") {
        treplyNo = this.parentElement.dataset.treplyno;
        // 수정 버튼 동작
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

        var buttonsDiv = $("<div>")
        .addClass("buttons-to-right")
        .attr("data-treplyno", treplyNo)
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
        treplyNo = this.parentElement.dataset.treplyno;
        var treplyContent = liElement.find(".comment-content textarea").val();
        data = {
            "treplyNo" : treplyNo,
            "treplyContent" : treplyContent,
        }
        $.ajax({
            url : "/tripBoard/updateReply",
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
                    swal(res.result,"","error");
                }
            }
        });
        
    } else if(btnName == "cancelBtn") {
        treplyNo = this.parentElement.dataset.treplyno;
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
    
        var buttonsDiv = $("<div>")
        .addClass("buttons-to-right")
        .attr("data-treplyno", treplyNo)
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
        "tboardNo" : tboardNo.val(),
        "treplyContent" : replyContent.val()
    }
    $.ajax({
        url :"/tripBoard/registerReply",
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
                swal(res.result,"","error");
            }
        }
    });
});

function replyList() {
    commentArea.empty();
    $.ajax({
        url :"/tripBoard/replyList?tboardNo=" + tboardNo.val(),
        type : "get",
        // beforeSend : function(xhr) {
        //     xhr.setRequestHeader(header,token);
        // },
        // contentType : "application/json; charset=utf-8",
        success : function(res){
            if(res.result === "SUCCESS") {
                // if()
                var con = res.replyList;
                rep = ` <section class="comments">
                <h4 class="headline margin-bottom-35">댓글 <span class="comments-amount">(${res.cnt})</span></h4>
                <hr/>
                <ul>`;
                for(let i=0; i<con.length; i++) {
                    var contentText = `${con[i].treplyContent}`;
                    contentText = contentText.replaceAll("\n", "<br/>");
                    rep += `    <li class="reply" style="margin-top: 5px;">
                                    <div class="avatar" style="left:15px; top:15px;"><img src="${pageContext}${con[i].memProfilePath}" style="width:65px; height:65px;"/> </div>
                                    <div class="comment-content">
                                        <div class="arrow-comment" style="width: 90%; padding-bottom: 10px;">
                                            <div class="comment-by">${con[i].memNo}&nbsp;|&nbsp; <span class="day">${con[i].treplyRegDate}</span></div>
                                            <p>${contentText}</p>
                                        </div>
                                    </div>`;
                                    if(res.me === con[i].memNo) {
                                        rep += `<div class="buttons-to-right" data-treplyNo="${con[i].treplyNo}">
                                                    <button class="btn"  data-btnName="modBtn"> 수정</button>
                                                    <button class="btn" data-btnName="delBtn"> 삭제</button>
                                                </div>`;
                                    }
                                `</li>`;
                }
                rep += `    </ul>
                        </section>`;
                commentArea.html(rep);
            }
        }
    });
}

const slickOption = {
    arrows: true,
    infinite: true,
    speed: 500,
    fade: true,
    slidesToShow: 1
};

function slickJs() {
    $(".slider").slick(slickOption);
}