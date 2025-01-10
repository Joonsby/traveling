package com.traveling.reservation.service;


import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.reservation.dao.ReservationManageDAO;

public class ReservationAcceptService implements ControlQuery {
	static ReservationAcceptService reservationAcceptService = new ReservationAcceptService(); // 싱글톤 방식으로 객체 생성
	public static ReservationAcceptService instance() {
		return reservationAcceptService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReservationManageDAO reservationManageDAO = new ReservationManageDAO();
		HashMap<String,String> updateInfo = new HashMap<String,String>();
		updateInfo.put("reservationId",req.getParameter("reservationId"));
		updateInfo.put("status",req.getParameter("status"));
		int cnt = reservationManageDAO.reservationUpdate(updateInfo);
		if(cnt > 0) {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/reservation/ReservationServlet?requestType=getReservationStatus");
			dispatcher.forward(req, res);
		}
		return null;
	}
}
