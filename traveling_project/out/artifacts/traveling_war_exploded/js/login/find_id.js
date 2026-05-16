/**
 * find_id.js - 아이디 찾기 기능
 */

let currentMethod = 'email'; // 현재 선택된 방식

/**
 * 인증 방식 전환
 */
function switchMethod(method) {
	currentMethod = method;

	// 탭 활성화
	$('.find_tab_btn').removeClass('active');
	$(`button[onclick="switchMethod('${method}')"]`).addClass('active');

	// 방식별 섹션 표시/숨김
	$('.find_method_section').removeClass('active');
	$(`#${method}_method`).addClass('active');

	// 입력값 초기화
	resetFormInputs(method);
}

/**
 * 입력 필드 초기화
 */
function resetFormInputs(method) {
	$(`#${method}_name`).val('');
	$(`#${method}_contact`).val('');
	$(`#${method}_code_input`).val('');
	$(`#${method}_code_input_row`).hide();
}

/**
 * 인증코드 발송
 */
function sendCode(method) {
	const name = $(`#${method}_name`).val().trim();
	const contact = $(`#${method}_contact`).val().trim();

	if (!name || !contact) {
		showMessage('필수 입력값을 모두 입력해주세요.', 'error');
		return;
	}

	// 전화번호 유효성 검사 (SMS 방식)
	if (method === 'sms' && !validatePhoneNumber(contact)) {
		showMessage('올바른 전화번호를 입력해주세요.', 'error');
		return;
	}

	// 로딩 상태
	const button = $(`#${method}_send_btn`);
	const originalText = button.text();
	button.prop('disabled', true).text('발송 중...');

	// AJAX 요청
	$.ajax({
		url: '/login/find-id/send-code',
		type: 'POST',
		data: {
			name: name,
			contact: contact,
			authType: method
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				showMessage('인증코드가 발송되었습니다. 메시지를 확인해주세요.', 'success');

				// 인증코드 입력 필드 서서히 나타남
				$(`#${method}_code_input_row`).fadeIn(300);

				// 버튼 상태 변경 (재발송만 가능)
				button.text('재발송').prop('disabled', false);

				// 5분 후 자동으로 버튼 비활성화
				setTimeout(function() {
					button.prop('disabled', true).text('발송 (만료)');
				}, 300000);
			} else {
				showMessage(response.message || '인증코드 발송에 실패했습니다.', 'error');
				button.text(originalText).prop('disabled', false);
			}
		},
		error: function() {
			showMessage('서버 요청 중 오류가 발생했습니다.', 'error');
			button.text(originalText).prop('disabled', false);
		}
	});
}

/**
 * 인증코드 검증
 */
function verifyCode(method) {
	const code = $(`#${method}_code_input`).val().trim();
	const contact = $(`#${method}_contact`).val().trim();

	if (!code || code.length !== 6 || isNaN(code)) {
		showMessage('6자리 숫자 인증코드를 입력해주세요.', 'error');
		return;
	}

	// AJAX 요청
	$.ajax({
		url: '/login/find-id/verify',
		type: 'POST',
		data: {
			code: code,
			contact: contact,
			authType: method
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				showMessage('인증이 완료되었습니다.', 'success');

				// Session에 이름 저장 (Session에서 참조하기 위함)
				const name = $(`#${method}_name`).val();
				sessionStorage.setItem('auth_name', name);

				// 아이디 조회
				getFoundId(method);
			} else {
				showMessage(response.message, 'error');
			}
		},
		error: function() {
			showMessage('인증 처리 중 오류가 발생했습니다.', 'error');
		}
	});
}

/**
 * 인증 성공 후 아이디 조회
 */
function getFoundId(method) {
	// AJAX 요청
	$.ajax({
		url: '/login/find-id/result',
		type: 'POST',
		data: {
			method: method
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				// 결과 화면 표시
				$('#result_user_id').text(response.maskedUserId || response.userId);
				$('.find_method_section').fadeOut(300, function() {
					$('#result_section').fadeIn(300);
				});
			} else {
				showMessage(response.message || '아이디 조회에 실패했습니다.', 'error');
			}
		},
		error: function() {
			showMessage('아이디 조회 중 오류가 발생했습니다.', 'error');
		}
	});
}

/**
 * 전화번호 유효성 검사
 */
function validatePhoneNumber(phone) {
	// 숫자만 추출
	const cleaned = phone.replace(/\D/g, '');
	// 01x-xxxx(x)-xxxx 형식 또는 10~11자리
	return cleaned.length >= 10 && cleaned.length <= 11;
}

/**
 * 메시지 표시
 */
function showMessage(message, type) {
	const messageBox = $('#message_box');
	const messageText = $('#message_text');

	messageText.text(message);
	messageBox
		.removeClass('success error')
		.addClass(type)
		.fadeIn(200)
		.delay(3000)
		.fadeOut(200);
}

/**
 * 페이지 로드 시 초기화
 */
$(document).ready(function() {
	// 기본값 email 선택
	switchMethod('email');

	// Enter 키로 코드 검증
	$('[id$="_code_input"]').keypress(function(e) {
		if (e.which === 13) {
			const method = $(this).attr('id').includes('email') ? 'email' : 'sms';
			verifyCode(method);
			return false;
		}
	});

	// 자동 포맷팅 (전화번호)
	$('#sms_contact').on('input', function() {
		let value = $(this).val().replace(/\D/g, '');
		if (value.length > 11) value = value.slice(0, 11);

		if (value.length <= 3) {
			$(this).val(value);
		} else if (value.length <= 7) {
			$(this).val(value.slice(0, 3) + '-' + value.slice(3));
		} else {
			$(this).val(value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7));
		}
	});
});

