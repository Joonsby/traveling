package com.traveling.stay.service;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;

public class StayCntService implements ControlQuery  {
	
	static StayCntService stayCntService = new StayCntService(); // 싱글톤 방식으로 객체 생성
	public static StayCntService instance() {
		return stayCntService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("host_id");		
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String stayId =  Integer.toString(stayManagementDAO.countStayId(hostId));
		if(stayId.equals("0")) {
			req.setAttribute("result", false);
		} else {
			req.setAttribute("result", true);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("webPage/stay/stay_sel_result.jsp");
		dispatcher.forward(req, res);
		return null;
	}

}
