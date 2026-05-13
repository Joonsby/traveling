package com.traveling.stay.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.common.ParsingCommon;
import com.traveling.stay.dao.StayManagementDAO;

public class StayCntService implements DataControl  {
	
	static StayCntService stayCntService = new StayCntService(); // 싱글톤 방식으로 객체 생성
	public static StayCntService instance() {
		return stayCntService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("host_id");		
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		int stayId =  stayManagementDAO.countStayId(hostId);
		ParsingCommon.writeJson(res, stayId);
	}

}
