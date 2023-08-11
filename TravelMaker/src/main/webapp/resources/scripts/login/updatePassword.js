//비밀번호 변경
//기본 div
let findDiv = $("#findDiv");
//전화번호 인증 후 div
let updateDiv = $("#updateDiv");
//회원 비밀번호
let memPw = $("#memPw");
//회원 비밀번호 확인
let checkPw = $("#checkPw");
//비밀번호 변경 버튼
let updatePw = $("#updatePw");
//비밀번호 변경
const passwordRegex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

//비밀번호 재설정
//비밀번호 정규식 체크
memPw.on("change", function() {
    if(!passwordRegex.test(memPw.val())) {
        memPw.css("border", "1px solid red");
    } else {
        memPw.css("border", "1px solid green");
    }
});

//비밀번호 확인 체크
checkPw.on("change", function() {
    if(checkPw.val() != memPw.val()) {
        memPw.css("border", "1px solid red");
    } else {
        memPw.css("border", "1px solid green");
    }
});

//비밀번호 변경 버튼 클릭 시
updatePw.on("click", function() {
    let pwval = memPw.val();
    let checkpwval = checkPw.val();

    if(pwval == null || pwval == "") {
        swal("비밀번호를 입력해 주세요.", "", "error");
        memPw.focus();
        return false;
    }

    if(checkpwval != pwval) {
        swal("비밀번호가 일치하지 않습니다.", "", "error");
        checkpwval.focus();
        return false;
    }

    if(!passwordRegex.test(pwval)) {
        swal('비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내이어야 합니다!', "", 'error');
        memPw.focus();
        return false;
    }
    
    $("form").submit();
});
//비밀번호 재설정