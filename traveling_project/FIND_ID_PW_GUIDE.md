# 아이디/비밀번호 찾기 기능 구현 완료 가이드

## 📋 구현 概要

JSP/Servlet + MyBatis 기반 프로젝트에 다음 기능이 추가되었습니다:

### 1. 아이디 찾기 (find_id)
- **이메일 인증**: 이름 + 이메일로 아이디 조회
- **SMS 인증**: 이름 + 휴대폰번호로 아이디 조회
- **특징**:
  - 페이지 이동 없이 jQuery로 방식 전환 (show/hide)
  - AJAX로 인증코드 발송/검증
  - 인증 성공 후 아이디 마스킹 처리 (보안)

### 2. 비밀번호 찾기/재설정 (find_pw)
- **이메일 인증**: user_id + 이름 + 이메일로 계정 검증 후 비밀번호 변경
- **SMS 인증**: user_id + 이름 + 휴대폰번호로 계정 검증 후 비밀번호 변경
- **특징**:
  - 3-Step UI (계정 검증 → 비밀번호 입력 → 완료)
  - 비밀번호 강도 표시
  - 인증 후에만 비밀번호 변경 가능

---

## 🗂️ 파일 구조

### Java 클래스 (새로 생성)
```
src/com/traveling/login/
├── controller/
│   └── LoginController.java (업데이트: 새 액션 추가)
├── service/
│   ├── FindIdSendCodeService.java        (이메일/SMS 인증코드 발송)
│   ├── FindIdVerifyCodeService.java      (인증코드 검증)
│   ├── FindIdResultService.java          (아이디 조회)
│   ├── FindPwSendCodeService.java        (비밀번호 찾기 인증코드 발송)
│   ├── FindPwVerifyCodeService.java      (비밀번호 찾기 검증)
│   └── ResetPwService.java               (비밀번호 변경)
├── dao/
│   └── FindIdDAO.java                    (새로 생성)
└── dto/
    └── AuthCode.java                     (인증코드 DTO, 새로 생성)
```

### JSP/HTML (업데이트)
```
WebContent/webPage/login/
├── find_id.jsp           (재작성: 이메일/SMS 폼 show/hide)
└── find_pw.jsp           (재작성: 3-Step UI)
```

### JavaScript (새로 생성)
```
WebContent/js/login/
├── find_id.js            (AJAX 통신, form 제어)
└── find_pw.js            (AJAX 통신, 3-Step 전환)
```

### CSS (업데이트)
```
WebContent/css/login/
└── find.css              (새 스타일 추가)
```

### MyBatis Mapper XML (새로 생성)
```
resources/mybatis/login/dao/find.xml
또는
WebContent/WEB-INF/classes/mybatis/login/dao/find.xml
```

---

## 🔧 필수 설정

### 1. 데이터베이스 테이블 생성

**auth_code 테이블** (인증코드 저장용)

