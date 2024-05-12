var map;
var overlayMap = {};

//필터링 데이터를 수집하는 함수
function collectFilterData() {
  return {
    minPrice: $(".range-min").val(),
    maxPrice: $(".range-max").val(),
    rating: $(".rating:checked").val(),
    parking: $("#parking").is(":checked") ? $("#parking").val() : null,
    wireless_internet: $("#wireless_internet").is(":checked") ? $("#wireless_internet").val() : null,
    tub: $("#tub").is(":checked") ? $("#tub").val() : null,
    washing_machine: $("#washing_machine").is(":checked") ? $("#washing_machine").val() : null,
    drying_machine: $("#drying_machine").is(":checked") ? $("#drying_machine").val() : null,
    air_conditioner: $("#air_conditioner").is(":checked") ? $("#air_conditioner").val() : null,
    fan: $("#fan").is(":checked") ? $("#fan").val() : null,
    heating_system: $("#heating_system").is(":checked") ? $("#heating_system").val() : null,
    pool: $("#pool").is(":checked") ? $("#pool").val() : null,
    arcade_game: $("#arcade_game").is(":checked") ? $("#arcade_game").val() : null,
    gym: $("#gym").is(":checked") ? $("#gym").val() : null,
    board_game: $("#board_game").is(":checked") ? $("#board_game").val() : null,
    barbecue_tool: $("#barbecue_tool").is(":checked") ? $("#barbecue_tool").val() : null,
    basic_cookware: $("#basic_cookware").is(":checked") ? $("#basic_cookware").val() : null,
    breakfast: $("#breakfast").is(":checked") ? $("#breakfast").val() : null,
    clean_service: $("#clean_service").is(":checked") ? $("#clean_service").val() : null,
    luggage_storage: $("#luggage_storage").is(":checked") ? $("#luggage_storage").val() : null,
  };
}

//중복된 AJAX 요청 로직을 처리하는 함수
function sendFilterRequest(filterData) {
  $.ajax({
    url: "priceFilter.condb?comm=filter",
    type: "POST",
    data: filterData,
    success: function (data) {
      var parsedData = JSON.parse(data);
      var accommodationBox = $("#accomodation_info_box");
      accommodationBox.empty();

      // 위치와 가격 정보를 저장할 객체를 초기화합니다.
      var locations = {};

      if (Array.isArray(parsedData.result)) {
        parsedData.result.forEach(function (item) {
          var formattedPrice = parseInt(item.price).toLocaleString();
          var key = parseFloat(item.latitude) + "_" + parseFloat(item.longitude);
          
          // locations 객체를 생성합니다.
          locations[key] = {
            lat: parseFloat(item.latitude),
            lng: parseFloat(item.longitude),
            stayName: item.stayName,
            price: formattedPrice
          };

          // 숙박 정보 HTML을 구성하고 페이지에 추가합니다.
          var accommodationHTML = `
            <div class="accomodation">
              <a href="stay_info.condb?comm=stay_info&stay_id=${item.stayId}">
                <div class="accomodation_box">
                  <div>
                    <img class="image" src="/traveling_project/images/stay_images/${item.image}" alt="이미지1" />
                  </div>
                  <div>
                    <h2 class="stay-name">${item.stayName}</h2>
                    <p class="avg-rating">${item.avgRating}</p>
                    <p class="road-addr">${item.roadAddr}</p>
                    <p class="room-price">₩ ${formattedPrice} ~</p>
                  </div>
                </div>
              </a>
            </div>`;
          accommodationBox.append(accommodationHTML);
        });
        
        // 지도에 오버레이를 생성합니다.
        createOverlays(locations);
      }
    },
    error: function (request, status, error) {
      // 오류 처리를 위한 콜백 함수를 추가할 수 있습니다.
      console.error("Ajax Request Error:", status, error);
    }
  });
}


//오버레이를 지도에서 제거하는 함수
function removeOverlays() {
for (var key in overlayMap) {
 if (overlayMap.hasOwnProperty(key)) {
   overlayMap[key].setMap(null); // 오버레이를 지도에서 제거
 }
}
overlayMap = {}; // 오버레이 객체를 비웁니다.
}

//오버레이를 생성하고 지도에 표시하는 함수
function createOverlays(locations) {
  removeOverlays(); // 기존에 있던 오버레이들을 지도에서 모두 제거합니다.

  for (var key in locations) {
    if (locations.hasOwnProperty(key)) {
      var position = locations[key];
      var content ='<div class="center">' +
                       '<p>' + position.stayName + '</p>' + 
                       '<span>₩' + position.price + '</span>' +
                   '</div>';                   
      var customOverlay = new kakao.maps.CustomOverlay({
        map: map,
        position: new kakao.maps.LatLng(position.lat, position.lng),
        content: content,
        yAnchor: 1
      });
      overlayMap[key] = customOverlay; // 생성된 오버레이를 객체에 추가합니다.
    }
  }
}

