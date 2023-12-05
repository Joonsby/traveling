<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>my page (예약정보)</title>
<!-- favicon -->
<link rel="shortcut icon" href="images/logo.png" type="image/x-icon" />
<!-- fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Gowun+Dodum&display=swap" rel="stylesheet" />
<style> <!-- 나눔고딕 폰트 -->
  @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
</style>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/member.css" />
<link rel="stylesheet" href="css/my_info.css" />
<link rel="stylesheet" href="css/review_modal.css" />
<!-- js -->
<script src="js/review_modal.js"></script>
<script src="js/my_info.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<!-- 마이페이지 공통 배너 -->
	<section id="member_status">
		<jsp:include page="./status.jsp"/>
	</section>
	<main id="member_contents">
	<!-- 마이페이지 사이드 nav include -->
		<jsp:include page="./my_page_nav.jsp"/>
		<section class="mypage-section">
			<!-- 이 부분에 기능 index 페이지 -->
			<div id="reservation_wrap" class="index_wrap">
				<article>
					<h2>예약정보</h2>
					<ul id="reservation_category" class="index_category">
						<li>숙소 이름</li>
						<li>일정</li>
						<li>인원</li>
						<li>상세보기</li>
						<li>리뷰</li>
					</ul>
					<div id="reservationInfo">
						<!-- DB에 연동해 받아온 정보들을 출력 -->
					</div>
				</article>
					<div class="review_modal_wrap">
						<div id="review_modal_index">
							<button class="close_btn">&times;</button>
							<form action="review_insert.jsp" id="review_form" method="post" enctype="multipart/form-data">
								<!-- 리뷰 form -->
								<input type="hidden" name="rid" id="rid_hidden" value="">
								<div id="rm_header">
									<p></p>
									<!-- stay_info 테이블의 stay_name 컬럼 -->
									<span></span>
									<!-- reservation 테이블의 check_in_date, check_out_date 컬럼 -->
								</div>
								<div id="rm_contents">
									<div class="review_title">
										<label for="rtitle" id="rtitle_la">제목</label> <br>
										<input type="text" id="rtitle" name="rtitle" placeholder="제목을 작성해주세요.">
									</div>
									<div class="review_content">
										<label for="rcontent" id="rcontent_la">내용</label> <br>
										<textarea id="rcontent" name="rcontent" placeholder="리뷰를 작성해주세요."></textarea>
									</div>
									<div class="review_image">
										<label for="file_list" id="r_file_la">파일</label>
										<div id="file_list" class="file_list">
											<div>
												<label id="r_image_label1" class="r_image_label" for="r_image1">이미지를 선택해주세요.</label>									
												<input type="button" id="review_remove_btn1" class="r_remove_btn" value="-" style="display:none">
												<input type="file" class="r_images" id="r_image1" name="r_image1" accept="image/png,image/jpeg,image/gif">
											</div>			
											<div>
												<label id="r_image_label2" class="r_image_label" for="r_image2">이미지를 선택해주세요.</label>
												<input type="button" id="review_remove_btn2" class="r_remove_btn" value="-" style="display:none">
												<input type="file" class="r_images" id="r_image2" name="r_image2" accept="image/png,image/jpeg,image/gif">		
											</div>								
											<div>
												<label id="r_image_label3" class="r_image_label" for="r_image3">이미지를 선택해주세요.</label>
												<input type="button" id="review_remove_btn3" class="r_remove_btn" value="-" style="display:none">
												<input type="file" class="r_images" id="r_image3" name="r_image3" accept="image/png,image/jpeg,image/gif">								
											</div>								
											<div>
												<label id="r_image_label4" class="r_image_label" for="r_image4">이미지를 선택해주세요.</label>
												<input type="button" id="review_remove_btn4" class="r_remove_btn" value="-" style="display:none">
												<input type="file" class="r_images" id="r_image4" name="r_image4" accept="image/png,image/jpeg,image/gif">									
											</div>								
											<div>
												<label id="r_image_label5" class="r_image_label" for="r_image5">이미지를 선택해주세요.</label>
												<input type="button" id="review_remove_btn5" class="r_remove_btn" value="-" style="display:none">
												<input type="file" class="r_images" id="r_image5" name="r_image5" accept="image/png,image/jpeg,image/gif">												
											</div>
										</div>
									</div>
								</div>
								<div class="star-rating">
									<input type="radio" id="5-stars" name="rating" value="5.0" />
									<label for="5-stars" class="star">★</label>
									<input type="radio" id="4-stars" name="rating" value="4.0" />
									<label for="4-stars" class="star">★</label>
									<input type="radio" id="3-stars" name="rating" value="3.0" />
									<label for="3-stars" class="star">★</label>
									<input type="radio" id="2-stars" name="rating" value="2.0" />
									<label for="2-stars" class="star">★</label>
									<input type="radio" id="1-star" name="rating" value="1.0" />
									<label for="1-star" class="star">★</label>
								</div>
								<div id="rm_btn">
									<input type="submit" id="submit_btn" value="저장">
									<input type="button" id="can_btn" name="can_btn" value="취소">
								</div>
							</form>
						</div>
					</div>
			</div>
		</section>
	</main>
	<div class="go_top"></div>
	<jsp:include page="./footer.jsp"/>
</body>

</html>