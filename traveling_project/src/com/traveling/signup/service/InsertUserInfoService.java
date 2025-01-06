package com.traveling.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.controller.ControlQuery;
import com.traveling.signup.dao.SignupDAO;
import com.traveling.signup.dto.UserInfo;

public class InsertUserInfoService implements ControlQuery{
	static InsertUserInfoService insertUserInfoService = new InsertUserInfoService(); // 싱글톤 방식으로 객체 생성
	public static InsertUserInfoService instance() {
		return insertUserInfoService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = SignupDAO.instance();
		UserInfo userInfo = new UserInfo();
		
		req.setCharacterEncoding("UTF-8");
		userInfo.setId(req.getParameter("id"));
		userInfo.setPw(req.getParameter("pw"));
		userInfo.setName(req.getParameter("name"));
		userInfo.setNews_agency(req.getParameter("news_agency"));
		userInfo.setPhone(req.getParameter("phone"));
		userInfo.setMail(req.getParameter("email") + "@" + req.getParameter("email_address"));
		userInfo.setBirth(req.getParameter("birth_year") + "-" + req.getParameter("birth_month") + "-" + req.getParameter("birth_day"));
		userInfo.setGender(req.getParameter("gender"));
		userInfo.setPost_code(req.getParameter("post_code"));
		userInfo.setRoad_addr(req.getParameter("road_addr"));
		userInfo.setJibun_addr(req.getParameter("jibun_addr"));
		userInfo.setDetail_addr(req.getParameter("detail_addr"));
		userInfo.setReference_addr(req.getParameter("reference_addr"));
		
		int cnt = signupDAO.insertUserInfo(userInfo);
		if (cnt > 0) {
			res.sendRedirect(req.getContextPath() + "/webPage/signup/signup_complete.jsp");
		}
		return null;
	}
		
}
