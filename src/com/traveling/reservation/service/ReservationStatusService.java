package com.traveling.reservation.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.reservation.dto.ReservationInfo;

public class ReservationStatusService implements DataControl {
	static ReservationStatusService reservationStatusService = new ReservationStatusService(); // 싱글톤 방식으로 객체 생성
	public static ReservationStatusService instance() {
		return reservationStatusService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("host_id");
		ReservationManageDAO reservationManageDAO = new ReservationManageDAO();
		List<ReservationInfo> reservationList =  reservationManageDAO.getHostReservationInfo(hostId);
		req.setAttribute("reservationList", reservationList);
		// Host page through layout with host css/js
		String[] cssList = new String[] {
			"/css/host/host_common.css",
			"/css/host/host_aside.css",
			"/css/reservation/reservation_acception.css"
		};
		String[] jsList = new String[] {
			"/js/reservation/reservation_acception.js"
		};
		LayoutForward.host(req, res, "예약 관리", "/webPage/reservation/reservation_acception.jsp", cssList, jsList);
	}
	
}
