package com.pro.reservation.service;


import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.controller.ControlQuery;
import com.pro.reservation.dao.ReservationManageDAO;
import com.pro.reservation.dto.ReservationInfo;

public class ReservationAcceptService implements ControlQuery {
	static ReservationAcceptService reservationAcceptService = new ReservationAcceptService(); // 싱글톤 방식으로 객체 생성
	public static ReservationAcceptService instance() {
		return reservationAcceptService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("hostId");
		ReservationManageDAO reservationManageDAO = new ReservationManageDAO();
		List<ReservationInfo> reservationList =  reservationManageDAO.getReservationInfo(hostId);
		req.setAttribute("reservationList", reservationList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/reservation/reservation_acception.jsp");
		dispatcher.forward(req, res);
		return null;
	}

}
