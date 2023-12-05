<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String hostId = request.getParameter("host_id");	
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String news_agency = request.getParameter("news_agency");
	String phone = request.getParameter("phone");
	String businessNum1 = request.getParameter("business_num1");
	String businessNum2 = request.getParameter("business_num2");
	String businessNum3 = request.getParameter("business_num3");
	String email = request.getParameter("email");
	String email_addr = request.getParameter("email_address");
	String birth_year = request.getParameter("birth_year");
	String birth_month = request.getParameter("birth_month");
	String birth_day = request.getParameter("birth_day");
	String gender = request.getParameter("gender");
	String post_code = request.getParameter("post_code");
	String road_addr = request.getParameter("road_addr");
	String jibun_addr = request.getParameter("jibun_addr");
	String detail_addr = request.getParameter("detail_addr");
	String reference_addr = request.getParameter("reference_addr");	
	String mail = email + "@" + email_addr;
	String birth = birth_year + "-" + birth_month + "-" + birth_day;
	String businessNum = businessNum1 + businessNum2 + businessNum3;
	
	Connection conn = null;
	Statement stmt = null;
	// db 비밀번호
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://15.164.100.42:3306/project?characterEncoding=utf-8", "joonsby", "xhddlf336!");
		stmt = conn.createStatement();
 		stmt.executeUpdate("insert into host_info values ('"
		        + hostId + "', '"
		        + pw + "', '"
		        + name + "', '"
		        + news_agency + "', '"
		        + phone + "', '"
		        + businessNum + "', '"
		        + mail + "', '"
		        + birth + "', '"
		        + gender + "', '"
		        + post_code + "', '"
		        + road_addr + "', '"
		        + jibun_addr + "', '"
		        + detail_addr + "', '"
		        + reference_addr + "', "
		        + "date_format(now(), '%Y%m%d%H%i%s'));");
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
	response.sendRedirect("signup_complete.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
호스트 가입이 완료 되었습니다.
</body>
</html>