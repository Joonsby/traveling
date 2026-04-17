package com.traveling.stay.service;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;

public class StayMainService implements ControlQuery {
	
	static StayMainService mainService = new StayMainService(); // 싱글톤 방식으로 객체 생성
	public static StayMainService instance() {
		return mainService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		req.setAttribute("popStays", stayManagementDAO.popStaySelect());
		req.setAttribute("bestReviewStays", stayManagementDAO.bestReviewStaySelect());
		req.setAttribute("cheapStays", stayManagementDAO.cheapStaySelect());
		
        RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
        dispatcher.forward(req, res);
	}
}
