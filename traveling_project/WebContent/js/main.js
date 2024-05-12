$(document).ready(function () {
  
    // 숙소 예약 창
    $('.menu li:eq(0)').click(function(){
      $('#search').fadeToggle('fast');
    })
  
    $('.close_btn').click(function(){
      $('#search').fadeOut('fast');
    })
  
    $('.rec_slider').slick({
      infinite: false,
      slidesToShow: 4,
      slidesToScroll: 4,
    });
  
    $('.pop_slider').slick({
      infinite: true,
      slidesToShow: 4,
      slidesToScroll: 1,
      draggable: false
    });
  
    $('.image_slider').slick({
      infinite: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      dots: true,
      draggable:false
    });
  
    $('.event .event_slider').slick({
      autoplay: true,
      autoplaySpeed: 5000,
      infinite: true,
      slidesToShow: 3,
      slidesToScroll: 1,
      dots: true,
    });
  
    // 호텔 추천 이미지 슬라이더 버튼 클릭시 a태그 막기
    const recImageSliderArrow = $('.image_slider > button');
    const recImageSliderDots = $(
      '.hotel_recommend > .rec_slider > .slick-list > .slick-track > .slick-slide .slick-dots li button'
    );
    $(recImageSliderArrow).click(function (e) {
      e.preventDefault();
    });
    $(recImageSliderDots).click(function (e) {
      e.preventDefault();
    });
  
    // 내 주변 숙소 이미지 슬라이더 버튼 클릭시 a태그 막기
    const popSliderArrow = $('.pop_slider > .slick-dots li button');
    const popSliderDots = $(
      '.popular_accomodation > .pop_slider > .slick-list > .slick-track > .slick-slide .slick-dots li button'
    );
    $(popSliderArrow).click(function (e) {
      e.preventDefault();
    });
    $(popSliderDots).click(function (e) {
      e.preventDefault();
    });
  
    // 내 주변 숙소 이미지 슬라이더 버튼 클릭시 a태그 막기
    const accomodationNearMeSliderArrow = $('.accomodation_near_me .image_slider ul.slick-dots li button');
    const accomodationNearMeDots = $(
      '.accomodation_near_me > .swiper > .slider > .swiper-slide > a .image_slider > ul.slick-dots li button'
    );
    $(accomodationNearMeSliderArrow).click(function (e) {
      e.preventDefault();
    });
    $(accomodationNearMeDots).click(function (e) {
      e.preventDefault();
    });
  
    // swiper
    new Swiper('.mySwiper.banner', {
      spaceBetween: 20,
      slidesPerView: 5,
      touchRatio: 0,
      pagination: {
        el: '.swiper-pagination',
        type: 'progressbar',
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  
    new Swiper('.mySwiper.event', {
      slidesPerView: 1,
      spaceBetween: 30,
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  
    let recReview = $('.rec_review');
    let popReview = $('.pop_review');
    $('.show_review').addClass('after_style');
    $('.review').hide();
    $('#rec_show_review').click(function () {
      recReview.slideToggle(300);
      console.log($(this).text());
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
  