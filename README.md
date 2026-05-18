# traveling

> Java/JSP 기반 숙박 업소 예약 서비스  
> 호스트의 숙소·객실 등록부터 사용자 예약, 결제, 예약 승인/거부, 일정 플래너 생성까지 처리하는 웹 프로젝트입니다.

[![Deploy Dynamic Web Project](https://github.com/Joonsby/traveling/actions/workflows/deploy.yml/badge.svg)](https://github.com/Joonsby/traveling/actions/workflows/deploy.yml)

---

## 프로젝트 소개

`traveling`은 사용자와 호스트 역할을 분리한 숙박 예약 웹 애플리케이션입니다.

- 호스트는 숙소와 객실을 등록하고, 사용자의 예약 요청을 승인하거나 거부할 수 있습니다.
- 사용자는 조건에 맞는 숙소를 검색하고, 객실을 예약·결제할 수 있습니다.
- 예약이 승인되면 예약 기간을 기준으로 일정 플래너가 생성됩니다.
- 사용자는 마이페이지에서 예약 내역, 리뷰, 마일리지, 위시리스트, 여행 일정을 관리할 수 있습니다.

---

## 개발 기간

| 구분 | 기간 | 내용 |
| --- | --- | --- |
| 최초 개발 | 2023.05.19 ~ 2023.12.01 | Java/JSP 기반 숙박 예약 서비스 구현 |
| 리팩토링 및 운영 환경 개선 | 2026.04 ~ 2026.05 | JSP/Servlet 구조 개선, 개발/운영 서버 분리, GitHub Actions 기반 배포 자동화 |

---

## 프로젝트 참여 인원

| 이름 | 담당 영역 |
| --- | --- |
| 이준섭 | 회원가입, 로그인, 메인페이지, 숙소 전체보기, 숙소 상세정보, 객실 페이지, 숙소 등록, 객실 등록, 예약 승인/거부, 2026년 구조 리팩토링 및 CI/CD·서버 환경 개선 |
| 정현학 | 결제 페이지, 마일리지 적립, 일정 플래너 생성, 마이페이지 관리 |

---

## 기술 스택

### Frontend

<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"> <img src="https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white">

### Backend

<img src="https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=openjdk&logoColor=white"> <img src="https://img.shields.io/badge/Servlet-6DB33F?style=for-the-badge&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/MyBatis-000000?style=for-the-badge&logoColor=white"> <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black">

### Infra / DevOps

<img src="https://img.shields.io/badge/AWS_EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white"> <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">

### API

- Kakao Map API

---

## 링크

- 개발 서버: `http://13.124.104.51:8080`
- 운영 서버: `http://13.124.104.51:8081`
- 네이버 블로그: <https://blog.naver.com/joonsby1234>

> 서버 IP는 EC2 인스턴스 변경 시 달라질 수 있습니다.

---

## 2026년 리팩토링 및 개선 사항

### 1. JSP/Servlet 기반 구조 개선

Spring Framework로 전환한 것은 아니며, 기존 JSP/Servlet 기반을 유지하면서 Spring MVC와 유사한 계층 구조로 리팩토링했습니다.

기존에는 기능별 Servlet/JSP 처리 흐름이 분산되어 있었고, 화면 이동·에러 처리·공통 레이아웃 처리도 반복되는 부분이 많았습니다. 이를 다음과 같이 정리했습니다.

- `Controller` 계층: 요청 URL의 action을 분석하고 적절한 Service로 위임
- `Service` 계층: 비즈니스 로직 처리
- `DAO / Mapper` 계층: MyBatis 기반 DB 접근
- `DTO` 계층: 요청·응답 데이터 전달 객체 관리
- `BaseController`: 공통 요청 로그, action 추출, 예외 처리 로직 공통화
- `DataControl`: Service 실행 규격을 인터페이스로 통일
- `LayoutForward`: 사용자/호스트 공통 레이아웃 forward 처리 및 페이지별 CSS/JS 주입
- `ViewUtil`: 에러 페이지 이동 처리 공통화

```text
Browser
  ↓
Controller(Servlet)
  ↓
Service(DataControl)
  ↓
DAO / MyBatis Mapper
  ↓
MySQL
  ↓
JSP View
```

### 2. 개발/운영 서버 분리

AWS EC2 내부에 Tomcat을 2개로 분리하여 개발 환경과 운영 환경을 나누었습니다.

| 환경 | 브랜치 | Tomcat 서비스 | 포트 | 배포 경로 |
| --- | --- | --- | --- | --- |
| 개발 | `dev` | `tomcat-dev` | `8080` | `/home/ubuntu/tomcat-dev/webapps` |
| 운영 | `main` | `tomcat-prd` | `8081` | `/home/ubuntu/tomcat-prd/webapps` |

이 구조를 통해 개발 브랜치의 변경 사항을 운영 서버에 바로 반영하지 않고, 개발 서버에서 먼저 확인한 뒤 운영 서버로 배포할 수 있도록 구성했습니다.

### 3. GitHub Actions 기반 CI/CD 구축

GitHub Actions를 이용해 Dynamic Web Project 구조의 JSP/Servlet 프로젝트를 WAR로 빌드하고, EC2 서버에 자동 배포하도록 구성했습니다.

배포 흐름은 다음과 같습니다.

```text
GitHub Actions 실행
  ↓
dev 또는 main 브랜치 선택
  ↓
JDK 8 설정
  ↓
Java source compile
  ↓
ROOT.war 생성
  ↓
EC2 서버로 WAR 업로드
  ↓
환경별 Tomcat 중지
  ↓
기존 ROOT 애플리케이션 제거
  ↓
새 ROOT.war 배포
  ↓
환경별 Tomcat 재시작
```

현재 배포 워크플로우는 `workflow_dispatch` 기반입니다. 즉, 단순 push 자동 배포가 아니라 GitHub Actions에서 `dev` 또는 `main` 브랜치를 선택해 실행하면 해당 환경으로 자동 빌드·배포되는 방식입니다.

### 4. DB 설정 외부화 및 환경 분리

MyBatis 설정에서 `local`, `dev`, `prod` 환경을 분리했습니다.

- 로컬 개발 환경: `local`
- 개발 서버 환경: `dev`
- 운영 서버 환경: `prod`

DB 접속 정보는 `dbinfo.properties`로 분리하고, 운영 서버에서는 `/home/ubuntu/config/dbinfo.properties` 파일을 배포된 애플리케이션의 classpath에 복사하는 방식으로 관리했습니다. 이를 통해 DB 계정, 비밀번호, 서버 주소 같은 민감한 정보를 소스 코드에 직접 고정하지 않도록 개선했습니다.

> Tomcat 서비스명은 `tomcat-prd`이지만, MyBatis 환경 id는 `prod`로 관리합니다.

---

## 주요 기능

### 1. 메인페이지

- 헤더에서 원하는 숙소 조건 검색
- 호스트가 등록한 숙소 정보 표시
- 인기 숙소, 평점 기반 숙소, 가격 조건 기반 숙소 조회

### 2. 숙소 전체보기

- 숙소 조건 필터링 사이드바 제공
- AJAX를 이용한 비동기 숙소 목록 조회
- Kakao Map API를 이용해 숙소 위치, 가격, 숙소명 표시
- 숙소 상세 페이지로 이동

### 3. 숙소 상세정보 및 객실 예약

- 숙소 이미지, 주소, 소개, 객실 정보 표시
- 객실별 기준 인원, 최대 인원, 추가 인원 요금 관리
- 예약 가능 정보 확인 후 예약 진행

### 4. 호스트 기능

- 호스트 전용 메인페이지 제공
- 오늘 체크인/체크아웃 예정 예약 조회
- 숙소 등록
- 객실 등록
- 예약 승인/거부 처리

### 5. 사용자/호스트 회원가입

- 사용자와 호스트를 구분하여 회원가입 진행
- 사용자 정보: 아이디, 비밀번호, 이름, 연락처, 이메일, 주소 등
- 호스트 정보: 사용자 기본 정보 + 사업자등록번호 등
- 아이디/이메일 중복 확인

### 6. 예약 및 결제 흐름

- 사용자가 객실 예약 요청 생성
- 결제 전 예약 정보를 `pending_reservation`으로 관리
- 결제 완료 후 실제 예약 데이터 생성
- 예약 상태를 `예약 대기`, `예약 확정`, `예약 거부` 등으로 관리
- 호스트 승인 시 예약 확정 처리

### 7. 일정 플래너

- 예약 승인 이후 예약 기간을 기준으로 일정 플래너 생성
- 날짜별 상세 일정 등록
- 일정 수정/삭제
- 마이페이지에서 내 여행 일정 확인

### 8. 마이페이지

- 예약 내역 조회
- 리뷰 등록/수정/삭제
- 마일리지 조회
- 위시리스트 관리
- 최근 여행 및 총 숙박일 정보 조회

---

## 주요 테이블

| 영역 | 테이블 |
| --- | --- |
| 회원/인증 | `user_info`, `host_info`, `auth_code` |
| 숙소/객실 | `stay_info`, `room_info`, `facility`, `stay_facility` |
| 예약/결제 | `reservation`, `pending_reservation` |
| 일정 | `planner`, `detail_plan`, `favorite_plan` |
| 리뷰/마이페이지 | `review_info`, `mileage`, `wish_list` |
| 공통 코드 | `code`, `code_group` |

---

## 배포 구조

```text
GitHub Repository
  ├─ dev branch  ── GitHub Actions ──> EC2 / tomcat-dev / 8080
  └─ main branch ── GitHub Actions ──> EC2 / tomcat-prd / 8081
```

GitHub Actions는 다음 작업을 수행합니다.

1. 선택한 브랜치 checkout
2. JDK 8 설정
3. `traveling_project/src` 하위 Java 파일 컴파일
4. `traveling_project/WebContent`를 기준으로 WAR 구조 생성
5. `ROOT.war` 생성
6. EC2 서버 `/tmp`로 WAR 업로드
7. 환경별 Tomcat 서비스 중지
8. 기존 ROOT 애플리케이션 삭제
9. 새 WAR 배포
10. 서버의 `dbinfo.properties`를 classpath에 복사
11. Tomcat 재시작

---

## DB 접근 메모

외부 개발 환경에서 EC2 내부 MySQL에 접근할 때는 SSH 터널을 이용할 수 있습니다.

```bash
ssh -i "<pem-key-path>" -L 3307:127.0.0.1:3306 ubuntu@<EC2_HOST>
```

터널을 연 뒤 로컬에서는 다음과 같이 접속합니다.

```text
Host: 127.0.0.1
Port: 3307
User: <mysql-user>
Database: project
```

이 방식은 MySQL 포트를 외부에 직접 노출하지 않고도 로컬 IDE나 DB 클라이언트에서 서버 DB에 접근할 수 있다는 장점이 있습니다.

---

## 로컬 실행 시 설정 예시

`dbinfo.properties`는 실제 비밀번호를 포함할 수 있으므로 저장소에 그대로 공개하지 않는 것이 좋습니다.

```properties
local.db.driver=com.mysql.cj.jdbc.Driver
local.db.url=jdbc:mysql://127.0.0.1:3306/project?serverTimezone=Asia/Seoul&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true
local.db.username=root
local.db.password=로컬_DB_비밀번호

# SSH 터널을 사용해 개발 서버 DB에 접근하는 경우 예시
dev.db.driver=com.mysql.cj.jdbc.Driver
dev.db.url=jdbc:mysql://127.0.0.1:3307/project?serverTimezone=Asia/Seoul&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true
dev.db.username=DB_사용자
dev.db.password=DB_비밀번호

prod.db.driver=com.mysql.cj.jdbc.Driver
prod.db.url=jdbc:mysql://127.0.0.1:3308/project?serverTimezone=Asia/Seoul&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true
prod.db.username=DB_사용자
prod.db.password=DB_비밀번호
```

환경 선택은 JVM 옵션으로 지정할 수 있습니다.

```bash
-Denv=local
-Denv=dev
-Denv=prod
```

---

## 트러블슈팅 기록

### MySQL collation 호환 문제

운영 DB에서 덤프한 SQL을 로컬 MySQL에 import할 때 다음 에러가 발생할 수 있습니다.

```text
ERROR 1273 (HY000): Unknown collation: 'utf8mb4_0900_ai_ci'
```

원인은 MySQL 8.0에서 사용하는 collation을 낮은 버전의 MySQL 또는 MariaDB가 인식하지 못하기 때문입니다. 로컬 DB 버전이 낮다면 덤프 파일에서 다음과 같이 변경하여 import할 수 있습니다.

```text
utf8mb4_0900_ai_ci → utf8mb4_general_ci
```

---

## 핵심 성과

- 단순 JSP/Servlet 프로젝트를 기능별 Controller-Service-DAO 구조로 정리했습니다.
- 사용자/호스트 공통 레이아웃 처리와 에러 처리를 공통 유틸로 분리했습니다.
- MyBatis 환경을 `local`, `dev`, `prod`로 분리했습니다.
- AWS EC2에서 개발 서버와 운영 서버를 `tomcat-dev`, `tomcat-prd`로 분리했습니다.
- GitHub Actions를 이용해 WAR 빌드부터 EC2 배포, Tomcat 재시작까지 자동화했습니다.
- 서버의 DB 설정 파일을 배포 과정에서 주입하여 민감한 설정값을 코드와 분리했습니다
