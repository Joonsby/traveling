package com.traveling.reservation.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.reservation.dto.RoomInfo;

public class ReservationPageService implements DataControl{
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
		String[] cssList = new String[] { "/css/reservation/reservation.css" };
		String[] jsList = new String[] { "/js/reservation/reservation.js" };
		LayoutForward.user(req, res, "예약 페이지", "/webPage/reservation/reservation.jsp", cssList, jsList);
	}
}
