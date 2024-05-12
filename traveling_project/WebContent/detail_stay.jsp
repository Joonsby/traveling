<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.pro.dto.StayInfo" %>
<%@ page import="com.pro.dto.RoomInfo" %>
<%@ page import="com.pro.dto.ReviewInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%
	List<StayInfo> detailStayList = (List<StayInfo>) request.getAttribute("detailStayList");
	List<RoomInfo> roomList = (List<RoomInfo>) request.getAttribute("roomList");
	List<ReviewInfo> reviewList = (List<ReviewInfo>) request.getAttribute("reviewList");
	String path = request.getContextPath();
	NumberFormat formatter = NumberFormat.getNumberInstance();
    String rawPhone = detailStayList.get(0).getHostPhone();
    String formattedPhone;    

    if(rawPhone != null && rawPhone.length() == 11) {
        formattedPhone = rawPhone.substring(0, 3) + "-" 
                         + rawPhone.substring(3, 7) + "-" 
                         + rawPhone.substring(7, 11);
    } else {
        formattedPhone = rawPhone;
    }    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>traveling</title>
<!-- favicon -->
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
<!-- css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<link rel="stylesheet" href="css/detail_stay.css">
<!-- js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=503ba05a6aebde2c3d2be42f78d1b63b&libraries=services"></script>
<script src="js/detail_stay.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h1 id="stay_name"><%=detailStayList.get(0).getStayName() %></h1>
	<!-- Swiper -->
	<div id="swiper-box">
		<div class="swiper mySwiper">
		  <div class="swiper-wrapper">
			<c:if test="${not empty detailStayList[0].image1}">
			  <div class="swiper-slide"><img alt="숙소 이미지" src="<c:url value='/images/stay_images/${detailStayList[0].image1}'/>"></div>
			</c:if>
			
			<c:if test="${not empty detailStayList[0].image2}">
			  <div class="swiper-slide"><img alt="숙소 이미지" src="<c:url value='/images/stay_images/${detailStayList[0].image2}'/>"></div>
			</c:if>
			
			<c:if test="${not empty detailStayList[0].image3}">
			  <div class="swiper-slide"><img alt="숙소 이미지" src="<c:url value='/images/stay_images/${detailStayList[0].image3}'/>"></div>
			</c:if>
			
			<c:if test="${not empty detailStayList[0].image4}">
			  <div class="swiper-slide"><img alt="숙소 이미지" src="<c:url value='/images/stay_images/${detailStayList[0].image4}'/>"></div>
			</c:if>
			
			<c:if test="${not empty detailStayList[0].image5}">
			  <div class="swiper-slide"><img alt="숙소 이미지" src="<c:url value='/images/stay_images/${detailStayList[0].image5}'/>"></div>
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
			<p class="content"><%=detailStayList.get(0).getContent() %></p>
			<input id="amenity-btn" type="button" value="편의 시설 보기">
		</div>
		<div class="amenity">
			<h3 id="amenity-title">편의시설</h3>
			<div class="stay-amenity-content">						
				<c:if test="${not empty detailStayList[0].tub or 
				             not empty detailStayList[0].bathSupplies or 
				             not empty detailStayList[0].hairDryer}">
				    <p class="amenity-category">						    
				        <b>욕실</b>
				        <hr>						        
				        <c:if test="${not empty detailStayList[0].tub}"><span>욕조</span></c:if>
				        <c:if test="${not empty detailStayList[0].bathSupplies}"><span>샤워용품</span></c:if>
				        <c:if test="${not empty detailStayList[0].hairDryer}"><span>헤어 드라이기</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].towel or 
				             not empty detailStayList[0].bedding or 
				             not empty detailStayList[0].washingMachine or 
				             not empty detailStayList[0].dryingMachine}">
				    <p class="amenity-category">
				        <b>침실 및 세탁 시설</b>
				        <hr>
				        <span>
				            <c:if test="${not empty detailStayList[0].towel}"><span>수건</span></c:if>
				            <c:if test="${not empty detailStayList[0].bedding}"><span>침구류</span></c:if>
				            <c:if test="${not empty detailStayList[0].washingMachine}"><span>세탁기</span></c:if>
				            <c:if test="${not empty detailStayList[0].dryingMachine}"><span>건조기</span></c:if>						
				        </span>
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].pool or 
				             not empty detailStayList[0].arcadeGame or 
				             not empty detailStayList[0].gym or 
				             not empty detailStayList[0].tv or 
				             not empty detailStayList[0].boardGame}">
				    <p class="amenity-category">
				        <b>엔터테인먼트</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].pool}"><span>수영장</span></c:if>
			            <c:if test="${not empty detailStayList[0].arcadeGame}"><span>오락실 게임</span></c:if>
			            <c:if test="${not empty detailStayList[0].gym}"><span>헬스장</span></c:if>
			            <c:if test="${not empty detailStayList[0].tv}"><span>TV</span></c:if>						
			            <c:if test="${not empty detailStayList[0].boardGame}"><span>보드 게임</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].airConditioner or 
				             not empty detailStayList[0].fan or						             
				             not empty detailStayList[0].heatingSystem}">
				    <p class="amenity-category">
				        <b>냉난방</b>
				        <hr>						        
				        <c:if test="${not empty detailStayList[0].airConditioner}"><span>에어컨</span></c:if>
				        <c:if test="${not empty detailStayList[0].fan}"><span>선풍기</span></c:if>
				        <c:if test="${not empty detailStayList[0].heatingSystem}"><span>난방</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].carbonMonoxideAlarm or 
				             not empty detailStayList[0].fireExtinguisher or 
				             not empty detailStayList[0].aidKit or 
				             not empty detailStayList[0].fireAlarm}">
				    <p class="amenity-category">
				        <b>숙소 안전</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].carbonMonoxideAlarm}"><span>일산화탄소 경보기</span></c:if>
			            <c:if test="${not empty detailStayList[0].fireExtinguisher}"><span>소화기</span></c:if>
			            <c:if test="${not empty detailStayList[0].aidKit}"><span>구급상자</span></c:if>
			            <c:if test="${not empty detailStayList[0].fireAlarm}"><span>화재 경보기</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].workspace or						             
				             not empty detailStayList[0].wirelessInternet}">
				    <p class="amenity-category">
				        <b>인터넷 및 업무 공간</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].workspace}"><span>업무 전용 공간</span></c:if>
			            <c:if test="${not empty detailStayList[0].wirelessInternet}"><span>무선 인터넷</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].barbecueTool or 
				             not empty detailStayList[0].basicCookware or
				             not empty detailStayList[0].diningTable or
				             not empty detailStayList[0].cutlery or
				             not empty detailStayList[0].refrigerator or
				             not empty detailStayList[0].microwave or
				             not empty detailStayList[0].electricRiceCooker or 
				             not empty detailStayList[0].gasStoveOrInduction}">
				    <p class="amenity-category">
				        <b>주방 및 식당</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].barbecueTool}"><span>바베큐 도구</span></c:if>
			            <c:if test="${not empty detailStayList[0].basicCookware}"><span>기본 조리도구</span></c:if>
			            <c:if test="${not empty detailStayList[0].diningTable}"><span>식탁</span></c:if>
			            <c:if test="${not empty detailStayList[0].cutlery}"><span>식기류</span></c:if>
			            <c:if test="${not empty detailStayList[0].refrigerator}"><span>냉장고</span></c:if>
			            <c:if test="${not empty detailStayList[0].microwave}"><span>전자레인지</span></c:if>
			            <c:if test="${not empty detailStayList[0].electricRiceCooker}"><span>전기밥솥</span></c:if>
			            <c:if test="${not empty detailStayList[0].gasStoveOrInduction}"><span>가스레인지 또는 인덕션</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].electricVehicleChargingFacilities or						             
				             not empty detailStayList[0].parkingLot}">
				    <p class="amenity-category">
				        <b>주차</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].electricVehicleChargingFacilities}"><span>전기차 충전 시설</span></c:if>
			            <c:if test="${not empty detailStayList[0].parkingLot}"><span>주차장</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].breakfast or						             
				             not empty detailStayList[0].cleanService or 
				             not empty detailStayList[0].luggageStorage}">
				    <p class="amenity-category">
				        <b>서비스</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].breakfast}"><span>아침 식사</span></c:if>
			            <c:if test="${not empty detailStayList[0].cleanService}"><span>청소 서비스</span></c:if>
			            <c:if test="${not empty detailStayList[0].luggageStorage}"><span>짐보관</span></c:if>						        
				    </p>
				</c:if>						
			</div>
			<input type="button" id="amenity-close" value="닫기">
		</div>
		<div id="modal-backdrop"></div>
	</section>
	<!-- 리뷰 -->
	<section class="detail-stay-review">
		<h3 id="review-title">리뷰 ★<%=detailStayList.get(0).getRatingAvg() %> (<%=detailStayList.get(0).getRating_count() %>)</h3>
		<div class="stay-review-wrap">
			<%
			if(reviewList.size() !=0){
				for(int i = 0; i < 3; i++){
			%>
			<div class="stay-review-content-wrap">
				<div class="stay-review-image">
					<img src="<%=path %>/images/review/<%=reviewList.get(i).getReview_image1() %>" width="150px" height="150px">
				</div>
				<div class="stay-review-content">
					<div class="review-writter">
						<h3><%=reviewList.get(i).getUser_id() %></h3>						
						<span class="review-writter-star">★<%=reviewList.get(i).getRating() %></span>
					</div>
					<div class="room-name">
						<h4><%=reviewList.get(i).getRoom_name() %></h4>
					</div>
					<div class="review-content-wrap">						
						<h3 class="review-title"><%=reviewList.get(i).getReview_title() %></h3>
						<p id="review-content"><%=reviewList.get(i).getReview_content() %></p>																	
					</div>
				</div>
			</div>			
			<%
				}
			} else{
				
			}
			%>
		</div>
	</section>
	<!-- 객실 예약 -->
	<section class="detail-stay-room">
		<h2>객실</h2>
		<ul class="room-list">
		<%
			for(int i = 0; i < roomList.size(); i++){
		%>		
			<li class="room-item" data-room_id="<%=roomList.get(i).getRoom_id()%>">
				<div class="room-item-wrap">
					<div class="room-item-image">
						<img alt="객실 이미지" src="<%=path %>/images/room_images/<%=roomList.get(i).getImage1() %>">
					</div>
					<div class="room-item-info">
						<div class="room-info-name">
							<h2><%=roomList.get(i).getRoomName() %></h2>
						</div>
						<div class="room-info-detail">
							<ul class="room-info-list">
								<li class="room-content">
									<h4>방 소개</h4>
									<span><%=roomList.get(i).getContent() %></span>
								</li>
								<li class="room-min-people">
									<h4>기준 인원</h4>
									<span><%=roomList.get(i).getStdPeople() %>명</span>
								</li>
								<li class="room-max-people">
									<h4>최대 인원</h4>
									<span><%=roomList.get(i).getMaxPeople() %>명</span>
								</li>
							</ul>
							<div class="room-to-reservation">								
								<a href="reservation.jsp?room_id=<%=roomList.get(i).getRoom_id()%>&user_id=<%=session.getAttribute("id") %>" class="reservation-a" data-id="<%=session.getAttribute("id") %>">예약하기</a>
								<span class="room-price">
								₩ <%
									String formattedPrice = formatter.format(roomList.get(i).getPrice());
									out.println(formattedPrice);									
								%> 
								</span>
							</div>
						</div>
					</div>
				</div>
			</li>
			<%
				}
			%>				
		</ul>
	</section>
	<!-- 숙소 위치 -->
	<section class="detail-stay-location">
		<h2>숙소 위치</h2>
		<div class="stay-location-wrap">
			<div>
				<div id="map"></div>
			</div>
			<div class="stay-location-info">
				<address data-latitude="<%=detailStayList.get(0).getLatitude()%>" data-longitude="<%=detailStayList.get(0).getLongitude()%>"><%= detailStayList.get(0).getRoadAddr() %></address>
				<span>T. <%= formattedPhone %></span>
			</div>
		</div>
	</section>
	<div class="go_top"></div>
	<jsp:include page="./footer.jsp" />
</body>
</html>