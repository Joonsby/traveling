<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String host_id = (String) session.getAttribute("host_id");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/host_aside.css" />
</head>
<body>
	<aside>
		<ul>
			<li>숙소 관리</li>
			<li><input type="button" class="add_stay_btn" value="숙소 등록하기"></li>
			<li><a href="add_room.jsp">객실 등록하기</a></li>
			<li><a href="stay_info.condb?comm=edit_stay&host_id=<%=host_id%>">숙소 정보</a></li>
			<li><a href="room_info.jsp">객실 정보</a></li>
		</ul>
		<ul>
			<li>예약 관리</li>
			<li><a href="#">예약 정보 조회</a></li>
			<li><a href="reservation_acception.jsp">예약 승인/거부</a></li>
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