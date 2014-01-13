function updateTime() {
	var currentDate = new Date();
	var hours = currentDate.getHours();
	var minutes = currentDate.getMinutes();
	var seconds = currentDate.getSeconds();
	var month = currentDate.getMonth();
	var year = currentDate.getFullYear();
	var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'Jully', 'August', 'September', 'October', 'November', 'December');
	var d = currentDate.getDate();
	var day = currentDate.getDay();
	var days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
	
	if (minutes < 10){
		minutes = "0" + minutes;
	}
	if (seconds < 10){
		seconds = "0" + seconds;
	}
	var dateValue = ''+d+' '+months[month]+' '+' '+year + ', ' +days[day];
	var timeValue; 
	if(hours > 12){
		timeValue =  (hours - 12) + ":" + minutes + ":" + seconds + " ";
	}else{
		timeValue = hours + ":" + minutes + ":" + seconds + " ";
	}

	if(hours > 11){
		timeValue+="PM";
	} else {
		timeValue+="AM"
	}

	setTimeout("updateTime()",1000);
		$("#time").text(timeValue);
		$("#date").text(dateValue);
}
updateTime();
$(document).on("keydown", "#search-data", function(e){
	if(e.keyCode == 13){
		$(this).parents("form").submit();
	}
});