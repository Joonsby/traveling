package com.traveling.login.service;

import java.time.LocalDateTime;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.login.dao.FindIdDAO;
import com.traveling.login.dto.AuthCode;

public class FindPwSendCodeService implements DataControl {

	static FindPwSendCodeService instance = new FindPwSendCodeService();

	public static FindPwSendCodeService instance() {
		return instance;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");

		String userId = req.getParameter("userId");
		String name = req.getParameter("name");
		String contact = req.getParameter("contact"); // 이메일 또는 전화번호
		String authType = req.getParameter("authType"); // "email" or "sms"

		// 유효성 검사
		if (userId == null || userId.trim().isEmpty() || name == null || name.trim().isEmpty()
				|| contact == null || contact.trim().isEmpty()) {
			res.getWriter().write("{\"success\": false, \"message\": \"필수 입력값이 누락되었습니다.\"}");
			return;
		}

		FindIdDAO findIdDAO = FindIdDAO.instance();

		// 사용자 존재 여부 확인 (보안: 직접 노출하지 않음)
		int userExists = 0;
		if ("email".equals(authType)) {
			userExists = findIdDAO.checkUserByIdNameAndEmail(userId, name, contact);
		} else if ("sms".equals(authType)) {
			userExists = findIdDAO.checkUserByIdNameAndPhone(userId, name, contact);
		} else {
			res.getWriter().write("{\"success\": false, \"message\": \"잘못된 인증 방식입니다.\"}");
			return;
		}

		// 보안: 사용자 존재 여부를 직접 노출하지 않음
		// 항상 성공 메시지를 보냄
		String authCode = generateAuthCode();

		try {
			// DB에 인증코드 저장
			AuthCode authCodeObj = new AuthCode();
			authCodeObj.setContact(contact);
			authCodeObj.setAuthCode(authCode);
			authCodeObj.setAuthType(authType);
			authCodeObj.setExpireTime(LocalDateTime.now().plusMinutes(10)); // 10분 유효

			findIdDAO.insertAuthCode(authCodeObj);

			// TODO: 실제 이메일/SMS 전송 로직
			if ("email".equals(authType)) {
				sendEmailCode(contact, authCode);
			} else if ("sms".equals(authType)) {
				sendSmsCode(contact, authCode);
			}

			// Session에 저장
			HttpSession session = req.getSession();
			session.setAttribute("pw_auth_contact", contact);
			session.setAttribute("pw_auth_type", authType);
			session.setAttribute("pw_auth_user_id", userId);
			session.setAttribute("pw_auth_name", name);

			res.getWriter().write("{\"success\": true, \"message\": \"인증코드가 발송되었습니다.\"}");
		} catch (Exception e) {
			e.printStackTrace();
			res.getWriter().write("{\"success\": false, \"message\": \"인증코드 발송에 실패했습니다.\"}");
		}
	}

	/**
	 * 6자리 랜덤 인증코드 생성
	 */
	private String generateAuthCode() {
		Random random = new Random();
		int code = 100000 + random.nextInt(900000);
		return String.valueOf(code);
	}

	/**
	 * 이메일로 인증코드 전송
	 */
	private void sendEmailCode(String email, String authCode) {
		System.out.println("[EMAIL] to: " + email + ", code: " + authCode);
	}

	/**
	 * SMS로 인증코드 전송
	 */
	private void sendSmsCode(String phone, String authCode) {
		System.out.println("[SMS] to: " + phone + ", code: " + authCode);
	}
}

