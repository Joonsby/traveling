$(document).ready(function() {
	
	$.ajax({
		url : "/webPage/reservation/user_reserv_info.jsp",
		success : function(data) {
			$("#reservationInfo").html(data);
		}
	});

});