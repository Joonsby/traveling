$(document).ready(function () {
	
	// 모달 닫기 취소 버튼
	$("#payment-cancel").click(function() {
		if (confirm("결제를 취소하시겠습니까?")) {
			$("#toss-modal-wrap").hide();
			$("body").css("overflow", "auto");
		}
	});
	
	// '예약하기' 버튼 이벤트 리스너 초기화
    $("#reservation-next").click(function () {
    	// 모달 열기
        $("#toss-modal-wrap").show();
        $("body").css("overflow", "hidden");
    	
        // 객체 만들어서 DB insert 및 결제창 넘길 용도
        const customer = {
            uid: $("#customer-id").val(),
            price: parseInt($("#final-price").text().replace(/[^0-9]/g, ""), 10),
            rname: $("#room-name").text(),
            rid: $("#room-id").val(),
            chk_in: $("#check-in-date").text(),
            chk_out: $("#check-out-date").text(),
            people: parseInt($("#guest-txt").text(), 10),
            chk_in_time: $("#check-in-time").val(),
            chk_out_time: $("#check-out-time").val()
        };
        
        requestPayment(customer);
    });
	
});

// 고객id 생성 로직
function generateRandomCustomer() {
	  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_=.@';
	  const minLength = 2;
	  const maxLength = 50;

	  // 문자열 길이를 무작위로 선택 (최소 2자 이상)
	  const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;

	  let randomCustomer = '';

	  // 최소 1개 이상의 대소문자, 숫자, 특수문자 포함
	  randomCustomer += characters.charAt(Math.floor(Math.random() * characters.length));
	  randomCustomer += characters.charAt(Math.floor(Math.random() * characters.length));

	  // 나머지 문자를 무작위로 선택
	  for (let i = 2; i < length; i++) {
	    randomCustomer += characters.charAt(Math.floor(Math.random() * characters.length));
	  }

	  return randomCustomer;
	}

// 주문id 생성 로직
function generateRandomOrder() {
	  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_=';
	  const minLength = 6;
	  const maxLength = 64;

	  // 문자열 길이를 무작위로 선택 (최소 6자 이상)
	  const length = Math.floor(Math.random() * (maxLength - minLength + 1)) + minLength;

	  let randomOrder = '';

	  // 문자 선택
	  for (let i = 0; i < length; i++) {
	    randomOrder += characters.charAt(Math.floor(Math.random() * characters.length));
	  }

	  return randomOrder;
	}



function requestPayment(customer) {
	const clientKey = 'test_ck_EP59LybZ8BddpojElBbV6GYo7pRe' // 테스트용 클라이언트 키
	const secretKey = 'test_sk_GjLJoQ1aVZJJpdPjyR1Vw6KYe2RN'
	const customerKey = generateRandomCustomer(); // 내 상점에서 고객을 구분하기 위해 발급한 고객의 고유 ID
	const button = document.getElementById("payment-btn")
	const orderId = generateRandomOrder();
				
	// 2. 결제위젯 SDK 초기화
	const paymentWidget = PaymentWidget(clientKey, customerKey) // 회원 결제
	// const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS) // 비회원 결제
	
	// JSON 형태로 데이터를 문자열로 변환
    const customerJsonString = JSON.stringify(customer);

    // encodeURIComponent를 사용하여 URL 파라미터로 안전하게 추가
    const encodedCustomer = encodeURIComponent(customerJsonString);
				
	const paymentMethodsWidget = paymentWidget.renderPaymentMethods(
			'#toss-window', {
				value : customer.price,
				currency : 'KRW',
				country : 'KR',
			}, {
				variantKey : 'DEFAULT'
			})
	button.addEventListener("click", function () {
		paymentWidget.requestPayment({
			orderId: orderId,
			orderName: customer.rname,                 
			successUrl: window.location.origin + "/traveling_project/pay_success.jsp?customer=" + encodedCustomer,
			failUrl: window.location.origin + "/fail",
			customerEmail: "customer123@gmail.com",
			customerName: customer.uid
		})
	})	
}