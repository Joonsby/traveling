$(document).ready(function() {
    
    $(".accept_btn").click(function(){      
      var tr = $(this).closest('tr');
      var reservationId = tr.find('input[type="hidden"]').val();
      if(confirm("예약 번호는[" + reservationId + "]입니다 \n예약을 확정하시겠습니까?")){          
          location.href="reservationUpdate.jsp?reservationId=" + reservationId 
      }
    });
    
    $(".reject_btn").click(function(){        
        var tr = $(this).closest('tr');
        var reservationId = tr.find('input[type="hidden"]').val();
        if(confirm("예약 번호는[" + reservationId + "]입니다 \n예약을 거부하시겠습니까?")){          
            location.href="reservationUpdate.jsp?cancelId=" + reservationId 
        }
      });

    // 승인 버튼
    $(".accept_btn").click(function() {
        $("#accept_modal").fadeIn(100);
        $("#background_overlay").show();
    });
    // 거부 버튼
    $('.reject_btn').click(function() {
        $('#reject_modal').fadeIn(100);
        $("#background_overlay").show();
    });
    // 모달창 확인 버튼
    $(".accept").click(function() {
        $("#accept_modal").fadeOut(100);
        $("#background_overlay").hide();
    })
    // 모달창 취소 버튼
    $('.btn').click(function() {
        $(".modal").fadeOut(100);
        $("#background_overlay").hide();
    });
    // 모달창 닫기 버튼
    $('.modal span').click(function() {
        $(".modal").fadeOut(100);
        $("#background_overlay").hide();
    })

});