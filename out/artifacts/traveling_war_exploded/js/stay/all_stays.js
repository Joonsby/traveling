let $rangeInput;
let $priceInput;
let $range;

const priceGap = 10000;

$(document).ready(function () {
  initElements();

  initStayMap();
  bindMapLayoutEvents();

  bindPriceInputEvents();
  bindRangeInputEvents();
  bindFilterEvents();
});

function initElements() {
  $rangeInput = $(".range-input input");
  $priceInput = $(".price-input input");
  $range = $(".slider .progress");
}

function bindPriceInputEvents() {
  $priceInput.on("input", function () {
    let raw = $(this).val().replace(/,/g, "");
    raw = raw.replace(/[^0-9]/g, "");

    if (raw === "") {
      $(this).val("");
      return;
    }

    $(this).val(formatPrice(raw));
  });

  $priceInput.on("blur", function () {
    normalizePriceInputs();
    sendFilterRequest(collectFilterData());
  });

  $priceInput.on("focus", function () {
    $(this).select();
  });
}

function bindRangeInputEvents() {
  $rangeInput.on("input", function () {
    let minVal = parseInt($rangeInput.first().val(), 10);
    let maxVal = parseInt($rangeInput.last().val(), 10);

    if (maxVal - minVal < priceGap) {
      if ($(this).hasClass("range-min")) {
        minVal = maxVal - priceGap;
        $rangeInput.first().val(minVal);
      } else {
        maxVal = minVal + priceGap;
        $rangeInput.last().val(maxVal);
      }
    }

    updatePriceUI(minVal, maxVal);
  });

  $rangeInput.on("change", function () {
    sendFilterRequest(collectFilterData());
  });
}

function bindFilterEvents() {
  $(".rating").on("change", function () {
    sendFilterRequest(collectFilterData());
  });

  $(".options").on("change", function () {
    sendFilterRequest(collectFilterData());
  });
}

function collectFilterData() {
  return {
    minPrice: $(".range-min").val(),
    maxPrice: $(".range-max").val(),
    rating: $(".rating:checked").val()
  };
}

function sendFilterRequest(filterData) {
  $.ajax({
    url: "/stay/filter",
    type: "POST",
    data: filterData,
    dataType: "json",
    success: function (data) {
      renderAccommodationList(data);
      createOverlays(convertToLocations(data));
    }
  });
}

function renderAccommodationList(data) {
  var accommodationBox = $("#accomodation_info_box");
  accommodationBox.empty();

  if (!Array.isArray(data)) {
    return;
  }

  data.forEach(function (item) {
    var formattedPrice = Number(item.min_room_price).toLocaleString();

    var accommodationHTML = `
      <div class="accomodation">
        <a href="/stay/detail?stay_id=${item.stayId}">
          <div class="accomodation_box">
            <div>
              <img class="image" src="/images/stay_images/${item.image1}" alt="이미지1" />
            </div>
            <div>
              <h2 class="stay-name">${item.stay_name}</h2>
              <p class="avg-rating">${item.avg_rating}</p>
              <p class="road-addr">${item.road_addr}</p>
              <p class="room-price">₩ ${formattedPrice} ~</p>
            </div>
          </div>
        </a>
      </div>`;

    accommodationBox.append(accommodationHTML);
  });
}

function convertToLocations(data) {
  var result = {};

  if (!Array.isArray(data)) {
    return result;
  }

  data.forEach(function (item) {
    var lat = parseFloat(item.latitude);
    var lng = parseFloat(item.longitude);

    if (isNaN(lat) || isNaN(lng)) {
      return;
    }

    var key = item.stayId || lat + "_" + lng;

    result[key] = {
      lat: lat,
      lng: lng,
      stayName: item.stay_name,
      price: Number(item.min_room_price).toLocaleString()
    };
  });

  return result;
}

function normalizePriceInputs() {
  const maxLimit = parseInt($rangeInput.last().prop("max"), 10);

  let minPrice = parsePrice($priceInput.first().val());
  let maxPrice = parsePrice($priceInput.last().val());

  if (minPrice < 0) {
    minPrice = 0;
  }

  if (maxPrice > maxLimit) {
    maxPrice = maxLimit;
  }

  if (maxPrice < minPrice + priceGap) {
    maxPrice = minPrice + priceGap;
  }

  if (maxPrice > maxLimit) {
    maxPrice = maxLimit;
    minPrice = maxLimit - priceGap;
  }

  updatePriceUI(minPrice, maxPrice);
}

function updatePriceUI(minPrice, maxPrice) {
  const maxLimit = parseInt($rangeInput.last().prop("max"), 10);

  $priceInput.first().val(formatPrice(minPrice));
  $priceInput.last().val(formatPrice(maxPrice));

  $rangeInput.first().val(minPrice);
  $rangeInput.last().val(maxPrice);

  $range.css("left", (minPrice / maxLimit) * 100 + "%");
  $range.css("right", 100 - (maxPrice / maxLimit) * 100 + "%");
}

function formatPrice(value) {
  return Number(value).toLocaleString();
}

function parsePrice(value) {
  const num = parseInt(String(value).replace(/,/g, ""), 10);
  return isNaN(num) ? 0 : num;
}