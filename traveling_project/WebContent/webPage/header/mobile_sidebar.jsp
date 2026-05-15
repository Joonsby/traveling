<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="userId" value="${sessionScope.id}"/>

<div id="mobileSidebar" class="mobile-sidebar">
  <div class="mobile-sidebar-header">
    <a href="<c:url value="/"/>" class="mobile-logo">
      <img src="<c:url value="/images/logo.png"/>" alt="로고 이미지"/>
    </a>
    <button type="button" id="mobileCloseBtn" class="mobile-close-btn">×</button>
  </div>

  <form action="/stay/popular" id="mobile_search" method="post">
    <input type="text" name="region" placeholder="어디로 떠나시나요?" />
    <input type="text" name="check_in_date" class="datepicker" placeholder="체크인 날짜" readonly />
    <input type="text" name="check_out_date" class="datepicker" placeholder="체크아웃 날짜" readonly />
    <input type="number" name="people_num" placeholder="인원 수를 선택하세요" min="1" max="15"/>
    <input type="submit" value="검색하기" />
  </form>

  <ul class="mobile-right-menu">
    <c:choose>
      <c:when test="${not empty userId}">
        <li><a href="/mypage/home">내 정보</a></li>
        <li><a href="/plan/my">내 일정</a></li>
        <li><a href="/login/logout">로그아웃</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="<c:url value="/webPage/login/login_select.jsp"/>">로그인</a></li>
        <li><a href="<c:url value="/webPage/signup/signup_select.jsp"/>">회원 가입</a></li>
      </c:otherwise>
    </c:choose>
  </ul>
</div>

<div id="sidebarDim" class="sidebar-dim"></div>