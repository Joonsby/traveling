const clientKey = 'test_ck_6BYq7GWPVvGE7XOgAaELrNE5vbo1';
const customerKey  = 'TOAajBuGbbEdCLN9lqa3p';
const tossPayments = TossPayments(clientKey);
const payment = tossPayments.payment({ customerKey });

$(document).ready(function () {
    $("#btnReservation").click(function () {
    	const reservation = {
    		roomId: $("#room-id").val(),
    		checkInDate: $("#check-in-date").text(),
            checkOutDate: $("#check-out-date").text(),
            people: $("#guest-txt").val()
    	}
    	
    	// 1. 예약 초안 생성
    	$.ajax({
    		url: "/webPage/reservation/ReservationServlet",
    		type: "POST",
    		dataType: "json",
    		data: {
    			requestType: "createPendingReservation",
    			reservation: JSON.stringify(reservation)
    		},
    		success: function(res){
    			if(res.result !== "SUCCESS"){
    				showModal('예약 생성 실패!','예약 생성에 실패 했습니다');
    				return;
    			}
    			
    			// 2. 결제창 호출
    			tossPayments.payment({ customerKey : "USER_" + Date.now() })
					.requestPayment({
						method: "CARD",
						amount: {
							currency: "KRW",
							value: res.amount
						},
						orderId: res.orderId,
						orderName: res.orderName,
						successUrl: window.location.origin + "/webPage/reservation/ReservationServlet?requestType=paymentSuccess",
						failUrl: window.location.origin + "/webPage/reservation/ReservationServlet?requestType=paymentfail"
    			});
    		}
    	});
    	
        /*const customer = {
            userId: $("#customer-id").val(),
            price: parseInt($("#final-price").text().replace(/[^0-9]/g, ""), 10),
            roomName: $("#room-name").text(),
            roomId: $("#room-id").val(),
            checkInDate: $("#check-in-date").text(),
            checkOutDate: $("#check-out-date").text(),
            people: parseInt($("#guest-txt").text(), 10),
            checkInTime: $("#check-in-time").val(),
            checkOutTime: $("#check-out-time").val()
        };*/
//        requestPayment(customer);
    });
});

function requestPayment(customer) {
    // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
    // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
	const encodedCustomer = encodeURIComponent(JSON.stringify(customer));
    payment.requestPayment({
      method: "CARD", // 카드 결제
      amount: {
        currency: "KRW",
        value: price,
      },
      orderId: "-cnUiTNaALH3VDDyxV8EW", // 고유 주문번호
      orderName: "토스 티셔츠 외 2건",
      successUrl: window.location.origin + "/webPage/reservation/ReservationServlet?requestType=payment&customer=" + encodedCustomer, // 결제 요청이 성공하면 리다이렉트되는 URL
      failUrl: window.location.origin + "/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
      customerEmail: "customer123@gmail.com",
      customerName: "김토스",
      customerMobilePhone: "01012341234",
      // 카드 결제에 필요한 정보
      card: {
        useEscrow: false,
        flowMode: "DEFAULT", // 통합결제창 여는 옵션
        useCardPoint: false,
        useAppCardOnly: false,
      },
    });
  }