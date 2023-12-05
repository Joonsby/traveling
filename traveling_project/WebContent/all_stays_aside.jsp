<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 하기</title>
<link rel="stylesheet" href="css/all_stays_aside.css" />
</head>
<body>
	<aside>
		<div id="side-map">
			<span></span>
			<p>지도 전체 보기</p>
		</div>
		<div id="fee">
			<h3>1박당 요금</h3>
	  <div class="price-input">		      	
	    <div class="field">
	      <span>이상</span>		          
	      <span>이하</span>		          
	    </div>		        
	    <div class="field">		          
	      <input type="text" class="input-min" value="0" />
	      <span class="won">₩</span>
	      <div class="separator">-</div>
	      <input type="text" class="input-max" value="500,000" />
	      <span class="won">₩</span>
	    </div>
	  </div>
	  <div class="slider">
	    <div class="progress"></div>
	  </div>
	  <div class="range-input">
	    <input type="range" class="range-min" min="0" max="500000" value="0" step="10000" />
	    <input type="range" class="range-max" min="0" max="500000" value="500000" step="10000" />
	  </div>		      
	 </div>
	 <div id="filter">	      	
	 	<h3>고객 평점</h3>
	 	<input id="rating_all" class="rating" type="radio" name="rating" value="0" checked> <label for="rating_all">전체 보기</label> <br>
	 	<input id="rating1" class="rating" type="radio" name="rating" value="4.5"> <label for="rating1">★ 4.5 + </label> <br>
	 	<input id="rating2" class="rating" type="radio" name="rating" value="4.0"> <label for="rating2">★ 4.0 + </label> <br>
	 	<input id="rating3" class="rating" type="radio" name="rating" value="3.5"> <label for="rating3">★ 3.5 + </label> <br>
	 	<input id="rating4" class="rating" type="radio" name="rating" value="3.0"> <label for="rating4">★ 3.0 + </label> <br>
	 	<hr>	 	
	 	<h3>편의 시설</h3>
	 	<input type="checkbox" id="parking" class="options" value="yes"> <label for="parking">주차</label> <br> 
	 	<input type="checkbox" id="wireless_internet" class="options" value="yes"> <label for="wireless_internet">무료 인터넷</label> <br>
	 	<input type="checkbox" id="tub" class="options" value="yes"><label for="tub"> 욕조</label> <br>
	 	<input type="checkbox" id="washing_machine" class="options" value="yes"><label for="washing_machine"> 세탁기</label> <br>
	 	<input type="checkbox" id="drying_machine" class="options" value="yes"><label for="drying_machine"> 건조기</label><br>
	 	<input type="checkbox" id="air_conditioner" class="options" value="yes"><label for="air_conditioner"> 에어컨</label><br>
	 	<input type="checkbox" id="fan" class="options" value="yes"><label for="fan"> 선풍기</label><br>
	 	<input type="checkbox" id="heating_system" class="options" value="yes"><label for="heating_system"> 난방</label> <br>
	 	<input type="checkbox" id="pool" class="options" value="yes"><label for="pool"> 수영장</label><br>
	 	<input type="checkbox" id="arcade_game" class="options" value="yes"><label for="arcade_game"> 오락실 게임</label><br>
	 	<input type="checkbox" id="gym" class="options" value="yes"><label for="gym"> 헬스장</label><br>
	 	<input type="checkbox" id="board_game" class="options" value="yes"><label for="board_game"> 보드게임</label><br>
	 	<input type="checkbox" id="barbecue_tool" class="options" value="yes"><label for="barbecue_tool"> 바베큐</label><br>
	 	<input type="checkbox" id="basic_cookware" class="options" value="yes"><label for="basic_cookware"> 기본 조리도구</label><br>
	 	<hr>
	 	<h3>서비스</h3>
	 	<input type="checkbox" id="breakfast" class="options" value="yes"><label for="breakfast"> 아침 식사</label> <br>
	 	<input type="checkbox" id="clean_service" class="options" value="yes"><label for="clean_service"> 청소 서비스</label><br>
	 	<input type="checkbox" id="luggage_storage" class="options" value="yes"><label for="luggage_storage"> 짐 보관</label><br>
	 </div>
	</aside>
</body>
</html>