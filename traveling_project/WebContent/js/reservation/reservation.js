const clientKey = 'test_ck_6BYq7GWPVvGE7XOgAaELrNE5vbo1';
const customerKey  = 'TOAajBuGbbEdCLN9lqa3p';
const tossPayments = TossPayments(clientKey);
const payment = tossPayments.payment({ customerKey });
const localeKo = {
    days: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
    daysShort: ['일', '월', '화', '수', '목', '금', '토'],
    daysMin: ['일', '월', '화', '수', '목', '금', '토'],
    months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    today: '오늘',
    clear: '초기화',
    dateFormat: 'yyyy-MM-dd',
    timeFormat: 'HH:mm',
    firstDay: 0
};
let currentDay 			= 1;
let currentPeople 		= 0;
let totalRoomPrice 		= 0;
let totalPeoplePrice 	= 0;
let finalPrice 			= 0;
let roomPrice 			= 0;
let additionalPeople 	= 0;
let standardPeople 		= 0;
let extraPersonFee 		= 0;

$(document).ready(function () {
	currentPeople = Number($('#standard-people').val());
	roomPrice = Number($('#room-price').val());
	standardPeople = Number($('#standard-people').val());
	extraPersonFee = Number($('#extra-person-fee').val());
    const today = new Date();
    const tomorrow = addDays(today, 1);
    
    $("#check-in-date").text(formatDate(today));
    $("#check-out-date").text(formatDate(tomorrow));
    
    new AirDatepicker('#datepicker', {
    	startDate: today,
    	range: true,
        inline: true,
        locale: localeKo,
        minDate: today,
        onSelect({date, formattedDate}){
            // range 선택일 경우 배열로 들어옴
        	if(formattedDate.length == 2){
        		currentDay = (new Date(formattedDate[1]) - new Date(formattedDate[0])) / (1000 * 60 * 60 * 24);
        		$("#check-in-date").text(formattedDate[0]);
        	    $("#check-out-date").text(formattedDate[1]);
        	    $('#leave-stay').text(currentDay + '박 ' + (Number(currentDay) + 1 + "일"));
        	    calRoomPrice();
        	}
        },
        selectedDates: [today,tomorrow]
    });
    
    $('.people-change').click((e) => {
    	if(e.target.id.includes("minus")){
    		if(Number($('#guest-txt').text()) <= standardPeople) return; // 현재 인원이 기준 인원보다 적거나 같으면 return
    		$('#guest-txt').text(--currentPeople);
    		calRoomPrice();
    	}
    	if(e.target.id.includes("plus")){
    		if(Number($('#guest-txt').text()) >= Number($('#maximum-people').val())) return; // 현재 인원이 최대 인원보다 크거나 같으면 return
    		$('#guest-txt').text(++currentPeople);
    		calRoomPrice();
    	}
    	
    })
	
    $("#btnReservation").click(function () {
    	const reservation = {
    		roomId: $("#room-id").val(),
    		checkInDate: $("#check-in-date").text(),
            checkOutDate: $("#check-out-date").text(),
            checkInTime: $("#check-in-time").val(),
            checkOutTime: $("#check-out-time").val(),
            people: $("#guest-txt").text()
    	}
    	
    	// 1. 예약 초안 생성
    	$.ajax({
    		url: "/reservation/pending-create",
    		type: "POST",
    		dataType: "json",
    		data: {
    			reservation: JSON.stringify(reservation)
    		},
    		success: function(res){
    			const amount = Number(res.amount);
    			
    			if(isNaN(amount) || amount <= 0){
    				showModal('결제 오류','결제 금액이 올바르지 않습니다.');
    				return;
    			}
    			
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
							value: amount
						},
						orderId: res.orderId,
						orderName: res.orderName,
						successUrl: window.location.origin + "/reservation/payment-success",
						failUrl: window.location.origin + "/reservation/payment-fail",
				        customerName: res.customerName,
				        customerEmail: res.customerEmail,
				        customerMobilePhone: res.customerMobilePhone,
				        card: {
				            useEscrow: false,
				            flowMode: "DEFAULT",
				            useCardPoint: false,
				            useAppCardOnly: false
				        }
    			});
    		}
    	});
    });
    calRoomPrice();
});

function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

function addDays(date, days) {
    const newDate = new Date(date);
    newDate.setDate(newDate.getDate() + days);
    return newDate;
}

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
      successUrl: window.location.origin + "/reservation/payment?customer=" + encodedCustomer, // 결제 요청이 성공하면 리다이렉트되는 URL
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

function calRoomPrice(){
	totalRoomPrice = currentDay * roomPrice; // 객실 요금
	additionalPeople = currentPeople - standardPeople // 인원추가 요금
	totalPeoplePrice = additionalPeople * extraPersonFee; // 총 요금
	finalPrice = totalRoomPrice + totalPeoplePrice;
    $('#total_room_price').text('￦' + totalRoomPrice.toLocaleString());
    $('#total_pers_price').text('￦' + totalPeoplePrice.toLocaleString());
    $('#final-price').text('￦' + finalPrice.toLocaleString());
}