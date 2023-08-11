var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var searchArea = document.querySelector("#searchArea");
var placeLocation = document.querySelector("#placeLocation");
var travelNo = document.querySelector("#travelNo").value;
// var accCont = document.querySelector("#accCont");
var memoCont = document.querySelector("#memoCont");
var menu = document.querySelector("#menu_wrap");

// 마커를 담을 배열입니다
var markers = [];
var tripList = [];
var erumNum = [];

// 선 그리기 객체
var drawingFlag = false;
var moveLine;
var clickLine;
var distanceOverlay;
var dots = {};
var ehyun = {};
var dragFlag = true;
var editFlag = false;
var flag;

//날짜 컨테이너 요소와 스크롤 버튼 요소 가져오기
var dateContainer = document.getElementById("dateContainer");
var dateNavLeft = document.getElementById("dateNavLeft");
var dateNavRight = document.getElementById("dateNavRight");
var travelNo = document.querySelector("#travelNo").value;
var travelDate = document.querySelector("#travelStartDate").value;

// 저장, 보내기 버튼
const btnSave = document.querySelector("#btnSave");
const btnSearch = document.querySelector("#btnSearch");

// 예약숙소, 메모 탭 버튼
const accBtn = document.querySelector("#accBtn");
const memoBtn = document.querySelector("#memoBtn");
const accDetail = document.querySelector("#accDetail");

const slickOption = {
    arrows: true,
    infinite: true,
    speed: 500,
    fade: true,
    slidesToShow: 1
};

// 기간 출력
displayFormattedDates(startDateStr, endDateStr);

// 로드 시 바로 실행
document.addEventListener('DOMContentLoaded', function() {
    getData();
    // accCont.style.display="block";
    memoCont.style.display="none";
});

// 검색하기 버튼 누르면 검색창 나옴
btnSearch.addEventListener("click", function(){
    removeMarker();
    deleteClickLine();
    deleteDistnce();
    deleteCircleDot();

    editFlag = true;
    var menu = document.querySelector("#menu_wrap");
    searchArea.style.display = "block";
    menu.style.display = "block";
    btnSave.style.display = "block";
    btnSearch.style.display = "none";

    ehyun.removeConnector();
    var erumNum = document.querySelectorAll(".erumNum");
    erumNum.forEach(function(erum){
        erum.style.display = "none";
    });

    // 편집 중일 때는 무조건 삭제 가능하도록
    var cancelIcons = document.querySelectorAll(".x-icon");
    cancelIcons.forEach(function(cancelIcon) {
        cancelIcon.style.display = "inline-block";
    });

    var placeList = document.querySelectorAll(".location");
    for(let i=0; i<placeList.length; i++) {
        var obj = placeList[i].dataset.place;
        pl = JSON.parse(obj);
        tripList.push(pl);
    }
    
    dragFlag = true;
    ehyun.dragEvent(dragFlag);
});

