package com.traveling.reservation.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.reservation.service.PaymentService;
import com.traveling.reservation.service.ReservationAcceptService;
import com.traveling.reservation.service.ReservationRejectService;
import com.traveling.reservation.service.ReservationStatusService;
import com.traveling.reservation.service.ReservationToPlannerService;
import com.traveling.reservation.service.RoomInfoService;

public class ReservationServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ControlQuery inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType=req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		
		try{
			switch(requestType) {
			case "getReservationStatus":
				inter = ReservationStatusService.instance();
				inter.dataCon(req, res);
				break;
			case "reservationUpdate":
				inter = ReservationAcceptService.instance();
				inter.dataCon(req, res);
				break;
			case "reservationReject":
				inter = ReservationRejectService.instance();
				inter.dataCon(req, res);
				break;
			case "reservationToPlanner":
				inter = ReservationToPlannerService.instance();
				inter.dataCon(req, res);
				break;
			case "getRoomInfo":
				inter = RoomInfoService.instance();
				inter.dataCon(req, res);
				break;
			case "payment":
				inter = PaymentService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
