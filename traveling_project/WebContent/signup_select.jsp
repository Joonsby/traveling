<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
    <!-- fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <!-- css  -->
    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/header.css" />
    <link rel="stylesheet" href="css/signup_select.css" />
    <link rel="stylesheet" href="css/footer.css" />
    <script src="js/signup.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="js/header.js"></script>
    <title>회원가입</title>
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
        <h2><span>Traveling</span> 에 오신 것을 환영합니다!</h2>
        <p>
          회원님께서 해당되는 회원 종류를 선택해주세요.<br />
          선택하신 회원 종류에 따라 가입 절차에 차이가 있으니,<br />
          반드시 회원님께 해당하는 경우를 선택해 주시기 바랍니다.
        </p>
      </div>
      <ul id="join">
        <li>
          <h3>개인 회원</h3>
          <p>individual</p>
          <a href="agree.jsp"><input type="button" value="가입하기" /></a>
        </li>
        <li>
          <h3>호스트</h3>
          <p>host</p>
          <a href="host_agree.jsp"><input type="button" value="가입하기" /></a>
        </li>
      </ul>
    </main>
    <%@ include file="footer.jsp"%>
  </body>
</html>
