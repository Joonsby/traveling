$(document).ready(function() {
	$.ajax({
		url : "select_user_status.jsp",
		dataType : "html",
		success : function(data) {
			var ugrade = $(data).find("#ugrade").text();
			var uper = $(data).find("#uper").text();
			var ndays = $(data).find("#ndays").text();
			var nstay = $(data).find("#tstay").text();
			var tmil = $(data).find("#tmil").text();

			$('#last_trip').html(ndays + "일");
			$('#grade_text').html(ugrade);
			if (ugrade == "VIP") {
				$('#grade_text').css('color', '#6666FF');
			} else if (ugrade == "GOLD") {
				$('#grade_text').css('color', '#fff26d');
			} else {
				$('#grade_text').css('color', 'rgb (192, 192, 192)');
			}
			$('#discount_percent').html(uper + "%");
			$('#nstay').html(nstay + "박");
			$('#nmileage').html(tmil + "P");
			$('#save_mileage').html(uper + "% 적립중");
		}
	});
});