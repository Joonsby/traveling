package com.pro.svc;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.FilterStayInfo;

public class PopStayService implements ControlQuery {
	static PopStayService ps = new PopStayService();

	public static PopStayService instance() {
		return ps;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		List<FilterStayInfo> stayList = stayManagementDAO.popStaySelect();
		req.setAttribute("stayList", stayList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("all_stays.jsp");
		dispatcher.forward(req, res);
		return null;
	}
}
