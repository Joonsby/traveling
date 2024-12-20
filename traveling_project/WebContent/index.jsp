<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/webPage/header/header.jsp"%>
<%@ page import="com.pro.stay.dao.StayManagementDAO" %>
<%@ page import="com.pro.stay.dto.StayInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<% 	
	StayManagementDAO stayManagementDAO = new StayManagementDAO();
 	pageContext.setAttribute("popStays",stayManagementDAO.popStaySelect());
 	pageContext.setAttribute("bestReviewStays",stayManagementDAO.bestReviewStaySelect());
 	pageContext.setAttribute("cheepStays",stayManagementDAO.cheepStaySelect());
 	List<StayInfo> cheepStays = stayManagementDAO.cheepStaySelect();
 	NumberFormat nf = NumberFormat.getInstance();
%>
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
			<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo"><img src="images/view_all.png" alt="모두 보기" /></a>
			<div class="slider rec_slider">
 			    <c:forEach var="popStay" items="${popStays}" begin="0" end="7">
	 			    <div>
	 			        <a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=${popStay.stay_id}">
	 			            <div class="image_slider">
	 			                <img src="<c:url value="/images/stay_images/${popStay.image1}" />" alt="이미지1" />
	 			                <img src="<c:url value="/images/stay_images/${popStay.image2}" />" alt="이미지2" />
	 			            </div>
	 			            <h3>${popStay.stay_name}</h3>
				            <p>${popStay.road_addr}</p>
	 			            <p>₩ <fmt:formatNumber value="${popStay.min_room_price}" type="number" pattern="#,##0" /> ~</p>
	 			            <div class="rec_review review">${popStay.review_content}</div>
	 			        </a>
	 			    </div>
	 			</c:forEach>
			</div>
			<span id="rec_show_review" class="show_review">리뷰 모두 보기</span>
		</section>
		<!-- 국내 인기 여행지 -->
		<section class="korea_popular_region">
			<h2>국내 인기 여행지</h2>
			<div class="slider">
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/jeju.jpg" alt="제주" />
					</div>
					<h2>제주</h2>
					<p>숙소 4,878개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/seoul.jpg" alt="서울" />
					</div>
					<h2>서울</h2>
					<p>숙소 5,923개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/busan.jpg" alt="부산" />
					</div>
					<h2>부산</h2>
					<p>숙소 2,719개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/sokcho.jpg" alt="속초" />
					</div>
					<h2>속초</h2>
					<p>숙소 797개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/incheon.jpg" alt="인천" />
					</div>
					<h2>인천</h2>
					<p>숙소 2,154개</p>
				</a>
				<a href="/webPage/stay/StayServlet?requestType=getPopStayInfo">
					<div>
						<img src="images/gangneung.jpg" alt="강릉" />
					</div>
					<h2>강릉</h2>
					<p>숙소 1,181개</p>
				</a>
			</div>
		</section>
		<!-- 가장 평점이 높은 숙소  -->
		<section id="best-review-stays">
			<div class="swiper mySwiper banner">
				<h2>가장 평점이 높은 숙소</h2>
				<a href="all_stays.jsp"><img src="images/view_all.png" alt="" /></a>
				<div class="slider swiper-wrapper">
					<c:forEach var="bestReviewStay" items="${bestReviewStays}" begin="0" end="7">
	 					<div class="swiper-slide banner">
	 						<a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=${bestReviewStay.stay_id}">
	 							<div class="image_slider">
		 			                <img src="<c:url value="/images/stay_images/${bestReviewStay.image1}" />" alt="이미지1" />
		 			                <img src="<c:url value="/images/stay_images/${bestReviewStay.image2}" />" alt="이미지2" />
	 							</div>
		 			            <h3>${bestReviewStay.stay_name}</h3>
					            <p>${bestReviewStay.stay_addr}</p>
		 			            <p>₩ <fmt:formatNumber value="${bestReviewStay.min_room_price}" type="number" pattern="#,##0" /> ~</p>
	 						</a>
	 					</div>
	 				</c:forEach>
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
				<c:forEach var="cheepStay" items="${cheepStays}" begin="0" end="7">
	 				<div>
	 					<a href="/webPage/stay/StayServlet?requestType=getDetailStayInfo&stay_id=<%=cheepStays.get(i).getStay_id()%>">
	 						<div class="image_slider">
	 			                <img src="<c:url value="/images/stay_images/${cheepStay.image1}" />" alt="이미지1" />
	 			                <img src="<c:url value="/images/stay_images/${cheepStay.image2}" />" alt="이미지2" />	 							
	 						</div>
	 						<h3>${cheepStay.stay_name}</h3>
	 						<p>${cheepStay.road_addr}</p>
	 			            <p>₩ <fmt:formatNumber value="${cheepStay.min_room_price}" type="number" pattern="#,##0" /> ~</p>
	 						<div class="review pop_review">${cheepStay.review_content}</div>
	 					</a>
	 				</div>
	 			</c:forEach>
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
