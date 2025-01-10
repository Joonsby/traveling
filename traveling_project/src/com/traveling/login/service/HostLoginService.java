package com.traveling.login.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;
import com.traveling.login.dao.LoginDAO;
import com.traveling.login.dto.HostInfo;
import com.traveling.login.dto.UserInfo;

public class HostLoginService implements ControlQuery {

	static HostLoginService hostLoginService = new HostLoginService(); // 싱글톤 방식으로 객체 생성
	public static HostLoginService instance() {
		return hostLoginService;
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
		int cnt = loginDAO.checkHostInfo(userInfo);
		if(cnt > 0) {
			List<HostInfo> hostList = loginDAO.getHostInfo(userInfo);
			session.setAttribute("host_id", hostList.get(0).getHost_id());
			session.setAttribute("pw", hostList.get(0).getPw());
			session.setAttribute("name", hostList.get(0).getName());
			res.sendRedirect(homePath + "/webPage/host/host_index.jsp");
		} else {
			res.sendRedirect(homePath + "/webPage/login/login.jsp?requestType=host&loginfail=Y");
		}
		return null;
	}
}
