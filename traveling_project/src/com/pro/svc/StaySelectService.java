package com.pro.svc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;

public class StaySelectService implements ControlQuery{
	static StaySelectService selStay = new StaySelectService();

	public static StaySelectService instance() {
		return selStay;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("host_id");		
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String stayId =  Integer.toString(stayManagementDAO.countStayId(hostId));
		if(stayId.equals("0")) {
			req.setAttribute("result", "false");
		} else {
			req.setAttribute("result", "true");
		}
		return stayId;
	}
}
