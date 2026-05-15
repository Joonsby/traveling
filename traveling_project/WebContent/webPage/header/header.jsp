<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="userId" value="${sessionScope.id}"/>

<header>
  <nav id="menu_nav">
    <h1 id="logo">
      <a href="<c:url value="/"/>">
        <img src="<c:url value="/images/logo.png"/>" alt="로고 이미지"/>
      </a>
    </h1>

    <form action="/stay/popular" id="accomodation_search" method="post">
      <div class="input-group">
        <input type="text" id="region" name="region" class="form-control" placeholder="어디로 떠나시나요?" />
        <input type="text" id="check_in_date" name="check_in_date" class="form-control datepicker" placeholder="체크인 날짜" readonly />
        <input type="text" id="check_out_date" name="check_out_date" class="form-control datepicker" placeholder="체크아웃 날짜" readonly />
        <input type="number" id="people_num" name="people_num" class="form-control" placeholder="인원" min="1" max="15"/>
        <input type="submit" id="search_btn" class="form-control" value="검색하기" />
      </div>
    </form>

    <ul class="right_menu">
      <c:choose>
        <c:when test="${not empty userId}">
          <li><a id="my-info" href="/mypage/home">내 정보</a></li>
          <li><a id="my-plan" href="/plan/my">내 일정</a></li>
          <li><a id="log-out" href="/login/logout">로그아웃</a></li>
        </c:when>
        <c:otherwise>
          <li><a id="login" href="<c:url value="/webPage/login/login_select.jsp"/>">로그인</a></li>
          <li><a id="sign-up" href="<c:url value="/webPage/signup/signup_select.jsp"/>">회원 가입</a></li>
        </c:otherwise>
      </c:choose>
    </ul>

    <button type="button" id="mobileMenuBtn" class="mobile-menu-btn">☰</button>
  </nav>
</header>

<%@ include file="/webPage/header/mobile_sidebar.jsp"%>