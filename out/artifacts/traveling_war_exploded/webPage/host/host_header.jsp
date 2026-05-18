<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="hostId" value="${sessionScope.host_id}"/>
<c:set var="name" value="${sessionScope.name}"/>

<header>
  <nav id="menu_nav">
    <h1 id="logo">
      <a href="<c:url value="/webPage/host/host_index.jsp"/>">
        <img src="<c:url value="/images/logo.png"/>" alt="로고 이미지" />
      </a>
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

    <div class="right_menu">
      <div class="menu-item"><a href="#">내 정보</a></div>
      <div class="menu-item"><a id="log-out" href="<c:url value="/login/logout"/>">로그아웃</a></div>
    </div>

    <button type="button" id="hostMobileMenuBtn" class="mobile-menu-btn">☰</button>
  </nav>
</header>

<%@ include file="/webPage/host/host_mobile_sidebar.jsp"%>