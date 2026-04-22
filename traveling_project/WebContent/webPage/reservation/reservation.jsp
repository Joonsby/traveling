<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<%@ page import="com.traveling.reservation.dao.ReservationManageDAO" %>
<%
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<!-- css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/air-datepicker@3.6.0/air-datepicker.css">
	<link rel="stylesheet" href="<c:url value="/css/reservation/reservation.css"/>" />
	<!-- js -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/air-datepicker@3.6.0/air-datepicker.js"></script>
	<script src="https://js.tosspayments.com/v2/standard"></script>
	<script src="<c:url value="/js/reservation/reservation.js"/>"></script>
	<title>예약</title>
</head>
<body>
	<!-- 예약 화면 -->
	<!-- 선택한 객실 정보 -->
	<section class="reservation-info">
		<div class="room-info-wrap">
			<div class="room-info-content">
				<div class="room-info-name">
					<h1 id="room-name">${roomList[0].room_name}</h1>
				</div>
				<div class="room-info-text">
					<p>${roomList[0].content}</p>
				</div>
			</div>
			<div class="room-info-images">
				<div class="room-info-image">
					<img src="<c:url value='/images/room_images/${roomList[0].image1}'/>" alt="숙소 이미지1" width="580px" height="480px" />
				</div>
				<div class="images-others">
					<div class="others-row">
						<img src="<c:url value='/images/room_images/${roomList[0].image2}'/>" alt="숙소 이미지2" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image3}'/>" alt="숙소 이미지3" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image4}'/>" alt="숙소 이미지4" width="190px" />
					</div>
					<div class="others-row">
						<img src="<c:url value='/images/room_images/${roomList[0].image5}'/>" alt="숙소 이미지5" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image6}'/>" alt="숙소 이미지6" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image7}'/>" alt="숙소 이미지7" width="190px" />
					</div>
					<div class="others-row">
						<img src="<c:url value='/images/room_images/${roomList[0].image8}'/>" alt="숙소 이미지8" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image9}'/>" alt="숙소 이미지9" width="190px" />
						<img src="<c:url value='/images/room_images/${roomList[0].image10}'/>" alt="숙소 이미지10" width="190px" />
					</div>
				</div>
			</div>
		</div>	
	</section>
	<section id="reservation-detail">
		<div id="reservation-calendar">
			<div id="detail-title">
				<h3>체크인/체크아웃</h3>
				<h3>예약정보</h3>
			</div>
			<div id="date-range">
				<div id="datepicker" class="cal"></div>
			</div>
			<div id="calendar-container">
				<ul class="detail-option">
					<li class="option-days">
						<div class="option-txt" id="travel-days">
							<div>
								<strong>숙박 기간 : </strong><p id="leave-stay"><b id="leave-stay-txt"></b>1박 2일</p>
							</div>
							<div>
								<p id="check-in-date">체크인</p> ~ <p id="check-out-date">체크아웃</p>
								<input type="hidden" id="check-in-time" value="${roomList[0].check_in_time}">
								<input type="hidden" id="check-out-time" value="${roomList[0].check_out_time}">
							</div>
						</div>
					</li>
					<li class="option-people">
						<div class="option-txt">
							<strong>이용인원 : </strong>
							<button type="button" class="people-change" id="people-minus">-</button>
							<span id="guest"><b id="guest-txt">${roomList[0].standard_people}</b>명</span>
							<button type="button" class="people-change" id="people-plus">+</button>
						</div>
						<input type="hidden" id="standard-people" value="${roomList[0].standard_people}">
						<input type="hidden" id="maximum-people" value="${roomList[0].maximum_people}">
					</li>
					<li class="option-result">
						<strong>요금안내</strong>
						<input type="hidden" id="room-price" value="${roomList[0].price}">
						<table border="1" id="total-price-table">
							<tbody>
								<tr id="default-price">
									<th>객실 요금</th>
									<td id="total_room_price">￦0</td>
								</tr>
								<tr id="add-people-price">
									<th>인원추가 요금</th>
									<td id="total_pers_price">￦0</td>
								</tr>
								<tr id="total-price">
									<th>총 요금</th>
									<td class="total" id="final-price">￦0</td>
								</tr>
							</tbody>
						</table>
						<button type="button" id="btnReservation">예약하기</button>
						<input type="hidden" id="customer-id" value="${userId}">
						<input type="hidden" id="room-id" value="${roomList[0].room_id}">
					</li>
				</ul>
			</div>
		</div>
	</section>
	<div class="go_top"></div>
	<%@ include file='../footer/footer.jsp'%>
</body>
</html>