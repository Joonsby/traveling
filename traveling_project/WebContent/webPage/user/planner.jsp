<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/webPage/header/header.jsp"%>
<%@ page import="java.util.List" %>
<%@ page import="com.traveling.plan.dto.MyPlanner" %>
<c:set var="planList" value="${requestScope.planList}" />
<!DOCTYPE html>
<html>
  <head>
    <title>my page -> 내 일정</title>
    <!-- jquery -->
    <!-- 장소 선택 다음 지도 api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7c58ef23f11133451e52c26eedfc5668&libraries=services,clusterer,drawing"></script>
    <!-- css -->
    <link rel="stylesheet" href="<c:url value="/css/login/member.css"/>" />
    <link rel="stylesheet" href="<c:url value="/css/reservation/nav.css"/>" />
    <link rel="stylesheet" href="<c:url value="/css/user/planner.css"/>" />
    <script src="<c:url value="/js/user/planner.js"/>"></script>
  </head>
  <body>
    <jsp:include page="../header/header.jsp" />
    <!-- 마이페이지 공통 배너 -->
    <section id="member_status">
      <jsp:include page="status.jsp"/>
    </section>
    <main id="member_contents">
      <jsp:include page="../reservation/my_page_nav.jsp"/>
      <section class="mypage-section"> <!-- 이 부분에 기능 index 페이지 -->
        <div id="planner_wrap">
          <article>
            <h2>내 일정</h2>
            <span class="notice_help"><u>#상세보기를 눌러 일정을 수정할 수 있습니다.</u></span>
            <ul id="planner_category">
              <li>숙소 이름</li>
              <li>여행 기간</li>
              <li>상세보기</li>
              <li>공유하기</li>
              <li>최근수정일</li>
            </ul>
            <c:choose>
            	<c:when test="${empty planList}">
	       	        <ul class="planner_list">
	           			<li>숙소를 예약하시면 일정이 등록됩니다.</li>
	           		</ul>
            	</c:when>
            	<c:otherwise>
            		<c:forEach var="planner" items="${planList}">
            			<ul class="planner_list">
			              <li class="planner_stay_info">
			                <a href="#">
			                  <span>${planner.location}</span>
			                  <h6 class="p_stay_name">${planner.stay_name}</h6>
			                </a>
			              </li>
			              <li class="planner_trip_date" data-days_count="${planner.days_count}">
			              	${planner.check_in_date} ~ ${planner.check_out_date}
			              </li>
			              <li>
			              	<button id="show_btn" class="show_detail" onclick="detail_plan(event)" data-plan_id="${planner.plan_id}">상세보기</button>
			              </li>
			              <li>
			              	<a href="#"><img src="./images/share.png" alt=""></a>
			              </li>
			              <li>
			                <span class="planner_update_date">${planner.modified_date}</span>
			              </li>
			            </ul>
            		</c:forEach>
            	</c:otherwise>
            </c:choose>
          </article>
          <!-- 수정하기 인덱스 -->
				<div class="planner_modal_wrap">
					<div id="planner_modal_index">
						<button class="close_btn">&times;</button>
						<form action="" id="planner_form" method="post">
							<!-- 모달 form -->
							<input type="hidden" name="pid" id="pid_hidden" value="">
							<!-- plan_id hidden-->
							<div id="pm_header">
								<p></p>
								<!-- stay_info 테이블의 stay_name 컬럼 -->
								<span></span>
								<!-- reservation 테이블의 check_in_date, check_out_date 컬럼 -->
							</div>
							<div id="pm_contents">
								<div class="planner_tab">
									<ul class="tab_list" id="date_tabs">
										<!-- 비동기 방식으로 n일차 탭 생성 -->
									</ul>
								</div>
								<div id="pm_btn">
									<input type="button" id="modi_btn" value="수정">
									<input type="button" id="modi_save_btn" value="저장">
									<input type="button" id="can_btn" name="can_btn" value="종료">
									<input type="button" id="modi_can_btn" name="can_btn" value="취소">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
      </section>
    </main>
    <div class="go_top"></div>
    <!-- footer include -->
    <jsp:include page="../footer/footer.jsp"/>
  </body>

</html>