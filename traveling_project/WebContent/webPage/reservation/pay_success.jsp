<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="javax.json.Json"%>
<%@ page import="javax.json.JsonObject"%>
<%@ page import="com.hh.db.ReservationInsert"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="ins" class="com.hh.db.ControlDB" />
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;		
	
	String customerParam = request.getParameter("customer");
	ReservationInsert rinfo = new ReservationInsert();
	NumberFormat formatter = NumberFormat.getInstance();

	if (customerParam != null && !customerParam.isEmpty()) {
		try {						
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf-8", "root", "xhddlf336!");
			stmt = conn.createStatement();
			
			// JSON 파서 생성
			javax.json.JsonReader jsonReader = Json.createReader(new java.io.StringReader(java.net.URLDecoder.decode(customerParam, "UTF-8")));
			JsonObject customerJson = jsonReader.readObject();			

			// JSON 객체에서 필요한 값을 추출
			String uid = customerJson.getString("uid");
			int price = customerJson.getInt("price");
			String rname = customerJson.getString("rname");
			String rid = customerJson.getString("rid");
			String chkin = customerJson.getString("chk_in");
			String chkout = customerJson.getString("chk_out");
			int people = customerJson.getInt("people");
			String chkinTime = customerJson.getString("chk_in_time");
			String chkoutTime = customerJson.getString("chk_out_time");
			
			String userId = (String) session.getAttribute("id");
			
			
	        rs = stmt.executeQuery("SELECT ui.name AS user_name, si.stay_name AS stay_name, ri.room_name AS room_name " + 
					        		"FROM user_info ui, stay_info si " + 
					        		"JOIN room_info ri ON ri.stay_id = si.stay_id " + 
					        		"WHERE ui.user_id = '"+ userId +"'  AND ri.room_id=" + rid + ";");
			if(rs.next()){
				String stay_name = rs.getString("stay_name");
				String room_name = rs.getString("room_name");
				String user_name = rs.getString("user_name");				
				rinfo.setRoom_name(room_name);
				rinfo.setStay_name(stay_name);
				rinfo.setUser_name(user_name);				
			}

			rinfo.setUser_id(uid);
			rinfo.setRoom_id(new Integer(rid));
			rinfo.setCheck_in_date(chkin);
			rinfo.setCheck_out_date(chkout);
			rinfo.setCheck_in_time(chkinTime);
			rinfo.setCheck_out_time(chkoutTime);
			rinfo.setPeople(people);
			rinfo.setPrice(price);

			ins.reservInsert(rinfo);
			jsonReader.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try{
				rs.close();
				stmt.close();
				conn.close();	
			} catch(Exception e){
				e.printStackTrace();
			}
			
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<!-- favicon -->
<link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon" />
<meta charset="UTF-8">
<title>예약 완료</title>
<link rel="stylesheet" href="css/pay_success.css" />
</head>
<body>
	<jsp:include page="../header/header.jsp" />

	<section id="success-reservation">
		<div id="notice-reservation-wrap">
			<div id="notice-reservation">
				<h1>예약이 완료되었습니다.</h1>
				<p>
					호스트가 수락하면 예약이 확정됩니다.<br> 상세 내용은 마이페이지에서 확인 가능합니다.
				</p>
				<p class="reservation-info">
					<strong>숙소 이름 : </strong><%=rinfo.getStay_name()%></p>
				<p class="reservation-info">
					<strong>체크인 날짜 : </strong><%=rinfo.getCheck_in_date()%></p>
				<p class="reservation-info">
					<strong>체크 아웃 날짜 : </strong><%=rinfo.getCheck_out_date()%></p>
				<p class="reservation-info">
					<strong>예약자 성함 : </strong><%=rinfo.getUser_name() %>
				</p>
				<p class="reservation-info">
					<strong>객실 이름 : </strong><%=rinfo.getRoom_name() %>
				</p>
				<p class="reservation-info">
					<strong>인원 수:</strong>
					<%=rinfo.getPeople()%></p>
				<p class="reservation-info">
					<strong>결제 금액 :</strong> ₩<%
						String formattedPrice = formatter.format(rinfo.getPrice());
						out.println(formattedPrice);
					%>
				</p>
			</div>
			<div id="go-mypage">
				<a href="index.jsp" id="go-to-main">메인화면으로 이동하기</a> <a href="my_info.jsp" id="go-mypage-tag">마이페이지로 이동하기</a>
			</div>
		</div>
	</section>


	<div class="go_top"></div>
	<jsp:include page="../footer/footer.jsp" />
</body>
</html>