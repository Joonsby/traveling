# traveling
# Traveling Project
### Java/JSP를 이용한 숙박 업소 예약 사이트 프로젝트

## 💻 프로젝트 소개
#### 1.호스트가 숙소를 등록합니다
#### 2.등록한 숙소를 사용자가 결제를 한뒤 예약을 합니다
#### 3.호스트가 예약을 승인/거부를 할수 있습니다. (예약을 승인하게 되면 일정 플래너가 예약한 날짜에 자동으로 생성 됩니다.)
#### 4.사용자가 일정을 등록하고 수정/삭제할 수 있습니다.

<br>

## 🕰️ 개발 기간
### 2023.05.19 ~ 2023.12.01

<br>

## 🧑‍🤝‍🧑프로젝트 참여 인원 : 2명
#### 이준섭: 회원가입, 메인페이지, 숙소 전체보기, 숙소 상세정보 페이지, 객실 페이지, 숙소 등록, 객실 등록, 예약 승인/거부
#### 정현학: 결제 페이지, 마일리지 적립, 일정 플래너 생성, 마이페이지 관리

<br>

## 사용 기술
<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white"> <img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jQuery&logoColor=white"> <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=JAVA&logoColor=white"> <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=MySQL&logoColor=white"> <img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=for-the-badge&logo=Apache Tomcat&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white">

<br>

## 링크
#### 호스팅 주소 : http://13.124.104.51:8080
#### 네이버 블로그 주소 : https://blog.naver.com/joonsby1234

<br>

## 📌주요 기능
#### 1. 메인페이지
- 헤더에서 원하는 숙소의 조건을 검색
- 호스트가 등록한 숙소 정보 표시 (JSP를 이용하여 숙소의 정보를 화면에 표시)
#### 2. 숙소 전체보기
- 좌측 메뉴에는 숙소의 조건을 필터링 하는 사이드바 메뉴 (AJAX를 사용하여 숙소의 정보를 비동기통신으로 받아옴)
- 가운데에는 숙소의 정보를 표시
- 우측에는 카카오맵 API를 이용하여 숙소의 위치에 가격과 숙소명 표시
#### 3. 호스트 메인페이지, 숙소/객실 등록
- 헤더와 좌측 사이드바 부분에 호스트가 이용할 수 있는 카테고리들을 표시
- 호스트 메인페이지에는 오늘 체크인 예정인 숙소 표시
- 숙소/객실의 이름,가격,주소,편의시설등을 기입하여 숙소/객실 등록
#### 4. 사용자/호스트 회원가입
- 사용자와 호스트를 구분하여 회원가입 진행
- 사용자/호스트의 이름,전화번호,휴대폰번호,이메일,주소,사업자등록번호 등을 입력하여 회원가입 진행
