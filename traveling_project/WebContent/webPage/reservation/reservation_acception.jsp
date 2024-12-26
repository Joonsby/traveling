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
<script src="<c:url value="/js/reservation/reservation_acception.js"/>"></script>
<title>호스트 페이지</title>
</head>
<body>
	<%
		pageContext.setAttribute("reservationList",request.getAttribute("reservationList"));
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
										<td style="display:none"><input id="reservation-id-value" type="hidden" value="${reservation.reservation_id}"></td>
										<td>${reservation.reservation_id }</td>
										<td>${reservation.name }</td>
										<td>${reservation.room_name }</td>
										<td>${reservation.check_in_date }</td>
										<td>${reservation.check_out_date }</td>
										<td>${reservation.check_in_time }</td>
										<td>${reservation.check_out_time }</td>
										<td>${reservation.people }</td>
										<td>${reservation.price }</td>
										<td>${reservation.payment_time }</td>
										<td>${reservation.status }</td>
										<c:choose>
											<c:when test="${reservation.status eq '예약 대기'}">
												<td><input type="button" class='accept_btn' value="승인"><input type='button' class='reject_btn' value='거부'></td>
											</c:when>
											<c:when test="${reservation.status eq '예약 확정'}">
												<td style="color:#1aa3ff">${reservation.status }</td>
											</c:when>
											<c:when test="${reservation.status eq '예약 취소'}">
												<td style="color:red">${reservation.status }</td>
											</c:when>
											<c:when test="${reservation.status eq '예약 거부'}">
												<td style="color:red">${reservation.status }</td>
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
