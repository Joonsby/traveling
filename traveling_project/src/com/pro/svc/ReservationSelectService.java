package com.pro.svc;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.CheckInInfo;

public class ReservationSelectService implements ControlQuery {

	static ReservationSelectService dbs = new ReservationSelectService();

	public static ReservationSelectService instance() {
		return dbs;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		res.setCharacterEncoding("UTF-8");
		StayManagementDAO stmd = StayManagementDAO.instance();
		CheckInInfo checkInInfo = new CheckInInfo();
		String hostId = (String) session.getAttribute("host_id");
		checkInInfo.setHostId(hostId);
		List<CheckInInfo> checkInlist = stmd.checkInSelect(checkInInfo);		
		req.setAttribute("checkInlist", checkInlist);
		RequestDispatcher dispatcher = req.getRequestDispatcher("webPage/host/host_index.jsp");
		dispatcher.forward(req, res);
		return null;
	}
}