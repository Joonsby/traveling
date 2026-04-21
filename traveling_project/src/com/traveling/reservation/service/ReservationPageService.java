package com.traveling.reservation.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.traveling.common.ControlQuery;
import com.traveling.common.ParsingCommon;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.reservation.dto.RoomInfo;

public class ReservationPageService implements ControlQuery{
	static ReservationPageService reservationPageService = new ReservationPageService(); // 싱글톤 방식으로 객체 생성
	public static ReservationPageService instance() {
		return reservationPageService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReservationManageDAO reservationManageDAO = new ReservationManageDAO();
		List<RoomInfo> roomList = reservationManageDAO.getRoomInfo(Integer.parseInt(req.getParameter("room_id")));
		req.setAttribute("roomList", roomList);
		req.getRequestDispatcher("/webPage/reservation/reservation.jsp").forward(req, res);
	}
}
