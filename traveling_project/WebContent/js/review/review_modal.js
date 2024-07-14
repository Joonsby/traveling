$(document).ready(function() {

    // 모달 닫기 오른쪽 위 X
    $(".close_btn").click(function() {
        if (confirm("저장되지 않은 정보는 복원할 수 없습니다. 종료하시겠습니까?")) {
            $(".review_modal_wrap").hide();
            $("body").css("overflow", "auto");
            $("#review_form")[0].reset();
        }
    });

    // 모달 닫기 취소 버튼
    $("#can_btn").click(function() {
        if (confirm("저장되지 않은 정보는 복원할 수 없습니다. 취소하시겠습니까?")) {
            $(".review_modal_wrap").hide();
            $("body").css("overflow", "auto");
            $("#review_form")[0].reset();
        }
    });

    for (let i = 1; i <= 5; i++) {
        const fileInput = $(`#r_image${i}`);
        const fileLabel = $(`#r_image_label${i}`);
        const removeBtn = $(`#review_remove_btn${i}`);

        fileInput.change(function() {
            handleImageChange(fileInput[0], fileLabel, removeBtn);
        });

        removeBtn.click(function() {
            handleImageRemoval(fileInput, fileLabel, removeBtn);
        });
    }
    ;

    function handleImageChange(input, label, removeBtn) {
        const file = input.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
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

    // 제목, 내용, 별점이 입력되지 않았으면 submit 안되도록
    $("#review_form").submit(function(event) {
        // 제목, 내용, 별점 값 가져오기
        var rtitle = $("#rtitle").val();
        var rcontent = $("#rcontent").val();
        var rating = $("input[name='rating']:checked").val();

        // 제목, 내용, 별점이 비어있는 경우 제출 방지
        if (rtitle === "" || rcontent === "" || rating === undefined) {
            alert("제목, 내용, 별점을 모두 입력해주세요.");
            event.preventDefault(); // 폼 제출 방지
        }
    });
});

function modal(event) {
    // 클릭한 작성하기 버튼 요소를 선택
    var $button = $(event.target);

    // 클릭한 작성하기 버튼이 속한 ul 요소를 찾기 위해 가장 가까운 부모 ul을 선택
    var $reservationInfo = $button.closest("ul.index_list");

    // data-reservation_id 속성 값을 가져옴
    var reservationId = $button.data("reservation_id");
    // ul 요소 내에서 이미 가져온 데이터를 읽음
    var stayName = $reservationInfo.find(".r_stay_name").text();
    var chkDate = $reservationInfo.find(".r_chk_date").text();

    // 모달에 예약 정보 추가
    $("#rid_hidden").val(reservationId);
    $("#rm_header p").text(stayName);
    $("#rm_header span").text(chkDate);

    // 모달 열기
    $(".review_modal_wrap").show();
    $("body").css("overflow", "hidden");
}
