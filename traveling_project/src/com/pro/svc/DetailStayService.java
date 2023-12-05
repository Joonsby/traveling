package com.pro.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.ReviewInfo;
import com.pro.dto.RoomInfo;
import com.pro.dto.StayInfo;

public class DetailStayService implements ControlQuery{
	static DetailStayService detailStayService = new DetailStayService();

	public static DetailStayService instance() {
		return detailStayService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		int stay_id = Integer.parseInt((String) req.getParameter("stay_id"));	
		
		StayManagementDAO stayManagementDAO = new StayManagementDAO();
		
		List<StayInfo> detailStayList =  stayManagementDAO.selectStayInfo(stay_id);
		
		List<RoomInfo> roomList = stayManagementDAO.selectRoomInfo(stay_id);		
		
		List<ReviewInfo> reviewList = stayManagementDAO.selectReview(stay_id);
		
		
		req.setAttribute("detailStayList", detailStayList);		
		req.setAttribute("roomList", roomList);
		req.setAttribute("reviewList", reviewList);
		return null;
	}	
}
