$(document).ready(function() {
	const errorTextTr = $('tr:has(#error_text)');
	const errorText = $('#error_text');

	$("#login_btn").click(function(e) {
		var idval = $('#id').val();
		var pwval = $('#pw').val();
		if (idval == '') {
			e.preventDefault();
			errorTextTr.show();
			errorText.html('아이디를 입력해주세요.');
		} else if (pwval == '') {
			e.preventDefault();
			errorTextTr.show();
			errorText.html('비밀번호를 입력해주세요.');
		}
	});

});
