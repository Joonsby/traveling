package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;

public class UserLogOutService implements ControlQuery {
	static UserLogOutService userLogOutService = new UserLogOutService();
	public static UserLogOutService instance() {
		return userLogOutService;
	}
	
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		session.invalidate();
		res.sendRedirect("/index.jsp");
	}
}
