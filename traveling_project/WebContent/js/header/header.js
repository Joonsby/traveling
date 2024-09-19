var picker = new ax5.ui.picker();

$(document).ready(function() {
    picker.bind({
        target: $('[data-ax5picker="basic"]'),
        direction: "top",
        content: {
            width: 270,
            margin: 10,
            type: 'date',
            config: {
                control: {
                    left: '<i class="fa fa-chevron-left"></i>',
                    yearTmpl: '%s',
                    monthTmpl: '%s',
                    right: '<i class="fa fa-chevron-right"></i>'
                },
                lang: {
                    yearTmpl: "%s년",
                    months: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
                    dayTmpl: "%s"
                }
            }
        },
        onStateChanged: function () {

        },
        btns: {
            today: {
                label: "Today", onClick: function () {
                    var today = new Date();
                    this.self
                            .setContentValue(this.item.id, 0, ax5.util.date(today, {"return": "yyyy-mm-dd"}))
                            .setContentValue(this.item.id, 1, ax5.util.date(today, {"return": "yyyy-mm-dd"}))
                            .close()
                    ;
                }
            },
            thisMonth: {
                label: "This Month", onClick: function () {
                    var today = new Date();
                    this.self
                            .setContentValue(this.item.id, 0, ax5.util.date(today, {"return": "yyyy-mm-01"}))
                            .setContentValue(this.item.id, 1, ax5.util.date(today, {"return": "yyyy-mm"})
                                    + '-'
                                    + ax5.util.daysOfMonth(today.getFullYear(), today.getMonth()))
                            .close();
                }
            },
            ok: {label: "Close", theme: "default"}
        }
    });
	
    $('#my_info').on('mouseleave', function() {
        $(this).fadeOut(50);
    });

    // #guests-dropdown 내부에서의 클릭 이벤트가 문서 클릭 이벤트로 전파되지 않도록 합니다.
    $('#guests-dropdown').click(function(event) {
        event.stopPropagation();
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
