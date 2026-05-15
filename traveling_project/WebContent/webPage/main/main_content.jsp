<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section id="video">
    <video autoplay loop muted>
        <source src="<c:url value="/video/Banner.mp4"/>" type="video/mp4" />
    </video>
</section>

<!-- 가장 인기가 많은 숙소 -->
<section class="hotel_recommend">
    <h2>가장 인기가 많은 숙소</h2>
    <a href="/stay/popular"><img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" /></a>
    <div class="slider rec_slider">
        <c:forEach var="popStay" items="${popStays}" begin="0" end="7">
            <div>
                <a href="/stay/detail?stay_id=${popStay.stay_id}">
                    <div class="image_slider">
                        <img src="<c:url value="/images/stay_images/${popStay.image1}"/>" alt="이미지1" />
                        <img src="<c:url value="/images/stay_images/${popStay.image2}"/>" alt="이미지2" />
                    </div>
                    <h3>${popStay.stay_name}</h3>
                    <p>${popStay.road_addr}</p>
                    <p>₩ <fmt:formatNumber value="${popStay.min_room_price}" type="number" pattern="#,##0" />~</p>
                    <p class="rec_review review">${popStay.review_content}</p>
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
        <a href="/stay/popular">
            <div><img src="<c:url value="/images/jeju.jpg"/>" alt="제주" /></div>
            <h2>제주</h2>
            <p>숙소 4,878개</p>
        </a>
        <a href="/stay/popular">
            <div><img src="<c:url value="/images/seoul.jpg"/>" alt="서울" /></div>
            <h2>서울</h2>
            <p>숙소 5,923개</p>
        </a>
        <a href="/stay/popular">
            <div><img src="<c:url value="/images/busan.jpg"/>" alt="부산" /></div>
            <h2>부산</h2>
            <p>숙소 2,719개</p>
        </a>
        <a href="/stay/popular">
            <div><img src="<c:url value="/images/sokcho.jpg"/>" alt="속초" /></div>
            <h2>속초</h2>
            <p>숙소 797개</p>
        </a>

        <a href="/stay/popular">
            <div><img src="<c:url value="/images/incheon.jpg"/>" alt="인천" /></div>
            <h2>인천</h2>
            <p>숙소 2,154개</p>
        </a>

        <a href="/stay/popular">
            <div><img src="<c:url value="/images/gangneung.jpg"/>" alt="강릉" /></div>
            <h2>강릉</h2>
            <p>숙소 1,181개</p>
        </a>
    </div>
</section>

<!-- 가장 평점이 높은 숙소 -->
<section id="best-review-stays">
    <div class="swiper mySwiper banner">
        <h2>가장 평점이 높은 숙소</h2>
        <a href="/stay/top-rated"><img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" /></a>
        <div class="slider swiper-wrapper">
            <c:forEach var="bestReviewStay" items="${bestReviewStays}" begin="0" end="7">
                <div class="swiper-slide banner">
                    <a href="/stay/detail?stay_id=${bestReviewStay.stay_id}">
                        <div class="image_slider">
                            <img src="<c:url value="/images/stay_images/${bestReviewStay.image1}"/>" alt="이미지1" />
                            <img src="<c:url value="/images/stay_images/${bestReviewStay.image2}"/>" alt="이미지2" />
                        </div>
                        <h3>${bestReviewStay.stay_name}</h3>
                        <p>${bestReviewStay.stay_addr}</p>
                        <p>₩ <fmt:formatNumber value="${bestReviewStay.min_room_price}" type="number" pattern="#,##0" /> ~ </p>
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
    <a href="/stay/low-price"><img src="<c:url value="/images/view_all.png"/>" alt="모두 보기" /></a>
    <div class="slider pop_slider">
        <c:forEach var="cheapStay" items="${cheapStays}" begin="0" end="7">
            <div>
                <a href="/stay/detail?stay_id=${cheapStay.stay_id}">
                    <div class="image_slider">
                        <img src="<c:url value="/images/stay_images/${cheapStay.image1}"/>" alt="이미지1" />
                        <img src="<c:url value="/images/stay_images/${cheapStay.image2}"/>" alt="이미지2" />
                    </div>
                    <h3>${cheapStay.stay_name}</h3>
                    <p>${cheapStay.stay_addr}</p>
                    <p> ₩ <fmt:formatNumber value="${cheapStay.min_room_price}" type="number" pattern="#,##0" /> ~ </p>
                    <p class="review pop_review"> ${cheapStay.review_content}</p>
                </a>
            </div>
        </c:forEach>
    </div>
    <span id="pop_show_review" class="show_review">리뷰 모두 보기 </span>
</section>

<!-- 이벤트 -->
<section class="event">
    <h2>이벤트</h2>
    <div class="slider event_slider">
        <a href="#"><img src="<c:url value="/images/event1.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event2.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event3.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event4.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event5.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event6.webp"/>" alt="이벤트" /></a>
        <a href="#"><img src="<c:url value="/images/event7.webp"/>" alt="이벤트" /></a>
    </div>
</section>
<div class="go_top"></div>