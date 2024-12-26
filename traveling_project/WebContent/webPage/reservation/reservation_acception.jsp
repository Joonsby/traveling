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
		pageContext.setAttribute("reservationList",request.getAttribute("reservationList"));
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
					<tbody>
						<c:choose>
							<c:when test="${not empty reservationList}">
								<c:forEach var="reservation" items="${reservationList}" varStatus="status">
									<tr>
										<td><input id="reservation-id-value" type="hidden" value="${reservation.reservationId}"></td>
										<td>${reservation.reservationId }</td>
										<td>${reservation.userId }</td>
										<td>${reservation.roomName }</td>
										<td>${reservation.checkInDate }</td>
										<td>${reservation.checkOutDate }</td>
										<td>${reservation.checkInTime }</td>
										<td>${reservation.checkOutTime }</td>
										<td>${reservation.people }</td>
										<td>${reservation.price }</td>
										<td>${reservation.paymentTime }</td>
										<td>${reservation.status }</td>
										<c:choose>
											<c:when test="${reservation.status} == '예약 대기'">
												<td><input type="button" class='accept_btn' value="승인"><input type='button' class='reject_btn' value='거부'></td>
											</c:when>
										</c:choose>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
				                <tr>
                    				<td colspan="12" style="text-align:center; color:#000; user-select:none; height:455px; line-height:455px;">예약 정보가 없습니다.</td>
                				</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</section>
	</main>
	<%@ include file="../footer/footer.jsp"%>
</body>
</html>
