<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<section id="video">
    <video autoplay loop muted>
        <source src="<c:url value="/video/Banner.mp4"/>" type="video/mp4" />
    </video>
</section>

<section class="hotel_recommend">
    <h2>가장 인기가 많은 숙소</h2>
    <a href="/stay/popular">
        <img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" />
    </a>
    <div class="slider rec_slider">
        <c:forEach var="popStay" items="${popStays}">
            <c:set var="stay" value="${popStay}" scope="request"/>
            <c:set var="stayAddress" value="${popStay.road_addr}" scope="request"/>
            <c:set var="reviewClass" value="rec_review review" scope="request"/>
            <jsp:include page="/webPage/common/stay_card.jsp"/>
        </c:forEach>
    </div>
    <span id="rec_show_review" class="show_review">리뷰 모두 보기</span>
</section>

<section class="korea_popular_region">
    <h2>국내 인기 여행지</h2>
    <c:set var="regions" value="jeju.jpg,제주,4,878|seoul.jpg,서울,5,923|busan.jpg,부산,2,719|sokcho.jpg,속초,797|incheon.jpg,인천,2,154|gangneung.jpg,강릉,1,181"/>
    <div class="slider">
        <c:forEach var="region" items="${fn:split(regions, '|')}">
            <c:set var="regionInfo" value="${fn:split(region, ',')}"/>
            <a href="/stay/popular">
                <div>
                    <img src="<c:url value="/images/${regionInfo[0]}"/>" alt="${regionInfo[1]}" />
                </div>
                <h2>${regionInfo[1]}</h2>
                <p>숙소 ${regionInfo[2]}개</p>
            </a>
        </c:forEach>
    </div>
</section>

<section id="best-review-stays">
    <div class="swiper mySwiper banner">
        <h2>가장 평점이 높은 숙소</h2>
        <a href="/stay/top-rated">
            <img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" />
        </a>
        <div class="slider swiper-wrapper">
            <c:forEach var="bestReviewStay" items="${bestReviewStays}">
                <div class="swiper-slide banner">
                    <c:set var="stay" value="${bestReviewStay}" scope="request"/>
                    <c:set var="stayAddress" value="${bestReviewStay.stay_addr}" scope="request"/>
                    <c:set var="reviewClass" value="" scope="request"/>
                    <jsp:include page="/webPage/common/stay_card.jsp"/>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
</section>

<section class="popular_accomodation">
    <h2>가격이 저렴한 숙소</h2>
    <a href="/stay/low-price">
        <img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" />
    </a>
    <div class="slider pop_slider">
        <c:forEach var="cheapStay" items="${cheapStays}">
            <c:set var="stay" value="${cheapStay}" scope="request"/>
            <c:set var="stayAddress" value="${cheapStay.stay_addr}" scope="request"/>
            <c:set var="reviewClass" value="review pop_review" scope="request"/>
            <jsp:include page="/webPage/common/stay_card.jsp"/>
        </c:forEach>
    </div>
    <span id="pop_show_review" class="show_review">리뷰 모두 보기</span>
</section>

<section class="event">
    <h2>이벤트</h2>
    <c:set var="eventImages" value="event1.webp,event2.webp,event3.webp,event4.webp,event5.webp,event6.webp,event7.webp"/>
    <div class="slider event_slider">
        <c:forEach var="eventImage" items="${fn:split(eventImages, ',')}">
            <a href="#">
                <img src="<c:url value="/images/${eventImage}"/>" alt="이벤트" />
            </a>
        </c:forEach>
    </div>
</section>

<div class="go_top"></div>