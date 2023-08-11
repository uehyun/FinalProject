window.addEventListener("DOMContentLoaded",function() {
	let memNoForAlarm = document.querySelector("#memNo").value;
	
	if(memNoForAlarm != null || memNoForAlarm != "") {
		getAlarmCount();
	} 
	
	let alarm = $("#alarm-badge");
	
	function getAlarmCount() {
		$.ajax({
	        url: "/alarm/getCount?memNo=" + memNoForAlarm,
	        type: "get",
	        success: function(res) {
	        	console.log(res);
	            if(res > 0) {
	            	alarm.show();
	            }
	        },
	        error: function(xhr) {
	
	        }
	    });
	}
});