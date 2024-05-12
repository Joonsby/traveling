<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String id = request.getParameter("host_id");
	String pw = request.getParameter("pw");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	// db 비밀번호
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf-8","root", "xhddlf336!");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from host_info where host_id='" + id + "';");
		if (rs.next()) {
			String hostId = rs.getString("host_id");
			String hostPw = rs.getString("pw");
			String name = rs.getString("name");
			if (id.equals(hostId) && pw.equals(hostPw)) {
				session.setAttribute("host_id", hostId);
				session.setAttribute("pw", hostPw);
				session.setAttribute("name", name);
				response.sendRedirect("hostLogin.condb?comm=hostData");
			} else {
				response.sendRedirect("host_login_fail.html");
			}
		} else {
			response.sendRedirect("host_login_fail.html");
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