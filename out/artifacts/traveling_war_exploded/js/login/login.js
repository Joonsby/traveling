$(document).ready(function() {
	$("#login_btn").click(function(e) {
		if ($('#id').val() == '') {
			e.preventDefault();
			$('tr:has(#error_text)').show();
			$('#error_text').html('아이디를 입력해주세요.');
		} else if ($('#pw').val() == '') {
			e.preventDefault();
			$('tr:has(#error_text)').show();
			$('#error_text').html('비밀번호를 입력해주세요.');
		}
	});
	
	$('#id').keydown(function(e){
		if(e.keyCode == 13){
			if ($('#id').val() == '') {
				e.preventDefault();
				$('tr:has(#error_text)').show();
				$('#error_text').html('아이디를 입력해주세요.');
			} else if ($('#pw').val() == '') {
				e.preventDefault();
				$('tr:has(#error_text)').show();
				$('#error_text').html('비밀번호를 입력해주세요.');
			}
		}
	})
	
	$('#pw').keydown(function(e){
		if(e.keyCode == 13){
			if ($('#id').val() == '') {
				e.preventDefault();
				$('tr:has(#error_text)').show();
				$('#error_text').html('아이디를 입력해주세요.');
			} else if ($('#pw').val() == '') {
				e.preventDefault();
				$('tr:has(#error_text)').show();
				$('#error_text').html('비밀번호를 입력해주세요.');
			}
		}
	})
});