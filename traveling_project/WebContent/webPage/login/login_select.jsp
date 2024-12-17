<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<!DOCTYPE html>
<html>
  <link rel="stylesheet" href="<c:url value="/css/login/login_select.css"/>" />
  <title>로그인 선택</title>
  <body>
    <main>
      <div id="content1">
        <img src="<c:url value="/images/logo.png"/>" alt="로고">
        <h2>로그인할 유형을 선택해주세요</h2>
      </div>
      <ul id="join">
        <li>
          <h3>개인 회원</h3>
          <p>individual</p>
          <a href="login.jsp?requestType=user"><input type="button" value="로그인하기" /></a>
        </li>
        <li>
          <h3>호스트</h3>
          <p>host</p>
          <a href="login.jsp?requestType=host"><input type="button" value="로그인하기" /></a>
        </li>
      </ul>
    </main>
	<%@ include file="../footer/footer.jsp"%>
  </body>
</html>
