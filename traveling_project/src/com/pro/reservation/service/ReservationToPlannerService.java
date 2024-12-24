package com.pro.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;

public class ReservationToPlannerService implements ControlQuery {
	static ReservationToPlannerService reservationToPlannerService = new ReservationToPlannerService(); // 싱글톤 방식으로 객체 생성
	public static ReservationToPlannerService instance() {
		return reservationToPlannerService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
