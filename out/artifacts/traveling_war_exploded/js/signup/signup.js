var isIdAvailable = false;
var isEmailAvailable = false;
var isPwAvailable = false;
var isPwChkAvailable = false;
var isNameAvailable = false;

function setErrorTxt(id, msg) {
    $('#' + id + '-txt').remove();
    $('#' + id).after('<p id="' + id + '-txt" class="error_text"></p>');
    $('#' + id + '-txt').text(msg);
    $('#' + id).css('border', '1px solid red');
}

function setAvailableTxt(id, msg) {
    $('#' + id + '-txt').remove();
    $('#' + id).after('<p id="' + id + '-txt" class="available_text"></p>');
    $('#' + id + '-txt').text(msg);
    $('#' + id).css('border', '1px solid #1aa3ff');
}

$(document).ready(function () {
    const empJ = /\s/g;
    const idJ = /^[a-z0-9]{6,20}$/;
    const pwJ = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
    const nameJ = /^[가-힣]{2,6}$/;
    const emailJ = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneJ = /^01[016789]\d{3,4}\d{4}$/;

    bindBirthInputEvents();
    bindSignupEvents();

    function goTop() {
        $(window).scrollTop(280);
    }

    $('#id').blur(function () {
        const requestType = $('#requestType').val();
        const idValue = $('#id').val();

        if (!idJ.test(idValue) || empJ.test(idValue)) {
            setErrorTxt('id', '특수문자를 제외한 6~20자의 영문 소문자와 숫자로 입력해주세요.');
            isIdAvailable = false;
            return;
        }

        $.ajax({
            type: 'POST',
            url: requestType === 'user' ? '/signup/user-id-check' : '/signup/host-id-check',
            data: requestType === 'user'
                ? { user_id: idValue }
                : { hostId: idValue },
            success: function (result) {
                const data = result.trim();

                if (data === 'true') {
                    setErrorTxt('id', '중복된 아이디입니다. 다시 입력해주세요.');
                    isIdAvailable = false;
                    return;
                }

                setAvailableTxt('id', '사용 가능한 아이디입니다.');
                isIdAvailable = true;
            }
        });
    });

    $('#pw').blur(function () {
        const pw = $('#pw').val();

        if (!pwJ.test(pw)) {
            setErrorTxt('pw', '공백을 제외한 8~16자의 영문+숫자+특수문자 조합으로 입력해주세요.');
            isPwAvailable = false;
            return;
        }

        setAvailableTxt('pw', '사용 가능한 비밀번호입니다.');
        isPwAvailable = true;
    });

    $('#pw_check').blur(function () {
        const pw = $('#pw').val();
        const pwCheck = $('#pw_check').val();

        if (pwCheck === '') {
            setErrorTxt('pw_check', '비밀번호를 확인해주세요.');
            isPwChkAvailable = false;
            return;
        }

        if (pw !== pwCheck) {
            setErrorTxt('pw_check', '비밀번호가 일치하지 않습니다.');
            isPwChkAvailable = false;
            return;
        }

        setAvailableTxt('pw_check', '비밀번호가 동일합니다.');
        isPwChkAvailable = true;
    });

    $('#name').blur(function () {
        const name = $('#name').val();

        if (!nameJ.test(name)) {
            setErrorTxt('name', '이름을 올바르게 입력해주세요.');
            isNameAvailable = false;
            return;
        }

        setAvailableTxt('name', '사용 가능한 이름입니다.');
        isNameAvailable = true;
    });

    $('#phone').blur(function () {
        const phone = $('#phone').val();

        if (!phoneJ.test(phone)) {
            setErrorTxt('phone', '"-"를 제외한 휴대폰 번호 11자리를 입력해주세요.');
            return;
        }

        setAvailableTxt('phone', '사용 가능한 전화번호입니다.');
    });

    $('#email').blur(function () {
        const requestType = $('#requestType').val();
        const email = $('#email').val();

        if (!emailJ.test(email)) {
            setErrorTxt('email', '올바른 이메일 형식으로 입력해주세요.');
            isEmailAvailable = false;
            return;
        }

        $.ajax({
            type: 'POST',
            url: requestType === 'user' ? '/signup/user-email-check' : '/signup/host-email-check',
            data: { email: email },
            success: function (result) {
                const data = result.trim();

                if (data === 'true') {
                    setErrorTxt('email', '이미 가입된 이메일입니다.');
                    isEmailAvailable = false;
                    return;
                }

                setAvailableTxt('email', '사용 가능한 이메일입니다.');
                isEmailAvailable = true;
            }
        });
    });

    $('#news_agency').change(function () {
        if ($(this).val() !== '') {
            setAvailableTxt('news_agency', '통신사가 선택되었습니다.');
        }
    });

    $('form[name="sign_up"]').submit(function (e) {
        const agency = $('#news_agency').val();
        const phone = $('#phone').val();
        const postcode = $('#sample4_postcode').val();
        const roadAddr = $('#sample4_roadAddress').val();
        const jibunAddr = $('#sample4_jibunAddress').val();
        const detailAddr = $('#sample4_detailAddress').val();

        if (!isIdAvailable) {
            e.preventDefault();
            setErrorTxt('id', '아이디를 확인해주세요.');
            goTop();
            return;
        }

        if (!isPwAvailable) {
            e.preventDefault();
            setErrorTxt('pw', '비밀번호를 확인해주세요.');
            goTop();
            return;
        }

        if (!isPwChkAvailable) {
            e.preventDefault();
            setErrorTxt('pw_check', '비밀번호가 일치하지 않습니다.');
            goTop();
            return;
        }

        if (!isNameAvailable) {
            e.preventDefault();
            setErrorTxt('name', '이름을 확인해주세요.');
            goTop();
            return;
        }

        if (agency === '') {
            e.preventDefault();
            setErrorTxt('news_agency', '통신사를 선택해주세요.');
            goTop();
            return;
        }

        if (!phoneJ.test(phone)) {
            e.preventDefault();
            setErrorTxt('phone', '"-"를 제외한 휴대폰 번호 11자리를 입력해주세요.');
            goTop();
            return;
        }

        if (!isEmailAvailable) {
            e.preventDefault();
            setErrorTxt('email', '이메일을 확인해주세요.');
            goTop();
            return;
        }

        if (!validateBirthRaw()) {
            e.preventDefault();
            goTop();
            return;
        }

        if (postcode === '' || roadAddr === '' || jibunAddr === '' || detailAddr === '') {
            e.preventDefault();
            $('#addr-txt').remove();
            $('#sample4_detailAddress').after('<p id="addr-txt" class="error_text">주소를 입력해주세요.</p>');
            $('#sample4_postcode, #sample4_roadAddress, #sample4_jibunAddress, #sample4_detailAddress').css('border', '1px solid red');
            goTop();
            return;
        }
    });
});

