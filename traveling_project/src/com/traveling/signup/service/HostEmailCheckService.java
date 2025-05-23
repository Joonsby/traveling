package com.traveling.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.signup.dao.SignupDAO;

public class HostEmailCheckService implements ControlQuery {
	static HostEmailCheckService hostEmailCheckService = new HostEmailCheckService(); // 싱글톤 방식으로 객체 생성
	public static HostEmailCheckService instance() {
		return hostEmailCheckService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = new SignupDAO();
		String hostEmail = req.getParameter("email");
		int cnt = signupDAO.checkHostEmail(hostEmail);
		if(cnt > 0) res.getWriter().write("true");
		else res.getWriter().write("false");
	}
}
