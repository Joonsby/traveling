package com.traveling.stay.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.traveling.controller.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.CheckInInfo;

public class CheckInListService implements ControlQuery {
	
	static CheckInListService checkInListService = new CheckInListService(); // 싱글톤 방식으로 객체 생성
	public static CheckInListService instance() {
		return checkInListService;
	}
	
	Gson gson = new Gson();

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		res.setCharacterEncoding("UTF-8");
		StayManagementDAO stmd = StayManagementDAO.instance();
		String hostId = (String) session.getAttribute("host_id");
		List<CheckInInfo> checkInlist = stmd.checkInSelect(hostId);
		res.getWriter().write(gson.toJson(checkInlist));
		return null;
	}

}
