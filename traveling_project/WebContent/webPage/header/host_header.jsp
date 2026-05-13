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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
	<link rel="stylesheet" href="<c:url value="/css/common/reset.css"/>" />
	<link rel="stylesheet" href="<c:url value="/css/common/common.css"/>" />
	<link rel="stylesheet" href="<c:url value="/css/header/header.css"/>" />
	<link rel="stylesheet" href="<c:url value="/css/header/host_header.css"/>" />
	<!-- font -->
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap"/>
	<!-- script -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="<c:url value="/js/common/common.js"/>"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="<c:url value="/js/header/host_header.js"/>"></script>
</head>
<body>
	<header>
		<nav id="menu_nav">
			<h1 id="logo">
				<a href="<c:url value="/webPage/host/host_index.jsp"/>"><img src="<c:url value="/images/logo.png"/>" alt="로고이미지" /></a>
			</h1>
			<ul class="lnb">
				<li>숙소 관리</li>
				<li>예약 관리</li>
				<li>매출 현황</li>
				<li>리뷰 관리</li>
			</ul>
			<ul class="lnb_menu">
				<li>
					<a href="<c:url value="/webPage/stay/add_stay.jsp"/>" id="add_stay_btn">숙소 등록하기</a>
					<a href="<c:url value="/webPage/room/add_room.jsp"/>">객실 등록하기</a>
					<a href="#">숙소 정보</a>
					<a href="#">객실 정보</a>
				</li>
				<li>
					<a href="#">예약 정보 조회</a>
					<a href="/reservation/status">예약 승인/거부</a>
				</li>
				<li>
					<a href="#">기간별 매출 조회</a>
					<a href="#">객실별 매출 조회</a>
				</li>
				<li>
					<a href="#">리뷰 조회하기</a>
				</li>
			</ul>
			<ul class="right_menu">
				<li><a href="#">내 정보</a></li>
				<li><a id="log-out" href="<c:url value="/login/logout"/>">로그아웃</a></li>
			</ul>
		</nav>
	</header>
	
    <!-- Modal -->
	<div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="ModalLabel"></h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body"><p></p></div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Confirm Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="confirmModalLabel">확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p class="mb-0">정말 진행하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="confirmOkBtn" class="btn btn-primary">확인</button>
	        <button type="button" id="confirmCancelBtn" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>