// 경로 배열에 저장하기
btnSave.addEventListener("click",function(){
    editFlag = false;
    dragFlag = false;
    btnSave.style.display = "none";
    btnSearch.style.display = "block";
    
    
    // 번호 초기화
    if(tripList.length > 0) {
        tripList.length = 0;
	}

    var spotNum = document.querySelectorAll('.spotNumber');
    for (let i = 0; i < spotNum.length; i++) {
        spotNum[i].innerHTML = i + 1;
    }

    var cancelIcons = document.querySelectorAll(".x-icon");
    cancelIcons.forEach(function(cancelIcon) {
        cancelIcon.style.display = "none";
    });

    var erumNum = document.querySelectorAll(".erumNum");
    erumNum.forEach(function(erum){
        erum.style.display = "inline-block";
    });


	removeMarker();     // 마커 지우기
    drawingFlag = false;    // 선 저장하기
    var placeList = document.querySelectorAll(".location");
    
    if(placeList.length == 0) {
        deleteClickLine();
        deleteDistnce();
        deleteCircleDot();
    } else {
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

    searchArea.style.display = "none";
    menu.style.display = "none";
    ehyun.sendData();

    ehyun.dragEvent(dragFlag);
});

accBtn.addEventListener("click", function(){
	var accCont = document.querySelector("#accCont");
	var memoCont = document.querySelector("#memoCont");
    accCont.style.display = "block";
    memoCont.style.display = "none";
});

memoBtn.addEventListener("click", function(){
    accCont.style.display = "none";
    memoCont.style.display = "block";
});

ehyun.sendData = function() {
    if(tripList.length == 0) {
        tripList[0] = {"travelNo" : travelNo, "travelDate" : travelDate};
    }
    $.ajax({
        url : "/member/addTripDetail",
        type : "post",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
        data : JSON.stringify(tripList),
        dataType : "json",
        contentType : "application/json; charset=utf-8",
        success: function(result) {
            if (result.result === "SUCCESS") {
                tripList = [];
            }
        },
        error: function(xhr, status, error) {
            console.log("Error:", error);
        }
    });
}

// 랜덤 색상 적용
ehyun.getRandomColor = function() {
    // 16진수 색상 코드를 생성
    var letters = "0123456789ABCDEF";
    var color = "#";
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

// drag drop 이벤트
const dragArea = document.querySelector("#placeLocation");
var sortable;
ehyun.dragEvent = function(dragFlag) {
    if(dragFlag === true) {
        sortable = new Sortable(dragArea, {
            animation: 350,
        });
        
        sortable.el.addEventListener('sort', function (event) {
            var sortedItems = event.to.children;
            ehyun.removeConnector();
            
            // 정렬된 항목을 기반으로 spotNum 업데이트
            for (let i = 0; i < sortedItems.length; i++) {
                var spotNum = sortedItems[i].querySelector('.spotNumber');
                spotNum.innerHTML = i + 1;
            }
        });
    } else {
        if (sortable) { // sortable이 정의된 경우에만 제거
            sortable.destroy(); // sortable 제거하여 drag 이벤트 비활성화
            sortable = undefined; // sortable 변수 초기화
        }
        var erum = document.querySelectorAll(".erumNum");
        for(let i=1; i<tripList.length; i++) {
            ehyun.drawConnector(erum[i]);
        }
    }
}

ehyun.drawMaker = function(){
    var placeList = document.querySelectorAll(".location");

    for(let i=0; i<placeList.length; i++) {
        // 내 마커 추가
        
        var obj = placeList[i].dataset.place;
        pl = JSON.parse(obj);
        tripList.push(pl)
        var placePosition = new kakao.maps.LatLng(tripList[i].y, tripList[i].x),
        marker = addMarker(placePosition, i);
        drawLine(markers[i]);
    }
    tripList = [];
    displayDot();
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

var map = new kakao.maps.Map(mapContainer, mapOption);  // 지도를 생성합니다   
var ps = new kakao.maps.services.Places();              // 장소 검색 객체를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1}); // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        swal('키워드를 입력해주세요!',"","warning");
        return false;
    }
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        displayPlaces(data);
        displayPagination(pagination);
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        swal('검색 결과가 존재하지 않습니다.',"","warning");
        return;
    } else if (status === kakao.maps.services.Status.ERROR) {
        swal('검색 결과 중 오류가 발생했습니다.',"","error");
        return;
    }
}

function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    removeAllChildNods(listEl);
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        bounds.extend(placePosition);
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'click', function() { displayInfowindow(marker, title);});
            kakao.maps.event.addListener(marker, 'mouseout', function() { infowindow.close();});
            itemEl.onmouseover =  function () { displayInfowindow(marker, title);};
            itemEl.onmouseout =  function () { infowindow.close();};
        })(marker, places[i].place_name);
        fragment.appendChild(itemEl);
    }
    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span><br/>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span><br/>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';
    
    // 검색하고 div 추가
    el.addEventListener('click', function () {
        if(confirm("추가 하시겠습니까?")) {
            ehyun.createRoute(places);
        } else {
            return false;
        }
    });

    return el;
}

