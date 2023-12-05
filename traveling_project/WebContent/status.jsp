<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css -->
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/member.css" />
<link rel="stylesheet" href="css/my_info.css" />
<!-- jquery -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- js -->
<script src="js/user_status.js"></script>
</head>
<body>
	<div id="status_wrap">
		<article id="member_info">
			<a href="#">회원정보수정</a>
			<h2 id="user_status_id"><%= session.getAttribute("id") %></h2>
			<!-- 현재 로그인 한 회원의 ID를 추출해서 출력 -->
			<p>
				마지막으로 여행을 다녀온지 <u id="last_trip"></u>이
				<!-- 마지막 체크아웃 날짜를 통해 연산해서 n일로 표시 -->
			</p>
			<p>지났습니다.</p>
		</article>
		<article id="member_grade">
			<a href="#">등급 별 혜택 확인</a>
			<h2 id="grade_text"></h2>
			<!-- 누적 금액을 통해 멤버십 등급 산정 -->
			<p>
				예약할 때마다 <span><u id="discount_percent"></u> 추가 적립</span>을 받게 됩니다.
				<!-- 멤버십 등급을 산정하고 조건문을 통해 해당 등급의 적립 비율 출력 -->
			</p>
		</article>
		<article id="member_content">
			<div>
				<!-- 이용횟수, 마일리지, 쿠폰 -->
				<ul id="content_lodgment">
					<li class="content_img"><figure id="won_img"></figure></li>
					<li style="padding-top: 26px" id="nstay"></li>
					<!-- 회원이 숙박한 횟수 연산해서 추출 -->
					<li class="content_text">숙박완료</li>
				</ul>
				<ul id="member_mileage">
					<li class="content_img"><figure id="point_img"></figure></li>
					<li style="padding-top: 26px" id="nmileage"></li>
					<!-- 누적된 마일리지 추출 -->
					<li class="content_text" id="save_mileage"></li>
					<!-- 회원 등급 별 해당하는 적립 비율 추출 -->
				</ul>
				<ul id="member_coupon">
					<li class="content_img"><figure id="coupon_img"></figure></li>
					<li style="padding-top: 18px"><a href="#" id="ncoupon">2개</a></li>
					<!-- 회원이 보유한 쿠폰 개수 추출, 쿠폰 화면 이동 가능 -->
					<li class="content_text_last">보유 쿠폰</li>
				</ul>
			</div>
		</article>
	</div>

</body>
</html>