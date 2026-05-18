<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/css/error/error.css"/>" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="<c:url value="/js/error/error.js"/>" ></script>
<title>오류 발생</title>
</head>
<body>
<div class="container">
    <h2>⚠️ 문제가 발생했습니다</h2>
    <p>
        <c:choose>
            <c:when test="${not empty errorMessage}">
                ${errorMessage}
            </c:when>
            <c:otherwise>
                요청을 처리하는 중 오류가 발생했습니다.
            </c:otherwise>
        </c:choose>
    </p>
    <p id="countdown-text">3초 뒤 이전 페이지로 이동합니다.</p>
    <div>
        <button onclick="history.back()">이전 페이지</button>
        <button onclick="location.href='${pageContext.request.contextPath}/'">홈으로</button>
    </div>
</div>
</body>
</html>