package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.login.dao.FindIdDAO;
import com.traveling.login.dto.AuthCode;

public class FindPwVerifyCodeService implements DataControl {

	static FindPwVerifyCodeService instance = new FindPwVerifyCodeService();

	public static FindPwVerifyCodeService instance() {
		return instance;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");

		String inputCode = req.getParameter("code");
		String contact = req.getParameter("contact");
		String authType = req.getParameter("authType");

		if (inputCode == null || inputCode.trim().isEmpty() || contact == null || contact.trim().isEmpty()) {
			res.getWriter().write("{\"success\": false, \"message\": \"필수 입력값이 누락되었습니다.\"}");
			return;
		}

		FindIdDAO findIdDAO = FindIdDAO.instance();

		try {
			// DB에서 인증코드 조회
			AuthCode authCode = findIdDAO.getAuthCodeByContactAndType(contact, authType);

			if (authCode == null) {
				res.getWriter().write("{\"success\": false, \"message\": \"인증코드가 만료되었습니다. 다시 발송해주세요.\"}");
				return;
			}

			// 시도 횟수 확인
			if (authCode.getVerifyCount() >= 5) {
				res.getWriter().write("{\"success\": false, \"message\": \"시도 횟수를 초과했습니다. 다시 시도해주세요.\"}");
				return;
			}

			// 인증코드 검증
			if (authCode.getAuthCode().equals(inputCode)) {
				// 인증 성공
				findIdDAO.markAuthCodeAsVerified(authCode.getAuthCodeId());

				// Session에 인증 성공 정보 저장
				HttpSession session = req.getSession();
				session.setAttribute("pw_auth_verified", true);

				res.getWriter().write("{\"success\": true, \"message\": \"인증이 완료되었습니다.\"}");
			} else {
				// 인증 실패
				findIdDAO.increaseVerifyCount(authCode.getAuthCodeId());
				int remainingAttempts = 5 - authCode.getVerifyCount() - 1;
				res.getWriter()
						.write("{\"success\": false, \"message\": \"인증코드가 일치하지 않습니다. 남은 시도: " + remainingAttempts + "\"}");
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.getWriter().write("{\"success\": false, \"message\": \"인증 처리 중 오류가 발생했습니다.\"}");
		}
	}
}

