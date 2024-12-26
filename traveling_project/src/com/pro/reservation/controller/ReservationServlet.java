package com.pro.reservation.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.reservation.service.ReservationAcceptService;
import com.pro.reservation.service.ReservationRejectService;
import com.pro.reservation.service.ReservationStatusService;
import com.pro.reservation.service.ReservationToPlannerService;

public class ReservationServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ControlQuery inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
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
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
