package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;

public class ReservationToPlannerService implements ControlQuery {
	static ReservationToPlannerService reservationToPlannerService = new ReservationToPlannerService(); // 싱글톤 방식으로 객체 생성
	public static ReservationToPlannerService instance() {
		return reservationToPlannerService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
	}
}