ehyun.createRoute = function(places) {
    var isDuplicate = false;
    for (var i = 0; i < tripList.length; i++) {
        if (tripList[i].id === places.id) {
            isDuplicate = true;
            swal("동일 장소는 추가할 수 없습니다.","","warning");
            break;
        }
    }

    if(!isDuplicate) {
        var pla = {
            travelNo : travelNo,
            id : places.id,
            placeName : places.place_name,
            placeUrl : places.place_url,
            categoryGroupName : places.category_group_name,
            phone : places.phone,
            x : places.x,
            y : places.y,
            travelDate : travelDate
        }
        tripList.push(pla);
        var pl = JSON.stringify(pla);

        var innerDiv = document.createElement('div');
        innerDiv.style.display = "flex";
        innerDiv.style.justifyContent = "space-between";
        innerDiv.style.margin = "0 25px";
        innerDiv.style.marginTop = "25px";

        var leftDiv = document.createElement('div');
        leftDiv.style.display = "inline-block";
        leftDiv.style.textAlign = "center";
        var leftP = document.createElement('p');
        leftDiv.appendChild(leftP);

        var rightDiv = document.createElement('div');
        rightDiv.style.display = "inline-block";
        rightDiv.style.width = "80px";
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

        var xIcon = document.createElement("div");
        xIcon.className = 'x-icon';
        xIcon.innerHTML = '<i class="fas fa-duotone fa-circle-xmark"></i>';
        
        erum.appendChild(spotNum);
        spot.appendChild(innerDiv);
        frame.appendChild(erum);
        if(editFlag) {
            xIcon.style.display = "inline-block";
            erum.style.display = "none";
        }
        
        frame.appendChild(spot);
        frame.appendChild(xIcon);
        ehyun.drawConnector(erum);
        
        placeLocation.appendChild(frame);
    }   
}

function getData() {
    var disDiv = document.querySelector("#distance-div");
    disDiv.innerHTML = getTimeHTML(0);
    removeMarker();
    var memoDiv = document.querySelector("#memoDiv");
    memoDiv.innerHTML = "수정 버튼을 눌러 메모를 입력하세요.";
    var xhr = new XMLHttpRequest();
    xhr.open("get",`/member/tripList?travelNo=${travelNo}&travelDate=${travelDate}`,true);
    //xhr.setRequestHeader("Content-Type" ,"application/json; charset=utf-8");
    xhr.onreadystatechange = function(res) {
        if(xhr.readyState == 4 && xhr.status == 200) {
            if(tripList.length > 0) {
                tripList.length = 0;
            }
            var places = JSON.parse(xhr.responseText);
            if(places.trip.length == 0) {
                createMap(36.32506205106138,127.4088952038996);
                deleteClickLine();
                deleteDistnce();
                deleteCircleDot();
            } else {
                createMap(places.trip[0].y,places.trip[0].x);
                for(let i=0; i<places.trip.length; i++) {
                    ehyun.createRoute(places.trip[i]);
                }
                ehyun.drawMaker();
                if(places.trip[0].memo != null) {
                    memoText = places.trip[0].memo.replace(/<br>/g, "\n");
                    memoDiv.style.whiteSpace = "pre-line";
                    memoDiv.innerHTML = memoText;
                }
            }
            if(places.acc.length > 0) {
                console.log(places.acc)
                accInfo(places.acc);
            }
            searchArea.style.display = "none";
            menu.style.display = "none";
            btnSave.style.display = "none";
            btnSearch.style.display = "block";
        }
    }
    xhr.send();
}

function accInfo(acc) {
    accDetail.innerHTML = "";
    // $(".slider").slick("unslick");
    var tblStr = "";
    for(let i=0; i<acc.length; i++) {
        tblStr += `
            <div class="acc-detail">
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight: 700;">${acc[i].accName}</h3>
                <div class="slider">`;
                    for(let j=0; j<acc[i].imgList.length; j++) {
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
                        <p style="font-weight : 700; font-size:16px;">
                            <a class="read-more">
                                <button class="addAcc" data-id="${acc[i].aresNo}" data-name="${acc[i].memName}" data-place-name="${acc[i].accName}" data-place-url="/main/detail/${acc[i].accNo}" data-x="${acc[i].accLatitude}" data-y="${acc[i].accLogitide}">
                                    숙소추가 <i class="fa fa-angle-right" aria-hidden="true"></i>
                                </button>
                            </a>
                        </p>
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

// 선 연결해주기
ehyun.drawConnector = function(erum) {
    if(tripList.length > 1) {
        var connector = document.createElement('div');
        connector.className = 'connector';
        
        erum.appendChild(connector);
    }
}

ehyun.removeConnector = function() {
    var connectorList = document.querySelectorAll('.connector');
    connectorList.forEach(function(connector) {
        var parent = connector.parentNode;
        parent.removeChild(connector);
    });
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
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

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

//=============================================== 선 그리기 ====================================================

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
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
            // console.log(erumNum[i]);
            // console.log(kmDistanse);

        }
        // appendChild(kmDistance);
        //================================= 거리계산 div ====================================
        displayCircleDot(clickPosition, distance);
    }
};

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
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

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
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

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
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

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {
	var kmDistance = distance / 1000;
	
    var content = '<span class="number" style="font-size: 24px;">' + kmDistance.toFixed(1) + '</span>km';

    return content;
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

// ================================ 날짜 출력 함수 ===================================

function displayFormattedDates(startDateStr, endDateStr) {
	var startDate = new Date(startDateStr);
	var endDate = new Date(endDateStr);
	var currentDate = new Date(startDate);
	var dateContainer = document.getElementById("dateContainer"); // 날짜를 추가할 컨테이너 요소
  
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
        if(btnSearch.style.display == "none") {
            swal("저장하기를 눌러주세요.","","warning")
            return false;
        }
        dateElements.forEach(function(element){
            element.style.color = "gray";
        });
        this.style.color = "red";

        travelDate = this.innerHTML;
        placeLocation.innerHTML = "";
        tripList = [];
        getData();
    });
});

