package com.traveling.login.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.login.dto.AuthCode;
import com.traveling.signup.dto.UserInfo;

public class FindIdDAO {
	static FindIdDAO findIdDAO = new FindIdDAO();

	public static FindIdDAO instance() {
		return findIdDAO;
	}

	SqlSessionFactory f = DBCon.getSqlSession();

	/**
	 * 이름과 이메일로 사용자 존재 여부 확인
	 */
	public int checkUserByNameAndEmail(String name, String email) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("name", name);
		params.put("email", email);
		int cnt = s.selectOne("checkUserByNameAndEmail", params);
		s.close();
		return cnt;
	}

	/**
	 * 이름과 전화번호로 사용자 존재 여부 확인
	 */
	public int checkUserByNameAndPhone(String name, String phone) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("name", name);
		params.put("phone", phone);
		int cnt = s.selectOne("checkUserByNameAndPhone", params);
		s.close();
		return cnt;
	}

	/**
	 * 이름과 이메일로 아이디 조회
	 */
	public String findIdByNameAndEmail(String name, String email) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("name", name);
		params.put("email", email);
		String userId = s.selectOne("findIdByNameAndEmail", params);
		s.close();
		return userId;
	}

	/**
	 * 이름과 전화번호로 아이디 조회
	 */
	public String findIdByNameAndPhone(String name, String phone) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("name", name);
		params.put("phone", phone);
		String userId = s.selectOne("findIdByNameAndPhone", params);
		s.close();
		return userId;
	}

	/**
	 * 인증코드 저장
	 */
	public void insertAuthCode(AuthCode authCode) {
		SqlSession s = f.openSession();
		s.insert("insertAuthCode", authCode);
		s.commit();
		s.close();
	}

	/**
	 * 유효한 인증코드로 검색 (이메일 또는 전화번호 + 타입)
	 */
	public AuthCode getAuthCodeByContactAndType(String contact, String authType) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("contact", contact);
		params.put("authType", authType);
		AuthCode authCode = s.selectOne("getAuthCodeByContactAndType", params);
		s.close();
		return authCode;
	}

	/**
	 * 인증코드 검증 시도 횟수 증가
	 */
	public void increaseVerifyCount(int authCodeId) {
		SqlSession s = f.openSession();
		s.update("increaseVerifyCount", authCodeId);
		s.commit();
		s.close();
	}

	/**
	 * 인증 성공 처리
	 */
	public void markAuthCodeAsVerified(int authCodeId) {
		SqlSession s = f.openSession();
		s.update("markAuthCodeAsVerified", authCodeId);
		s.commit();
		s.close();
	}

	/**
	 * user_id와 이름, 이메일로 사용자 확인 (비밀번호 찾기용)
	 */
	public int checkUserByIdNameAndEmail(String userId, String name, String email) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("id", userId);
		params.put("name", name);
		params.put("email", email);
		int cnt = s.selectOne("checkUserByIdNameAndEmail", params);
		s.close();
		return cnt;
	}

	/**
	 * user_id와 이름, 전화번호로 사용자 확인 (비밀번호 찾기용)
	 */
	public int checkUserByIdNameAndPhone(String userId, String name, String phone) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("id", userId);
		params.put("name", name);
		params.put("phone", phone);
		int cnt = s.selectOne("checkUserByIdNameAndPhone", params);
		s.close();
		return cnt;
	}

	/**
	 * 비밀번호 업데이트
	 */
	public void updatePassword(String userId, String newPassword) {
		SqlSession s = f.openSession();
		Map<String, String> params = new HashMap<>();
		params.put("id", userId);
		params.put("pw", newPassword);
		s.update("updatePassword", params);
		s.commit();
		s.close();
	}
}

