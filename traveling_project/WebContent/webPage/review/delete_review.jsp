<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.traveling.review.dao.ReviewManageDAO" %>
<!DOCTYPE html>
<jsp:useBean id="del" class="com.hh.db.ControlDB" />
<%
	ReviewManageDAO reviewManageDAO = ReviewManageDAO.instance();
	String reservationId = (String) request.getParameter("reservationId");
	reviewManageDAO.reviewDelete(reservationId);	
%>