```sql
CREATE TABLE IF NOT EXISTS auth_code (
    auth_code_id INT AUTO_INCREMENT PRIMARY KEY,
    contact VARCHAR(255) NOT NULL COMMENT '이메일 또는 전화번호',
    auth_code VARCHAR(6) NOT NULL COMMENT '6자리 인증코드',
    auth_type VARCHAR(10) NOT NULL COMMENT 'email 또는 sms',
    expire_time DATETIME NOT NULL COMMENT '만료 시간 (발송 후 10분)',
    verify_count INT DEFAULT 0 COMMENT '검증 시도 횟수',
    is_verified TINYINT(1) DEFAULT 0 COMMENT '인증 성공 여부',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
    INDEX idx_contact_type (contact, auth_type),
    INDEX idx_expire_time (expire_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

실행 SQL 파일:
- `schema_auth.sql` (프로젝트 루트)

### 2. user_account 테이블 필드 확인

다음 필드가 존재하는지 확인하세요:
- `user_id` (PK)
- `user_pw`
- `user_name`
- `email_addr` (또는 `email`)
- `phone`

기존 필드명이 다르면 MyBatis Mapper XML (`find.xml`)의 SELECT 문을 수정하세요.

---

## 🌐 API 엔드포인트

### 아이디 찾기

| Action | URL | Method | 파라미터 | 반환 |
|--------|-----|--------|---------|------|
| 페이지 | `/login/find-id` | GET | - | HTML |
| 인증코드 발송 | `/login/find-id/send-code` | POST | `name`, `contact`, `authType` | JSON |
| 인증코드 검증 | `/login/find-id/verify` | POST | `code`, `contact`, `authType` | JSON |
| 아이디 조회 | `/login/find-id/result` | POST | - | JSON (userId, maskedUserId) |

### 비밀번호 찾기

| Action | URL | Method | 파라미터 | 반환 |
|--------|-----|--------|---------|------|
| 페이지 | `/login/find-pw` | GET | - | HTML |
| 인증코드 발송 | `/login/find-pw/send-code` | POST | `userId`, `name`, `contact`, `authType` | JSON |
| 인증코드 검증 | `/login/find-pw/verify` | POST | `code`, `contact`, `authType` | JSON |
| 비밀번호 변경 | `/login/find-pw/reset` | POST | `newPw`, `confirmPw` | JSON |

---

## 📊 Session 속성

### 아이디 찾기
- `auth_verified` (boolean): 인증 완료 여부
- `auth_contact` (String): 인증 대상 (이메일/전화번호)
- `auth_type` (String): 인증 방식 ("email" or "sms")
- `auth_name` (String): 사용자 이름

### 비밀번호 찾기
- `pw_auth_verified` (boolean): 인증 완료 여부
- `pw_auth_contact` (String): 인증 대상
- `pw_auth_type` (String): 인증 방식
- `pw_auth_user_id` (String): 사용자 아이디
- `pw_auth_name` (String): 사용자 이름

---

## 🔐 보안 사항

### 구현된 보안 기능
1. **인증 전 정보 노출 방지**
   - 사용자 존재 여부를 직접 노출하지 않음
   - 항상 "발송 성공" 메시지 반환

2. **아이디 마스킹**
   - 예: `test123` → `te****23`
   - FindIdResultService.maskUserId()

3. **인증 시도 횟수 제한**
   - 최대 5회 시도 가능
   - 초과 시 재발송 필요

4. **Session 기반 인증**
   - 인증 성공 후에만 아이디/비밀번호 변경 가능
   - Session 정리로 중복 접근 방지

5. **인증코드 만료**
   - 발송 후 10분 내에만 검증 가능

---

## 📝 커스터마이징 가이드

### 1. 이메일/SMS 실제 발송 구현

**이메일 (JavaMail API 사용)**

`FindIdSendCodeService.java`의 `sendEmailCode()` 메서드:

```java
private void sendEmailCode(String email, String authCode) {
    // TODO: JavaMail API 또는 Spring Mail 사용
    // Properties props = new Properties();
    // Session session = Session.getInstance(props, ...);
    // MimeMessage message = new MimeMessage(session);
    // message.setRecipients(...);
    // Transport.send(message);
}
```

**SMS (Twilio, AWS SNS, COOLSMS 등)**

`FindIdSendCodeService.java`의 `sendSmsCode()` 메서드:

```java
private void sendSmsCode(String phone, String authCode) {
    // TODO: SMS API 통합
    // 예시: COOLSMS API
    // SingleMessageSendingClient client = new SingleMessageSendingClient(apiKey, apiSecret);
    // ...
}
```

### 2. 인증코드 포맷 변경

기본값: 6자리 숫자

변경하려면 다음 파일을 수정:
- `FindIdSendCodeService.generateAuthCode()`
- `FindPwSendCodeService.generateAuthCode()`
- `find_id.js`의 코드 길이 검증
- `find_pw.js`의 코드 길이 검증

### 3. 비밀번호 강도 요구사항 변경

`ResetPwService.java`:

```java
if (newPassword.length() < 6) {  // 최소 길이 변경
    res.getWriter().write("{\"success\": false, \"message\": \"비밀번호는 최소 X자 이상이어야 합니다.\"}");
}
```

---

## ⚠️ 주의 사항

### 1. 데이터베이스 필드명
- 현재는 `email_addr`, `phone`을 사용
- 프로젝트의 실제 필드명과 일치하는지 **반드시 확인**
- 다르면 `find.xml`의 SQL 쿼리 수정 필요

### 2. Mapper XML 등록
- `find.xml`이 MyBatis 설정에 등록되었는지 확인
- `dbcon.xml` (mybatis-config)에 추가 필요할 수 있음

### 3. 트랜잭션 처리
- 현재는 각 작업별 개별 commit
- 필요하면 `ResetPwService`에서 트랜잭션 추가

---

## 🚀 테스트 방법

### 1. 개발 환경
```bash
# IDE에서 바로 실행
http://localhost:8080/[context]/login/find-id
http://localhost:8080/[context]/login/find-pw
```

### 2. 콘솔 로그 확인
```
[EMAIL] to: user@example.com, code: 123456
[SMS] to: 01012345678, code: 123456
```

### 3. DB 직접 확인
```sql
SELECT * FROM auth_code WHERE is_verified = false;
```

---

## 📌 완료 체크리스트

- [ ] `auth_code` 테이블 생성
- [ ] Controller에서 새 액션 확인
- [ ] Service 클래스 컴파일 확인
- [ ] JSP, JS, CSS 배포 확인
- [ ] `find.xml` Mapper 등록 확인
- [ ] 로컬에서 인증코드 발송 테스트
- [ ] 인증코드 검증 테스트
- [ ] 아이디 조회 테스트
- [ ] 비밀번호 변경 테스트
- [ ] 모바일 반응형 확인

---

## 📞 문제 해결

### 문제: "401 Unauthorized" 또는 매퍼 미인식
**해결**: `find.xml`이 클래스패스에 있는지, MyBatis 설정에 등록되었는지 확인

### 문제: 인증코드가 발송되지 않음
**해결**: 콘솔 로그에서 `[EMAIL]` 또는 `[SMS]` 메시지 확인 후, 실제 메일/SMS 발송 코드 구현

### 문제: 모바일에서 폼이 깨짐
**해결**: `find.css`의 미디어쿼리 확인 (max-width: 768px, 480px)

### 문제: 인증 후 아이디가 보이지 않음
**해결**: Browser 개발자 도구 → Console에서 JS 에러 확인

---

## 🔄 향후 개선 사항

1. **이메일/SMS 실제 발송**
   - JavaMail API 또는 Spring Mail 통합
   - COOLSMS/Twilio 등 외부 API 연동

2. **인증 로그 기록**
   - 실패 시도 기록
   - 부정 접근 모니터링

3. **다국어 지원**
   - 메시지 다국어화

4. **CAPTCHA 추가**
   - 봇 공격 방지

5. **소셜 로그인 연동**
   - Google, Kakao 등

---

## 📄 참고 자료

- Controller 액션: `/login/find-id`, `/login/find-pw` 및 하위 액션
- Service 패턴: Singleton + DataControl 인터페이스
- DAO 패턴: MyBatis SqlSession 사용
- jQuery AJAX: 비동기 통신 ($.ajax)

---

**구현 완료일**: 2026-05-17
**JSP/Servlet + MyBatis 기반 프로젝트**

