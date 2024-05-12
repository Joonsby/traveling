<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="stadb" class="com.hh.db.ControlDB"/>
<jsp:useBean id="memsta" class="com.hh.db.MemberStatus"/>
<%
    String id = (String)session.getAttribute("id");
    int sum = stadb.statusPrice(id);
    int ndays = stadb.lastTravel(id);
    int tstay = stadb.totalStay(id);
    int tmil = stadb.totalMileage(id);

    String grade = memsta.userGrade(sum);
    int per = memsta.gradePer(grade);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 마지막 여행 ~ -->
<div><p id="ndays"><%=ndays %></p></div>
<!-- 등급 연산 추출 -->
<div><p id="ugrade"><%=grade %></p></div>
<!-- 등급에 맞는 적립율 추출 -->
<div><p id="uper"><%=per %></p></div>
<!-- 총 숙박일수 -->
<div><p id="tstay"><%=tstay %></p></div>
<!-- 누적 마일리지 -->
<div><p id="tmil"><%=tmil %></p></div>

</body>
</html>