<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	// db 비밀번호
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://15.164.100.42:3306/project?characterEncoding=utf-8","joonsby", "xhddlf336!");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from user_info where user_id='" + id + "';");
		if (rs.next()) {
			String userId = rs.getString("user_id");
			String userPw = rs.getString("pw");
			if (userId.equals(id) && userPw.equals(pw)) {
				session.setAttribute("id", id);
				session.setAttribute("pw", pw);
				response.sendRedirect("user_index.jsp");
			} else {
				response.sendRedirect("user_login_fail.html");
			}
		} else {
			response.sendRedirect("user_login_fail.html");
		}
	} finally {
		try {
			stmt.close();
		} catch (Exception ignored) {

		}
		try {
			conn.close();
		} catch (Exception ignored) {

		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>