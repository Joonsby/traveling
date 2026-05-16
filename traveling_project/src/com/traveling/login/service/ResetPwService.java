package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.login.dao.FindIdDAO;

public class ResetPwService implements DataControl {

	static ResetPwService instance = new ResetPwService();

	public static ResetPwService instance() {
		return instance;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");

		String newPassword = req.getParameter("newPw");
		String confirmPassword = req.getParameter("confirmPw");

		HttpSession session = req.getSession();

		// Session에서 인증 정보 확인
		Boolean isVerified = (Boolean) session.getAttribute("pw_auth_verified");
		String userId = (String) session.getAttribute("pw_auth_user_id");

		if (isVerified == null || !isVerified || userId == null || userId.isEmpty()) {
			res.getWriter().write("{\"success\": false, \"message\": \"인증되지 않은 요청입니다.\"}");
			return;
		}

		// 유효성 검사
		if (newPassword == null || newPassword.trim().isEmpty() || confirmPassword == null
				|| confirmPassword.trim().isEmpty()) {
			res.getWriter().write("{\"success\": false, \"message\": \"필수 입력값이 누락되었습니다.\"}");
			return;
		}

		// 비밀번호 일치 확인
		if (!newPassword.equals(confirmPassword)) {
			res.getWriter().write("{\"success\": false, \"message\": \"비밀번호가 일치하지 않습니다.\"}");
			return;
		}

		// 비밀번호 강도 검사 (선택사항)
		if (newPassword.length() < 6) {
			res.getWriter().write("{\"success\": false, \"message\": \"비밀번호는 최소 6자 이상이어야 합니다.\"}");
			return;
		}

		FindIdDAO findIdDAO = FindIdDAO.instance();

		try {
			// 비밀번호 업데이트
			findIdDAO.updatePassword(userId, newPassword);

			// Session 정보 제거 (보안)
			session.removeAttribute("pw_auth_verified");
			session.removeAttribute("pw_auth_contact");
			session.removeAttribute("pw_auth_type");
			session.removeAttribute("pw_auth_user_id");
			session.removeAttribute("pw_auth_name");

			res.getWriter().write("{\"success\": true, \"message\": \"비밀번호가 성공적으로 변경되었습니다.\"}");
		} catch (Exception e) {
			e.printStackTrace();
			res.getWriter().write("{\"success\": false, \"message\": \"비밀번호 변경 중 오류가 발생했습니다.\"}");
		}
	}
}

