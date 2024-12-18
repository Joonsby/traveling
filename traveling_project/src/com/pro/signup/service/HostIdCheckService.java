package com.pro.signup.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.signup.dao.SignupDAO;

public class HostIdCheckService  implements ControlQuery{
	static HostIdCheckService hostIdCheckService = new HostIdCheckService(); // 싱글톤 방식으로 객체 생성
	public static HostIdCheckService instance() {
		return hostIdCheckService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		SignupDAO signupDAO = new SignupDAO();
		String hostId = req.getParameter("hostId");
		int cnt = signupDAO.checkHostId(hostId);
		if(cnt > 0) return "true";
		else return "false";
	}
}
