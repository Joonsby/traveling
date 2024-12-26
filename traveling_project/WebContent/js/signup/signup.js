var isIdAvailable = false;
var isEmailAvailable = false;
var isPwAvailable = false;
var isPwChkAvailable = false;
var isNameAvailable = false;
var isBusinessNumAvailable = false;

function setErrorTxt(id,msg){
	$('#' + id + '-txt').remove();
	$('#' + id).after('<p id="' + id + '-txt" class="error_text"></p>')
	$('#' + id + '-txt').text(msg);
	$('#' + id).css('border','1px solid red');
}

function setAvailableTxt(id,msg){
	$('#' + id + '-txt').remove();
	$('#' + id).after('<p id="' + id + '-txt" class="available_text"></p>')
	$('#' + id + '-txt').text(msg);
	$('#' + id).css('border','1px solid #1aa3ff');
}

$(document).ready(function () {
  //모든 공백 체크 정규식
  const empJ = /\s/g;
  //아이디 정규식
  const idJ = /^[a-z0-9]{6,20}$/;
  // 비밀번호 정규식
  const pwJ = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
  // 이름 정규식
  const nameJ = /^[가-힣]{2,6}$/;
  // 이메일 검사 정규식
  const emailJ = /^[a-zA-Z0-9\-_]+$/;
  // 휴대폰 번호 정규식
  const phoneJ = /^01[016789]\d{3,4}\d{5}$/;
  // 사업자 등록번호 정규식
  const businessNumJ1 = /^[0-9]{3}$/;
  const businessNumJ2 = /^[0-9]{2}$/;
  const businessNumJ3 = /^[0-9]{5}$/;

  // scrollTop 함수
  function goTop() {
    $(window).scrollTop(280);
  }
  
  // 아이디 중복 처리 & 유효성 검사
  if($('#requestType').val() == 'user'){
	  $('#id').blur(function () {
		  const user_id = $('#id').val();
		  $.ajax({
			  type: 'POST',
			  url: '/webPage/signup/SignupServlet',
			  data: {
				  requestType : "checkUserId",
				  user_id: user_id
			  },
			  success: function (result) {
				  const data = result.trim();
				  console.log(data);
				  if (data == 'true') {
					  setErrorTxt('id','중복된 아이디입니다. 다시 입력해주세요.');
					  isIdAvailable = false;
				  } else if (data == 'false') {
					  if (idJ.test(user_id) && !empJ.test(user_id)) {
						  setAvailableTxt('id','사용가능한 아이디 입니다.');
						  isIdAvailable = true;
					  } else {
						  setErrorTxt('id','특수문자를 제외한 8~20자의 영문과 숫자로 입력해주세요.')
						  isIdAvailable = false;
					  }
				  }
			  },
		  });
	  });
	  

	  // 이메일 유효성 검사
	  $('#email').blur(function () {
	    const emailValue = $('#email').val();
	    console.log(emailValue);
	    $.ajax({
	    	type: 'POST',
	    	url: '/webPage/signup/SignupServlet',
	    	data: {
	    		requestType : "checkHostEmail",
	    		email : emailValue
	    	},
	    	success: function (result) {
	    		const data = result.trim();
	    		if (data == 'true') {
	    	    	$('#email-txt').hide();
	    	    	$('#email').css('border','1px solid red');
	    	    	$('#email_address').after('<p id="email-txt" class="error_text">이미 가입된 이메일 입니다. 다시 입력해주세요.</p>');
	    		} else if (data == 'false') {
	    		    if (!emailJ.test(emailValue)) {
	    		    	$('#email-txt').hide();
	    		    	$('#email').css('border','1px solid red');
	    		    	$('#email_address').after('<p id="email-txt" class="error_text">올바른 이메일 형식을 입력해주세요.</p>');
	    		    } else {
	    		    	$('#email-txt').hide();
	    		    	$('#email').css('border', '1px solid #1aa3ff');
	    		    }
	    		}
	    	}
	    });
	  });
	  
	  
  } else{
	  $('#id').blur(function () {
		  const hostId = $('#id').val();
		  $.ajax({
			  type: 'POST',
			  url: '/webPage/signup/SignupServlet',
			  data: {
				  requestType : "checkHostId",
				  hostId: hostId
			  },
			  success: function (result) {
				  const data = result.trim();
				  if (data == 'true') {
					  setErrorTxt('id','중복된 아이디입니다. 다시 입력해주세요.');
					  isIdAvailable = false;
				  } else if (data == 'false') {
					  if (idJ.test(hostId) && !empJ.test(hostId)) {
						  setAvailableTxt('id','사용가능한 아이디 입니다.');
						  isIdAvailable = true;
					  } else {
						  setErrorTxt('id','특수문자를 제외한 8~20자의 영문과 숫자로 입력해주세요.')
						  isIdAvailable = false;
					  }
				  }
			  },
		  });
	  });
	  
	  // 이메일 유효성 검사
	  $('#email').blur(function () {
	    const emailValue = $('#email').val();
	    $.ajax({
	    	type: 'POST',
	    	url: '/webPage/signup/SignupServlet',
	    	data: {
	    		requestType : "checkUserEmail",
	    		email : emailValue
	    	},
	    	success: function (result) {
	    		const data = result.trim();
	    		if (data == 'true') {
	    	    	$('#email-txt').hide();
	    	    	$('#email').css('border','1px solid red');
	    	    	$('#email_address').after('<p id="email-txt" class="error_text">이미 가입된 이메일 입니다. 다시 입력해주세요.</p>');
	    		} else if (data == 'false') {
	    		    if (!emailJ.test(emailValue)) {
	    		    	$('#email-txt').hide();
	    		    	$('#email').css('border','1px solid red');
	    		    	$('#email_address').after('<p id="email-txt" class="error_text">올바른 이메일 형식을 입력해주세요.</p>');
	    		    } else {
	    		    	$('#email-txt').hide();
	    		    	$('#email').css('border', '1px solid #1aa3ff');
	    		    }
	    		}
	    	}
	    });
	  });
  }

  // 비밀번호 유효성 검사
  $('#pw').blur(function () {
    const user_pw = $('#pw').val();
    if (!pwJ.test(user_pw)) {
    	setErrorTxt('pw','공백을 제외한 8~16자의 영문 대/소문자+숫자+특수문자 조합으로 입력해주세요.');
    	isPwAvailable = false;
    } else {
    	setAvailableTxt('pw','사용 가능한 비밀번호입니다.');
    	isPwAvailable = true;
    }
  });

  // 비밀번호 확인
  $('#pw_check').blur(function () {
    const pw_check = $('#pw_check').val();
    const user_pw = $('#pw').val();

    if (pw_check == '') {
    	setErrorTxt('pw_check','비밀번호를 확인해주세요.');
    	isPwChkAvailable = false;
    } else if (pw_check == user_pw) {
    	setAvailableTxt('pw_check','비밀번호가 동일합니다.');
    	isPwChkAvailable = true;
    } else {
    	setErrorTxt('pw_check','비밀번호가 일치하지 않습니다.');
    	isPwChkAvailable = false;
    }
  });

  // 이름 유효성 검사
  $('#name').blur(function () {
    const user_name = $('#name').val();
    if (!nameJ.test(user_name)) {
    	setErrorTxt('name','이름을 올바르게 입력해주세요.');
    	isNameAvailable = false;
    } else {
      $('#name').css('border', '1px solid #1aa3ff');
      $('#name-txt').hide();
      isNameAvailable = true;
    }
  });

  // 통신사 클릭시 빨간색 테두리, 경고문 사라짐
  $('#agency_td div label').click(function () {
    $(this).children().first().css('border', '0');
    $('#agency_td div label').css('border', '1px solid #999');
    $('#agency_td div label:eq(0)').css('border-right', '0');
    $('#agency_td div label:eq(1)').css('border-right', '0');
    $('#agency_td div label:eq(2)').css('border-right', '0');
    $('#agency_td div label:eq(3)').css('border-right', '0');
    $('#agency_td div label:eq(4)').css('border-right', '0');
    $('#agency-txt').hide();
  });

  // 전화번호 유효성 검사
  $('#phone').blur(function () {
    const phoneValue = $('#phone').val();
    if (!phoneJ.test(phoneValue)) {
    	setErrorTxt('phone','" - "를 제외한 전화번호 11자리를 입력해주세요');
    } else {
      $('#phone').css('border', '1px solid #1aa3ff');
      $('#phone-txt').hide();
    }
  });

  // 이메일 주소 선택시 #1aa3ff 테두리 적용
  $('#email_address').change(function () {
      $(this).css('border', '1px solid #1aa3ff');
      $('#email-txt').hide();
  });

  // 생년월일 클릭시 테두리 적용
  $('#birth_year').click(function () {
    $(this).css('border', '1px solid #999');
    $('#birth_text').hide();
  });
  $('#birth_month').click(function () {
    $(this).css('border', '1px solid #999');
    $('#birth_text').hide();
  });
  $('#birth_day').click(function () {
    $(this).css('border', '1px solid #999');
    $('#birth_text').hide();
  });

  // 주소 검색 버튼 클릭시 빨간색 테두리, 경고문 사라짐
  $('#post_search_btn').click(function () {
    $('#addr-txt').hide();
    $('#sample4_postcode').css('border', '1px solid #999');
    $('#sample4_roadAddress').css('border', '1px solid #999');
    $('#sample4_jibunAddress').css('border', '1px solid #999');
    $('#sample4_detailAddress').css('border', '1px solid #999');
    $('#sample4_extraAddress').css('border', '1px solid #999');
  });

  // 회원가입 버튼 클릭
  $('#sign_up_btn').click(function (e) {
    const user_pw = $('#pw').val();
    const pw_check = $('#pw_check').val();
    const user_name = $('#name').val();
    const checkedAgency = $("input[name='news_agency']:checked");
    const phoneValue = $('#phone').val();
    const emailValue = $('#email').val();
    const birthYear = $('#birth_year').val();
    const birthMonth = $('#birth_month').val();
    const birthDay = $('#birth_day').val();
    const postcode = $('#sample4_postcode').val();
    const roadAddr = $('#sample4_roadAddress').val();
    const jibunAddr = $('#sample4_jibunAddress').val();
    const extraAddr = $('#sample4_extraAddress').val();
    
    if(!isIdAvailable){
    	setErrorTxt('id','아이디를 확인해주세요.');
    	goTop();
    	e.preventDefault();
    	return;
    }
    
    if(!isPwAvailable){
    	setErrorTxt('pw','비밀번호를 확인해주세요.');
    	goTop();
    	e.preventDefault();
    	return;
    }
    
    if(!isPwChkAvailable){
    	setErrorTxt('pw_check','비밀번호가 일치하지 않습니다.');
    	goTop();
    	e.preventDefault();
    	return;
    }
    
    if(!isNameAvailable){
    	setErrorTxt('name','이름을 확인해주세요.');
    	goTop();
    	e.preventDefault();
    	return;
    }

    // 비밀번호 체크
    if (!pwJ.test(user_pw)) {
      $('#pw_text').html('공백을 제외한 8~16자의 영문 대/소문자+숫자+특수문자 조합으로 입력해주세요.');
      $('#pw_text').css('color', 'red');
      $('#pw').css('border', '2px solid red');
      e.preventDefault();
    } else {
      $('#pw').css('border', '1px solid #999');
      $('#pw_text').html('사용 가능한 비밀번호입니다.');
      $('#pw_text').css('color', '#1aa3ff');
    }

    // 비밀번호 확인 체크
    if (pw_check == '') {
      e.preventDefault();
      goTop();
      $('#pw_check_text').html('비밀번호를 확인해주세요.');
      $('#pw_check').css('border', '2px solid red');
    } else if (pw_check == user_pw) {
      $('#pw_check_text').html('비밀번호가 동일합니다.');
      $('#pw_check_text').css('color', '#1aa3ff');
      $('#pw_check').css('border', '1px solid #999');
    } else {
      e.preventDefault();
      goTop();
      $('#pw_check_text').html('비밀번호가 일치하지 않습니다.');
      $('#pw_check_text').css('color', 'red');
      $('#pw_check').css('border', '2px solid red');
      e.preventDefault();
    }

    // 이름 체크
    if (!nameJ.test(user_name)) {
      e.preventDefault();
      goTop();
      $('#name_text_td').css('display', 'block');
      $('#name_text').html('이름을 올바르게 입력해주세요.');
      $('#name').css('border', '2px solid red');
    } else {
      $('#name_text_td').css('display', 'none');
      $('#name').css('border', '1px solid #999');
      $('#name_text').hide();
    }

    // 통신사 체크
    if (checkedAgency.length === 0) {
      e.preventDefault();
      goTop();
      $('#agency_td').append('<p id="agency-txt" class="error_text">통신사를 선택해주세요.</p>');
      $('#agency_td div label').css('border', '2px solid red');
      $('#agency_td div label:eq(0)').css('border-right', '0');
      $('#agency_td div label:eq(1)').css('border-right', '0');
      $('#agency_td div label:eq(2)').css('border-right', '0');
      $('#agency_td div label:eq(3)').css('border-right', '0');
      $('#agency_td div label:eq(4)').css('border-right', '0');
      return;
    } else {
      $('#agency-txt').hide();
      $('#agency_td div label').css('border', '1px solid #999');
    }

    // 전화번호 체크
    if (!phoneJ.test(phoneValue)) {
      e.preventDefault();
      goTop();
      setErrorTxt('phone','" - "를 제외한 전화번호 11자리를 입력해주세요');
      return;
    } else {
        $('#phone').css('border', '1px solid #1aa3ff');
        $('#phone-txt').hide();
    }

    // 이메일 체크
    if (!emailJ.test(emailValue)) {
    	e.preventDefault();
      	goTop();
      	$('#email-txt').hide();
  	  	$('#email').css('border','1px solid red');
  	  	$('#email_address').after('<p id="email-txt" class="error_text">올바른 이메일 형식을 입력해주세요.</p>');
  	  	return;
    } else {
    	$('#email-txt').hide();
    	$('#email').css('border', '1px solid #1aa3ff');
    }
    
    // 이메일 주소 체크
    if ($('#email_address').val() == '0'){
    	e.preventDefault();
    	goTop();
    	$('#email-txt').hide();
    	$('#email_address').css('border','1px solid red');
    	$('#email_address').after('<p id="email-txt" class="error_text">이메일 주소를 선택해주세요.</p>');
    	return;
    }

    // 생년월일 체크
    if (!birthYear) {
      e.preventDefault();
      $('#birth-txt').hide();
      $('#birth_year').css('border', '1px solid red');
      $('#birth_day').after('<p id="birth-txt" class="error_text">생년월일을 선택해주세요.</p>');
      return;
    } else{
      $('#birth_year').css('border', '1px solid #1aa3ff');
      $('#birth-txt').hide();
    }
    
    if (!birthMonth) {
      e.preventDefault();
      $('#birth-txt').hide();
      $('#birth_month').css('border', '1px solid red');
      $('#birth_day').after('<p id="birth-txt" class="error_text">생년월일을 선택해주세요.</p>');
      return;
    } else{
        $('#birth_month').css('border', '1px solid #1aa3ff');
        $('#birth-txt').hide();
    }
    if (!birthDay) {
      e.preventDefault();
      $('#birth-txt').hide();
      $('#birth_day').css('border', '1px solid red');
      $('#birth_day').after('<p id="birth-txt" class="error_text">생년월일을 선택해주세요.</p>');
      return;
    } else {
    	$('#birth_day').css('border', '1px solid #1aa3ff');
        $('#birth-txt').hide();
    }

    // 주소 체크
    if (postcode == '' || roadAddr == '' || jibunAddr == '' || extraAddr == '') {
      e.preventDefault();
      $('#addr-txt').hide();
      $('#sample4_extraAddress').after('<p id="addr-txt" class="error_text">주소를 입력해주세요.</p>')
      $('#sample4_postcode').css('border', '1px solid red');
      $('#sample4_roadAddress').css('border', '1px solid red');
      $('#sample4_jibunAddress').css('border', '1px solid red');
      $('#sample4_detailAddress').css('border', '1px solid red');
      $('#sample4_extraAddress').css('border', '1px solid red');
      return;
    } else {
      $('#addr-txt').hide();
    }
  });
});

// 주소 검색 API
function sample4_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function (data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var roadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 참고 항목 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if (data.buildingName !== '' && data.apartment === 'Y') {
        extraRoadAddr += extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName;
      }
      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if (extraRoadAddr !== '') {
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('sample4_postcode').value = data.zonecode;
      document.getElementById('sample4_roadAddress').value = roadAddr;
      document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

      // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
      if (roadAddr !== '') {
        document.getElementById('sample4_extraAddress').value = extraRoadAddr;
      } else {
        document.getElementById('sample4_extraAddress').value = '';
      }

      var guideTextBox = document.getElementById('guide');
      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if (data.autoRoadAddress) {
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
        guideTextBox.style.display = 'block';
      } else if (data.autoJibunAddress) {
        var expJibunAddr = data.autoJibunAddress;
        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
        guideTextBox.style.display = 'block';
      } else {
        guideTextBox.innerHTML = '';
        guideTextBox.style.display = 'none';
      }
    },
  }).open();
}
