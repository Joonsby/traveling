package com.traveling.stay.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.common.ParsingCommon;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.CheckInInfo;

public class CheckOutListService implements ControlQuery{
	static CheckOutListService checkOutListService = new CheckOutListService(); // 싱글톤 방식으로 객체 생성
	public static CheckOutListService instance() {
		return checkOutListService;
	}
	

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		res.setCharacterEncoding("UTF-8");
		StayManagementDAO stmd = StayManagementDAO.instance();
		String hostId = req.getParameter("hostId");
		List<CheckInInfo> checkOutlist = stmd.checkOutSelect(hostId);
		res.getWriter().write(ParsingCommon.gson.toJson(checkOutlist));
	}
}
