$(document).ready(function() {
	
	$.ajax({
		url : "./user_reserv_info.jsp",
		success : function(data) {
			$("#reservationInfo").html(data);
		}
	});

});