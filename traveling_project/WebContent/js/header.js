$(document).ready(function() {

    // 내 정보 아이콘 클릭시 a 링크 막기
    const loginIcon = $('#menu_nav .right_menu a:eq(0)');
    $(loginIcon).click(function(e) {
        e.preventDefault();
        $('#my_info').fadeIn(50);
    });

    $('#my_info').on('mouseleave', function() {
        $(this).fadeOut(50);
    });

    $('#people_num').click(function(e) {
        $('#guests-dropdown').show();
        e.stopPropagation();
    });

    // 문서의 어느 곳이든 클릭했을 때의 이벤트 핸들러입니다.
    $(document).click(function(event) {
        var target = $(event.target); // 클릭된 요소를 가져옵니다.

        // 클릭된 요소가 #people_num 또는 #guests-dropdown 내부의 것이 아니라면 #guests-dropdown을
        // 숨깁니다.
        if (!target.closest('#people_num').length && !target.closest('#guests-dropdown').length) {
            $('#guests-dropdown').hide();
        }
    });

    // #guests-dropdown 내부에서의 클릭 이벤트가 문서 클릭 이벤트로 전파되지 않도록 합니다.
    $('#guests-dropdown').click(function(event) {
        event.stopPropagation();
    });

    // 달력 클릭시 효과
    var today = new Date().toISOString().split('T')[0];
    const date = $('input[type="date"]');
    date.attr('min', today)
    $('#check_in_date').change(function() {
        var selectedDate = new Date($(this).val());
        selectedDate.setDate(selectedDate.getDate() + 1);
        var nextDay = selectedDate.toISOString().split('T')[0];
        $('#check_out_date').attr('min', nextDay)
    })
    date.css('color', '#000');
    date.on('focus', function() {
        $(this).css('background-color', '#fff');
    });
    date.on('blur', function() {
        $(this).css('background-color', '#f5f5f5');
    });
    date.hover(function() {
        $(this).css('background-color', '#ececec');
    }, function() {
        // hover를 벗어났을 때, focus 상태가 아닌 경우에만 원래 배경 색상으로 복원
        if (!date.is(':focus')) {
            $(this).css('background-color', '#f5f5f5');
        }
    });
    var number = 1;
    $('#plus').click(function(){
        if(number < 15){
            number++;
            $('#number').text(number);    
        }        
    })
    $('#minus').click(function(){
        if(number > 1){
            number--;
            $('#number').text(number);
        }
    })

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
        $('html,body').animate({
            scrollTop : 0
        }, 400);
        return false;
    });
});
