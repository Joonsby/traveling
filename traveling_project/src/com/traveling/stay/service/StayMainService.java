package com.traveling.stay.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.stay.dao.StayManagementDAO;

public class StayMainService implements DataControl {
	
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

		// Forward to main via layout (user)
		LayoutForward.user(req, res, "Home", "/index.jsp", null, null);
	}
}
