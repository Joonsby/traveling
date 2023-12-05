<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pro.dto.FilterStayInfo" %>
<%@ page import="java.text.NumberFormat" %>
<%
	List<FilterStayInfo> stayList = (List<FilterStayInfo>) request.getAttribute("stayList");
	List<FilterStayInfo> filterList = (List<FilterStayInfo>) request.getAttribute("filterList");
	String path = request.getContextPath();
	NumberFormat nf = NumberFormat.getInstance();	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
    <!-- css -->    
    <link rel="stylesheet" href="css/all_stays.css" />
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <!-- script -->
    <script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=503ba05a6aebde2c3d2be42f78d1b63b&libraries=services"></script>
    <script src="js/all_stays.js"></script>    
    <title>인기 숙소 정보</title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <main class="clearfix">
    <%@ include file="all_stays_aside.jsp" %>
      <section id="accomodation_info" class="clearfix">
      	<div id="accomodation_info_box">
	      <%	      
	      	for(int i = 0; i < stayList.size(); i++){
	      %>
      	<div class="accomodation">
	      	<a href="stay_info.condb?comm=stay_info&stay_id=<%=stayList.get(i).getStay_id()%>">
	      		<div class="accomodation_box">
		      		<div>
		      			<img class="image" src="<%=path %>/images/stay_images/<%=stayList.get(i).getImage1() %>" alt="이미지1" />
		      		</div>
		      		<div>		      			
		      			<input type="hidden" class="latitude" value="<%=stayList.get(i).getLatitude()%>">
		      			<input type="hidden" class="longitude" value="<%=stayList.get(i).getLongitude()%>">
		      			<input type="hidden" class="price-val" value="<%= nf.format(stayList.get(i).getMin_room_price()) %>">
		      			<input type="hidden" class="name-val" value="<%= stayList.get(i).getStay_name() %>">
		      			<h2 class="stay-name"><%= stayList.get(i).getStay_name() %></h2>
		            	<p class="avg-rating"><%=stayList.get(i).getAvg_rating() + " (" + stayList.get(i).getRating_count() + ")" %></p>
		            	<p class="road-addr"><%= stayList.get(i).getRoad_addr() %></p>
		            	<p class="room-price">₩ <%= nf.format(stayList.get(i).getMin_room_price()) %> ~</p>
		      		</div>
	      		</div>	      			      		
	      	</a>
	      </div>	      
	      <%
	      	}
	      %>
	     </div>	         	
      </section>
      <div id="map"></div>
      <div id="map-close">목록 보기</div>            
    </main>    
    <%@ include file="footer.jsp"%>    
  </body>
</html>
