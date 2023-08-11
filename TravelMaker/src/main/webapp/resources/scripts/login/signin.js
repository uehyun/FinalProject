let id = $("#username");
let pw = $("#password");
let login = $("#login");

pw.on("keypress", function(e) {
	if(e.keyCode == 13) {
		signIn();
	}
});

login.on("click",function(){
	signIn();
});

function signIn() {
	let idval = id.val(); 
	let pwval = pw.val(); 
	
	if(idval == "" || idval == null) {
		swal("아이디를 입력해주세요.", "", "error");
		id.focus();
		return false;
	}
	
	if(pwval == "" || pwval == null) {
		swal("비밀번호를 입력해주세요.", "", "error");
		pw.focus();
		return false;
	}
	
	$("form").submit();
}