// ================================ 여행 공유 상대 추가하기 ===================================
var addMem = $("#addMem");
var memId = $("#memId");
var travelNo2 = $("#travelNo").val();
addMem.on("click",function(){
    data = {
        "memId":memId.val(),
        "travelNo" : travelNo2
    }
    $.ajax({
        url : "/member/addMem",
        type: "post",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
        data : JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
        dataType : "json",
        success : function(res) {
            if(res.result === "SUCCESS") {
                var imgDiv = $("#img-div");
                var tooltip = $("#tooltip");
                imgDiv.html("");
                var img = "";
                for(let i=0; i<res.mem.memList.length; i++) {
                    if(res.mem.memList[i].memProfilePath != null) {
                        img += `<img class="memList-img" src="${pageContext}${res.mem.memList[i].memProfilePath}" style="transform : translateY(25%) translateX(${-75 + i * 150}%); z-index : ${i+1};"/>`
                    } else {
                        img += `<img class="memList-img" src="http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70" style="transform : translateY(25%) translateX(${-75 + i * 150}%); z-index : ${i+1};">`;
                    }
                }
                imgDiv.html(img);
                
                var closeButton = document.querySelector('.mfp-close');
                closeButton.click();
                swal(res.msg,"","success");
            } else {
                swal(res.msg,"","error");
            }
        }
    });
});


// ============================= 메모 기능 ==============================================
var memoModBtn = $("#memoModBtn");
var memoOkBtn = $("#memoOkBtn");
var memoDiv = $("#memoDiv");
var memoText = "";

memoModBtn.on("click", function() {
    memoModBtn.css("display", "none");
    memoOkBtn.css("display", "block");
    memoText = memoDiv.html();
    var mta = `<textarea class="memo-text" cols="20" rows="2">${memoText}</textarea>`;
    memoDiv.html(mta);
});

memoOkBtn.on("click", function() {
    memoModBtn.css("display", "block");
    memoOkBtn.css("display", "none");
    memoText = $(".memo-text").val();
    getMemo(travelDate);
    // memoText = memoText.replace(/<br>/g, "\n");
    // memoDiv.html(memoText);
    // memoDiv.css("white-space", "pre-line");
});

function getMemo(tdate) {
    data = {
        "travelNo" : travelNo2,
        "memo" : memoText,
        "travelDate" : tdate
    }
    $.ajax({
        url : "/member/tripMemo",
        type : "post",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header,token);
        },
        data : JSON.stringify(data),
        contentType : "application/json; charset=utf-8",
        dataType : "json",
        success : function(res) {
            if(res.result === "SUCCESS") {
                memoText = res.memo.replace(/<br>/g, "\n");
                memoDiv.html(memoText);
                memoDiv.css("white-space", "pre-line");
            } else {
                swal(res.msg,"","error");
            }
        }
    });
}

document.addEventListener("click", function(e) {
    if(e.target.classList.contains("addAcc")) {
        if(btnSearch.style.display == "block") {
            swal("편집중일 때만 추가가 가능합니다.","","warning");
            return false;
        }
        pla = {
            id : e.target.dataset.id,
            place_name : e.target.dataset.name + "님의 공간",
            place_url : e.target.dataset.placeUrl,
            category_group_name : "숙소",
            phone : "",
            x : e.target.dataset.x,
            y : e.target.dataset.y
        }
        ehyun.createRoute(pla);
    }
    if(e.target.classList.contains("x-icon")) {
        e.target.parentElement.remove();
    }
    if(e.target.classList.contains("fa-circle-xmark")) {
        e.target.parentElement.parentElement.remove();
    }
});



// ========================================== slick Js =======================================================

function slickJs() {
    $(".slider").slick(slickOption);
}