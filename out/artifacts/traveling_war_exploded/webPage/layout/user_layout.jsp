<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <%@ include file="/webPage/common/head.jsp"%>
  <link rel="stylesheet" href="<c:url value="/css/header/header.css"/>" />
  <script src="<c:url value="/js/header/header.js"/>"></script>
  <c:forEach var="css" items="${pageCssList}">
    <link rel="stylesheet" href="<c:url value='${css}'/>" />
  </c:forEach>
  <c:forEach var="js" items="${pageJsList}">
    <script src="<c:url value='${js}'/>"></script>
  </c:forEach>
  <title>${empty pageTitle ? "Traveling" : pageTitle}</title>
</head>
<body>

  <%@ include file="/webPage/header/header.jsp"%>

  <main>
    <jsp:include page="${contentPage}" />
  </main>

  <%@ include file="/webPage/common/modal.jsp"%>
  <%@ include file="/webPage/common/confirm_modal.jsp"%>

  <%@ include file="/webPage/footer/footer.jsp"%>

</body>
</html>