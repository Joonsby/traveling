var checkInDate = null;
var checkOutDate = null;
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
})

$(document).ready(function() {
	flatpickr.localize(flatpickr.l10ns.ko);
	
	flatpickr("#check_in_date", {
		minDate: 'today',
		onClose : [
			function(selectedDates, dateStr, instance){
				checkInDate = Number(replaceAllString(dateStr,'-',''));
				if(checkOutDate !=null && checkInDate > checkOutDate){
					showModal('#Modal','체크인 날짜','체크인 날짜를 다시 선택하시기 바랍니다.');
					$('#check_in_date').val('');
					checkInDate = null;
				}
			}
		]
	});
	flatpickr("#check_out_date", {
		minDate: new Date().fp_incr(1),
		onChange : [
			function(selectedDates, dateStr, instance){
				checkOutDate = Number(replaceAllString(dateStr,'-',''));
				if(Number(replaceAllString(dateStr,'-','')) <  checkInDate){
					showModal('#Modal','체크아웃 날짜','체크아웃 날짜를 다시 선택하시기 바랍니다.');
					$('#check_out_date').val('');
					checkOutDate = null;
				}
			}
		]
	});
	
	// 검색하기 버튼 클릭
	$('#search_btn').click(function(e){
		if($('#region').val() == null || $('#region').val() == ''){
			e.preventDefault();
			showModal('#Modal','여행 지역 선택','여행하실 지역을 입력해주시기 바랍니다.');
			return;
		}
		if($('#check_in_date').val() == null || $('#check_in_date').val() == ''){
			e.preventDefault();
			showModal('#Modal','체크인 날짜','체크인 날짜를 입력해주시기 바랍니다.');
			return;
		}
		if($('#check_out_date').val() == null || $('#check_out_date').val() == ''){
			e.preventDefault();
			showModal('#Modal','체크아웃 날짜','체크아웃 날짜를 입력해주시기 바랍니다.');
			return;
		}
		if($('#people_num').val() == null || $('#people_num').val() == ''){
			e.preventDefault();
			showModal('#Modal','인원수 선택','여행하실 인원수를 선택해 주시기 바랍니다.');
			return;
		}
	});
	
	// 인원수 체크
	$('#people_num').blur(function(){
		if(parseInt($(this).val()) > 15){
			showModal('#Modal','인원수 재입력','최대 인원수는 15명 입니다.');
			$(this).val(1);
			return;
		}
	});
	
    $('#my_info').on('mouseleave', function() {
        $(this).fadeOut(50);
    });
    
    $('.right_menu').on('mouseenter',function(){
    	$('#my_info').show();
    });
    
    $('#my_info').on('mouseleave',function(){
    	$(this).hide();
    });

    // 위로 가기 버튼
    $('div.go_top').hide();
    $(window).scroll(function() {
        if ($(this).scrollTop() > 200) {
            $('div.go_top').fadeIn();
        } else {
            $('div.go_top').fadeOut();
        }
    });
    $('div.go_top').click(function() {
        $('html,body').animate({scrollTop : 0},0);
    });
});
