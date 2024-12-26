<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pro.reservation.ReservationAcception"%>
<%
	ReservationAcception reservationAcception = new ReservationAcception();
	String reservationId = request.getParameter("reservationId");
	String cancelId = request.getParameter("cancelId");
	out.println(reservationId);
	reservationAcception.reservationAccept(reservationId);
	reservationAcception.reservationReject(cancelId);
	response.sendRedirect("reservation_acception.jsp");
%>