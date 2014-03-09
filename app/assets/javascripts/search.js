function updateTime() {
	var currentDate = new Date();
	var hours = currentDate.getHours();
	var minutes = currentDate.getMinutes();
	var month = currentDate.getMonth();
	var year = currentDate.getFullYear();
	var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'Jully', 'August', 'September', 'October', 'November', 'December');
	var d = currentDate.getDate();
	var day = currentDate.getDay();
	var days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
	
	if (minutes < 10){
		minutes = "0" + minutes;
	}
	var dateValue = '' + days[day] + ', ' +  d + ' ' + months[month] + ', ' + year;
	var timeValue; 
  if(hours==0){
    hours = 12;
  }
	if(hours > 12){
		timeValue =  (hours - 12) + ":" + minutes + " ";
	}else{
		timeValue = hours + ":" + minutes + " ";
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