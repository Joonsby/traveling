package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;

public class UserLogOutService implements DataControl {
	static UserLogOutService userLogOutService = new UserLogOutService();
	public static UserLogOutService instance() {
		return userLogOutService;
	}
	
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		session.invalidate();
		res.sendRedirect("/");
	}
}
