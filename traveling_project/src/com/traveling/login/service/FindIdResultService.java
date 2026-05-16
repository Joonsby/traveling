package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.login.dao.FindIdDAO;

public class FindIdResultService implements DataControl {

	static FindIdResultService instance = new FindIdResultService();

	public static FindIdResultService instance() {
		return instance;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/json; charset=UTF-8");

		HttpSession session = req.getSession();

		// Session에서 인증 정보 확인
		Boolean isVerified = (Boolean) session.getAttribute("auth_verified");
		String contact = (String) session.getAttribute("auth_contact");
		String authType = (String) session.getAttribute("auth_type");

		if (isVerified == null || !isVerified || contact == null || authType == null) {
			res.getWriter().write("{\"success\": false, \"message\": \"인증되지 않은 요청입니다.\"}");
			return;
		}

		FindIdDAO findIdDAO = FindIdDAO.instance();

		try {
			String userId = null;

			// 방식에 따라 아이디 조회
			if ("email".equals(authType)) {
				// 이메일로 아이디 조회하기 위해 이름이 필요함
				String name = (String) session.getAttribute("auth_name");
				if (name == null || name.isEmpty()) {
					res.getWriter().write("{\"success\": false, \"message\": \"필수 정보가 누락되었습니다.\"}");
					return;
				}
				userId = findIdDAO.findIdByNameAndEmail(name, contact);
			} else if ("sms".equals(authType)) {
				String name = (String) session.getAttribute("auth_name");
				if (name == null || name.isEmpty()) {
					res.getWriter().write("{\"success\": false, \"message\": \"필수 정보가 누락되었습니다.\"}");
					return;
				}
				userId = findIdDAO.findIdByNameAndPhone(name, contact);
			}

			if (userId != null && !userId.isEmpty()) {
				// 아이디를 일부 마스킹 (보안)
				String maskedUserId = maskUserId(userId);

				// Session 정보 제거 (보안)
				session.removeAttribute("auth_verified");
				session.removeAttribute("auth_contact");
				session.removeAttribute("auth_type");
				session.removeAttribute("auth_name");

				res.getWriter()
						.write("{\"success\": true, \"userId\": \"" + userId + "\", \"maskedUserId\": \"" + maskedUserId + "\"}");
			} else {
				res.getWriter().write("{\"success\": false, \"message\": \"등록된 계정을 찾을 수 없습니다.\"}");
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.getWriter().write("{\"success\": false, \"message\": \"조회 중 오류가 발생했습니다.\"}");
		}
	}

	/**
	 * 아이디 마스킹 (예: test123 → te****23)
	 */
	private String maskUserId(String userId) {
		if (userId.length() <= 4) {
			return userId.replaceAll(".", "*");
		}
		int showCount = 2;
		String visible = userId.substring(0, showCount) + userId.substring(userId.length() - showCount);
		int maskCount = userId.length() - 2 * showCount;
		String mask = "";
		for (int i = 0; i < maskCount; i++) {
			mask += "*";
		}
		return userId.substring(0, showCount) + mask + userId.substring(userId.length() - showCount);
	}
}

