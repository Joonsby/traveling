<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/css/login/login.css"/>" />
<script src="<c:url value="/js/login/login.js"/>"></script>
<title>로그인 화면</title>
</head>
<body>
	<main>
	    <c:choose>
	        <c:when test="${param.requestType eq 'user'}">
	            <c:set var="actionUrl" value="/webPage/login/LoginServlet?requestType=getUserInfo" />
	        </c:when>
	        <c:when test="${param.requestType eq 'host'}">
	            <c:set var="actionUrl" value="/webPage/login/LoginServlet?requestType=getHostInfo" />
	        </c:when>
    	</c:choose>
		<form name="user_info" action="${actionUrl}" method="post">
			<table id="login_table">
				<thead>
					<tr>
						<c:choose>
							<c:when test="${param.requestType eq 'user'}">
								<th>개인 회원 로그인</th>
							</c:when>
							<c:when test="${param.requestType eq 'host'}">
								<th>호스트 로그인</th>
							</c:when>
						</c:choose>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" name="id" id="id" placeholder="아이디를 입력하세요." /></td>
					</tr>
					<tr>
						<td><input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요." /></td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${param.loginfail eq 'Y'}">
								<td><p id="error_text">아이디 혹은 비밀번호를 잘못 입력하셨습니다.</p></td>
							</c:when>
						</c:choose>
					</tr>
					<tr>
						<td><input type="checkbox" name="id_save" id="id_save" /> <label for="id_save">아이디 저장</label></td>
					</tr>
					<tr>
						<td><input type="submit" id="login_btn" value="로그인"></td>
					</tr>
					<tr>
						<td id="search">
							<a href="#">아이디 찾기</a>
							<a href="#">비밀번호 찾기</a>
							<a href="<c:url value="/webPage/signup/signup_select.jsp"/>">회원가입</a>
						</td>
					</tr>
				</tbody>
			</table>
			<br />
		</form>
	</main>
	<%@ include file='../footer/footer.jsp'%>	
</body>
</html>