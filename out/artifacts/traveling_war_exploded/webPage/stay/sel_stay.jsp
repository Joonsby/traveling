<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String hostId = request.getParameter("hostId");
	String result = "false";
	Connection conn = null;
	Statement stmt = null;
	// db 비밀번호
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "xhddlf336!");
			if (conn == null) {
				throw new Exception("데이터베이스에 연결할 수 없습니다.<br>");
			}
			stmt= conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM stay_info WHERE host_id = '" + hostId + "';");
			if (rs.next()) {
				result = "true";
			} else{
				result = "false";
			}
		} finally {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		out.print(result);
%>