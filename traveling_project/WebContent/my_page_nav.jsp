<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/nav.css" />
</head>
<body>
	<nav id="member_contents_nav">
		<!-- 왼쪽 nav -->
		<h2>전체 메뉴</h2>
		<h3>내 예약</h3>
		<ul>
			<li><a href="./my_info.jsp">예약정보</a></li>
			<li><a href="#">취소/환불정보</a></li>
			<li><a href="#">찜 목록</a></li>
			<li><a href="myplan.condb?comm=myplan">내 일정</a></li>
			<li><a href="#">메시지</a></li>
			<li><a href="./review_control.jsp">리뷰관리</a></li>
		</ul>
		<h3>내 계정</h3>
		<ul>
			<li><a href="#">회원정보 확인/수정</a></li>
			<li><a href="#">등급 별 혜택</a></li>
			<li><a href="#">쿠폰/마일리지</a></li>
			<li><a href="#">회원탈퇴</a></li>
		</ul>
		<h3>고객센터</h3>
		<ul>
			<li><a href="#">1:1문의</a></li>
			<li><a href="#">공지사항</a></li>
			<li><a href="#">FAQ</a></li>
		</ul>
		<h3>로그아웃</h3>
		<a href="logout.jsp">로그아웃</a>
	</nav>

</body>
</html>