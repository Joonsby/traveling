package com.traveling.main.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.stay.dao.StayManagementDAO;

public class MainService implements DataControl{
	static MainService mainService = new MainService(); // 싱글톤 방식으로 객체 생성
	public static MainService instance() {
		return mainService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		req.setAttribute("popStays", stayManagementDAO.popStaySelect());
		req.setAttribute("bestReviewStays", stayManagementDAO.bestReviewStaySelect());
		req.setAttribute("cheapStays", stayManagementDAO.cheapStaySelect());
		req.getRequestDispatcher("index.jsp").forward(req, res);
	}
}
