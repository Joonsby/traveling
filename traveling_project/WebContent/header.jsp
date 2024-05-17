<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String id = (String) session.getAttribute("id");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="uid" value="<%=id %>"/>
<html>
  <head>
    <meta charset="UTF-8" />    	
    <!-- css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/header.css" />  
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />    
    <!-- font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
    <!-- script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>    
    <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>   
    <script src="js/header.js"></script>
    <script src="js/main.js"></script>
    <title>Traveling</title>
  </head>
<body>
    <header>
      <nav id="menu_nav">
        <h1 id="logo">
          <a href="index.jsp"><img src="images/logo.png" alt=""/></a>
        </h1>
        <form action="search_stays.condb?comm=pop_stays" id="accomodation_search" method="post">
          <input type="text" name="region" id="region" required placeholder="어디로 떠나시나요?" />
          <input type="text" name="check_in_date" id="check_in_date" class="date" placeholder="체크인 날짜" required readonly/>
          <span class="calendar_image"></span>
          <input type="text" name="check_out_date" id="check_out_date" class="date" placeholder="체크 아웃 날짜" required readonly/>
          <span class="calendar_image"></span>
          <input type="text" name="people_num" id="people_num" placeholder="인원 수를 선택하세요" readonly/>
          <input id="search_btn" type="submit" value="검색하기" />
        </form>
        <div id="guests-dropdown">
	        <div id="button-box">
	        	<input type="button" id="minus" value="-">
	        	<span id="number">1</span>
	        	<input type="button" id="plus" value="+">
	        </div>        	
        </div>
        <div class="right_menu">
          <a href="#" class="ir_pm">내 정보</a>
          <a href="#" class="ir_pm">언어 선택</a>
          <a href="#" class="ir_pm">고객 센터</a>
        </div>
        <ul id="my_info">
        	<c:choose>
    			<c:when test="${not empty uid}">
        			<!-- uid가 있는 경우에 실행할 코드 -->
        			<li><a id="my-info" href="my_info.jsp">내 정보</a></li>
          			<li><a id="my-plan" href="myplan.condb?comm=myplan">내 일정</a></li>
          			<li><a id="log-out" href="logout.jsp">로그아웃</a></li>
    			</c:when>
    			<c:otherwise>
        			<!-- uid가 없는 경우에 실행할 코드 -->
        			<li><a id="login" href="login_select.jsp">로그인</a></li>
          			<li><a id="sign-up" href="signup_select.jsp">회원 가입</a></li>
    			</c:otherwise>
			</c:choose>
        </ul>
      </nav>
    </header>
</body>
</html>