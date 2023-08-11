let languageDiv = document.querySelector("#languageDiv");
let preLanguageBtn = document.querySelector("#preLanguageBtn");

let currencyDiv = document.querySelector("#currencyDiv");
let preCurrencyBtn = document.querySelector("#preCurrencyBtn");

preLanguageBtn.addEventListener("click", function() {
	if(languageDiv.style.display === "none") {
		languageDiv.style.display = "block";
  		preLanguageBtn.innerText = "취소";
	} else {
		languageDiv.style.display = "none";
  		preLanguageBtn.innerText = "수정";
	}
});

preCurrencyBtn.addEventListener("click", function() {
	if(currencyDiv.style.display === "none") {
		currencyDiv.style.display = "block";
		preCurrencyBtn.innerText = "취소";
	}  else {
		currencyDiv.style.display = "none";
		preCurrencyBtn.innerText = "수정";
	}
}); 

let updateBtn1 = document.querySelector("#updateBtn1");
let updateBtn2 = document.querySelector("#updateBtn2");

updateBtn1.addEventListener("click", function() {
	let val = document.querySelector("select[name='languageOption']").value;
	
	if(val == null || val == "") {
		swal("언어를 선택해주세요.", "", "error");
		return false;
	}
	
	let memNo = document.querySelector("#memNo").value;

	let data = {
		memPreLanguage: val,
		memNo: memNo
	};

	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/member/updatePrefer", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			res = JSON.parse(xhr.responseText);
			
			if(res == "OK") {
				swal("수정되었습니다.", "", "success");
			} else {
				swal("수정을 실패했습니다.", "", "error");
			}
		} 
  	};
  	xhr.onerror = function() {
  		console.log(xhr.status);
  	};
    xhr.send(JSON.stringify(data));
});

updateBtn2.addEventListener("click", function() {
	let val = document.querySelector("select[name='currencyOption']").value;
	
	if(val == null || val == "") {
		swal("통화를 선택해주세요.", "", "error");
		return false;
	}
	
	let memNo = document.querySelector("#memNo").value;

	let data = {
		memPreCurrency: val,
		memNo: memNo
	};

	let token = document.querySelector("meta[name='_csrf']").content;
	let header = document.querySelector("meta[name='_csrf_header']").content;
	
	var xhr = new XMLHttpRequest();
  	xhr.open("post", "/member/updatePrefer", true);
  	xhr.setRequestHeader(header, token);
  	xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
  	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			res = JSON.parse(xhr.responseText);
			
			if(res == "OK") {
				swal("수정되었습니다.", "", "success");
			} else {
				swal("수정을 실패했습니다.", "", "error");
			}
		} 
  	};
  	xhr.onerror = function() {
  		console.log(xhr.status);
  	};
    xhr.send(JSON.stringify(data));
});