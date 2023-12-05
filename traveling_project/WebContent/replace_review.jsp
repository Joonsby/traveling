<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hh.db.ReviewObj"%>
<!DOCTYPE html>
<jsp:useBean id="selReview" class="com.hh.db.ControlDB" />
<%
	String rid = request.getParameter("reservationId");

	ReviewObj riv = selReview.reviewReplace(rid);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<p id="riv_title"><%=riv.getRtitle()%></p>
	</div>
	<div>
		<p id="riv_content"><%=riv.getRcontent()%></p>
	</div>
	<div>
		<p id="riv_rating"><%=riv.getRating()%></p>
	</div>
	
	<div>
		<img id="riv_img1" src="<%= request.getContextPath() %>/images/review/<%= riv.getImage_path01() %>" alt="<%= riv.getImage_path01() %>">
	</div>
	<div>
		<img id="riv_img2" src="<%= request.getContextPath() %>/images/review/<%= riv.getImage_path02() %>" alt="<%= riv.getImage_path02() %>">
	</div>
	<div>
		<img id="riv_img3" src="<%= request.getContextPath() %>/images/review/<%= riv.getImage_path03() %>" alt="<%= riv.getImage_path03() %>">
	</div>
	<div>
		<img id="riv_img4" src="<%= request.getContextPath() %>/images/review/<%= riv.getImage_path04() %>" alt="<%= riv.getImage_path04() %>">
	</div>
	<div>
		<img id="riv_img5" src="<%= request.getContextPath() %>/images/review/<%= riv.getImage_path05() %>" alt="<%= riv.getImage_path05() %>">
	</div>

</body>
</html>