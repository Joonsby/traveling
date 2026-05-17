$(document).ready(function() {
    var latitude = $('address').data("latitude");
    var longitude = $('address').data("longitude");
    var swiper = new Swiper(".mySwiper", {
        slidesPerView : 3,
        spaceBetween : 20,
        /*loop : true,*/
        pagination : {
            el : ".swiper-pagination",
            clickable : true,
        },
        navigation : {
            nextEl : ".swiper-button-next",
            prevEl : ".swiper-button-prev",
        },
        breakpoints: {
            // 1200px 이하: 2개씩
            0: {
                slidesPerView: 2,
                spaceBetween: 15,
            },
            // 1200px 이상: 3개씩
            1200: {
                slidesPerView: 3,
                spaceBetween: 20,
            }
        }
    });

    $('#amenity-btn').click(function(e) {
        e.preventDefault();
        // Use common.js helper to show amenity inside the shared Bootstrap modal
        if(typeof showAmenityModal === 'function'){
            showAmenityModal('편의시설', '.amenity');
        } else {
            // fallback to original behavior if helper not available
            $('.amenity').show();
            $('body').css('overflow', 'hidden');
            $('#modal-backdrop').show();
        }
    });

    $('#amenity-close').click(function() {
        $('.amenity').hide();
        $('body').css('overflow', 'auto');
        $('#modal-backdrop').hide();
    });

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center : new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
        level : 3, // 지도의 확대 레벨
        mapTypeId : kakao.maps.MapTypeId.ROADMAP
    // 지도종류
    };

    // 지도를 생성한다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
    map.setDraggable(false);

    // 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
    map.setZoomable(false);

    // 지도 타입 변경 컨트롤을 생성한다
    var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    // 지도에 마커를 생성하고 표시한다
    var marker = new kakao.maps.Marker({
        position : new kakao.maps.LatLng(latitude, longitude), // 마커의 좌표
        map : map
    // 마커를 표시할 지도 객체
    });

    $('.reservation-a').click(function(e) {
        var userID = $(this).data('id');
        if (!userID) {
            e.preventDefault();
            showConfirmModal(
                    "로그인 필요",
                    "예약 하려면 로그인이 필요합니다. 로그인 화면으로 이동하시겠습니까?",
                    function() {
                        window.location.href = '/login/select';
                    }
                );
        }
    })
});