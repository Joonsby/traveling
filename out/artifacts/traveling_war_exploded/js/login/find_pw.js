/**
 * find_pw.js - 비밀번호 찾기 및 재설정 기능
 */

let currentPwMethod = 'email'; // 현재 선택된 방식
let isPwVerified = false; // 인증 완료 여부

/**
 * 비밀번호 찾기 방식 전환
 */
function switchPwMethod(method) {
	currentPwMethod = method;

	$('#pw_email_method, #pw_sms_method').hide().removeClass('active');
	$(`#pw_${method}_method`).show().addClass('active');

	$('.find_tab_btn').removeClass('active');
	$(`#pw_${method}_method button[onclick="switchPwMethod('${method}')"]`).addClass('active');

	$(`#pw_${method}_code_input_row`).hide();
	$(`#pw_${method}_code_input`).val('');
}

/**
 * 입력 필드 초기화
 */
function resetPwFormInputs(method) {
	$(`#pw_${method}_id`).val('');
	$(`#pw_${method}_name`).val('');
	$(`#pw_${method}_contact`).val('');
	$(`#pw_${method}_code_input`).val('');
	$(`#pw_${method}_code_input_row`).hide();
}

/**
 * 비밀번호 찾기 인증코드 발송
 */
function sendPwCode(method) {
	const userId = $(`#pw_${method}_id`).val().trim();
	const name = $(`#pw_${method}_name`).val().trim();
	const contact = $(`#pw_${method}_contact`).val().trim();

	if (!userId || !name || !contact) {
		showPwMessage('필수 입력값을 모두 입력해주세요.', 'error');
		return;
	}

	// 전화번호 유효성 검사 (SMS 방식)
	if (method === 'sms' && !validatePhoneNumber(contact)) {
		showPwMessage('올바른 전화번호를 입력해주세요.', 'error');
		return;
	}

	// 로딩 상태
	const button = $(`#pw_${method}_send_btn`);
	const originalText = button.text();
	button.prop('disabled', true).text('발송 중...');

	// AJAX 요청
	$.ajax({
		url: '/login/find-pw/send-code',
		type: 'POST',
		data: {
			userId: userId,
			name: name,
			contact: contact,
			authType: method
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				showPwMessage('인증코드가 발송되었습니다. 메시지를 확인해주세요.', 'success');

				// 인증코드 입력 필드 서서히 나타남
				$(`#pw_${method}_code_input_row`).fadeIn(300);

				// 버튼 상태 변경
				button.text('재발송').prop('disabled', false);

				// 5분 후 자동으로 버튼 비활성화
				setTimeout(function() {
					button.prop('disabled', true).text('발송 (만료)');
				}, 300000);
			} else {
				showPwMessage(response.message || '인증코드 발송에 실패했습니다.', 'error');
				button.text(originalText).prop('disabled', false);
			}
		},
		error: function() {
			showPwMessage('서버 요청 중 오류가 발생했습니다.', 'error');
			button.text(originalText).prop('disabled', false);
		}
	});
}

/**
 * 비밀번호 찾기 인증코드 검증
 */
function verifyPwCode(method) {
	const code = $(`#pw_${method}_code_input`).val().trim();
	const contact = $(`#pw_${method}_contact`).val().trim();

	if (!code || code.length !== 6 || isNaN(code)) {
		showPwMessage('6자리 숫자 인증코드를 입력해주세요.', 'error');
		return;
	}

	// AJAX 요청
	$.ajax({
		url: '/login/find-pw/verify',
		type: 'POST',
		data: {
			code: code,
			contact: contact,
			authType: method
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				showPwMessage('인증이 완료되었습니다.', 'success');
				isPwVerified = true;

				// Step 1 → Step 2 전환
				setTimeout(function() {
					$('#step1_section').fadeOut(300, function() {
						$('#step2_section').fadeIn(300);

						// 비밀번호 입력 필드에 포커스
						$('#new_password').focus();
					});
				}, 500);
			} else {
				showPwMessage(response.message, 'error');
			}
		},
		error: function() {
			showPwMessage('인증 처리 중 오류가 발생했습니다.', 'error');
		}
	});
}

/**
 * 비밀번호 강도 표시
 */
function updatePasswordStrength(password) {
	const strengthBar = $('#pw_strength_bar');
	const strengthText = $('#pw_strength_text');

	let strength = 0;

	if (password.length >= 6) strength += 1;
	if (password.length >= 8) strength += 1;
	if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength += 1;
	if (/[0-9]/.test(password)) strength += 1;
	if (/[^a-zA-Z0-9]/.test(password)) strength += 1;

	const strengthLevels = ['', '약', '중간', '보통', '강함', '매우 강함'];
	const strengthColors = ['', '#ff4444', '#ff9900', '#ffbb33', '#00c400', '#007e00'];

	strengthBar.css('width', (strength * 20) + '%').css('background-color', strengthColors[strength]);
	strengthText.text('강도: ' + strengthLevels[strength]);
}

/**
 * 비밀번호 변경
 */
function resetPassword() {
	if (!isPwVerified) {
		showPwMessage('먼저 인증을 완료해주세요.', 'error');
		return;
	}

	const newPw = $('#new_password').val().trim();
	const confirmPw = $('#confirm_password').val().trim();

	if (!newPw || !confirmPw) {
		showPwMessage('비밀번호를 모두 입력해주세요.', 'error');
		return;
	}

	if (newPw.length < 6) {
		showPwMessage('비밀번호는 최소 6자 이상이어야 합니다.', 'error');
		return;
	}

	if (newPw !== confirmPw) {
		showPwMessage('비밀번호가 일치하지 않습니다.', 'error');
		return;
	}

	// AJAX 요청
	$.ajax({
		url: '/login/find-pw/reset',
		type: 'POST',
		data: {
			newPw: newPw,
			confirmPw: confirmPw
		},
		dataType: 'json',
		success: function(response) {
			if (response.success) {
				showPwMessage('비밀번호가 성공적으로 변경되었습니다.', 'success');

				// Step 2 → Step 3 전환
				setTimeout(function() {
					$('#step2_section').fadeOut(300, function() {
						$('#step3_section').fadeIn(300);
					});
				}, 500);
			} else {
				showPwMessage(response.message || '비밀번호 변경에 실패했습니다.', 'error');
			}
		},
		error: function() {
			showPwMessage('서버 요청 중 오류가 발생했습니다.', 'error');
		}
	});
}

/**
 * 전화번호 유효성 검사
 */
function validatePhoneNumber(phone) {
	const cleaned = phone.replace(/\D/g, '');
	return cleaned.length >= 10 && cleaned.length <= 11;
}

/**
 * 메시지 표시 (비밀번호 찾기용)
 */
function showPwMessage(message, type) {
	const messageBox = $('#pw_message_box');
	const messageText = $('#pw_message_text');

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
	switchPwMethod('email');

	// Enter 키로 코드 검증
	$('[id^="pw_"][id$="_code_input"]').keypress(function(e) {
		if (e.which === 13) {
			const method = $(this).attr('id').includes('email') ? 'email' : 'sms';
			verifyPwCode(method);
			return false;
		}
	});

	// 비밀번호 강도 표시
	$('#new_password').on('input', function() {
		updatePasswordStrength($(this).val());
	});

	// 자동 포맷팅 (전화번호)
	$('#pw_sms_contact').on('input', function() {
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

