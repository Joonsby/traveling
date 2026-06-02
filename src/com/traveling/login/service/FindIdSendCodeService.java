package com.traveling.login.service;

import java.time.LocalDateTime;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.login.dao.FindIdDAO;
import com.traveling.login.dto.AuthCode;

public class FindIdSendCodeService implements DataControl {

	static FindIdSendCodeService instance = new FindIdSendCodeService();

	public static FindIdSendCodeService instance() {
		return instance;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");

		String name = req.getParameter("name");
		String contact = req.getParameter("contact"); // 이메일 또는 전화번호
		String authType = req.getParameter("authType"); // "email" or "sms"

		// 유효성 검사
		if (name == null || name.trim().isEmpty() || contact == null || contact.trim().isEmpty()) {
			res.getWriter().write("{\"success\": false, \"message\": \"필수 입력값이 누락되었습니다.\"}");
			return;
		}

		FindIdDAO findIdDAO = FindIdDAO.instance();

		// 사용자 존재 여부 확인 (보안: 직접 노출하지 않음)
		int userExists = 0;
		if ("email".equals(authType)) {
			userExists = findIdDAO.checkUserByNameAndEmail(name, contact);
		} else if ("sms".equals(authType)) {
			userExists = findIdDAO.checkUserByNameAndPhone(name, contact);
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

			// Session에 저장 (선택사항: 프론트에서 필요시)
			HttpSession session = req.getSession();
			session.setAttribute("auth_contact", contact);
			session.setAttribute("auth_type", authType);

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
	 * 이메일로 인증코드 전송 (실제 구현 필요)
	 */
	private void sendEmailCode(String email, String authCode) {
		// TODO: JavaMail API를 사용하여 이메일 전송
		System.out.println("[EMAIL] to: " + email + ", code: " + authCode);
	}

	/**
	 * SMS로 인증코드 전송 (실제 구현 필요)
	 */
	private void sendSmsCode(String phone, String authCode) {
		// TODO: SMS API (Twilio, COOLSMS 등)를 사용하여 SMS 전송
		System.out.println("[SMS] to: " + phone + ", code: " + authCode);
	}
}

