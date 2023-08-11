var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var personType = document.querySelector('.personType1');          // 승객선택 div
var personCheckBtn = document.querySelector(".personCheckBtn");   // 확인버튼
var passengerModal = document.querySelector('.selectPerson1');    // 모달
var adultNum = document.querySelector('.adultNum');
var childNum = document.querySelector('.childNum');
 

var plusAdultBtn = document.querySelector('#plusAdultBtn');
var minusAdultBtn = document.querySelector('#minusAdultBtn');
var plusChildBtn = document.querySelector('#plusChildBtn'); 
var minusChildBtn = document.querySelector('#minusChildBtn');
var fillBtn = document.querySelector('#fillBtn');

var count;
var count2; 

var nextFBtn = $('#nextFBtn');
var flightNo = $('#flightNo').val();

var firstName = document.querySelector('.passengerFirstname');
var lastName = document.querySelector('.passengerLastname');
var email = document.querySelector('.passengerEmail');
var phone = document.querySelector('.passengerPhone');
var passportNo = document.querySelector('.passportNo');
var passportEndDate = document.querySelector('.passportEndDate');
var birth = document.querySelector('.passengerBirth');

const engRegex = /^[a-zA-Z]*$/; 
const emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    
    ////////////////////////////////////////////////////////////////////////
    
    var reservationContainer = document.querySelector('.reservationContainer');
    var bookingForm = document.querySelector('.tour_booking_form_box');
    var clonedBookings = [];

    var count = parseInt(adultNum.innerText);
    var count2 = parseInt(childNum.innerText);

    const setValues = [
        {
            firstName : "Park",
            lastName : "JinYou",
            email : "koo123@naver.com",
            phone : "01032321010",
            passportNo : "akjdf13d3",
            passportEndDate : "20251212",
            birth : "19891212"
        },
        {
            firstName : "John",
            lastName : "Park",
            email : "kkk1207@naver.com",
            phone : "01029821023",
            passportNo: "adkjf123",
            passportEndDate: "20251111",
            birth : "19891212"
        }
    ];
    
    let currentIndex = 0;
    
    fillBtn.addEventListener("click", function(){
        event.preventDefault();
        const currentSet = setValues[currentIndex];
        firstName.value = currentSet.firstName;
        lastName.value = currentSet.lastName;
        email.value = currentSet.email;
        phone.value = currentSet.phone;
        passportNo.value = currentSet.passportNo;
        passportEndDate.value = currentSet.passportEndDate;
        birth.value = currentSet.birth;

        currentIndex = (currentIndex + 1) % setValues.length;

    });

    // 인원 선택 모달 확인 버튼 클릭 했을 때 이벤트
    personCheckBtn.addEventListener('click', function() {
        passengerModal.style.display = 'none';
        
        // 성인 div 복제 및 정규식 체크
        for (let i = 1; i < count; i++) {
            cloneAdultBooking();
        }
        // 유소년 div 복제 및 정규식 체크
        for (let i = 0; i < count2; i++) {
            cloneChildBooking();
        }
        
    });

    // 성 정규식 체크
    firstName.addEventListener('input', function() {
        var firstNameVal = firstName.value;
        var firstnameEx = document.querySelector('.firstnameEx');

        if (!engRegex.test(firstNameVal)) {
            firstName.style.border = '1px solid red';
            firstnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
            firstnameEx.style.color = 'red';
            return false;
        } else {
            firstName.style.border = '';
            firstnameEx.textContent = '';
        }
    });
    // 이름 정규식 체크
    lastName.addEventListener('input', function() {
        var lastNameVal = lastName.value;
        var lastnameEx = document.querySelector('.lastnameEx');

        if (!engRegex.test(lastNameVal)) {
            lastName.style.border = '1px solid red';
            lastnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
            lastnameEx.style.color = 'red';
            return false;
        } else {
            lastName.style.border = '';
            lastnameEx.textContent = '';
        }
    });

    // 이메일 정규식 체크
    email.addEventListener('input', function(){
        var emailVal = email.value;
        var emailEx = document.querySelector('.emailEx');
        if(!emailRegex.test(emailVal)){
            email.style.border = '1px solid red';
            emailEx.textContent = '이메일 형식에 맞게 기입하셔야 합니다.';
            emailEx.style.color = 'red';
            return false;
        } else {
            email.style.border = '';
            emailEx.textContent = '';
        }
    });

    personType.addEventListener('click', function() {
        passengerModal.style.display = 'block';
        count = adultNum.innerText;
        count2 = childNum.innerText;
    });

    plusAdultBtn.addEventListener('click', function(){
        count++;
        adultNum.innerText = count;
    });
    minusAdultBtn.addEventListener('click',function(){
        count--;
        count = Math.max(count, 1);
        adultNum.innerText = count;
    });
    plusChildBtn.addEventListener('click', function(){
        count2++;
        childNum.innerText = count2;
    });
    minusChildBtn.addEventListener('click',function(){
        count2--;
        count2 = Math.max(count2, 0);
        childNum.innerText = count2;
    });

