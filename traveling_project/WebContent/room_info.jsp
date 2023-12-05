<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pro.dto.CheckInInfo"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- css -->
<link rel="stylesheet" href="css/host_common.css" />
<link rel="stylesheet" href="css/add_stay.css" />
<link rel="stylesheet" href="css/add_room.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css" />

<!-- favicon -->
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<!-- script -->
<script src="js/add_room.js"></script>
<title>호스트 페이지</title>
</head>
<body>
	<%@ include file="host_header.jsp"%>
	<main>
		<%@ include file="host_aside.jsp"%>
		<section>
			<h2>객실 등록하기</h2>
			<form action="add_room.condb?comm=room_ins" method="post" enctype="multipart/form-data">
				<table>
					<tbody>
						<tr>
							<th>객실 이름</th>
							<td>								
								<input type="text" id="room_name" name="room_name" placeholder="객실 이름을 입력해주세요.">
								<p id="room_name_error_text" class='error_text'>객실 이름을 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th>객실 설명</th>
							<td>
								<p style="line-height: 1">
									<p id="content_error_text" class='error_text'>객실 설명을 입력해주세요.</p>
									<textarea id="content" name="content" placeholder="객실에 대한 상세한 정보를 입력해주세요."></textarea>
								</p>								
							</td>
						</tr>
						<tr>
							<th>체크인 시간</th>
							<td>
								<input type="text" name="check_in_time" placeholder="체크인 시간을 선택해주세요." readonly>
							</td>
						</tr>
						<tr>
							<th>체크아웃 시간</th>
							<td>
								<input type="text" name="check_out_time" placeholder="체크아웃 시간을 선택해주세요." readonly>
							</td>
						</tr>
						<tr>
							<th>객실 가격</th>
							<td>							
								<input type="number" id="price" name="price" placeholder="객실 가격을 입력해주세요.">
								<p id="price_error_text" class='error_text'>객실 가격을 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<th>기준 인원</th>
							<td>
								<input type="hidden" name="std_people" id="std_people_input" value="1" />
								<input type="button" id="std_decrease_btn" value="-" />
								<span id="std_people_number"  class="people_num">1</span>								
								<input type="button" id="std_increase_btn" value="+" />
							</td>							
						</tr>
						<tr>
							<th>최대 인원</th>
							<td  id="max_people_td">
							    <input type="hidden" name="max_people" id="max_people_input" value="1" />
								<input type="button" id="max_decrease_btn" value="-" />
								<span id="max_people_number" class="people_num">1</span>
								<input type="button" id="max_increase_btn" value="+" />
							</td>							
						</tr>
						<tr>
						<th id="image_th">객실 이미지</th>
						<td id="image_td">							
							<p id="image_text">객실 이미지는 최소 5장에서 최대 10장까지 등록해주세요.</p>
							<div id="att_zone">
								<div>
									<label id="image_label1" class="image_label" for="image1">이미지를 선택해주세요.</label>									
									<input type="button" id="remove_btn1" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image1" name="image1" accept="image/png,image/jpeg,image/gif">
								</div>			
								<div>
									<label id="image_label2" class="image_label" for="image2">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn2" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image2" name="image2" accept="image/png,image/jpeg,image/gif">		
								</div>								
								<div>
									<label id="image_label3" class="image_label" for="image3">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn3" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image3" name="image3" accept="image/png,image/jpeg,image/gif">								
								</div>								
								<div>
									<label id="image_label4" class="image_label" for="image4">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn4" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image4" name="image4" accept="image/png,image/jpeg,image/gif">									
								</div>								
								<div>
									<label id="image_label5" class="image_label" for="image5">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn5" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image5" name="image5" accept="image/png,image/jpeg,image/gif">												
								</div>								
								<div>
									<label id="image_label6" class="image_label" for="image6">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn6" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image6" name="image6" accept="image/png,image/jpeg,image/gif">												
								</div>								
								<div>
									<label id="image_label7" class="image_label" for="image7">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn7" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image7" name="image7" accept="image/png,image/jpeg,image/gif">												
								</div>								
								<div>
									<label id="image_label8" class="image_label" for="image8">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn8" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image8" name="image8" accept="image/png,image/jpeg,image/gif">												
								</div>								
								<div>
									<label id="image_label9" class="image_label" for="image9">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn9" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image9" name="image9" accept="image/png,image/jpeg,image/gif">												
								</div>								
								<div>
									<label id="image_label10" class="image_label" for="image10">이미지를 선택해주세요.</label>
									<input type="button" id="remove_btn10" class="remove_btn" value="-" style="display:none">
									<input type="file" class="images" id="image10" name="image10" accept="image/png,image/jpeg,image/gif">												
								</div>								
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<input id="add_room_btn" type="submit" value="등록하기">
			</form>
		</section>
	</main>
	<%@ include file="footer.jsp"%>	
</body>
</html>
