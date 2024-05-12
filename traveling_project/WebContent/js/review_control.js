$(document).ready(function() {
	$.ajax({
		url : "user_review_info.jsp",
		dataType : "html",
		success : function(data) {
			$("#review_list").html(data);
		}
	});
	
	let initialValues = {};

	  // 초기 상태 저장
	  function saveInitialValues() {
	    initialValues.rtitle = $("#rtitle").val();
	    initialValues.rcontent = $("#rcontent").val();

	    $("input.r_images").each(function(i) {
	      initialValues[`r_image${i + 1}`] = $(this).val();
	    });

	    initialValues.rating = $("input[name='rating']:checked").val();
	    
	    // 초기 상태에서 이미지 URL을 저장
	    initialValues.imageURLs = [];
	    $(".r_image_label").each(function() {
	      initialValues.imageURLs.push($(this).css('background-image'));
	    });
	  }
	
	// 수정 버튼 클릭 시
	$("#r_modi_btn").click(function() {
		if (confirm("수정 버튼을 누르면 등록된 이미지는 삭제됩니다. 수정하시겠습니까?")) {
			// 입력 필드를 수정 가능하게 만들고 수정 버튼을 비활성화
			$("#r_modi_btn").hide();
			$("#r_can_btn").hide();
			$("#r_modi_save_btn").show();
			$("#r_modi_can_btn").show();
			$("#rtitle, #rcontent, .r_images, input[name='rating']").prop("disabled", false);
			saveInitialValues();
			$(".r_images").val("");
			$(".r_image_label").css('background', 'url(/traveling_project/images/image.png) no-repeat center/60px');
			$(".r_image_label").text('이미지를 선택해주세요.');
		}
	});
	
	// 모달 닫기 오른쪽 위 X
	$("#r_can_btn").click(function() {
		if (confirm("저장되지 않은 정보는 복원할 수 없습니다. 종료하시겠습니까?")) {
			$("#r_modi_btn").show();
			$("#r_can_btn").show();
			$("#r_modi_save_btn").hide();
			$("#r_modi_can_btn").hide();
			$(".review_modal_wrap").hide();
			$("body").css("overflow", "auto");
		}
	});
	
	// 취소 버튼
	$("#r_modi_can_btn").click(function() {
		if (confirm("저장되지 않은 정보는 복원할 수 없습니다. 취소하시겠습니까?")) {
			$("#r_modi_btn").show();
			$("#r_can_btn").show();
			$("#r_modi_save_btn").hide();
			$("#r_modi_can_btn").hide();
			// 초기 상태로 복원
		    $("#rtitle").val(initialValues.rtitle);
		    $("#rcontent").val(initialValues.rcontent);
		    $("input[name='rating'][value='" + initialValues.rating + "']").prop("checked", true);
		    $("#rtitle, #rcontent, .r_images, input[name='rating']").prop("disabled", true);
		    
		    $(".r_images").val('');
		    $(".r_image_label").css('background', 'url(/traveling_project/images/image.png) no-repeat center/60px');
		    $(".r_image_label").text('이미지를 선택해주세요.');
		    
		    $(".r_images").val('');
		    $(".r_image_label").each(function(i) {
		        $(this).css('background-image', initialValues.imageURLs[i]);
		        $(this).text('');
		      });
		    $(".r_remove_btn").hide();
		}
	});
});


// 리뷰 삭제하기 버튼 함수
function delete_review(event) {
	if (confirm("삭제된 리뷰는 복원이 불가능합니다. 삭제하시겠습니까?")) {
		// 클릭한 작성하기 버튼 요소를 선택
		var $button = $(event.target);
		// 삭제할 리뷰 요소의 부모 <li> 요소를 선택
	    var $reviewItem = $button.closest("ul.index_list");
		// data-reservation_id 속성 값을 가져옴
		var reservationId = $button.data("reservation_id");
		
		$.ajax({
			url : "delete_review.jsp",
			data : {
				reservationId : reservationId
			},
			success: function(data) {
				$.ajax({
					url : "user_review_info.jsp",
					success : function(data) {
						$("#review_list").html(data);
					}
				});
			}
		});
	}
}

// 리뷰 상세보기 버튼 함수
function replace(event) {
	// 클릭한 작성하기 버튼 요소를 선택
	var $button = $(event.target);	
	// data-reservation_id 속성 값을 가져옴
	var reservationId = $button.data("reservation_id");
	
	$.ajax({
		url : "replace_review.jsp",
		data : {
			reservationId : reservationId
		},
		dataType : "HTML",
		success : function(data) {
			var rtitle = $(data).find("#riv_title").text();
			var rcontent = $(data).find("#riv_content").text();
			var rating = $(data).find("#riv_rating").text();		
			
			// 클릭한 작성하기 버튼이 속한 ul 요소를 찾기 위해 가장 가까운 부모 ul을 선택
			var $reservationInfo = $button.closest("ul.index_list");
			
			// ul 요소 내에서 이미 가져온 데이터를 읽음
			var stayName = $reservationInfo.find(".r_stay_name").text();
			var chkDate = $reservationInfo.find(".r_chk_date").text();
			
			// 모달에 예약 정보 추가
			$("#rid_hidden").val(reservationId);
			$("#rm_header p").text(stayName);
			$("#rm_header span").text(chkDate);
			$("#rtitle").val(rtitle);
			$("#rcontent").val(rcontent);
			
			for (var i = 1; i <= 5; i++) {
				var rimg = $(data).find("#riv_img" + i).attr("src");
				var $imageLabel = $("#r_image_label" + i);
				var $imageInput = $("#r_image" + i);
				var $removeButton = $("#review_remove_btn" + i);
				
				// 이미지 파일 경로 가져오기
				var imagePath = rimg; // 예: rimg1, rimg2, ...
				
				if (imagePath == "/traveling_project/images/review/null") {
					$imageLabel.css('background', 'url(/traveling_project/images/image.png) no-repeat center/60px');
			    	$imageLabel.text('');
			    	$removeButton.hide();
				} else {
					$imageLabel.css("background-image", "url(" + imagePath + ")");
					$imageLabel.css("background-size", "contain");
					$imageLabel.text(""); // 이미지 선택 안내 텍스트를 지웁니다.
					$removeButton.hide(); // Remove 버튼 표시
				}
			}
			
			// rating 변수에 따라 라디오 버튼 선택
			switch (rating) {
			  case "5.0":
			    $("#5-stars").prop("checked", true);
			    break;
			  case "4.0":
			    $("#4-stars").prop("checked", true);
			    break;
			  case "3.0":
			    $("#3-stars").prop("checked", true);
			    break;
			  case "2.0":
			    $("#2-stars").prop("checked", true);
			    break;
			  case "1.0":
			    $("#1-star").prop("checked", true);
			    break;
			  default:
			    // 선택된 라디오 버튼이 없는 경우
			    break;
			}
		
			// 모달 열기
			$(".review_modal_wrap").show();
			$("body").css("overflow", "hidden");
			$("#rtitle, #rcontent, .r_images, input[name='rating']").prop("disabled", true);
		}
	});
}
