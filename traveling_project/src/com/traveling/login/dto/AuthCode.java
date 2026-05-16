package com.traveling.login.dto;

import java.time.LocalDateTime;

public class AuthCode {
	private int authCodeId;
	private String contact; // 이메일 또는 전화번호
	private String authCode; // 인증코드
	private String authType; // "email" or "sms"
	private LocalDateTime expireTime; // 만료 시간
	private int verifyCount; // 검증 시도 횟수
	private boolean isVerified; // 인증 성공 여부
	private LocalDateTime createdAt;

	// Getters and Setters
	public int getAuthCodeId() {
		return authCodeId;
	}

	public void setAuthCodeId(int authCodeId) {
		this.authCodeId = authCodeId;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}

	public LocalDateTime getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(LocalDateTime expireTime) {
		this.expireTime = expireTime;
	}

	public int getVerifyCount() {
		return verifyCount;
	}

	public void setVerifyCount(int verifyCount) {
		this.verifyCount = verifyCount;
	}

	public boolean isVerified() {
		return isVerified;
	}

	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}