var formDataArray = [];

// 유소년 복제 함수
function cloneChildBooking(){
    let clonedBooking = bookingForm.cloneNode(true);
        clonedBooking.querySelector("input[name='passengerType']").value = "유소년";
        // console.log("test1: ",clonedBooking);
        reservationContainer.appendChild(clonedBooking);
        let lfirstName=clonedBooking.querySelector(".passengerFirstname");
        let llastName = clonedBooking.querySelector(".passengerLastname");
        let lemail = clonedBooking.querySelector(".passengerEmail");
        let lbirth = clonedBooking.querySelector(".passengerBirth");

        lbirth.addEventListener("input", function(){
            let lbirthVal = lbirth.value;
            let lbirthEx = clonedBooking.querySelector('.birthEx');
            let personType = clonedBooking.querySelector("input[name='passengerType']").value;
            console.log("personType:", personType);
            if (personType == "유소년") {
                let birthYear = parseInt(lbirthVal.substr(0, 4));
                let currentYear = new Date().getFullYear();
                let age = currentYear - birthYear;
            
                if (age > 15 || age < 0) { 
                    lbirth.style.border = '1px solid red';
                    lbirthEx.textContent = '만 0~15세까지 입력할 수 있습니다.';
                    lbirthEx.style.color = 'red';
                } else {
                    lbirth.style.border = '';
                    lbirthEx.textContent = '';
                }
            }
        });

        lfirstName.addEventListener("input",function(){
            let lfirstNameVal = lfirstName.value;
            let lfirstnameEx = clonedBooking.querySelector('.firstnameEx');

            if (!engRegex.test(lfirstNameVal)) {
                lfirstName.style.border = '1px solid red';
                lfirstnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
                lfirstnameEx.style.color = 'red';
                return false;
            } else {
                lfirstName.style.border = '';
                lfirstnameEx.textContent = '';
            }
        });

        llastName.addEventListener("input",function(){
            let llastNameVal = llastName.value;
            let llastnameEx = clonedBooking.querySelector('.lastnameEx');

            if (!engRegex.test(llastNameVal)) {
                llastName.style.border = '1px solid red';
                llastnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
                llastnameEx.style.color = 'red';
                return false;
            } else {
                llastName.style.border = '';
                llastnameEx.textContent = '';
            }
        });

        lemail.addEventListener("input",function(){
            let lemailVal = lemail.value;
            let lemailEx = clonedBooking.querySelector('.emailEx');

            if (!emailRegex.test(lemailVal)) {
                lemail.style.border = '1px solid red';
                lemailEx.textContent = '이메일 형식에 맞게 기입하셔야 합니다.';
                lemailEx.style.color = 'red';
                return false;
            } else {
                lemail.style.border = '';
                lemailEx.textContent = '';
            }
        });
}

// 성인 복제 함수 
function cloneAdultBooking(){
    let clonedBooking = bookingForm.cloneNode(true);
        clonedBooking.querySelector("input[name='passengerType']").value = "성인";
        reservationContainer.appendChild(clonedBooking);
        let lfirstName=clonedBooking.querySelector(".passengerFirstname");
        let llastName = clonedBooking.querySelector(".passengerLastname");
        let lemail = clonedBooking.querySelector(".passengerEmail");

        lemail.addEventListener("input",function(){
            let lemailVal = lemail.value;
            let lemailEx = clonedBooking.querySelector('.emailEx');

            if (!emailRegex.test(lemailVal)) {
                lemail.style.border = '1px solid red';
                lemailEx.textContent = '이메일 형식에 맞게 기입하셔야 합니다.';
                lemailEx.style.color = 'red';
                return false;
            } else {
                lemail.style.border = '';
                lemailEx.textContent = '';
            }
        });


        lfirstName.addEventListener("input",function(){
            let lfirstNameVal = lfirstName.value;
            let lfirstnameEx = clonedBooking.querySelector('.firstnameEx');

            if (!engRegex.test(lfirstNameVal)) {
                lfirstName.style.border = '1px solid red';
                lfirstnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
                lfirstnameEx.style.color = 'red';
                return false;
            } else {
                lfirstName.style.border = '';
                lfirstnameEx.textContent = '';
            }
        });

        llastName.addEventListener("input",function(){
            let llastNameVal = llastName.value;
            let llastnameEx = clonedBooking.querySelector('.lastnameEx');

            if (!engRegex.test(llastNameVal)) {
                llastName.style.border = '1px solid red';
                llastnameEx.textContent = '성명은 영문 정자로 기입하셔야 합니다.';
                llastnameEx.style.color = 'red';
                return false;
            } else {
                llastName.style.border = '';
                llastnameEx.textContent = '';
            }
        });

}

