$(document).ready(function() {
	
	$('tr:has(#error_text)').show();
	const errorText = $('#error_text');	
	errorText.html("아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
	$("#login_btn").click(function(e) {
		const idVal = $('#id').val();
		const pwVal = $('#pw').val();
		if (idVal == '') {
			e.preventDefault();			
			errorText.html('아이디를 입력해주세요.');
		} else if (pwVal == '') {
			e.preventDefault();			
			errorText.html('비밀번호를 입력해주세요.');
		}
	});
})