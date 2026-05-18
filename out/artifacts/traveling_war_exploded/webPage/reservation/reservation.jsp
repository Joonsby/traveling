<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<c:set var="imageCount" value="0" />

		<c:if test="${not empty roomList[0].image1}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image2}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image3}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image4}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image5}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image6}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image7}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image8}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image9}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<c:if test="${not empty roomList[0].image10}">
			<c:set var="imageCount" value="${imageCount + 1}" />
		</c:if>
		<div class="room-info-images image-count-${imageCount}">
			<c:if test="${not empty roomList[0].image1}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image1}'/>" alt="숙소 이미지1" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image2}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image2}'/>" alt="숙소 이미지2" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image3}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image3}'/>" alt="숙소 이미지3" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image4}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image4}'/>" alt="숙소 이미지4" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image5}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image5}'/>" alt="숙소 이미지5" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image6}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image6}'/>" alt="숙소 이미지6" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image7}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image7}'/>" alt="숙소 이미지7" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image8}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image8}'/>" alt="숙소 이미지8" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image9}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image9}'/>" alt="숙소 이미지9" />
				</div>
			</c:if>

			<c:if test="${not empty roomList[0].image10}">
				<div class="room-image-box">
					<img src="<c:url value='/images/room_images/${roomList[0].image10}'/>" alt="숙소 이미지10" />
				</div>
			</c:if>
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
			<div class="option-days">
				<div class="option-txt" id="travel-days">
					<div>
						<strong>숙박 기간 : </strong>
						<p id="leave-stay">1박 2일</p>
					</div>
					<div>
						<p id="check-in-date">체크인</p> ~ <p id="check-out-date">체크아웃</p>
					</div>
				</div>
			</div>
			<div class="option-people">
				<div class="option-txt">
					<div>
						<strong>이용 인원 : </strong>
					</div>
					<div>
						<button type="button" class="people-change" id="people-minus">-</button>
						<span id="guest"><b id="guest-txt">${roomList[0].standard_people}</b>명</span>
						<button type="button" class="people-change" id="people-plus">+</button>
					</div>
				</div>
			</div>
			<div class="option-result">
				<strong>요금안내</strong>
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
			</div>
		</div>
	</div>
</section>
<div class="go_top"></div>
<%@ include file='../footer/footer.jsp'%>
<form id="reservation-form">
	<input type="hidden" id="room-id" value="${roomList[0].room_id}">
	<input type="hidden" id="customer-id" value="${userId}">
	<input type="hidden" id="room-price" value="${roomList[0].price}">
	<input type="hidden" id="check-in-time" value="${roomList[0].check_in_time}">
	<input type="hidden" id="check-out-time" value="${roomList[0].check_out_time}">
	<input type="hidden" id="standard-people" value="${roomList[0].standard_people}">
	<input type="hidden" id="maximum-people" value="${roomList[0].maximum_people}">
	<input type="hidden" id="extra-person-fee" value="${roomList[0].extra_person_fee}">
</form>