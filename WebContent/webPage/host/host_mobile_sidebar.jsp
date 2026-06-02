<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="hostMobileSidebar" class="mobile-sidebar host-mobile-sidebar">
  <div class="mobile-sidebar-header">
    <a href="<c:url value="/webPage/host/host_index.jsp"/>" class="mobile-logo">
      <img src="<c:url value="/images/logo.png"/>" alt="로고 이미지"/>
    </a>
    <button type="button" id="hostMobileCloseBtn" class="mobile-close-btn">×</button>
  </div>

  <ul class="host-mobile-menu">
    <li class="mobile-menu-title">숙소 관리</li>
    <li><a href="<c:url value="/webPage/stay/add_stay.jsp"/>" id="mobile_add_stay_btn">숙소 등록하기</a></li>
    <li><a href="<c:url value="/webPage/room/add_room.jsp"/>">객실 등록하기</a></li>
    <li><a href="#">숙소 정보</a></li>
    <li><a href="#">객실 정보</a></li>

    <li class="mobile-menu-title">예약 관리</li>
    <li><a href="#">예약 정보 조회</a></li>
    <li><a href="/reservation/status">예약 승인/거부</a></li>

    <li class="mobile-menu-title">매출 현황</li>
    <li><a href="#">기간별 매출 조회</a></li>
    <li><a href="#">객실별 매출 조회</a></li>

    <li class="mobile-menu-title">리뷰 관리</li>
    <li><a href="#">리뷰 조회하기</a></li>

    <li class="mobile-menu-title">계정</li>
    <li><a href="#">내 정보</a></li>
    <li><a href="<c:url value="/login/logout"/>">로그아웃</a></li>
  </ul>
</div>

<div id="hostSidebarDim" class="sidebar-dim"></div>