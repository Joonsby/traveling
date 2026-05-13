package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;

public class ReservationRejectService implements DataControl {
	static ReservationRejectService reservationRejectService = new ReservationRejectService(); // 싱글톤 방식으로 객체 생성
	public static ReservationRejectService instance() {
		return reservationRejectService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
	}
	
}
