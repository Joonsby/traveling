<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- css -->
    <link rel="stylesheet" href="css/reset.css" />     
    <link rel="stylesheet" href="css/signup_complete.css"> 
    <!-- favicon -->
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
    <!-- font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <!-- script -->
    <script src="js/header.js"></script>
    <title>가입 완료</title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <main>
      <ul id="step">
        <li>01.회원 선택</li>
        <li>02.약관 동의</li>
        <li>03.회원 정보 입력</li>
        <li>04.가입 완료</li>
      </ul>
      <div id="content1">
        <img src="images/logo.png" alt="">
        <h2>회원가입이 완료되었습니다!</h2>        
      </div>
      <div id="btn">
        <a href="login_select.jsp"><input type="button" id="login" value="로그인하기"></a>
        <a href="index.jsp"><input type="button" id="main" value="메인 화면"></a>
      </div>      
    </main>
    <%@ include file="footer.jsp"%>
  </body>
</html>
