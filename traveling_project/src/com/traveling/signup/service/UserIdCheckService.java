package com.traveling.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.signup.dao.SignupDAO;

public class UserIdCheckService implements ControlQuery{
	static UserIdCheckService userIdCheckService = new UserIdCheckService(); // 싱글톤 방식으로 객체 생성
	public static UserIdCheckService instance() {
		return userIdCheckService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = new SignupDAO();
		String userId = req.getParameter("user_id");
		int cnt = signupDAO.checkUserId(userId);
		if(cnt > 0) res.getWriter().write("true");
		else res.getWriter().write("false");
	}
	
}
