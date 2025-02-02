<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="userId" value="${sessionScope.id}"/>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="shortcut icon" href="<c:url value="/images/logo.png"/>" type="image/x-icon"/>
    <!-- css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_blue.css">
    <link rel="stylesheet" href="<c:url value="/css/common/reset.css"/>" />
    <link rel="stylesheet" href="<c:url value="/css/header/header.css"/>" />
    <!-- font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com"/>
    <link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
    <!-- script -->
    <script src="<c:url value="/js/common/common.js"/>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>	    
    <script src="<c:url value="/js/header/header.js"/>"></script>
  </head>
<body>
	<header>
      <nav id="menu_nav">
        <h1 id="logo">
          <a href="<c:url value="/index.jsp"/>"><img src="<c:url value="/images/logo.png"/>" alt="로고 이미지"/></a>
        </h1>
        <form action="/webPage/stay/StayServlet?requestType=getPopStayInfo" id="accomodation_search" method="post">
          <div class="input-group">
	          <input type="text" id="region" name="region" class="form-control" placeholder="어디로 떠나시나요?" />
	          <input type="text" id="check_in_date" name="check_in_date" class="form-control datepicker" placeholder="체크인 날짜" readonly />
	          <input type="text" id="check_out_date" name="check_out_date" class="form-control datepicker" placeholder="체크아웃 날짜" readonly />
	          <input type="number" id="people_num" name="people_num" class="form-control" placeholder="인원 수를 선택하세요" min="1" max="15"/>
	          <input type="submit" id="search_btn" class="form-control" value="검색하기" />
          </div>
        </form>
        <div class="right_menu">
          <a href="#" class="ir_pm">내 정보</a>
          <a href="#" class="ir_pm">언어 선택</a>
          <a href="#" class="ir_pm">고객 센터</a>
        </div>
        <ul id="my_info">
        	<c:choose>
    			<c:when test="${not empty userId}">
        			<li><a id="my-info" href="<c:url value="/webPage/mypage/MyPageServlet?requestType=getMyPageInfo"/>">내 정보</a></li>
          			<li><a id="my-plan" href="/webPage/plan/PlanServlet?requestType=myplan">내 일정</a></li>
          			<li><a id="log-out" href="<c:url value="/webPage/login/LoginServlet?requestType=logOut"/>">로그아웃</a></li>
    			</c:when>
    			<c:otherwise>
        			<li><a id="login" href="<c:url value="/webPage/login/login_select.jsp"/>">로그인</a></li>
          			<li><a id="sign-up" href="<c:url value="/webPage/signup/signup_select.jsp"/>">회원 가입</a></li>
    			</c:otherwise>
			</c:choose>
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
</body>
</html>