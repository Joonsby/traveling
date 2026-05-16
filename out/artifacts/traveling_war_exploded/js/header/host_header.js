$(document).ready(function() {
    // nav menu에 hover시 lnb_menu 나타남
    $(".lnb_menu").hide();
    $(".lnb").mouseenter(function() {
        $(".lnb_menu").stop().slideDown(200);
    });
    $("#menu_nav").mouseleave(function() {
        $('.lnb_menu').stop().slideUp(200);
    });    
    
    const hostId = $('#host_id').val()

    $('#add_stay_btn').click(function(e) {
    	e.preventDefault();
        $.ajax({
            type : "POST",
            url : "/stay/count",
            success : function(cnt) {
                if (cnt > 0) {
                	e.preventDefault();
                	showModal('숙소 등록 제한','한 계정당 하나의 숙소만 등록할 수 있습니다.');
                } else{
                    window.location.href = "/webPage/stay/add_stay.jsp";
                }
            },
        });
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
