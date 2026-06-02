var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    draggable: false, // 지도를 생성할때 지도 이동 및 확대/축소를 막으려면 draggable: false 옵션을
    // 추가하세요
    level: 5, // 지도의 확대 레벨
  };
// 지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
// 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, "center_changed", function () {
  // 지도의 레벨을 얻어옵니다
  var level = map.getLevel();
  // 지도의 중심좌표를 얻어옵니다
  var latlng = map.getCenter();
  var latitude = latlng.getLat();
  var longitude = latlng.getLng();
  document.getElementById("latitudeInput").value = latitude;
  document.getElementById("longitudeInput").value = longitude;
});
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지도 타입 컨트롤을 지도에 표시합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
// 주소-좌표 변환 객체를 생성
var geocoder = new kakao.maps.services.Geocoder();
// 마커를 미리 생성
var marker = new daum.maps.Marker({
  position: new daum.maps.LatLng(33.450701, 126.570667),
  map: map,
});

function sample5_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function (data) {
      var addr = data.address; // 최종 주소 변수
      // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var roadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ""; // 참고 항목 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if (data.buildingName !== "" && data.apartment === "Y") {
        extraRoadAddr += extraRoadAddr !== "" ? ", " + data.buildingName : data.buildingName;
      }
      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if (extraRoadAddr !== "") {
        extraRoadAddr = " (" + extraRoadAddr + ")";
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById("sample4_postcode").value = data.zonecode;
      document.getElementById("sample4_roadAddress").value = roadAddr;
      document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

      // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
      if (roadAddr !== "") {
        document.getElementById("sample4_extraAddress").value = extraRoadAddr;
      } else {
        document.getElementById("sample4_extraAddress").value = "";
      }
      // 주소로 상세 정보를 검색
      geocoder.addressSearch(data.address, function (results, status) {
        // 정상적으로 검색이 완료됐으면
        if (status === daum.maps.services.Status.OK) {
          var result = results[0]; // 첫번째 결과의 값을 활용

          // 해당 주소에 대한 좌표를 받아서
          var coords = new daum.maps.LatLng(result.y, result.x);
          // 지도를 보여준다.
          mapContainer.style.display = "block";
          map.relayout();
          // 지도 중심을 변경한다.
          map.setCenter(coords);
          // 마커를 결과값으로 받은 위치로 옮긴다.
          marker.setPosition(coords);
        }
      });
    },
  }).open();
}

// 유효성 검사 jquery
$(document).ready(function () {    
    
  // 숙소 이름 blur
  $("#stay_name").blur(function () {
    if ($("#stay_name").val() == "") {
      $("#stay_name").addClass('border_change');
      $("#stay_name_text").css("display", "block");
    } else {
      $("#stay_name").removeClass('border_change');
      $("#stay_name_text").css("display", "none");
    }
  });

  // 주소 검색 클릭
  $("#addr_search").click(function () {
    $('.addr').removeClass('border_change')
    $("#addr_text").hide();
  });
  
  // 상세 주소 blur
  $('#sample4_detailAddress').blur(function(){
      $(this).removeClass('border_change');
      $('#addr_text').hide();
  })
  
  // 연락받을 전화번호 blur
  $("#host_phone").blur(function () {
    const phoneJ = /^01[016789]\d{3,4}\d{5}$/;
    const phoneValue = $("#host_phone").val();
    if (!phoneJ.test(phoneValue)) {
      $("#host_phone").addClass('border_change');
      $("#phone_text").css("display", "block");
    } else {
      $("#host_phone").removeClass('border_change');
      $("#phone_text").css("display", "none");
    }
  });
  
  //이미지 라벨 클릭
  $('.image_label').click(function(){
    $('#image_text').css('color','#1aa3ff');
    $('#image_text').css('font-weight','normal');
    $('#image_td').removeClass('border_change');
  });
  
  // 숙소 상세 정보 focus
  $('textarea').focus(function(){      
      $('textarea').removeClass('textarea_change');
  })
  
  // 등록하기 버튼 클릭
  $("#add_btn").click(function (e) {
    const stayNameVal = $('#stay_name').val();
    const postcodeVal = $('#sample4_postcode').val();
    const detailAddrVal = $('#sample4_detailAddress').val();
    const phoneVal = $('#host_phone').val();
    let emptyFields = 0;
    $('input[type="file"]').each(function() {
        if ($(this).val() === '') {
            emptyFields++;
        }
    });      
    if (stayNameVal == "") {
      e.preventDefault();
      $('html, body').animate({ scrollTop: 0 }, 'fast');
      $("#stay_name").addClass('border_change');
      $("#stay_name_text").css("display", "block");
    } else if (postcodeVal == "") {
      e.preventDefault();
      $('html, body').animate({ scrollTop: 0 }, 'fast');
      $('.addr').addClass('border_change')      
      $("#addr_text").css("display", "block");
    } else if(detailAddrVal == ""){
      e.preventDefault();
      $('html, body').animate({ scrollTop: 0 }, 'fast');
      $("#sample4_detailAddress").addClass('border_change');
      $('#addr_text').css("display","block");
      $('#addr_text').text("상세 주소를 입력해주세요.");
    } else if (phoneVal == "") {
      e.preventDefault();
      $('html, body').animate({ scrollTop: 200 }, 'fast');
      $("#host_phone").addClass('border_change')
      $("#phone_text").css("display", "block");
    } else if (emptyFields >= 3){
      e.preventDefault();
      $('html, body').animate({ scrollTop: 600 }, 'fast');
      $('#image_text').css('color','red');
      $('#image_text').css('font-weight','bold');
      $('#image_td').addClass('border_change')
    } else if ($('textarea').val() == ""){
      e.preventDefault();
      $('html, body').animate({ scrollTop: 860 }, 'fast');      
      $('textarea').addClass('textarea_change');
    }
  }); 

  function handleImageChange(input, label, removeBtn) {
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        label.css('background-image', `url(${e.target.result})`);
        label.css('background-size', 'contain');
        label.text('');
        removeBtn.show();
      };
      reader.readAsDataURL(file);
    } else {
      label.css('background', 'url(/traveling_project/images/image.png) no-repeat center/60px');
      label.text('이미지를 선택해주세요.');
      removeBtn.hide();
    }
  }

  function handleImageRemoval(input, label, removeBtn) {
    input.val('');
    label.css('background', 'url(/traveling_project/images/image.png) no-repeat center/60px');
    label.text('이미지를 선택해주세요.');
    removeBtn.hide();
  }
 
  for (let i = 1; i <= 5; i++) {
    const fileInput = $(`#image${i}`);
    const fileLabel = $(`#image_label${i}`);
    const removeBtn = $(`#remove_btn${i}`);

    fileInput.change(function () {
      handleImageChange(fileInput[0], fileLabel, removeBtn);
    });

    removeBtn.click(function () {
      handleImageRemoval(fileInput, fileLabel, removeBtn);
    });
  };
});


