<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header/host_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/css/host/host_index.css"/>" />
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com"/>
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="<c:url value="/js/host/host_index.js"/>"></script>
<title>호스트 페이지</title>
</head>
<body>
	<main>
		<%@ include file="host_aside.jsp"%>
		<section>
			<input type="hidden" id="host_id" value="${host_id}">
			<div>
				<h2>${name} 님, 안녕하세요!</h2>
				<a href="<c:url value="/webPage/stay/add_stay.jsp"/>" class="add_stay_btn">숙소 등록하기</a>
			</div>
			<span id="underline"></span>
			<div>
				<h3>빠른 예약 조회</h3>
				<a href="#">모든 예약</a>
			</div>
			<div>
				<input type="button" id="check_in_btn" class='statusBtn active' value="체크인 예정">
				<input type="button" id="check_out_btn" class='statusBtn' value="체크아웃 예정">
				<input type="button" id="hosting_btn" class='statusBtn' value="현재 호스팅">
				<input type="button" id="empty_review" class='statusBtn' value="답변 안한 후기">
			</div>
			<div id="table-div"></div>
		</section>
	</main>
    <%@ include file="../footer/footer.jsp"%>
</body>
</html>
