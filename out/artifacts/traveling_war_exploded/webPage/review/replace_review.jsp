<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.traveling.review.dto.ReviewInfo"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<jsp:useBean id="reviewManageDAO" class="com.traveling.review.dao.ReviewManageDAO" />
<%
	String reservationId = request.getParameter("reservationId");
	pageContext.setAttribute("reviewList",reviewManageDAO.reviewReplace(reservationId));
%>
<body>
	<div><p id="riv_title">${reviewList[0].rtitle}</p></div>
	<div><p id="riv_content">${reviewList[0].rcontent()}</p></div>
	<div><p id="riv_rating">${reviewList[0].rating}</p></div>	
	<div><img id="riv_img1" src="<c:url value="/images/review/${reviewList[0].image_path01}"/>" alt="${reviewList[0].image_path01}"/></div>
	<div><img id="riv_img2" src="<c:url value="/images/review/${reviewList[0].image_path02}"/>" alt="${reviewList[0].image_path02}"/></div>
	<div><img id="riv_img3" src="<c:url value="/images/review/${reviewList[0].image_path03}"/>" alt="${reviewList[0].image_path03}"/></div>
	<div><img id="riv_img4" src="<c:url value="/images/review/${reviewList[0].image_path04}"/>" alt="${reviewList[0].image_path04}"/></div>
	<div><img id="riv_img5" src="<c:url value="/images/review/${reviewList[0].image_path05}"/>" alt="${reviewList[0].image_path05}"/></div>
</body>