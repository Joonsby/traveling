<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="stay" value="${detailStayList[0]}" />
<c:set var="sessionUserId" value="${sessionScope.id}" />
<c:set var="hostPhone" value="${stay.host_phone}" />
<h1 id="stay_name">${stay.stay_name}</h1>

<!-- Swiper -->
<div id="swiper-box">
	<div class="swiper mySwiper">
		<div class="swiper-wrapper">
			<c:if test="${not empty stay.image1}">
				<div class="swiper-slide">
					<img alt="숙소 이미지" src="<c:url value='/images/stay_images/${stay.image1}'/>">
				</div>
			</c:if>

			<c:if test="${not empty stay.image2}">
				<div class="swiper-slide">
					<img alt="숙소 이미지" src="<c:url value='/images/stay_images/${stay.image2}'/>">
				</div>
			</c:if>

			<c:if test="${not empty stay.image3}">
				<div class="swiper-slide">
					<img alt="숙소 이미지" src="<c:url value='/images/stay_images/${stay.image3}'/>">
				</div>
			</c:if>

			<c:if test="${not empty stay.image4}">
				<div class="swiper-slide">
					<img alt="숙소 이미지" src="<c:url value='/images/stay_images/${stay.image4}'/>">
				</div>
			</c:if>

			<c:if test="${not empty stay.image5}">
				<div class="swiper-slide">
					<img alt="숙소 이미지" src="<c:url value='/images/stay_images/${stay.image5}'/>">
				</div>
			</c:if>
		</div>
	</div>
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
</div>

<!-- 숙소 정보 -->
<section class="detail-stay-info">
	<div>
		<h3 style="text-align:center;">숙소 설명</h3>
		<p class="content">${stay.content}</p>
		<input id="amenity-btn" type="button" value="편의 시설 보기">
	</div>

	<div class="amenity">
		<h3 id="amenity-title">편의시설</h3>
		<div class="stay-amenity-content">
			<c:forEach var="category" items="${facilityList}">
				<div class="amenity-category">
					<b>${category.categoryName}</b>
					<hr>
					<c:forEach var="facilityName" items="${category.facilityList}">
						<span>${facilityName}</span>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
		<input type="button" id="amenity-close" value="닫기">
	</div>

	<div id="modal-backdrop"></div>
</section>

<!-- 리뷰 -->
<section class="detail-stay-review">
	<h3 id="review-title">리뷰 ★${stay.rating_avg} (${stay.rating_count})</h3>
	<div class="stay-review-wrap">
		<c:if test="${not empty reviewList}">
			<c:forEach var="review" items="${reviewList}" begin="0" end="2">
				<c:url var="reviewImageUrl" value="/images/review/${review.review_image1}" />
				<div class="stay-review-content-wrap">
					<div class="stay-review-image">
						<img src="${reviewImageUrl}" alt="리뷰 이미지" width="150px" height="150px" />
					</div>
					<div class="stay-review-content">
						<div class="review-writter">
							<h3>${review.user_id}</h3>
							<span class="review-writter-star">★${review.rating}</span>
						</div>
						<div class="room-name">
							<h4>${review.room_name}</h4>
						</div>
						<div class="review-content-wrap">
							<h3 class="review-title">${review.review_title}</h3>
							<p id="review-content">${review.review_content}</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</section>

<!-- 객실 예약 -->
<section class="detail-stay-room">
	<h2>객실</h2>
	<div class="room-list">
		<c:forEach var="room" items="${roomList}" varStatus="status">
			<c:url var="roomImageUrl" value="/images/room_images/${room.image1}" />
			<c:url var="reservationUrl" value="/reservation/page">
				<c:param name="room_id" value="${room.room_id}" />
				<c:param name="user_id" value="${sessionUserId}" />
			</c:url>

			<div class="room-item" data-room_id="${room.room_id}">
				<div class="room-item-wrap">
					<div class="room-item-image">
						<img src="${roomImageUrl}" alt="객실이미지" />
					</div>
					<div class="room-item-info">
						<div class="room-info-name">
							<h2>${room.roomName}</h2>
						</div>
						<div class="room-info-detail">
							<div class="room-info-list">
								<div class="room-content">
									<h4>방 소개</h4>
									<p>${room.content}</p>
								</div>
								<div class="room-min-people">
									<h4>기준 인원</h4>
									<p>${room.stdPeople}명</p>
								</div>
								<div class="room-max-people">
									<h4>최대 인원</h4>
									<p>${room.maxPeople}명</p>
								</div>
							</div>
						</div>
						<div class="room-to-reservation">
							<a href="${reservationUrl}" class="reservation-a" data-id="<c:out value='${sessionUserId}' />">예약하기</a>
							<span class="room-price">₩ <fmt:formatNumber value="${room.price}"/></span>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>

<!-- 숙소 위치 -->
<section class="detail-stay-location">
	<h2>숙소 위치</h2>
	<div class="stay-location-wrap">
		<div>
			<div id="map"></div>
		</div>
		<div class="stay-location-info">
			<address data-latitude="${stay.latitude}" data-longitude="${stay.longitude}">
				${stay.road_addr}
			</address>
			<%-- <span>T. ${stay.host_phone}</span> --%>
			<span>
				T. ${fn:substring(hostPhone, 0, 3)} - ${fn:substring(hostPhone, 4, 8)} - ${fn:substring(hostPhone, 9, 13)}
			</span>
		</div>
	</div>
</section>