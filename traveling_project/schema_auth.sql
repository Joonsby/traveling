-- auth_code 테이블 생성 (아이디/비밀번호 찾기 인증코드 저장)
CREATE TABLE IF NOT EXISTS auth_code (
    auth_code_id INT AUTO_INCREMENT PRIMARY KEY,
    contact VARCHAR(255) NOT NULL COMMENT '이메일 또는 전화번호',
    auth_code VARCHAR(6) NOT NULL COMMENT '6자리 인증코드',
    auth_type VARCHAR(10) NOT NULL COMMENT \'email 또는 sms\',
    expire_time DATETIME NOT NULL COMMENT '만료 시간 (발송 후 10분)',
    verify_count INT DEFAULT 0 COMMENT '검증 시도 횟수',
    is_verified TINYINT(1) DEFAULT 0 COMMENT '인증 성공 여부',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시간',
    INDEX idx_contact_type (contact, auth_type),
    INDEX idx_expire_time (expire_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 기존 user_account 테이블 확인 (있는지 체크)
-- 이미 존재한다면 수정 불필요
-- 필요한 필드: user_id, user_pw, user_name, email_addr, phone

