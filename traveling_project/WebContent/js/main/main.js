let isMobile = window.matchMedia('(max-width: 1200px)').matches;
let resizeTimer;

$(window).scroll(function() {
	if(isMobile){
        $('div.go_top').hide();
        return;
	}
	
    if ($(this).scrollTop() > 200) {
        $('div.go_top').fadeIn();
    } else {
        $('div.go_top').fadeOut();
    }
});

$(document).on(
	    'click',
	    '.slick-arrow, .slick-dots button',
	    function (e) {
	        e.preventDefault();
	        e.stopPropagation();
	    }
);

$(window).on('resize',function(){
	clearTimeout(resizeTimer);
    resizeTimer = setTimeout(function () {
        const before = isMobile;
        updateIsMobile();

        if (before !== isMobile) {
            resetSliders();
        }
    }, 200);
});

function updateIsMobile(){
	isMobile = window.matchMedia('(max-width: 1200px)').matches;
}

function resetSliders() {
    if ($('.pop_slider').hasClass('slick-initialized')) {
        $('.pop_slider').slick('unslick');
    }

    if ($('.image_slider').hasClass('slick-initialized')) {
        $('.image_slider').slick('unslick');
    }

    if ($('.event .event_slider').hasClass('slick-initialized')) {
        $('.event .event_slider').slick('unslick');
    }

    if ($('.rec_slider').hasClass('slick-initialized')) {
        $('.rec_slider').slick('unslick');
    }

    sliderInit();
}

$(document).ready(function () {
	let recReview = $('.rec_review');
	let popReview = $('.pop_review');
	
    // 위로 가기 버튼
    $('div.go_top').hide();
    $('div.go_top').click(function() {
        $('html,body').animate({scrollTop : 0},0);
    });
	
    sliderInit();
  
    $('.show_review').addClass('after_style');
    $('.review').hide();
    $('#rec_show_review').click(function () {
      recReview.slideToggle(300);
      if ($(this).text() == '접기') {
        $(this).text('리뷰 모두 보기');
        $(this).addClass('after_style');
      } else {
        $(this).text('접기');
        $(this).removeClass('after_style');
      }
    });
  
    // 인기 숙소 리뷰 모두 보기
    $('#pop_show_review').click(function () {
      popReview.slideToggle(300);
      if ($(this).text() == '접기') {
        $(this).text('리뷰 모두 보기');
        $(this).addClass('after_style');
      } else {
        $(this).text('접기');
        $(this).removeClass('after_style');
        if($(this).text() == '접기'){
          $('#pop_show_review').mouseenter(function(){
            $(this).css("color","#1200ff")
          }) 
          $('#pop_show_review').mouseleave(function(){
            $(this).css("color","#000")
          }) 
        } 
      }
    });
});

function sliderInit() {

    $('.pop_slider').slick({
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 1,
        draggable: isMobile,
        swipe: isMobile,
        arrows: !isMobile,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    draggable: true,
                    swipe: true,
                    arrows: false
                }
            }
        ]
    });

	$('.image_slider').slick({
	    infinite: true,
	    slidesToShow: 1,
	    slidesToScroll: 1,
	    dots: !isMobile,
	    draggable: !isMobile,
	    swipe: !isMobile,
	    arrows: !isMobile
	});

    $('.event .event_slider').slick({
        autoplay: true,
        autoplaySpeed: 5000,
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 1,
        dots: true,
        draggable: isMobile,
        swipe: isMobile,
        arrows: !isMobile,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    draggable: true,
                    swipe: true,
                    arrows: false
                }
            }
        ]
    });

    $('.rec_slider').slick({
        infinite: false,
        slidesToShow: 4,
        slidesToScroll: 4,
        draggable: isMobile,
        swipe: isMobile,
        arrows: !isMobile,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    draggable: true,
                    swipe: true,
                    arrows: false
                }
            }
        ]
    });

    new Swiper('.mySwiper.banner', {
        pagination: {
            el: '.swiper-pagination',
            type: 'progressbar',
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        breakpoints: {
            0: {
                slidesPerView: 3,
                spaceBetween: 10,
                allowTouchMove: true,
                touchRatio: 1
            },
            1200: {
                slidesPerView: 5,
                spaceBetween: 20,
                allowTouchMove: false,
                touchRatio: 0
            }
        }
    });

    new Swiper('.mySwiper.event', {
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        allowTouchMove: isMobile,
        touchRatio: 1,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        breakpoints: {
            0: {
                allowTouchMove: true,
                navigation: false
            },
            1200: {
                allowTouchMove: false,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
            }
        }
    });
}