<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* String hostId = (String) session.getAttribute("host_id");
	String name = (String) session.getAttribute("name"); */	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- css -->
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/header.css" />
<link rel="stylesheet" href="css/host_header.css" />
<!-- favicon -->
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap"
	rel="stylesheet" />
<!-- jquery -->
rk dkslq
<!-- script -->
<script src="js/header.js"></script>
<script src="js/host_header.js"></script>
<script src="js/host_index.js"></script>
</head>
<body>
	<%-- <input type="hidden" id="host_id" value="<%= hostId %>"> --%>
	<header>
		<nav id="menu_nav">
			<h1 id="logo">
				<a href="host_index.condb?comm=hostData"><img src="images/logo.png" alt="" /></a>
			</h1>
			<ul class="lnb">
				<li>숙소 관리</li>
				<li>예약 관리</li>
				<li>매출 현황</li>
				<li>리뷰 관리</li>
			</ul>
			<ul class="lnb_menu">
				<li>
					<input type="button" class="add_stay_btn" value="숙소 등록하기">				
					<a href="add_room.jsp">객실 등록하기</a>
					<a href="#">숙소 정보</a>
					<a href="#">객실 정보</a>
				</li>
				<li>
					<a href="#">예약 정보 조회</a>
					<a href="reservation_acception.jsp">예약 승인/거부</a>
					<a href="#">지난 예약 내역</a>
				</li>
				<li>
					<a href="#">기간별 매출 조회</a>
					<a href="#">객실별 매출 조회</a>
				</li>
				<li>
					<a href="#">리뷰 조회하기</a>
					<a href="#">리뷰 답글 달기</a>
					<a href="#">리뷰 신고하기</a>
					<a href="#">자주 사용된 키워드</a>
				</li>
			</ul>
			<div class="right_menu">
				<a href="#" class="ir_pm">내정보</a>
				<a href="#" class="ir_pm">언어 선택</a>
				<a href="#" class="ir_pm">고객 센터</a>
			</div>
			<ul id="my_info">
				<li><a href="login_select.jsp">내 정보</a></li>
				<li><a href="host_logout.jsp">로그 아웃</a></li>
			</ul>
		</nav>
	</header>
		<div class="main_modal" id="myModal">
   		<div class="modal-content">
        	<span class="close" id="closeModal"></span>
        	<p>하나의 계정당 한개의 숙소만 등록 가능합니다.</p>
    	</div>
	</div>
</body>
</html>