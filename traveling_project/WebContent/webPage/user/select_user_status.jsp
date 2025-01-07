<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myPageManageDAO" class="com.traveling.mypage.dao.MyPageManageDAO"/>
<%
    String id = (String)session.getAttribute("id");
    int sum = myPageManageDAO.statusPrice(id);
    int ndays = myPageManageDAO.lastTravel(id);
    int tstay = myPageManageDAO.totalStay(id);
    int tmil = myPageManageDAO.totalMileage(id);
    
	String grade = null;
	if (sum >= 3000000) { // 결제금액 300만원 이상
		grade = "VIP";
	} else if (sum >= 1000000) { // 100만원 이상
		grade = "GOLD";
	} else {
		grade = "SILVER"; // 기본 등급
	}
	
	int per = 0;	
	if (grade.equals("VIP")) {
		per = 5;
	} else if (grade.equals("GOLD")) {
		per = 3;
	} else {
		per = 1;
	}
	
	request.setAttribute("sum",sum);
	request.setAttribute("grade",grade);
	request.setAttribute("per",per);
	request.setAttribute("tstay",tstay);
	request.setAttribute("tmil",tmil);
%>
<body>
	<div><p id="ndays"><c:out value="${ndays}"/></p></div>
	<div><p id="ugrade"><c:out value="${grade}"/></p></div>
	<div><p id="uper"><c:out value="${per}"/></p></div>
	<div><p id="tstay"><c:out value="${tstay}"/></p></div>
	<div><p id="tmil"><c:out value="${tmil}"/></p></div>
</body>