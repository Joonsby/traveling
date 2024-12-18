<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="<c:url value="/css/signup/signup_complete.css"/>" />
    <title>가입 완료</title>
  </head>
  <body>
    <main>
      <ul id="step">
        <li>01.회원 선택</li>
        <li>02.약관 동의</li>
        <li>03.회원 정보 입력</li>
        <li>04.가입 완료</li>
      </ul>
      <div id="content1">
        <img src="<c:url value="/images/logo.png"/>" alt="">
        <h2>회원가입이 완료되었습니다!</h2>        
      </div>
      <div id="btn">
        <a href="login_select.jsp"><input type="button" id="login" value="로그인하기"></a>
        <a href="index.jsp"><input type="button" id="main" value="메인 화면"></a>
      </div>      
    </main>
    <%@ include file="../footer/footer.jsp"%>
  </body>
</html>
