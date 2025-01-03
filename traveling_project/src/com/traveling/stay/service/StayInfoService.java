package com.traveling.stay.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.controller.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class StayInfoService implements ControlQuery  {
	
	static StayInfoService stayInfoService = new StayInfoService(); // 싱글톤 방식으로 객체 생성
	public static StayInfoService instance() {
		return stayInfoService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String host_id = req.getParameter("host_id");
		List<StayInfo> stayInfo =  stayManagementDAO.selectStayInfo(host_id);
		req.setAttribute("stayInfo", stayInfo);
		RequestDispatcher dispatcher = req.getRequestDispatcher("webPage/stay/stay_info.jsp");
		dispatcher.forward(req, res);
		return null;
	}

}
