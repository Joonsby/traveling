<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/webPage/header/header.jsp"%>
<%@ page import="com.pro.stay.dao.StayManagementDAO" %>
<%@ page import="com.pro.stay.dto.StayInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<% 	
	StayManagementDAO stayManagementDAO = new StayManagementDAO();
 	List<StayInfo> popStays = stayManagementDAO.popStaySelect();
 	List<StayInfo> bestReviewStays = stayManagementDAO.bestReviewStaySelect();
 	List<StayInfo> cheepStays = stayManagementDAO.cheepStaySelect();
 	NumberFormat nf = NumberFormat.getInstance();
%>
<c:set var="uid" value="<%=id %>"/>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value="/css/main/style.css"/>" />
    <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>  
    <script src="<c:url value="/js/main/main.js"/>"></script>
    <title>메인페이지</title>
</head>
<body>
	<section id="video">
		<video autoplay loop muted>
			<source src="video/Banner.mp4" type="video/mp4" width="100%" />
		</video>
	</section>	
	<main>
		<!-- 가장 인기가 많은 숙소 -->
		<section class="hotel_recommend">
			<h2>가장 인기가 많은 숙소</h2>
			<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo"><img src="images/view_all.png" alt="" /></a>
			<div class="slider rec_slider">
				<%
				        for (int i = 0; i < 8; i++) {
	    		%>
 			    <div>
 			        <a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=<%=popStays.get(i).getStay_id()%>">
 			            <div class="image_slider">
 			                <img src="<%=path %>/images/stay_images/<%=popStays.get(i).getImage1() %>" alt="이미지1" /> 
 			                <img src="<%=path %>/images/stay_images/<%=popStays.get(i).getImage2() %>" alt="이미지2" />
 			            </div>
 			            <h3><%=popStays.get(i).getStay_name() %></h3>
			            <p><%=popStays.get(i).getRoad_addr() %></p>
 			            <p>₩ <%=nf.format(popStays.get(i).getMin_room_price()) %> ~</p>
 			            <div class="rec_review review">"<%=popStays.get(i).getReview_content() %>"</div>
 			        </a>
 			    </div>
			    <%
			        	}
			    %>
			</div>
			<span id="rec_show_review" class="show_review">리뷰 모두 보기</span>
		</section>
		<!-- 국내 인기 여행지 -->
		<section class="korea_popular_region">
			<h2>국내 인기 여행지</h2>
			<div class="slider">
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/jeju.jpg" alt="" />
					</div>
					<h2>제주</h2>
					<p>숙소 4,878개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/seoul.jpg" alt="" />
					</div>
					<h2>서울</h2>
					<p>숙소 5,923개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/busan.jpg" alt="" />
					</div>
					<h2>부산</h2>
					<p>숙소 2,719개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/sokcho.jpg" alt="" />
					</div>
					<h2>속초</h2>
					<p>숙소 797개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/incheon.jpg" alt="" />
					</div>
					<h2>인천</h2>
					<p>숙소 2,154개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/gangneung.jpg" alt="" />
					</div>
					<h2>강릉</h2>
					<p>숙소 1,181개</p>
				</a>
			</div>
		</section>
		<!-- 가장 평점이 높은 숙소  -->
		<section class="accomodation_near_me">
			<div class="swiper mySwiper banner">
				<h2>가장 평점이 높은 숙소</h2>
				<a href="all_stays.jsp"><img src="images/view_all.png" alt="" /></a>
				<div class="slider swiper-wrapper">
				<% for(int i = 0; i < 9; i++){ %>
 					<div class="swiper-slide banner">
 						<a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=<%=bestReviewStays.get(i).getStay_id()%>">
 							<div class="image_slider">
 								<img src="<%=path %>/images/stay_images/<%=bestReviewStays.get(i).getImage1() %>" alt="이미지1" />
 								<img src="<%=path %>/images/stay_images/<%=bestReviewStays.get(i).getImage2() %>" alt="이미지1" />
 							</div>
 							<h3><%=bestReviewStays.get(i).getStay_name() %></h3>
 							<p><%=bestReviewStays.get(i).getStay_addr() %></p>
	 			            <p>₩ <%=nf.format(bestReviewStays.get(i).getMin_room_price()) %> ~</p>
 						</a>
 					</div>
				<%
					}
				%>
				</div>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</section>

		<!-- 가격이 저렴한 숙소 -->
 		<section class="popular_accomodation">
			<h2>가격이 저렴한 숙소</h2>
			<a href="all_stays.jsp"><img src="images/view_all.png" alt="" /></a>
			<div class="slider pop_slider">
				<%for(int i = 0; i < 8; i++) {%>
 				<div>
 					<a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=<%=cheepStays.get(i).getStay_id()%>">
 						<div class="image_slider">
 							<img src="<%=path %>/images/stay_images/<%=cheepStays.get(i).getImage1() %>" alt="이미지1" />
 							<img src="<%=path %>/images/stay_images/<%=cheepStays.get(i).getImage2() %>" alt="이미지2" />
 						</div>
 						<h3><%=cheepStays.get(i).getStay_name() %></h3>
 						<p><%=cheepStays.get(i).getStay_addr() %></p>
 			            <p>₩ <%=nf.format(cheepStays.get(i).getMin_room_price()) %> ~</p>
 						<div class="review pop_review">"<%=cheepStays.get(i).getReview_content() %>"</div>
 					</a>
 				</div>
				<%
					}
				%>				
			</div>
			<span id="pop_show_review" class="show_review">리뷰 모두 보기</span>
		</section>
		<!-- 이벤트 -->
		<section class="event">
			<h2>이벤트</h2>
			<div class="slider event_slider">
				<a href="#"><img src="images/event1.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event2.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event3.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event4.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event5.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event6.webp" alt="이벤트" /></a>
				<a href="#"><img src="images/event7.webp" alt="이벤트" /></a>
			</div>
		</section>
	</main>
	<div class="go_top"></div>
    <%@ include file='/webPage/footer/footer.jsp'%>
</body>
</html>
