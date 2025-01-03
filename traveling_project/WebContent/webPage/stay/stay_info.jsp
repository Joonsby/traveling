<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.traveling.stay.dto.StayInfo" %>
<%@ page import="java.util.List" %>
<%@ include file="../header/host_header.jsp"%>
<% 
	List<StayInfo> stayInfo = (List<StayInfo>) request.getAttribute("stayInfo");
	String path = request.getContextPath();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- css -->
<link rel="stylesheet" href="../../css/common/reset.css" />
<link rel="stylesheet" href="css/add_stay.css" />
<link rel="stylesheet" href="css/host_common.css" />
<link rel="stylesheet" href="css/stay_info.css" />
<!-- favicon -->
<link rel="shortcut icon" href="../../images/logo.png" type="image/x-icon" />
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap"
	rel="stylesheet" />
<!-- jquery -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 카카오 api -->
<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=503ba05a6aebde2c3d2be42f78d1b63b&libraries=services"></script>
<!-- script -->
<title>숙소 등록</title>
</head>
<body>	
	<main>
		<%@ include file="../host/host_aside.jsp"%>
		<section>	
			<h2>숙소 정보</h2>			
			<form action="/webPage/stay/StayServlet?requestType=insertStayInfo&name=<%= hostId %>" method="post" enctype="multipart/form-data">					
				<table>
					<tr>
						<th>숙소 이름</th>
						<td colspan="2">
							<p id="stay-name" class="info"><%=stayInfo.get(0).getStay_name() %></p>
							<input id="stay-name-edit" type="button" value="수정하기">
						</td>						
					</tr>
					<tr>
						<th rowspan="2">숙소 주소</th>
						<td colspan="2" id="addr-td">
							<div id="addr-box">
								<p class="info">우편번호 : <%=stayInfo.get(0).getPost_code() %></p>
								<p class="info">도로명 주소 : <%=stayInfo.get(0).getRoad_addr() %></p>
								<p class="info">지번 주소 : <%=stayInfo.get(0).getJibun_addr() %></p>
								<p class="info">상세 주소 : <%=stayInfo.get(0).getDetail_addr() %></p>
								<p class="info">참고 사항 : <%=stayInfo.get(0).getReference_addr() %></p>
							</div>
							<input type="button" id="addr-edit-btn" value="수정하기">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="hidden" id="latitude" value="<%=stayInfo.get(0).getLatitude()%>">
							<input type="hidden" id="longitude" value="<%=stayInfo.get(0).getLongitude()%>">
							<div id="map" style="width: 100%; height: 300px; margin-top: 10px;"></div>
						</td>
					</tr>
					<tr>
						<th>연락받을 전화번호</th>
						<td>
							<p id="host-phone" class="info"><%=stayInfo.get(0).getHost_phone() %></p>
							<input id="phone-edit-btn" type="button" value="수정하기">
						</td>
					</tr>
					<tr>
						<th>숙소 이미지</th>
						<td id="image_td">							
							<div id="att_zone">
								<div class="img-box">
									<img src="<%=path%>/images/stay_images/<%=stayInfo.get(0).getImage1()%>" height="128">
								</div>			
								<div class="img-box">
									<img src="<%=path%>/images/stay_images/<%=stayInfo.get(0).getImage2()%>" height="128">
								</div>								
								<div class="img-box">
									<img src="<%=path%>/images/stay_images/<%=stayInfo.get(0).getImage3()%>" height="128">								
								</div>								
								<div class="img-box">
									<img src="<%=path%>/images/stay_images/<%=stayInfo.get(0).getImage4()%>" height="128">
								</div>								
								<div class="img-box">
									<img src="<%=path%>/images/stay_images/<%=stayInfo.get(0).getImage5()%>" height="128">		
								</div>
							</div>
							<input id="image-edit-btn" type="button" value="수정하기">
						</td>
					</tr>
					<tr>					
						<th>숙소 상세 정보</th>
						<td>							
							<p class="info">
								<%=stayInfo.get(0).getContent()%>
							</p>
							<input id="content-edit-btn" type="button" value="수정하기">
						</td>
					</tr>
					<tr>
					<th rowspan="2">편의 시설</th>							
						<td>
							<div style="color:#999; border-bottom:none">
								<div>
									<c:choose>
									
									    <c:when test="${not empty stayInfo[0].tub}">
									        <div>${stayInfo[0].tub}</div>
									    </c:when>
									    
										<c:when test="${not empty stayInfo[0].bath_supplies}">
											<div>${stayInfo[0].bath_supplies}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].hair_dryer}">
											<div>${stayInfo[0].hair_dryer}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].towel}">
											<div>${stayInfo[0].towel}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].bedding}">
											<div>${stayInfo[0].bedding}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].washing_machine}">
											<div>${stayInfo[0].washing_machine}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].drying_machine}">
											<div>${stayInfo[0].drying_machine}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].pool}">
											<div>${stayInfo[0].pool}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].arcade_game}">
											<div>${stayInfo[0].arcade_game}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].gym}">
											<div>${stayInfo[0].gym}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].tv}">
											<div>${stayInfo[0].tv}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].board_game}">
											<div>${stayInfo[0].board_game}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].air_conditioner}">
											<div>${stayInfo[0].air_conditioner}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].fan}">
											<div>${stayInfo[0].fan}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].heatingSystem}">
											<div>${stayInfo[0].heating_system}</div>
										</c:when>
										
										<c:when test="${not empty stayInfo[0].carbon_monoxide_alarm}">
											<div>${stayInfo[0].carbon_monoxide_alarm}</div>
										</c:when>
										
									</c:choose>																		
								</div>
								<div>
									<div>화재 경보기</div>
									<div>업무 전용 공간</div>
									<div>무선 인터넷</div>
									<div>바베큐 도구</div>
									<div>기본 조리도구</div>
									<div>식탁</div>
									<div>식기류</div>
									<div>냉장고</div>
									<div>전자레인지</div>
									<div>전기밥솥</div>
									<div>가스레인지 또는 인덕션</div>
									<div>전기차 충전시설</div>
									<div>주차장</div>
									<div>아침식사</div>
									<div>청소 서비스</div>
									<div>짐보관</div>								
								</div>								
							</div>
							<input id="amenties_edit_btn" type="button" value="수정하기">
						</td>
					</tr>	
				</table>
				<input type="submit" id='add_btn' value="등록하기">
			</form>
		</section>		
	</main>
	<%@ include file='../footer/footer.jsp'%>	
	<script src="js/add_stay.js"></script>
</body>
</html>