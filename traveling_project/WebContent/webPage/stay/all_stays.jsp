<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="shortcut icon" href="<c:url value="/images/logo.png"/>" type="image/x-icon"/>
    <link rel="stylesheet" href="<c:url value="/css/stay/all_stays.css"/>" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=503ba05a6aebde2c3d2be42f78d1b63b"></script>
    <script src="<c:url value="/js/stay/stay_map.js"/>"></script>
    <script src="<c:url value="/js/stay/all_stays.js"/>"></script>
    <title>숙소 목록</title>
  </head>
  <body>
    <main class="clearfix">
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
    </main>
    <%@ include file="../footer/footer.jsp"%>
  </body>
</html>
