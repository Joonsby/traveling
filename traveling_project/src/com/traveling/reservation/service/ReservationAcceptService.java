package com.traveling.reservation.service;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.reservation.dao.ReservationManageDAO;

public class ReservationAcceptService implements DataControl {
	static ReservationAcceptService reservationAcceptService = new ReservationAcceptService(); // 싱글톤 방식으로 객체 생성
	public static ReservationAcceptService instance() {
		return reservationAcceptService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
		HashMap<String,String> updateInfo = new HashMap<String,String>();
		updateInfo.put("reservationId",req.getParameter("reservationId"));
		updateInfo.put("status",req.getParameter("status"));
		int cnt = reservationManageDAO.reservationUpdate(updateInfo);
		if(cnt > 0) {
			req.setAttribute("message", "예약 상태가 정상적으로 변경되었습니다.");
			req.getRequestDispatcher("/reservation/status").forward(req, res);
		} else {
			ViewUtil.forwardError(req,res,"예약 상태 변경에 실패했습니다.");
		}
	}
}
