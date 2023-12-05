<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- favicon -->
  <link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
  <!-- fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
  <!-- css -->
  <link rel="stylesheet" href="css/reset.css" />
  <link rel="stylesheet" href="css/header.css" />
  <link rel="stylesheet" href="css/login_select.css">
  <link rel="stylesheet" href="css/footer.css" />
  <!-- jquery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
  <script src="js/table_signup.js"></script>
  <script src="js/header.js"></script>
  <title>로그인 선택</title>
  <body>
    <%@ include file="header.jsp"%>
    <main>
      <div id="content1">
        <img src="images/logo.png" alt="">
        <h2>로그인할 유형을 선택해주세요</h2>
      </div>
      <ul id="join">
        <li>
          <h3>개인 회원</h3>
          <p>individual</p>
          <a href="user_login.html"><input type="button" value="로그인하기" /></a>
        </li>
        <li>
          <h3>호스트</h3>
          <p>host</p>
          <a href="host_login.html"><input type="button" value="로그인하기" /></a>
        </li>
      </ul>
    </main>
	<%@ include file="footer.jsp"%>
  </body>
</html>
