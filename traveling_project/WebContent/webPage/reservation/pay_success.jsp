<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/webPage/header/header.jsp"%>
<c:set var="reservationInfo" value="${reservationInfo}"/>
<!DOCTYPE html>
<html>
<head>
<title>예약 완료</title>
<link rel="stylesheet" href="<c:url value="/css/pay_success.css"/>" />
</head>
<body>
	<section id="success-reservation">
		<div id="notice-reservation-wrap">
			<div id="notice-reservation">
				<h1>예약이 완료되었습니다.</h1>
				<p>호스트가 수락하면 예약이 확정됩니다.<br> 상세 내용은 마이페이지에서 확인 가능합니다.</p>
				<p class="reservation-info">
					<strong>숙소 이름 : </strong><c:out value="${reservationInfo.stayName}"/></p>
				<p class="reservation-info"><strong>체크인 날짜 : </strong><c:out value="${reservationInfo.checkInDate}"/></p>
				<p class="reservation-info"><strong>체크 아웃 날짜 : </strong><c:out value="${reservationInfo.checkOutDate}"/></p>
				<p class="reservation-info"><strong>예약자 성함 : </strong><c:out value="${reservationInfo.name}"/></p>
				<p class="reservation-info"><strong>객실 이름 : </strong><c:out value="${reservationInfo.roomName}"/></p>
				<p class="reservation-info"><strong>인원 수:</strong><c:out value="${reservationInfo.people}"/></p>
				<p class="reservation-info"><strong>결제 금액 :</strong> ₩ <fmt:formatNumber value="${reservationInfo.price}"/></p>
			</div>
			<div id="go-mypage">
				<a href="index.jsp" id="go-to-main">메인화면으로 이동하기</a> <a href="/webPage/mypage/MyPageServlet?requestType?getMyPageInfo" id="go-mypage-tag">마이페이지로 이동하기</a>
			</div>
		</div>
	</section>
	<div class="go_top"></div>
	<%@ include file='/webPage/footer/footer.jsp'%>
</body>
</html>