package com.pro.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.signup.dao.SignupDAO;
import com.pro.signup.dto.HostInfo;

public class InsertHostInfoService implements ControlQuery{
	static InsertHostInfoService insertHostInfoService = new InsertHostInfoService(); // 싱글톤 방식으로 객체 생성
	public static InsertHostInfoService instance() {
		return insertHostInfoService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = new SignupDAO();
		HostInfo hostInfo = new HostInfo();
		
		req.setCharacterEncoding("UTF-8");
		hostInfo.setHost_id(req.getParameter("host_id"));
		hostInfo.setPw(req.getParameter("pw"));
		hostInfo.setName(req.getParameter("name"));
		hostInfo.setNews_agency(req.getParameter("news_agency"));
		hostInfo.setBusiness_num(req.getParameter("business_num1"));
		hostInfo.setPhone(req.getParameter("phone"));
		hostInfo.setMail(req.getParameter("email") + "@" + req.getParameter("email_address"));
		hostInfo.setBirth(req.getParameter("birth_year") + "-" + req.getParameter("birth_month") + "-" + req.getParameter("birth_day"));
		hostInfo.setGender(req.getParameter("gender"));
		hostInfo.setPost_code(req.getParameter("post_code"));
		hostInfo.setRoad_addr(req.getParameter("road_addr"));
		hostInfo.setJibun_addr(req.getParameter("jibun_addr"));
		hostInfo.setDetail_addr(req.getParameter("detail_addr"));
		hostInfo.setReference_addr(req.getParameter("reference_addr"));
		
		int cnt = signupDAO.insertHostInfo(hostInfo);
		if(cnt > 0) {
			res.sendRedirect(req.getContextPath() + "/webPage/signup/signup_complete.jsp");
		}
		return null;
	}
}
