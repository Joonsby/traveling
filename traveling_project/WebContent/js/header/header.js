var checkInDate = null;
var checkOutDate = null;
var mobileCheckInDate = null;
var mobileCheckOutDate = null;
var scrolling = false;

$(window).on('scroll',function(){
	if(!scrolling){
		scrolling = true;
	}
	
    // Flatpickr가 열려 있다면 닫기
    $('.datepicker').each(function () {
        const flatpickrInstance = $(this)[0]._flatpickr;
        if (flatpickrInstance && flatpickrInstance.isOpen) {
            flatpickrInstance.close();
        }
    });
});

$(document).keydown(function(e){
    if(e.key === 'Escape'){
        closeMobileSidebar();
    }
});

$(document).ready(function() {
	$('#mobileMenuBtn').click(function(){
		openMobileSidebar();
	});
	
	$('#mobileCloseBtn').click(function(){
		closeMobileSidebar();
	});
	
	$('#sidebarDim').click(function(){
	    closeMobileSidebar();
	});
	
	flatpickr.localize(flatpickr.l10ns.ko);
	// 체크인
	flatpickr("#check_in_date", {
		minDate: 'today',
		onClose : [
			function(selectedDates, dateStr, instance){
				checkInDate = Number(replaceAllString(dateStr,'-',''));
				if(checkOutDate !=null && checkInDate > checkOutDate){
					showModal('체크인 날짜','체크인 날짜를 다시 선택하시기 바랍니다.');
					$('#check_in_date').val('');
					checkInDate = null;
				}
			}
		]
	});
	// 체크아웃
	flatpickr("#check_out_date", {
		minDate: new Date().fp_incr(1),
		onChange : [
			function(selectedDates, dateStr, instance){
				checkOutDate = Number(replaceAllString(dateStr,'-',''));
				if(Number(replaceAllString(dateStr,'-','')) <  checkInDate){
					showModal('체크아웃 날짜','체크아웃 날짜를 다시 선택하시기 바랍니다.');
					$('#check_out_date').val('');
					checkOutDate = null;
				}
			}
		]
	});
	// 모바일 체크인
	flatpickr("#mobile_check_in_date", {
	    minDate: 'today',
	    disableMobile: true,

	    onClose: [
	        function(selectedDates, dateStr, instance) {

	            mobileCheckInDate = Number(
	                replaceAllString(dateStr, '-', '')
	            );

	            if (
	                mobileCheckOutDate != null &&
	                mobileCheckInDate > mobileCheckOutDate
	            ) {
	                showModal(
	                    '체크인 날짜',
	                    '체크인 날짜를 다시 선택하시기 바랍니다.'
	                );

	                $('#mobile_check_in_date').val('');
	                mobileCheckInDate = null;
	            }
	        }
	    ]
	});
	// 모바일 체크아웃
	flatpickr("#mobile_check_out_date", {
	    minDate: new Date().fp_incr(1),
	    disableMobile: true,

	    onChange: [
	        function(selectedDates, dateStr, instance) {

	            mobileCheckOutDate = Number(
	                replaceAllString(dateStr, '-', '')
	            );

	            if (
	                mobileCheckOutDate < mobileCheckInDate
	            ) {
	                showModal(
	                    '체크아웃 날짜',
	                    '체크아웃 날짜를 다시 선택하시기 바랍니다.'
	                );

	                $('#mobile_check_out_date').val('');
	                mobileCheckOutDate = null;
	            }
	        }
	    ]
	});
	
	// 검색하기 버튼 클릭
	$('#search_btn').click(function(e) {
	    validateSearchForm($(this).closest('form'), e);
	});
	
	// 인원수 체크
	$('#people_num').blur(function(){
		if(parseInt($(this).val()) > 15){
			showModal('인원수 재입력','최대 인원수는 15명 입니다.');
			$(this).val(1);
			return;
		}
	});
    
    $('#my_info').on('mouseleave',function(){
    	$(this).hide();
    });
    
    // 모바일
    $('#mobile_search').submit(function(e) {
        validateSearchForm($(this), e);
    });
    
    // 로그아웃 버튼
    $('#log-out').click(function(e){
    	e.preventDefault();
    	showConfirmModal(			
			'로그아웃',
			'정말 로그아웃하시겠습니까?',
			function () {
				window.location.href = $('#log-out').attr('href');
			}
		);
    });  
});

function validateSearchForm($form, e) {
    const region = $form.find('input[name="region"]').val();
    const checkInDate = $form.find('input[name="check_in_date"]').val();
    const checkOutDate = $form.find('input[name="check_out_date"]').val();
    const peopleNum = $form.find('input[name="people_num"]').val();

    if (region == null || region.trim() == '') {
        e.preventDefault();
        showModal('여행 지역 선택', '여행하실 지역을 입력해주시기 바랍니다.');
        return false;
    }

    if (checkInDate == null || checkInDate.trim() == '') {
        e.preventDefault();
        showModal('체크인 날짜', '체크인 날짜를 입력해주시기 바랍니다.');
        return false;
    }

    if (checkOutDate == null || checkOutDate.trim() == '') {
        e.preventDefault();
        showModal('체크아웃 날짜', '체크아웃 날짜를 입력해주시기 바랍니다.');
        return false;
    }

    if (peopleNum == null || peopleNum.trim() == '') {
        e.preventDefault();
        showModal('인원수 선택', '여행하실 인원수를 선택해 주시기 바랍니다.');
        return false;
    }

    return true;
}

function openMobileSidebar() {
    $('#mobileSidebar').addClass('active');
    $('#sidebarDim').addClass('active');

    $('body').css({
        overflow: 'hidden',
        height: '100vh'
    });
}

function closeMobileSidebar() {
    $('#mobileSidebar').removeClass('active');
    $('#sidebarDim').removeClass('active');

    $('body').css({
        overflow: '',
        height: ''
    });
}
