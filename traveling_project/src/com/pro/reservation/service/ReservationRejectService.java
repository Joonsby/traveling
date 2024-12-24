package com.pro.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;

public class ReservationRejectService implements ControlQuery {
	static ReservationRejectService reservationRejectService = new ReservationRejectService(); // 싱글톤 방식으로 객체 생성
	public static ReservationRejectService instance() {
		return reservationRejectService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}
