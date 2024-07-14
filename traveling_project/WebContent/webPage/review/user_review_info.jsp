<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="getInfo" class="com.hh.db.ControlDB" />

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.hh.db.MyPageObj"%>
<%@ page import="com.hh.db.ReservationSort" %>

<%
	String id = (String) session.getAttribute("id");

	ArrayList<MyPageObj> rivConList = getInfo.reviewControlPage(id);
	
	ReservationSort.sortByCheckInDate(rivConList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if (rivConList.size() == 0) {
	%>
	<ul class='index_list'>
		<li>작성한 리뷰가 없습니다.</li>
	</ul>
	<%
		} else {
			for (int i = 0; i < rivConList.size(); i++) {
				String rid = rivConList.get(i).getReservation_id();
				String sname = rivConList.get(i).getStayName();
				String loc = rivConList.get(i).getLocation();
				String chkIn = rivConList.get(i).getCheckInDate();
				String chkOut = rivConList.get(i).getCheckOutDate();
				String rtime = rivConList.get(i).getReviewTime();
	%>
	<ul class="index_list">
		<li><a href="#">
			<span class="r_location"><%=loc %></span> <!-- 예약 테이블의 location 컬럼 -->
			<h6 class="r_stay_name"><%=sname %></h6> <!-- 예약 테이블의 참조키인 방 정보 테이블에서 가져온 숙소 이름 -->
		</a></li>
		<li class="r_chk_date"><%=chkIn %> ~ <%=chkOut %></li>
		<!-- 예약 테이블의 체크인 ~ 체크아웃 날짜 -->
		<li><button class="replace_review_btn" onclick="replace(event)" data-reservation_id="<%=rid%>">상세보기</button></li>
		<li><button class="remove_review_btn" onclick="delete_review(event)" data-reservation_id="<%=rid%>">삭제하기</button></li>
		<li><%=rtime %></li>
		<!-- 리뷰 테이블 최종수정일 -->
	</ul>
	<%
			}
		}
	%>

</body>
</html>