<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.traveling.review.dto.MyPageInfo"%>
<%@ page import="com.traveling.review.dao.ReviewManageDAO"%>
<%@ page import="com.traveling.reservation.dao.ReservationManageDAO"%>
<%
	String id = (String) session.getAttribute("id");
	ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
	ReviewManageDAO reviewManageDAO = ReviewManageDAO.instance();
	
	pageContext.setAttribute("reservationInfoList",reservationManageDAO.getReservationInfo(id));
	pageContext.setAttribute("reservReview",reviewManageDAO.hasReview(id));
%>
<html>
<head>
<title>예약 정보</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty reservationInfoList}">
			<ul class='index_list'>
				<li>예약정보가 없습니다.</li>
			</ul>
		</c:when>
		<c:otherwise>
			<c:forEach var="reservationInfo" items="${reservationInfoList}">
				<ul class="index_list">
					<li><span class="r_location">${reservationInfo.location}</span></li>
					<li class="r_chk_date">${reservationInfo.checkInDate} ~ ${reservationInfo.checkOutDate}</li>
					<li class="r_people">${reservationInfo.people}</li>
					<li><a href="#" class="detail_reservation">상세보기</a></li>
					<c:choose>
						<c:when test="${fn:contains(reservReview,reservationInfo.reservation_id)}">
							<li>
								<div class="review-container">
									<button class='review_modal review_written' data-reservation_id="${reservationInfo.reservation_id}" disabled>작성완료</button>
									<p id="tooltipText${reservationInfo.reservation_id}" class="tooltip-text">작성된 리뷰는 리뷰관리 페이지에서 확인 가능합니다</p>
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${reservationInfo.status eq '예약 확정'}">
									<li><button class='review_modal' onclick="modal(event)" data-reservation_id="${reservationInfo.reservation_id}">작성하기</button></li>
								</c:when>
								<c:otherwise>
									<li>
										<div class="review-container">
											<button class='review_modal reserv_can' data-reservation_id="${reservationInfo.reservation_id}" disabled>작성불가</button>
											<p id="tooltipText${reservationInfo.reservation_id}" class="tooltip-text">예약이 확정되지 않았거나 취소/거부 된 경우 작성할 수 없습니다</p>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</ul>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>
