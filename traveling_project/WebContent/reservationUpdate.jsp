<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pro.reservation.ReservationAcception"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ReservationAcception reservationAcception = new ReservationAcception();
		String reservationId = request.getParameter("reservationId");
		String cancelId = request.getParameter("cancelId");
		out.println(reservationId);
		reservationAcception.reservationAccept(reservationId);
		reservationAcception.reservationReject(cancelId);
		response.sendRedirect("reservation_acception.jsp");
	%>
</body>
</html>