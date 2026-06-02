<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
    <a href="/stay/detail?stay_id=${stay.stay_id}">
        <div class="image_slider">
            <img src="<c:url value="/images/stay_images/${stay.image1}"/>" alt="이미지1" />
            <img src="<c:url value="/images/stay_images/${stay.image2}"/>" alt="이미지2" />
        </div>
        <h3>${stay.stay_name}</h3>
        <p>${stayAddress}</p>
        <p>
            ₩ <fmt:formatNumber value="${stay.min_room_price}" type="number" pattern="#,##0" /> ~
        </p>
        <c:if test="${not empty reviewClass}">
            <p class="${reviewClass}">${stay.review_content}</p>
        </c:if>
    </a>
</div>