<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="host_id" value="${sessionScope.host_id}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/css/host/host_aside.css"/>" />
</head>
<body>
	<aside>
		<ul>
			<li>숙소 관리</li>
			<li><input type="button" class="add_stay_btn" value="숙소 등록하기"></li>
			<li><a href="add_room.jsp">객실 등록하기</a></li>
			<li><a href="/webPage/stay/StayServlet?requestType=getStayInfo&host_id=<c:out value="{host_id}"/>">숙소 정보</a></li>
			<li><a href="room_info.jsp">객실 정보</a></li>
		</ul>
		<ul>
			<li>예약 관리</li>
			<li><a href="#">예약 정보 조회</a></li>
			<li><a href="/webPage/reservation/ReservationServlet?requestType=getReservationStatus">예약 승인/거부</a></li>
			<li><a href="#">지난 예약 내역</a></li>
		</ul>
		<ul>
			<li>매출 현황</li>
			<li><a href="#">기간별 매출 조회</a></li>
			<li><a href="#">객실별 매출 조회</a></li>
		</ul>
		<ul>
			<li>리뷰 관리</li>
			<li><a href="#">리뷰 조회하기</a></li>
			<li><a href="#">리뷰 답글 달기</a></li>
			<li><a href="#">리뷰 신고하기</a></li>
			<li><a href="#">자주 사용된 키워드</a></li>
		</ul>
	</aside>
</body>
</html>