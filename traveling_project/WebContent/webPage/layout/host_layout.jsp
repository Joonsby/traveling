<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <%@ include file="/webPage/common/head.jsp"%>

  <link rel="stylesheet" href="<c:url value="/css/header/header.css"/>" />
  <link rel="stylesheet" href="<c:url value="/css/header/host_header.css"/>" />
  <script src="<c:url value="/js/header/host_header.js"/>"></script>

  <title>${empty pageTitle ? "Host - Traveling" : pageTitle}</title>
</head>
<body>

  <%@ include file="/webPage/host/host_header.jsp"%>

  <main>
    <jsp:include page="${contentPage}" />
  </main>

  <%@ include file="/webPage/common/modal.jsp"%>
  <%@ include file="/webPage/common/confirm_modal.jsp"%>

</body>
</html>