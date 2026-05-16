<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="main-wrap" class="clearfix">
<%@ include file="all_stays_aside.jsp" %>
  <section id="accomodation_info" class="clearfix">
	<div id="accomodation_info_box">
		<c:forEach var="stay" items="${stayList}">
			<div class="accomodation">
				<a href="/stay/detail?stay_id=${stay.stay_id}">
					<div class="accomodation_box">
						<div>
							<img class="image" src="<c:url value="/images/stay_images/${stay.image1}"/>" alt="숙소이미지">
						</div>
						<div>
							<input type="hidden" class="latitude" value="${stay.latitude}">
							<input type="hidden" class="longitude" value="${stay.longitude}">
							<input type="hidden" class="price-val" value="${stay.min_room_price}">
							<input type="hidden" class="name-val" value="${stay.stay_name}">
							<h2 class="stay-name">${stay.stay_name}</h2>
							<p class="avg-rating">${stay.rating_avg}</p>
							<p class="road-addr">${stay.road_addr}</p>
							<p class="room-price">₩ <fmt:formatNumber value="${stay.min_room_price}" pattern="#,###" /> ~</p>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	 </div>
  </section>
  <div id="map"></div>
  <div id="map-close">목록 보기</div>
</div>

