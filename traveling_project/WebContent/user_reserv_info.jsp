<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="getInfo" class="com.hh.db.ControlDB" />

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hh.db.MyPageObj"%>
<%@ page import="com.hh.db.ReservationSort"%>

<%
	String id = (String) session.getAttribute("id");

	ArrayList<MyPageObj> rinfoList = getInfo.getReservInfo(id);

	ReservationSort.sortByCheckInDate(rinfoList);

	List<Integer> reservReview = getInfo.hasReview(id);
%>
<html>
<head>
<title>Reservation Info</title>
</head>
<body>
	<%
		if (rinfoList.size() == 0) {
	%>
	<ul class='index_list'>
		<li>예약정보가 없습니다.</li>
	</ul>
	<%
		} else {
			for (int i = 0; i < rinfoList.size(); i++) {
				String rid = rinfoList.get(i).getReservation_id();
				String chkIn = rinfoList.get(i).getCheckInDate();
				String chkOut = rinfoList.get(i).getCheckOutDate();
				int people = rinfoList.get(i).getPeople();
				String stat = rinfoList.get(i).getStatus();
				String stayName = rinfoList.get(i).getStayName();
				String location = rinfoList.get(i).getLocation();

				boolean hasReview = reservReview.contains(Integer.parseInt(rid)); // 리뷰 작성 여부 확인
	%>
	<ul class='index_list'>
		<li><a href='#'> <span class='r_location'><%=location%></span>
		<h6 class='r_stay_name'><%=stayName%></h6>
		</a></li>
		<li class='r_chk_date'><%=chkIn%> ~ <%=chkOut%></li>
		<li class='r_people'><%=people%></li>
		<li><a href='#' class='detail_reservation'>상세보기</a></li>
		<%
			if (hasReview) {
		%>
		<!-- 리뷰 작성이 이미 완료된 경우 -->
		<li>
			<div class="review-container">
				<button class='review_modal review_written' data-reservation_id="<%=rid%>" disabled>작성완료</button>
				<p id="tooltipText<%=rid%>" class="tooltip-text">작성된 리뷰는 리뷰관리 페이지에서 확인 가능합니다</p>
			</div>
		</li>
		<%
			} else {
				if (stat.equals("예약 취소") || stat.equals("예약 거부") || stat.equals("예약 대기")) {
		%>
		<li>
			<div class="review-container">
				<button class='review_modal reserv_can' data-reservation_id="<%=rid%>" disabled>작성불가</button>
				<p id="tooltipText<%=rid%>" class="tooltip-text">예약이 확정되지 않았거나 취소/거부 된 경우 작성할 수 없습니다</p>
			</div>
		</li>
		<%
			} else {
		%>
		<!-- 리뷰 작성이 아직 안 된 경우 -->
		<li><button class='review_modal' onclick="modal(event)" data-reservation_id="<%=rid%>">작성하기</button></li>
		<%
			}
					}
		%>
	</ul>
	<%
		}
		}
	%>
</body>
</html>
