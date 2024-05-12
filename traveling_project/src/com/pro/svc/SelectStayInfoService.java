package com.pro.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.StayInfo;

public class SelectStayInfoService implements ControlQuery{
	
	static SelectStayInfoService sis = new SelectStayInfoService();

	public static SelectStayInfoService instance() {
		return sis;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String host_id = req.getParameter("host_id");
		List<StayInfo> stayInfo =  stayManagementDAO.selectStayInfo(host_id);
		req.setAttribute("stayInfo", stayInfo);
		return null;
	}

}
