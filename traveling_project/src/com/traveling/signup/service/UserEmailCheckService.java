package com.traveling.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.signup.dao.SignupDAO;

public class UserEmailCheckService implements ControlQuery{
	static UserEmailCheckService userEmailCheckService = new UserEmailCheckService(); // 싱글톤 방식으로 객체 생성
	public static UserEmailCheckService instance() {
		return userEmailCheckService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = new SignupDAO();
		String userEmail = req.getParameter("email");
		int cnt = signupDAO.checkUserEmail(userEmail);
		if(cnt > 0) res.getWriter().write("true");
		else res.getWriter().write("false");
	}
}