$(function(){
    // 계속 버튼 클릭시 이벤트
    nextFBtn.on('click', function(){
        var firstnames = document.querySelectorAll('.passengerFirstname');
        var lastnames = document.querySelectorAll('.passengerLastname');
        var emails = document.querySelectorAll('.passengerEmail');
        var phones = document.querySelectorAll('.passengerPhone');
        var passportNos = document.querySelectorAll('.passportNo');
        var passportEndDates = document.querySelectorAll('.passportEndDate');
        var births = document.querySelectorAll('.passengerBirth');

        for (let i = 0; i < firstnames.length; i++) {
            var firstNameVal = firstnames[i].value;

            if (firstNameVal == null || firstNameVal == '') {
                firstnames[i].style.border = '1px solid red';
                firstnames[i].focus();
                return false;
            }else{
                firstnames[i].style.border = '';
            }
        }
        for (let i = 0; i < lastnames.length; i++) {
            var lastNameVal = lastnames[i].value;

            if (lastNameVal == null || lastNameVal == '') {
                lastnames[i].style.border = '1px solid red';
                lastnames[i].focus();
                return false;
            }else{
                lastnames[i].style.border = '';
            }
        }
        for (let i = 0; i < emails.length; i++) {
            var emailVal = emails[i].value;

            if (emailVal == null || emailVal == '') {
                emails[i].style.border = '1px solid red';
                emails[i].focus();
                return false;
            }else{
                emails[i].style.border = '';
            }
        }
        for (let i = 0; i < phones.length; i++) {
            var phoneVal = phones[i].value;

            if (phoneVal == null || phoneVal == '') {
                phones[i].style.border = '1px solid red';
                phones[i].focus();
                return false;
            }else{
                phones[i].style.border = '';
            }
        }
        for (let i = 0; i < passportNos.length; i++) {
            var passportNoVal = passportNos[i].value;

            if (passportNoVal == null || passportNoVal == '') {
                passportNos[i].style.border = '1px solid red';
                passportNos[i].focus();
                return false;
            }else{
                passportNos[i].style.border = '';
            }
        }
        for (let i = 0; i < passportEndDates.length; i++) {
            var EndDateVal = passportEndDates[i].value;

            if (EndDateVal == null || EndDateVal == '') {
                passportEndDates[i].style.border = '1px solid red';
                passportEndDates[i].focus();
                return false;
            }else{
                passportEndDates[i].style.border = '';
            }
        }
        for (let i = 0; i < births.length; i++) {
            var birthVal = births[i].value;

            if (birthVal == null || birthVal == '') {
                births[i].style.border = '1px solid red';
                births[i].focus();
                return false;
            }else{
                births[i].style.border = '';
            }
        }


        var form = $('.passengerForm'); // 대상 폼 요소 선택

        for(let i=0; i<form.length; i++){
            var forms = $(form[i]);
            var formDataObject = {}; // 폼 데이터를 담을 객체

            adultCount = adultNum.innerText;
            childCount = childNum.innerText;
            
            formDataObject['adultCount'] = adultCount;  // 성인 수 
            formDataObject['childCount'] = childCount;  // 유소년 수

            forms.serializeArray().forEach(function(field) {
                formDataObject[field.name] = field.value; 
            });

            formDataArray.push(formDataObject); // 배열에 폼 데이터 객체 추가
        }
        console.log("formDataArray : ", formDataArray);
        $.ajax({
            url: '/flight/passengerInfo',
            type: 'post',
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
            data : JSON.stringify(formDataArray),
            contentType : 'application/json; charset = utf-8',
            success : function(res){
                location.href = '/flight/seatReservation?flightNo='+flightNo;
            },
            error : function(xhr){
                console.log(xhr.status);
            }
        }); 
    }); 

})
    




    
