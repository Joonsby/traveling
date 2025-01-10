<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="hostId" value="${sessionScope.host_id}"/>
<c:set var="name" value="${sessionScope.name}"/>
<!DOCTYPE html>
<html>
<head>
<!-- favicon -->
<link rel="shortcut icon" href="<c:url value="/images/logo.png"/>" type="image/x-icon"/>
<!-- css -->
<link rel="stylesheet" href="<c:url value="/css/common/reset.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/header/header.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/header/host_header.css"/>" />
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="<c:url value="/js/common/common.js"/>"></script>
<script src="<c:url value="/js/header/header.js"/>"></script>
<script src="<c:url value="/js/header/host_header.js"/>"></script>
</head>
<body>
	<header>
		<nav id="menu_nav">
			<h1 id="logo">
				<a href="/webPage/stay/StayServlet?requestType=getCheckInList"><img src="<c:url value="/images/logo.png"/>" alt="로고이미지" /></a>
			</h1>
			<ul class="lnb">
				<li>숙소 관리</li>
				<li>예약 관리</li>
				<li>매출 현황</li>
				<li>리뷰 관리</li>
			</ul>
			<ul class="lnb_menu">
				<li>
					<a href="#" id="add_stay_btn">숙소 등록하기</a>
					<a href="<c:url value="/webPage/room/add_room.jsp"/>">객실 등록하기</a>
					<a href="#">숙소 정보</a>
					<a href="#">객실 정보</a>
				</li>
				<li>
					<a href="#">예약 정보 조회</a>
					<a href="/webPage/reservation/ReservationServlet?requestType=getReservationStatus">예약 승인/거부</a>
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
				<li><a href="#">내 정보</a></li>
				<li><a href="<c:url value="/webPage/login/host_logout.jsp"/>">로그 아웃</a></li>
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