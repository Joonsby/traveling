<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<%@ page import="com.traveling.review.dto.MyPageInfo"%>
<jsp:useBean id="reviewManageDAO" class="com.traveling.review.dao.ReviewManageDAO" />
<%
	String id = (String) session.getAttribute("id");
	List<MyPageInfo> reviewList = reviewManageDAO.getReviewList(id);
	pageContext.setAttribute("reviewList",reviewManageDAO.getReviewList(id));
%>
<body>
	<c:choose>
		<c:when test="${empty reviewList}">
			<ul class='index_list'>
				<li>작성한 리뷰가 없습니다.</li>
			</ul>			
		</c:when>
		<c:otherwise>
			<c:forEach var="review" items="${reviewList}">
				<ul class="index_list">
					<li><a href="#">
						<span class="r_location">${review.reservation_id}</span> <!-- 예약 테이블의 location 컬럼 -->
						<h6 class="r_stay_name">${review.stayName}</h6> <!-- 예약 테이블의 참조키인 방 정보 테이블에서 가져온 숙소 이름 -->
					</a></li>
					<li class="r_chk_date">${review.checkInDate} ~ ${review.checkOutDate}</li>
					<!-- 예약 테이블의 체크인 ~ 체크아웃 날짜 -->
					<li><button class="replace_review_btn" onclick="replace(event)" data-reservation_id="${review.reservation_id}">상세보기</button></li>
					<li><button class="remove_review_btn" onclick="delete_review(event)" data-reservation_id="${reviewList.reservation_id}">삭제하기</button></li>
					<li>${review.reviewTime}</li>
					<!-- 리뷰 테이블 최종수정일 -->
				</ul>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>