$(document).ready(function () {            
  var locations = {};
  // 위도와 경도 값을 포함하는 각 요소에 대해 반복합니다.
  $(".latitude").each(function (index, element) {
    var latitude = parseFloat(element.value);
    var longitudeElement = $(".longitude")[index];
    var longitude = parseFloat(longitudeElement.value);    

    // 고유한 키를 생성합니다. 여기서는 위도와 경도를 조합하여 키를 만듭니다.
    var key = latitude + "_" + longitude;

    // 위치 객체를 생성하여 locations 객체에 저장합니다.
    locations[key] = {
      lat: latitude,
      lng: longitude,
      stayName: $(".name-val")[index].value,
      price: $(".price-val")[index].value
    };    
  });
  
  //locations 객체의 모든 키를 얻습니다.
  var keys = Object.keys(locations);

  // 첫 번째 키를 얻습니다.
  var firstKey = keys[0];

  // 첫 번째 위치 객체를 얻습니다.
  var firstLocation = locations[firstKey];

  // 첫 번째 위치의 lat과 lng 값을 얻습니다.
  var firstLat = firstLocation.lat;
  var firstLng = firstLocation.lng;

  // 지도를 표시할 div
  var mapContainer = document.getElementById("map");
  var mapOption = {
    center: new kakao.maps.LatLng(firstLat, firstLng), // 지도의 중심좌표
    level: 6, // 지도의 확대 레벨
  };

  // 지도를 생성합니다
  map = new kakao.maps.Map(mapContainer, mapOption);

//지도에 오버레이를 추가하는 부분을 수정합니다.
  for (var key in locations) {
    if (locations.hasOwnProperty(key)) {
      var location = locations[key];
      var position = new kakao.maps.LatLng(location.lat, location.lng);
      
      // 커스텀 오버레이에 표시할 내용을 설정합니다.
      var content = '<div class="center">' +
                       '<p>' + location.stayName + '</p>' + 
                       '<span>₩' + location.price + '</span>' +
                     '</div>';
                    

      // 커스텀 오버레이를 생성합니다.
      var customOverlay = new kakao.maps.CustomOverlay({
        map: map,
        position: position,
        content: content,
        yAnchor: 1
      });

      // 생성된 오버레이를 overlayMap 객체에 저장합니다.
      overlayMap[key] = customOverlay;
    }
  }

  // 지도 타입 변경 컨트롤을 생성한다
  var mapTypeControl = new kakao.maps.MapTypeControl();

  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

  // 지도에 확대 축소 컨트롤을 생성한다
  var zoomControl = new kakao.maps.ZoomControl();

  // 지도의 우측에 확대 축소 컨트롤을 추가한다
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

  let stayRequest = new XMLHttpRequest();
  const $rangeInput = $(".range-input input");
  const $priceInput = $(".price-input input");
  const $range = $(".slider .progress");
  let priceGap = 10000;

  // 숫자에 콤마를 추가하는 함수
  function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

  // 문자열에서 콤마를 제거하는 함수
  function removeCommas(str) {
    return parseInt(str.replace(/,/g, ""), 10);
  }

  $priceInput.on("input", function (e) {
    let minPrice = parseInt($priceInput.first().val().replace(/,/g, "")),
      maxPrice = parseInt($priceInput.last().val().replace(/,/g, ""));

    if (maxPrice - minPrice >= priceGap && maxPrice <= $rangeInput.last().prop("max")) {
      if ($(this).hasClass("input-min")) {
        $rangeInput.first().val(minPrice);
        $range.css("left", (minPrice / $rangeInput.first().prop("max")) * 100 + "%");
        $(this).val(numberWithCommas(minPrice));
      } else {
        $rangeInput.last().val(maxPrice);
        $range.css("right", 100 - (maxPrice / $rangeInput.last().prop("max")) * 100 + "%");
        $(this).val(numberWithCommas(maxPrice));
      }
    } else {
      $(this).val(numberWithCommas($(this).val().replace(/,/g, "")));
    }
  });

  $rangeInput.on("input", function () {
    let minVal = parseInt($rangeInput.first().val());
    let maxVal = parseInt($rangeInput.last().val());
    if (maxVal - minVal < priceGap) {
      if ($(this).hasClass("range-min")) {
        $rangeInput.first().val(maxVal - priceGap);
      } else {
        $rangeInput.last().val(minVal + priceGap);
      }
    } else {
      $priceInput.first().val(numberWithCommas(minVal));
      $priceInput.last().val(numberWithCommas(maxVal));
      $range.css("left", (minVal / $rangeInput.first().prop("max")) * 100 + "%");
      $range.css("right", 100 - (maxVal / $rangeInput.last().prop("max")) * 100 + "%");
    }
  });

  // 가격 입력 칸 blur 했을 때
  $priceInput.on("blur", function () {
    sendFilterRequest(collectFilterData());
  });

  // 가격 필터에서 mouseup 했을 때
  $rangeInput.on("mouseup", function () {
    sendFilterRequest(collectFilterData());
  });

  // input에 focus하면 전체 선택
  $priceInput.on("focus", function () {
    $(this).select();
  });

  // 리뷰 평점 바뀔 때 이벤트
  $(".rating").on("change", function () {
    sendFilterRequest(collectFilterData());
  });

  // 필터 바뀔 때 이벤트
  $(".options").on("change", function () {
    sendFilterRequest(collectFilterData());
  });
  
  $('#side-map').click(function(){
      $('#map').css('width','100vw');
      map.relayout();
      $('#map-close').show();
  })
  
  $('#map-close').click(function(){
      $('#map').css('width','933px');
      map.relayout();
      $(this).hide();      
  })  
});
