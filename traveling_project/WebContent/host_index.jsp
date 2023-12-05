<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pro.dto.CheckInInfo"%>
<%@ page import="java.text.DecimalFormat" %>
<%
	String hostId = (String) session.getAttribute("host_id");
	String name = (String) session.getAttribute("name");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- css -->
<link rel="stylesheet" href="css/host_index.css" />
<!-- favicon -->
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- script -->
<title>호스트 페이지</title>
</head>
<body>
	<%@ include file="host_header.jsp"%>
	<%
		hostId = (String) session.getAttribute("hostId");
		name = (String) session.getAttribute("name");
	%>
	<main>
		<%@ include file="host_aside.jsp"%>
		<section>
		<input type="hidden" id="host_id" value="<%= hostId %>">
			<div>
				<h2>
					<%						
						out.println(name + " 님, 안녕하세요!");				
					%>
				</h2>
				<input type="button" class="add_stay_btn" value="숙소 등록하기">	
			</div>
			<span id="underline"></span>
			<div>
				<h3>빠른 예약 조회</h3>
				<a href="#">모든 예약</a>
			</div>
			<div>
				<input type="button" id="check_in_btn" class='btn' value="체크인 예정">
				<input type="button" id="check_out_btn" class='btn' value="체크아웃 예정">
				<input type="button" id="hosting_btn" class='btn' value="현재 호스팅">
				<input type="button" id="empty_review" class='btn' value="답변 안한 후기">
			</div>
			<div>
			<%
				List<CheckInInfo> checkInInfo = (List<CheckInInfo>) request.getAttribute("checkInlist");
				if (checkInInfo.size() != 0) {
					out.println("<table>"+
						"<thead>"+
							"<tr>" +								
								"<th>예약 번호</th>" +
								"<th>방 이름</th>" +
								"<th>사용자 이름</th>" +								
								"<th>인원수</th>" +
								"<th>가격</th>" +
								"<th>체크인 날짜</th>" +
								"<th>체크아웃 날짜</th>" +
								"<th>체크인 시간</th>" +
								"<th>체크아웃 시간</th>" +
								"<th>결제 시간</th>" +								
							"</tr>"+
						"</thead>");
					out.println("<tbody>");
					DecimalFormat df = new DecimalFormat("#,###");
					for (int i = 0; i < checkInInfo.size(); i++) {
						out.println("<tr>" +							
										"<td>" + checkInInfo.get(i).getReservationId() + "</td>" +
										"<td>" + checkInInfo.get(i).getRoomName() + "</td>" +
										"<td>" + checkInInfo.get(i).getUserName() + "</td>" +							 
										"<td>" + checkInInfo.get(i).getPeople() + "</td>" + 
										"<td>" + df.format(checkInInfo.get(i).getPrice()) + "</td>" +  
										"<td>" + checkInInfo.get(i).getCheckInDate() + "</td>" +  
										"<td>" + checkInInfo.get(i).getCheckOutDate() + "</td>" + 
										"<td>" + checkInInfo.get(i).getCheckInTime() + "</td>" +
										"<td>" + checkInInfo.get(i).getCheckOutTime() + "</td>" +
										"<td>" + checkInInfo.get(i).getPaymentTime() + "</td>" +
									"</tr>");																							
					}
					out.println("</tbody>");
					out.println("</table>");
				} else{
					out.println("<p>오늘의 체크인 정보가 없습니다.</p>");
				}
			%>				
			</div>
		</section>
	</main>
	<%@ include file="footer.jsp"%>
</body>
</html>
