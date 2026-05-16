<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="userId" value="${sessionScope.id}"/>
<header>
  <nav id="menu_nav">
	<div id="logo">
	  <a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>" alt="로고 이미지"/></a>
	</div>
	<form action="/stay/popular" id="accomodation_search" method="post">
	  <div class="input-group">
		  <input type="text" id="region" name="region" class="form-control" placeholder="어디로 떠나시나요?" />
		  <input type="text" id="check_in_date" name="check_in_date" class="form-control datepicker" placeholder="체크인 날짜" readonly />
		  <input type="text" id="check_out_date" name="check_out_date" class="form-control datepicker" placeholder="체크아웃 날짜" readonly />
		  <input type="number" id="people_num" name="people_num" class="form-control" placeholder="인원" min="1" max="15"/>
		  <input type="submit" id="search_btn" class="form-control" value="검색하기" />
	  </div>
	</form>
	<div class="right_menu">
		<c:choose>
			<c:when test="${not empty userId}">
				<div class="menu-item"><a id="my_info" href="/mypage/home">내 정보</a></div>
				<div class="menu-item"><a id="my-plan" href="/plan/my">내 일정</a></div>
				<div class="menu-item"><a id="log-out" href="/login/logout">로그아웃</a></div>
			</c:when>
			<c:otherwise>
				<div class="menu-item"><a id="login" href="/login/select">로그인</a></div>
				<div class="menu-item"><a id="sign-up" href="/signup/select">회원 가입</a></div>
			</c:otherwise>
		</c:choose>
	</div>
	<button type="button" id="mobileMenuBtn" class="mobile-menu-btn">☰</button>
  </nav>
</header>
<%@ include file="/webPage/header/mobile_sidebar.jsp"%>