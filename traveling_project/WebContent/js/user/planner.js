$(document).ready(function() {
	
	// 원래 상태를 저장할 객체
	var originalState = {};

	// 수정 버튼 클릭 시
	$("#modi_btn").click(function() {
		// 원래의 일정 상태를 저장합니다.
        originalState.schedules = $(".schedule").map(function() {
            return $(this).clone(); // 각 일정의 복제본을 저장합니다.
        }).get();
		$("#modi_btn").hide();
		$("#can_btn").hide();
		$("#modi_save_btn").show();
		$("#modi_can_btn").show();
		$(".days_btn button").show();
		$(".dsch input").prop("disabled", false);
		$(".nonetext").remove();
	});

	// 수정 -> 취소 버튼 클릭 시
	$("#modi_can_btn").click(function() {
		if (confirm("저장되지 않은 정보는 삭제됩니다. 취소하시겠습니까?")) {
			// 저장된 원래의 일정 상태로 복원합니다.
            $(".schedule").each(function(index) {
                $(this).replaceWith(originalState.schedules[index]); // 각 일정을 원래 상태로 교체합니다.
            });
			$("#modi_btn").show();
			$("#can_btn").show();
			$("#modi_save_btn").hide();
			$("#modi_can_btn").hide();
			$(".days_btn button").hide();
			$(".dsch input").prop("disabled", true);
		}
	});

	// close 버튼 (X) 또는 종료 버튼 클릭 시
	$(".close_btn, #can_btn").click(function() {
		if (confirm("저장되지 않은 정보는 삭제됩니다. 종료하시겠습니까?")) {
			$(".planner_modal_wrap").hide();
			$("#modi_btn").show();
			$("#can_btn").show();
			$("#modi_save_btn").hide();
			$("#modi_can_btn").hide();
			$('body').css('overflow', 'auto');
			$("#date_tabs").empty();
			history.pushState(null, null, window.location.href.split('#')[0]); // 모달창을 닫으면 url에 남아있던 브라우저 기록을 지워줌
		}
	});
	
	/*// 저장 버튼 클릭 시
	$("#modi_save_btn").click(function() {
		if (confirm("저장하시겠습니까?")) {
		$("#modi_btn").show();
		$("#can_btn").show();
		$("#modi_save_btn").hide();
		$("#modi_can_btn").hide();
		$(".days_btn button").hide();
		$(".dsch input").prop("disabled", true);
		// INSERT 할 때 필요한 plan_id 값을 가져옴
        var pid = $("#pid_hidden").val();
        
		$.ajax({
			url: "delete_plan.condb?comm=delPlan",
			method: "POST",
			data: {
				pid : pid
			},
			success: function(res) {
				 비동기 방식으로 데이터 처리할 예정 
				$(".dsch").each(function() {
			        var schedule = $(this);

			        // 특정 .dsch 요소 안에서 필드 값을 가져옵니다.
			        var pdate = schedule.find(".pdate").val();
			        var pst = schedule.find(".pst").val();
			        var pet = schedule.find(".pet").val();
			        var pcon = schedule.find(".pcon").val();
			        
			        $.ajax({
			        	url: "insert_plan.condb?comm=insPlan",
			        	method: "POST",
			        	data: {
			        		pid : pid,
			        		pdate : pdate,
			        		pst : pst,
			        		pet : pet,
			        		pcon : pcon
			        	},
			        	success: function(res) {
			        		// 삭제 및 삽입 작업이 성공한 후에 업데이트 작업 수행
		                    $.ajax({
		                        url: "update_plan.condb?comm=upPlan",
		                        method: "POST",
		                        data: {
		                            pid: pid
		                        },
		                        success: function (updateResult) {

		                        }
		                    });
		                }
			        });  
			    });
			}
		});
		alert("저장되었습니다.");

		}
		
	});*/
	
	// 저장 버튼 클릭 시
	$("#modi_save_btn").click(function() {
	    if (confirm("저장하시겠습니까?")) {
	        var pid = $("#pid_hidden").val(); // plan_id 값을 가져옴
	        
	        // 먼저 일정을 삭제하는 AJAX 요청
	        $.ajax({
	            url: "delete_plan.condb?comm=delPlan",
	            type: "POST",
	            data: { pid: pid },
	            success: function(response) {
	                // 여기에서 새 일정을 삽입하는 AJAX 요청을 합니다.
	                insertSchedules(pid, function() {
	                    // 모든 AJAX 호출이 성공한 후 UI를 원래 상태로 되돌립니다.
	                    $("#modi_btn").show();
	                    $("#can_btn").show();
	                    $("#modi_save_btn").hide();
	                    $("#modi_can_btn").hide();
	                    $(".days_btn button").hide();
	                    $(".dsch input").prop("disabled", true);
	                    alert("저장되었습니다."); // 성공 메시지
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error("Delete error:", status, error);
	            }
	        });
	    }
	});

	function insertSchedules(planId, callback) {
		// 각 .dsch 요소에 대해 반복
	    var isAllSuccess = true;
	    $(".dsch").each(function() {
	        var schedule = $(this);
	        var pdate = schedule.find(".pdate").val();
	        var pst = schedule.find(".pst").val();
	        var pet = schedule.find(".pet").val();
	        var pcon = schedule.find(".pcon").val();
	        
	        // 새 일정을 삽입하는 AJAX 요청
	        $.ajax({
	            url: "insert_plan.condb?comm=insPlan",
	            type: "POST",
	            data: {
	                pid: planId,
	                pdate: pdate,
	                pst: pst,
	                pet: pet,
	                pcon: pcon
	            },
	            success: function(response) {
	                // 삽입 성공 후, 일정을 업데이트하는 AJAX 요청을 할 수 있습니다.
	                updateSchedule(planId);
	            },
	            error: function(xhr, status, error) {
	                console.error("Insert error:", status, error);
	                isAllSuccess = false;
	            }
	        });
	    });
	    
	    // 모든 ajax 요청이 성공한 경우 callback 함수를 호출합니다.
	    if (isAllSuccess) {
	    	callback();
	    }
	}

	function updateSchedule(planId) {
	    // 일정을 업데이트하는 AJAX 요청
	    $.ajax({
	        url: "update_plan.condb?comm=upPlan",
	        type: "POST",
	        data: { pid: planId },
	        success: function(response) {
	            // 업데이트 성공 후 할 작업
	            console.log("Update success:", response);
	        },
	        error: function(xhr, status, error) {
	            console.error("Update error:", status, error);
	        }
	    });
	}

	
	// 이벤트 위임을 사용하여 "추가하기" 버튼 클릭 이벤트 처리
    $(".tab_list").on("click", ".add_schedule", function() {
        var activeTab = $(".tabDay.is_on");
        var tabId = activeTab.attr("data-tab");

        // 현재 선택된 탭에서 이미 추가된 스케줄의 개수를 계산
        var existingSchedules = $("#" + tabId).find(".schedule > div").length;

        // 현재 탭에서 스케줄의 개수에 1을 더해 "currentDay" 값을 설정
        currentDay = existingSchedules + 1;

        if (currentDay > 10) {
            return; // 더 이상 스케줄을 추가하지 않음
        }

        addScheduleToActiveTab(activeTab, currentDay);
    });
    
    // 체크박스로 삭제
    $(".tab_list").on("click", ".del_schedule", function () {
        // 삭제할 스케줄 요소를 모두 선택
        var schedulesToDelete = $(".tabDay.is_on").find(".delete_box:checked").closest(".dsch");

        // 선택한 스케줄 삭제
        schedulesToDelete.remove();
        
        // 스케줄 번호를 다시 업데이트
        var tabId = $(".tabDay.is_on").attr("data-tab");

        // 남은 항목들을 재배열
        var tabNumber = 1;
        
        // 이미지 파일 이름 생성
        var imageFileName = tabNumber + "_" + tabId;
        
        $("#" + tabId).find(".dsch").each(function() {
        	// 클래스 이름 숫자 변경
        	var schedule = $(this);
            var currentClass = schedule.attr("class");
            var newClass = currentClass.replace(/detail_sch\d+/, "detail_sch" + tabNumber);
            schedule.attr("class", newClass);
            // 이미지 파일 변경
            var imgTag = $(this).find("img");
            var imageFileName = tabNumber + "_" + tabId;
            imgTag.attr("src", "images/number/" + imageFileName + ".png");
            tabNumber++;
        });
    });

});

function createDaysTabs(countDays, checkInDate, planId) {
	for (var i = 0; i < countDays; i++) {
	    var j = i + 1;
	    tabnum = "<li class='tabDay' data-tab='day" + j + "'>"
	        + "<a href='#day" + j + "' class='tab_btn'>" + j + "일차</a>"
	        + "<div id='day" + j + "' class='tab_cont'>"
	        + "<p class='plan_days'>" + j + "일차 <span class='ndate'>" + formatCheckinDate(checkInDate) + "</span>"
	        + "<div class='days_btn'><button type='button' class='add_schedule'>추가하기</button>"
	        + "<button type='button' class='del_schedule'>삭제하기</button></div></p>"
	        + "<div class='schedule sch" + j + "'></div></div>";
	    $(".tab_list").append(tabnum);
	    if (j == 1) {
			$(".tabDay").addClass("is_on");
		}
	    
	    // 클로저를 사용하여 현재 반복 변수 'j'를 보존
	    (function (currentTab) {
	        // AJAX 요청을 수행
	        $.ajax({
	            url: "planner.condb?comm=plan_sel",
	            method: "POST",
	            data: {
	                planId: planId,
	                planDate: formatCheckinDate(checkInDate)
	            },
	            success: function (response) {
	                response = $(response);
	                
	                if (response.size() == 0) {
	                	var nonSchedule = 
	                		`<div class='dsch nonetext'>
	                			<p>등록된 상세 일정이 없습니다. 수정 버튼을 눌러 일정을 추가해보세요.</p>
	                		</div>`
	                	$(".schedule.sch" + currentTab).append(nonSchedule);
	                }

	                for (var x = 0; x < response.size(); x++) {
	                    var a = 1;
	                    var pdate = response.find("#ajax_pdate" + x).html();
	                    var pst = response.find("#ajax_pst" + x).html();
	                    var pet = response.find("#ajax_pet" + x).html();
	                    var pcont = response.find("#ajax_pcont" + x).html();

	                    var newSchedule = '<div class="dsch detail_sch' + (x + 1) + '">' +
	                    	'<input type="hidden" class="pdate" value="' + pdate + '">' +
	                        '<img src="images/number/' + (x + 1) + '_day' + currentTab + '.png" alt="" width="36px" height="36px">' +
	                        '<input type="time" class="pst" value="' + pst + '"> ~ <input type="time" class="pet" value ="' + pet + '"><br>' +
	                        '<input type="checkbox" class="delete_box" name="delete_box">' +
	                        '<input type="text" class="pcon" maxlength="100" value="' + pcont + '">' +
	                        '</div>';

	                    $(".schedule.sch" + currentTab).append(newSchedule);

	                }

	                $(".dsch input").prop("disabled", true);
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                // 에러 처리
	                console.error("AJAX 오류:", textStatus, errorThrown);
	            }
	        });
	    })(j); // 클로저로 'j' 변수 보존
	    
	    // 하루씩 늘리기
	    checkInDate.setDate(checkInDate.getDate() + 1);
	}
}

// 상세보기 버튼 클릭
function detail_plan(event) {
	// 클릭한 상세보기 버튼 요소를 선택
	var $button = $(event.target);

	// 클릭한 상세보기 버튼이 속한 ul 요소를 찾기 위해 가장 가까운 부모 ul을 선택
	var $reservationInfo = $button.closest("ul.planner_list");

	// data-plan_id 속성 값을 가져옴
	var planId = $button.data("plan_id");
    
    var countDays = parseInt($reservationInfo.find(".planner_trip_date").data("days_count"), 10);
	
	// .planner_trip_date 클래스를 가진 요소의 텍스트 가져오기
	var tripDateText = $reservationInfo.find(".planner_trip_date").text();

	// "체크인 날짜 ~ 체크아웃 날짜" 형식의 텍스트를 공백 문자(~)로 분리
	var dateParts = tripDateText.split("~");

	// 체크인 날짜 추출하고 공백을 제거
	var checkInDateStr = dateParts[0].trim();

	// 체크인 날짜를 JavaScript Date 객체로 변환
	var checkInDate = new Date(checkInDateStr);
	
	// '일자별 탭'을 생성하는 함수 호출
    createDaysTabs(countDays, checkInDate, planId);
    
    // '지도로 보기' 탭 추가
    var mapTab = "<li class='tabDay' data-tab='map_tab'>" +
        "<a href='#map_tab' class='tab_btn'>지도</a>" +
        "<div id='map_tab' class='tab_cont'>" +
        "<div id='map' style='width:660px; height:500px'></div>" +
        "</div></li>";
    $(".tab_list").append(mapTab);
	
	// 탭 버튼
	$("ul.tab_list li").click(function() {
		var activeTab = $(this).attr("data-tab"); // ex) day1
		var isMapLoaded = false;
		$("ul.tab_list li").removeClass("is_on");
		$(".tab_cont").removeClass("is_on");
		$(this).addClass("is_on");
		$("#" + activeTab).addClass("is_on");
		
		// 지도 탭이 클릭되었을 때 loadmap 함수 호출
		if(activeTab === 'map_tab' && !isMapLoaded) {
			loadmap();
			isMapLoaded = true;
		}
		
		// 버튼 활성화 여부 설정
        var activeTabSchedules = $("#" + activeTab).find(".schedule > div").length;
        if (activeTabSchedules >= 10) {
            $(".add_schedule").prop("disabled", true);
            $(".add_schedule").css({
                "cursor": "auto",
                "background-color": "#E9E9E9"
            });
        } else {
            $(".add_schedule").prop("disabled", false);
            $(".add_schedule").css({
                "cursor": "pointer",
                "background-color": "#007BFF"
            });
        }
	});

	// ul 요소 내에서 이미 가져온 데이터를 읽음
	var stayName = $reservationInfo.find(".p_stay_name").text();
	var chkDate = $reservationInfo.find(".planner_trip_date").text();

	// 모달에 예약 정보 추가
    $("#pid_hidden").val(planId);
	$("#pm_header p").text(stayName);
	$("#pm_header span").text(chkDate);

	// 모달 열기
	$('.planner_modal_wrap').show();
	$('body').css('overflow', 'hidden');
	
}

function formatCheckinDate(date) {
    // 날짜를 "yyyy-MM-dd" 형식으로 포맷팅
    return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
}

// 일정 추가하기 버튼 - 함수
function addScheduleToActiveTab(activeTab, currentDay) {
    activeTab = $(activeTab); // JavaScript DOM 요소를 jQuery 객체로 변환

    // 선택된 탭에 대한 일정을 추가
    var tabId = activeTab.attr("data-tab");
    var pdate = activeTab.find(".ndate").html();
    var tabNumber = currentDay;

    // 이미지 파일 이름 생성
    var imageFileName = tabNumber + "_" + tabId;

    var newSchedule = '<div class="dsch detail_sch' + tabNumber + '">' +
    	'<input type="hidden" class="pdate" value="' + pdate  + '">' +
        '<img src="images/number/' + imageFileName + '.png" alt="" width="36px" height="36px">' +
        '<input type="time" class="pst"> ~ <input type="time" class="pet"><br>' +
        '<input type="checkbox" class="delete_box" name="delete_box">' +
        '<input type="text" class="pcon" maxlength="100" placeholder="내용은 100자 이내로 입력해주세요.">' +
        '</div>';

    $("#" + tabId).find(".schedule").append(newSchedule);
}

function loadmap() {
	// 지도 API
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    
    // 마커 이미지는 해당 스케줄의 이미지를 사용
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
    //마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    // 마커가 표시될 위치에 추가한 장소의 위도, 경도 값을 가져와 넣어줌
    markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

    //마커를 생성합니다
    var marker = new kakao.maps.Marker({
    position: markerPosition, 
    image: markerImage // 마커이미지 설정 
    });

    //마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
}
