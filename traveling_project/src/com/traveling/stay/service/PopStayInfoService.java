package com.traveling.stay.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class PopStayInfoService implements ControlQuery {

	static PopStayInfoService popStayInfoService = new PopStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static PopStayInfoService instance() {
		return popStayInfoService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		List<StayInfo> stayList = stayManagementDAO.popStaySelect();
		req.setAttribute("stayList", stayList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/stay/all_stays.jsp");
		dispatcher.forward(req, res);
	}

}
