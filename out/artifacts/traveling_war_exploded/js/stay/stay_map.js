var map;
var overlayMap = {};
var locations = {};

$(window).resize(function(){
  windowWidth = $(window).width();
  if(windowWidth > 1200){
    $("#map").show();
  }
});

function initStayMap() {
  locations = collectInitialLocations();

  var keys = Object.keys(locations);

  if (keys.length === 0) {
    console.warn("지도에 표시할 숙소 위치가 없습니다.");
    return;
  }

  createMap(locations[keys[0]]);
  addMapControls();
  createOverlays(locations);
}

function collectInitialLocations() {
  var result = {};

  $(".latitude").each(function (index, element) {
    var latitude = parseFloat(element.value);
    var longitude = parseFloat($(".longitude")[index].value);

    if (isNaN(latitude) || isNaN(longitude)) {
      return;
    }

    var key = latitude + "_" + longitude;

    result[key] = {
      lat: latitude,
      lng: longitude,
      stayName: $(".name-val")[index].value,
      price: Number($(".price-val")[index].value).toLocaleString()
    };
  });

  return result;
}

function createMap(firstLocation) {
  var mapContainer = document.getElementById("map");

  var mapOption = {
    center: new kakao.maps.LatLng(firstLocation.lat, firstLocation.lng),
    level: 6
  };

  map = new kakao.maps.Map(mapContainer, mapOption);
}

function addMapControls() {
  var mapTypeControl = new kakao.maps.MapTypeControl();
  map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

  var zoomControl = new kakao.maps.ZoomControl();
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
}

function createOverlays(locations) {
  removeOverlays();

  for (var key in locations) {
    if (!locations.hasOwnProperty(key)) {
      continue;
    }

    var position = locations[key];

    var content =
      '<div class="center">' +
        '<p>' + position.stayName + '</p>' +
        '<span>₩' + position.price + '</span>' +
      '</div>';

    var customOverlay = new kakao.maps.CustomOverlay({
      map: map,
      position: new kakao.maps.LatLng(position.lat, position.lng),
      content: content,
      yAnchor: 1
    });

    overlayMap[key] = customOverlay;
  }
}

function removeOverlays() {
  for (var key in overlayMap) {
    if (overlayMap.hasOwnProperty(key)) {
      overlayMap[key].setMap(null);
    }
  }

  overlayMap = {};
}

function bindMapLayoutEvents() {
  $("#side-map").on("click", function () {
    $("#map").css("width", "100vw");

    if (map) {
      map.relayout();
    }

    $("#map-close").show();
  });

  $("#map-close").on("click", function () {
    if(windowWidth > 1200){
      $("#map").css("width", "48%");
      if (map) map.relayout();
    } else{
        $("#map").hide();
    }
    $(this).hide();
  });
}