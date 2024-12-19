package com.pro.stay.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.stay.dao.StayManagementDAO;
import com.pro.stay.dto.ReviewInfo;
import com.pro.stay.dto.RoomInfo;
import com.pro.stay.dto.StayInfo;

public class DetailStayInfoService implements ControlQuery  {
	
	static DetailStayInfoService detailStayInfoService = new DetailStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static DetailStayInfoService instance() {
		return detailStayInfoService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		int stay_id = Integer.parseInt((String) req.getParameter("stay_id"));
		StayManagementDAO stayManagementDAO = new StayManagementDAO();
		List<StayInfo> detailStayList =  stayManagementDAO.selectStayInfo(stay_id);
		List<RoomInfo> roomList = stayManagementDAO.selectRoomInfo(stay_id);
		List<ReviewInfo> reviewList = stayManagementDAO.selectReview(stay_id);
		req.setAttribute("detailStayList", detailStayList);
		req.setAttribute("roomList", roomList);
		req.setAttribute("reviewList", reviewList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/stay/detail_stay.jsp");
		dispatcher.forward(req, res);
		return null;
	}

}