function bindBirthInputEvents() {
    $('#birth_raw').on('input', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
        $('#birth_raw-txt').remove();
        $(this).css('border', '1px solid #999');
        $('#birth').val('');
    });

    $('#birth_raw').on('blur', function () {
        if ($(this).val() !== '') {
            validateBirthRaw();
        }
    });
}

function convertBirthToFullDate(rawBirth) {
    if (!/^\d{6}$/.test(rawBirth)) {
        return null;
    }

    const yy = Number(rawBirth.substring(0, 2));
    const mm = rawBirth.substring(2, 4);
    const dd = rawBirth.substring(4, 6);

    const currentYear = new Date().getFullYear();
    const currentYY = currentYear % 100;
    const fullYear = yy <= currentYY ? 2000 + yy : 1900 + yy;

    if (!isValidBirthDate(fullYear, Number(mm), Number(dd))) {
        return null;
    }

    return fullYear + '-' + mm + '-' + dd;
}

function isValidBirthDate(year, month, day) {
    const nowYear = new Date().getFullYear();
    const minYear = nowYear - 100;

    if (year < minYear || year > nowYear) return false;
    if (month < 1 || month > 12) return false;

    const lastDay = new Date(year, month, 0).getDate();
    if (day < 1 || day > lastDay) return false;

    const inputDate = new Date(year, month - 1, day);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return inputDate <= today;
}

function validateBirthRaw() {
    const rawBirth = $('#birth_raw').val();
    const convertedBirth = convertBirthToFullDate(rawBirth);

    $('#birth_raw-txt').remove();

    if (convertedBirth == null) {
        setErrorTxt('birth_raw', '생년월일을 6자리로 정확히 입력해주세요. 예: 980922');
        $('#birth').val('');
        return false;
    }

    $('#birth').val(convertedBirth);
    setAvailableTxt('birth_raw', convertedBirth + ' 형식으로 저장됩니다.');
    return true;
}

function bindSignupEvents() {
    $('#post_search_btn').on('click', function () {
        sample4_execDaumPostcode();
    });

    $('#sign_up_cancel').on('click', function () {
        const requestType = $('#requestType').val();
        location.href = '/signup/agree?requestType=' + requestType;
    });
}