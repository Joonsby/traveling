<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../header/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<title>my page (예약정보)</title>
<link rel="stylesheet" href="<c:url value="/css/login/member.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/login/my_info.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/review/review_modal.css"/>" />
<!-- js -->
<script src="<c:url value="/js/review/review_modal.js"/>"></script>
<script src="<c:url value="/js/user/my_info.js"/>"></script>
</head>
<body>
	<!-- 마이페이지 공통 배너 -->
	<section id="member_status">
		<jsp:include page="../user/status.jsp"/>
	</section>
	<main id="member_contents">
	<!-- 마이페이지 사이드 nav include -->
		<jsp:include page="../reservation/my_page_nav.jsp"/>
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
						<c:choose>
							<c:when test="${empty reservationList}">
								<ul class='index_list'>
									<li>예약정보가 없습니다.</li>
								</ul>
							</c:when>
							<c:otherwise>
								<c:forEach var="reservationInfo" items="${reservationList}">
									<ul class="index_list">
										<li><span class="r_location">${reservationInfo.location}</span></li>
										<li class="r_chk_date">${reservationInfo.checkInDate} ~ ${reservationInfo.checkOutDate}</li>
										<li class="r_people">${reservationInfo.people}</li>
										<li><a href="#" class="detail_reservation">상세보기</a></li>
										<c:choose>
											<c:when test="${fn:contains(reviewList,reservationInfo.reservation_id)}">
												<li>
													<div class="review-container">
														<button class='review_modal review_written' data-reservation_id="${reservationInfo.reservation_id}" disabled>작성완료</button>
														<p id="tooltipText${reservationInfo.reservation_id}" class="tooltip-text">작성된 리뷰는 리뷰관리 페이지에서 확인 가능합니다</p>
													</div>
												</li>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${reservationInfo.status eq '예약 확정'}">
														<li><button class='review_modal' onclick="modal(event)" data-reservation_id="${reservationInfo.reservation_id}">작성하기</button></li>
													</c:when>
													<c:otherwise>
														<li>
															<div class="review-container">
																<button class='review_modal reserv_can' data-reservation_id="${reservationInfo.reservation_id}" disabled>작성불가</button>
																<p id="tooltipText${reservationInfo.reservation_id}" class="tooltip-text">예약이 확정되지 않았거나 취소/거부 된 경우 작성할 수 없습니다</p>
															</div>
														</li>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</ul>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</article>
					<div class="review_modal_wrap">
						<div id="review_modal_index">
							<button class="close_btn">&times;</button>
							<form action="/webPage/review/ReviewServlet?requestType=reviewInsert" id="review_form" method="post" enctype="multipart/form-data">
								<!-- 리뷰 form -->
								<input type="hidden" name="rid" id="rid_hidden">
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
	<%@ include file='../footer/footer.jsp'%>
</body>
</html>