<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<%@ page import="com.pro.stay.dto.StayInfo" %>
<%@ page import="com.pro.stay.dto.RoomInfo" %>
<%@ page import="com.pro.stay.dto.ReviewInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%
	List<StayInfo> detailStayList = (List<StayInfo>) request.getAttribute("detailStayList");
	List<RoomInfo> roomList = (List<RoomInfo>) request.getAttribute("roomList");
	List<ReviewInfo> reviewList = (List<ReviewInfo>) request.getAttribute("reviewList");
	NumberFormat formatter = NumberFormat.getNumberInstance();
    String rawPhone = detailStayList.get(0).getHost_phone();
    String formattedPhone = null;

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
<title>숙소 상세 정보</title>
<!-- css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<link rel="stylesheet" href="<c:url value="/css/stay/detail_stay.css"/>" />
<!-- js -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=503ba05a6aebde2c3d2be42f78d1b63b&libraries=services"></script>
<script src="<c:url value="/js/stay/detail_stay.js"/>"></script>
</head>
<body>
	<h1 id="stay_name"><%=detailStayList.get(0).getStay_name() %></h1>
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
				             not empty detailStayList[0].bath_supplies or 
				             not empty detailStayList[0].hair_dryer}">
				    <p class="amenity-category">						    
				        <b>욕실</b>
				        <hr>						        
				        <c:if test="${not empty detailStayList[0].tub}"><span>욕조</span></c:if>
				        <c:if test="${not empty detailStayList[0].bath_supplies}"><span>샤워용품</span></c:if>
				        <c:if test="${not empty detailStayList[0].hair_dryer}"><span>헤어 드라이기</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].towel or 
				             not empty detailStayList[0].bedding or 
				             not empty detailStayList[0].washing_machine or 
				             not empty detailStayList[0].drying_machine}">
				    <p class="amenity-category">
				        <b>침실 및 세탁 시설</b>
				        <hr>
				        <span>
				            <c:if test="${not empty detailStayList[0].towel}"><span>수건</span></c:if>
				            <c:if test="${not empty detailStayList[0].bedding}"><span>침구류</span></c:if>
				            <c:if test="${not empty detailStayList[0].washing_machine}"><span>세탁기</span></c:if>
				            <c:if test="${not empty detailStayList[0].drying_machine}"><span>건조기</span></c:if>						
				        </span>
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].pool or 
				             not empty detailStayList[0].arcade_game or 
				             not empty detailStayList[0].gym or 
				             not empty detailStayList[0].tv or 
				             not empty detailStayList[0].board_game}">
				    <p class="amenity-category">
				        <b>엔터테인먼트</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].pool}"><span>수영장</span></c:if>
			            <c:if test="${not empty detailStayList[0].arcade_game}"><span>오락실 게임</span></c:if>
			            <c:if test="${not empty detailStayList[0].gym}"><span>헬스장</span></c:if>
			            <c:if test="${not empty detailStayList[0].tv}"><span>TV</span></c:if>						
			            <c:if test="${not empty detailStayList[0].board_game}"><span>보드 게임</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].air_conditioner or 
				             not empty detailStayList[0].fan or						             
				             not empty detailStayList[0].heating_system}">
				    <p class="amenity-category">
				        <b>냉난방</b>
				        <hr>						        
				        <c:if test="${not empty detailStayList[0].air_conditioner}"><span>에어컨</span></c:if>
				        <c:if test="${not empty detailStayList[0].fan}"><span>선풍기</span></c:if>
				        <c:if test="${not empty detailStayList[0].heating_system}"><span>난방</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].carbon_monoxide_alarm or 
				             not empty detailStayList[0].fire_extinguisher or 
				             not empty detailStayList[0].aid_kit or 
				             not empty detailStayList[0].fire_alarm}">
				    <p class="amenity-category">
				        <b>숙소 안전</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].carbon_monoxide_alarm}"><span>일산화탄소 경보기</span></c:if>
			            <c:if test="${not empty detailStayList[0].fire_extinguisher}"><span>소화기</span></c:if>
			            <c:if test="${not empty detailStayList[0].aid_kit}"><span>구급상자</span></c:if>
			            <c:if test="${not empty detailStayList[0].fire_alarm}"><span>화재 경보기</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].workspace or						             
				             not empty detailStayList[0].wireless_internet}">
				    <p class="amenity-category">
				        <b>인터넷 및 업무 공간</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].workspace}"><span>업무 전용 공간</span></c:if>
			            <c:if test="${not empty detailStayList[0].wireless_internet}"><span>무선 인터넷</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].barbecue_tool or 
				             not empty detailStayList[0].basic_cookware or
				             not empty detailStayList[0].dining_table or
				             not empty detailStayList[0].cutlery or
				             not empty detailStayList[0].refrigerator or
				             not empty detailStayList[0].microwave or
				             not empty detailStayList[0].electric_rice_cooker or 
				             not empty detailStayList[0].gas_stove_or_induction}">
				    <p class="amenity-category">
				        <b>주방 및 식당</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].barbecue_tool}"><span>바베큐 도구</span></c:if>
			            <c:if test="${not empty detailStayList[0].basic_cookware}"><span>기본 조리도구</span></c:if>
			            <c:if test="${not empty detailStayList[0].dining_table}"><span>식탁</span></c:if>
			            <c:if test="${not empty detailStayList[0].cutlery}"><span>식기류</span></c:if>
			            <c:if test="${not empty detailStayList[0].refrigerator}"><span>냉장고</span></c:if>
			            <c:if test="${not empty detailStayList[0].microwave}"><span>전자레인지</span></c:if>
			            <c:if test="${not empty detailStayList[0].electric_rice_cooker}"><span>전기밥솥</span></c:if>
			            <c:if test="${not empty detailStayList[0].gas_stove_or_induction}"><span>가스레인지 또는 인덕션</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].electric_vehicle_charging_facilities or not empty detailStayList[0].parking_lot}">
				    <p class="amenity-category">
				        <b>주차</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].electric_vehicle_charging_facilities}"><span>전기차 충전 시설</span></c:if>
			            <c:if test="${not empty detailStayList[0].parking_lot}"><span>주차장</span></c:if>						        
				    </p>
				</c:if>
				<c:if test="${not empty detailStayList[0].breakfast or not empty detailStayList[0].clean_service or not empty detailStayList[0].luggage_storage}">
				    <p class="amenity-category">
				        <b>서비스</b>
				        <hr>						        
			            <c:if test="${not empty detailStayList[0].breakfast}"><span>아침 식사</span></c:if>
			            <c:if test="${not empty detailStayList[0].clean_service}"><span>청소 서비스</span></c:if>
			            <c:if test="${not empty detailStayList[0].luggage_storage}"><span>짐보관</span></c:if>						        
				    </p>
				</c:if>						
			</div>
			<input type="button" id="amenity-close" value="닫기">
		</div>
		<div id="modal-backdrop"></div>
	</section>
	<!-- 리뷰 -->
	<section class="detail-stay-review">
		<h3 id="review-title">리뷰 ★<%=detailStayList.get(0).getRating_avg() %> (<%=detailStayList.get(0).getRating_count() %>)</h3>
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
				<address data-latitude="<%=detailStayList.get(0).getLatitude()%>" data-longitude="<%=detailStayList.get(0).getLongitude()%>"><%= detailStayList.get(0).getRoad_addr() %></address>
				<span>T. <%= formattedPhone %></span>
			</div>
		</div>
	</section>
	<div class="go_top"></div>
	<%@ include file="../footer/footer.jsp"%>
</body>
</html>