<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/host_header.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.pro.reservation.ReservationInfo"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/css/host/host_common.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/host/host_aside.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/reservation/reservation_acception.css"/>" />
<!-- script -->
<script src="<c:url value="/js/host/host_header.js"/>"></script>
<script src="<c:url value="/js/reservation/reservation_acception.js"/>"></script>
<title>호스트 페이지</title>
</head>
<body>
	<jsp:useBean id="reservationAcception" class="com.pro.reservation.ReservationAcception" scope="page" />
	<%
		// 예약 대기중인 예약 테이블 객체 배열
		ArrayList<ReservationInfo> rwArr = reservationAcception.reservationWaiting(hostId);
		// 예약 확정된 예약 테이블 객체 배열
		ArrayList<ReservationInfo> rcArr = reservationAcception.reservationConfirmed(hostId);
		// 예약 거부된 예약 테이블 객체 배열
		ArrayList<ReservationInfo> rRArr = reservationAcception.reservationRejected(hostId);
		// 예약 취소된 예약 테이블 객체 배열
		ArrayList<ReservationInfo> rCancArr = reservationAcception.reservationCancelled(hostId);
	%>
	<main>
		<%@ include file="../host/host_aside.jsp"%>
		<section>
			<h2>예약 승인/거부</h2>
			<div id="reservation_table">
				<table>
					<thead>
						<tr>
							<th>예약 번호</th>
							<th>예약자 성함</th>
							<th>객실 이름</th>
							<th>체크인 날짜</th>
							<th>체크 아웃 날짜</th>
							<th>체크인 시간</th>
							<th>체크 아웃 시간</th>
							<th>인원수</th>
							<th>결제 금액</th>
							<th>결제 시간</th>
							<th>예약 상태</th>
							<th id="note">비고</th>
						</tr>
					</thead>
					<%
						// 예약 대기
						if (rwArr.size() != 0) {
							for (int i = 0; i < rwArr.size(); i++) {
					%>
						<tr>
							<td><input id="reservation-id-value" type="hidden" value="<%=rwArr.get(i).getReservationId()%>"></td>
							<td><%=rwArr.get(i).getReservationId()%></td>
							<td><%=rwArr.get(i).getUserId()%></td>
							<td><%=rwArr.get(i).getRoomName()%></td>
							<td><%=rwArr.get(i).getCheckInDate()%></td>
							<td><%=rwArr.get(i).getCheckOutDate()%></td>
							<td><%=rwArr.get(i).getCheckInTime()%></td>
							<td><%=rwArr.get(i).getCheckOutTime()%></td>
							<td><%=rwArr.get(i).getPeople()%></td>
							<td><%=rwArr.get(i).getPrice()%></td>
							<td><%=rwArr.get(i).getPaymentTime()%></td>
							<td style='color: #999'><%=rwArr.get(i).getStatus()%></td>
							<td><input type="button" class='accept_btn' value="승인"><input type='button' class='reject_btn' value='거부'></td>
						</tr>
					<%
						}
							// 예약 확정
							for (int i = 0; i < rcArr.size(); i++) {
					%>
						<tr>
							<td><%=rcArr.get(i).getReservationId() %></td>
							<td><%=rcArr.get(i).getUserId() %></td>
							<td><%=rcArr.get(i).getRoomName() %></td>
							<td><%=rcArr.get(i).getCheckInDate() %></td>
							<td><%=rcArr.get(i).getCheckOutDate() %></td>
							<td><%=rcArr.get(i).getCheckInTime() %></td>
							<td><%=rcArr.get(i).getCheckOutTime() %></td>
							<td><%=rcArr.get(i).getPeople() %></td>
							<td><%=rcArr.get(i).getPrice() %></td>
							<td><%=rcArr.get(i).getPaymentTime() %></td>
							<td style="color:#1a44ff; font-weight:bold;"><%=rcArr.get(i).getStatus() %></td>
							<td>-</td>								
						</tr>
					<%
							}					
							// 예약 거부
							for (int i = 0; i < rRArr.size(); i++) {
					%>
							<tr>
								<td><%=rRArr.get(i).getReservationId() %></td>
								<td><%=rRArr.get(i).getUserId() %></td>
								<td><%=rRArr.get(i).getRoomName() %></td>
								<td><%=rRArr.get(i).getCheckInDate() %></td>
								<td><%=rRArr.get(i).getCheckOutDate() %></td>
								<td><%=rRArr.get(i).getCheckInTime() %></td>
								<td><%=rRArr.get(i).getCheckOutTime() %></td>
								<td><%=rRArr.get(i).getPeople() %></td>
								<td><%=rRArr.get(i).getPrice() %></td>
								<td><%=rRArr.get(i).getPaymentTime() %></td>
								<td style='color:red;font-weight:bold'><%=rRArr.get(i).getStatus() %></td>
								<td>-</td>
							</tr>
					<%
							}
							// 예약 취소
							for (int i = 0; i < rCancArr.size(); i++) {
					%>
							<tr>
								<td><%=rCancArr.get(i).getReservationId() %></td>
								<td><%=rCancArr.get(i).getUserId() %></td>
								<td><%=rCancArr.get(i).getRoomName() %></td>
								<td><%=rCancArr.get(i).getCheckInDate() %></td>
								<td><%=rCancArr.get(i).getCheckOutDate() %></td>
								<td><%=rCancArr.get(i).getCheckInTime() %></td>
								<td><%=rCancArr.get(i).getCheckOutTime() %></td>
								<td><%=rCancArr.get(i).getPeople() %></td>
								<td><%=rCancArr.get(i).getPrice() %></td>
								<td><%=rCancArr.get(i).getPaymentTime() %></td>
								<td style='color:red;font-weight:bold'><%=rCancArr.get(i).getStatus() %></td>
								<td>-</td>
							</tr>
					<%
							}
						}
					%>					
				</table>
				<%
					if (rwArr.size() == 0 && rcArr.size() == 0 && rRArr.size() == 0 && rCancArr.size() == 0) {
				%>
				<p style='height:466px; line-height:466px; color:#000; user-select:none;'>예약 정보가 없습니다.</p>
				<%
					}
				%>				
			</div>
		</section>
	</main>
	<%@ include file="../footer/footer.jsp"%>
</body>
</html>
