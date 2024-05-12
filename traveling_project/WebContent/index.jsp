<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pro.index.IndexDAO" %>
<%@ page import="com.pro.dto.PopStayInfo" %>
<%@ page import="java.util.HashMap" %>
<%
 	IndexDAO indexDAO = new IndexDAO(); 
 	String path = request.getContextPath();
 	HashMap<Integer, PopStayInfo> popStays = indexDAO.selectPopStays();
 	HashMap<Integer, PopStayInfo> bestReviewStays = indexDAO.selectBestReviewStays();
 	HashMap<Integer, PopStayInfo> cheepStays = indexDAO.selectCheepStays();
%> 	
<!DOCTYPE html>
<html>
<head>	
    <!-- favicon -->
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon"/>
	<%@ include file="header.jsp"%>	
</head>
<body>
	<section id="video">
		<video autoplay loop muted>
			<source src="video/Banner.mp4" type="video/mp4" width="100%" />
		</video>
	</section>	
	<main>
		<!-- 호텔 추천 -->
		<section class="hotel_recommend">
			<h2>가장 인기가 많은 숙소</h2>
			<a href="pop_stays.condb?comm=pop_stays"><img src="images/view_all.png" alt="" /></a>
			<div class="slider rec_slider">
				<%
				        for (int i = 0; i < 8; i++) {
	    		%>
 			    <div>
 			        <a href="stay_info.condb?comm=stay_info&stay_id=<%=popStays.get(i).getStay_id()%>">
 			            <div class="image_slider">
 			                <img src="<%=path %>/images/stay_images/<%=popStays.get(i).getImage1() %>" alt="이미지1" /> 
 			                <img src="<%=path %>/images/stay_images/<%=popStays.get(i).getImage2() %>" alt="이미지2" />
 			            </div>
 			            <h3><%=popStays.get(i).getStayName() %></h3>
			            <p><%=popStays.get(i).getStayAddr() %></p>
 			            <p>₩ <%=popStays.get(i).getPrice() %> ~</p>
 			            <div class="rec_review review">"<%=popStays.get(i).getReviewContent() %>"</div>
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
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/jeju.jpg" alt="" />
					</div>
					<h2>제주</h2>
					<p>숙소 4,878개</p>
				</a>
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/seoul.jpg" alt="" />
					</div>
					<h2>서울</h2>
					<p>숙소 5,923개</p>
				</a>
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/busan.jpg" alt="" />
					</div>
					<h2>부산</h2>
					<p>숙소 2,719개</p>
				</a>
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/sokcho.jpg" alt="" />
					</div>
					<h2>속초</h2>
					<p>숙소 797개</p>
				</a>
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/incheon.jpg" alt="" />
					</div>
					<h2>인천</h2>
					<p>숙소 2,154개</p>
				</a>
				<a href="search_stays.condb?comm=pop_stays">
					<div>
						<img src="images/gangneung.jpg" alt="" />
					</div>
					<h2>강릉</h2>
					<p>숙소 1,181개</p>
				</a>
			</div>
		</section>
		<!-- 내 근처 숙소  -->
		<section class="accomodation_near_me">
			<div class="swiper mySwiper banner">
				<h2>가장 평점이 높은 숙소</h2>
				<a href="all_stays.jsp"><img src="images/view_all.png" alt="" /></a>
				<div class="slider swiper-wrapper">
				<% for(int i = 0; i < 9; i++){ %>
 					<div class="swiper-slide banner">
 						<a href="stay_info.condb?comm=stay_info&stay_id=<%=bestReviewStays.get(i).getStay_id()%>">
 							<div class="image_slider">
 								<img src="<%=path %>/images/stay_images/<%=bestReviewStays.get(i).getImage1() %>" alt="이미지1" />
 								<img src="<%=path %>/images/stay_images/<%=bestReviewStays.get(i).getImage2() %>" alt="이미지1" />
 							</div>
 							<h3><%=bestReviewStays.get(i).getStayName() %></h3>
 							<p><%=bestReviewStays.get(i).getStayAddr() %></p>
 							<p>₩ <%=bestReviewStays.get(i).getPrice() %>~</p>
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

		<!-- 인기 숙소 -->
 		<section class="popular_accomodation">
			<h2>가격이 저렴한 숙소</h2>
			<a href="all_stays.jsp"><img src="images/view_all.png" alt="" /></a>
			<div class="slider pop_slider">
				<%for(int i = 0; i < 8; i++) {%>
 				<div>
 					<a href="stay_info.condb?comm=stay_info&stay_id=<%=cheepStays.get(i).getStay_id()%>">
 						<div class="image_slider">
 							<img src="<%=path %>/images/stay_images/<%=cheepStays.get(i).getImage1() %>" alt="이미지1" />
 							<img src="<%=path %>/images/stay_images/<%=cheepStays.get(i).getImage2() %>" alt="이미지2" />
 						</div>
 						<h3><%=cheepStays.get(i).getStayName() %></h3>
 						<p><%=cheepStays.get(i).getStayAddr() %></p>
 						<p>₩ <%=cheepStays.get(i).getPrice() %>~</p>
 						<div class="review pop_review">"<%=cheepStays.get(i).getReviewContent() %>"</div>
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
				<a href="#"><img src="images/event1.webp" alt="" /></a> <a href="#"><img src="images/event2.webp" alt="" /></a> <a href="#"><img src="images/event3.webp" alt="" /></a> <a href="#"><img src="images/event4.webp" alt="" /></a> <a href="#"><img src="images/event5.webp" alt="" /></a> <a href="#"><img src="images/event6.webp" alt="" /></a> <a href="#"><img src="images/event7.webp" alt="" /></a>
			</div>
		</section>
	</main>
	<div class="go_top"></div>
	<%@ include file="footer.jsp"%>
</body>
</html>
