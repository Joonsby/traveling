package com.traveling.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.controller.ControlQuery;
import com.traveling.login.dao.LoginDAO;
import com.traveling.login.dto.UserInfo;

public class UserLoginService implements ControlQuery {

	static UserLoginService userLoginService = new UserLoginService(); // 싱글톤 방식으로 객체 생성
	public static UserLoginService instance() {
		return userLoginService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String homePath = req.getContextPath();
		res.setCharacterEncoding("UTF-8");
		LoginDAO loginDAO = LoginDAO.instance();
		UserInfo userInfo = new UserInfo();
		userInfo.setUserId(req.getParameter("id"));
		userInfo.setUserPw(req.getParameter("pw"));
		int cnt = loginDAO.checkUserInfo(userInfo);
		if(cnt > 0) {
			session.setAttribute("id", req.getParameter("id"));
			res.sendRedirect(homePath + "/");
		} else {
			res.sendRedirect(homePath + "/webPage/login/login.jsp?requestType=user&loginfail=Y");
		}
		return null;
	}
	
}
