package com.traveling.reservation.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.reservation.service.CreatePendingReservationService;
import com.traveling.reservation.service.PaymentFailService;
import com.traveling.reservation.service.PaymentSuccessService;
import com.traveling.reservation.service.ReservationAcceptService;
import com.traveling.reservation.service.ReservationPageService;
import com.traveling.reservation.service.ReservationRejectService;
import com.traveling.reservation.service.ReservationStatusService;
import com.traveling.reservation.service.ReservationToPlannerService;
import com.traveling.reservation.service.RoomInfoService;

public class ReservationController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/reservation/");
		printRequestLog(req,"ReservationController",action);
		try{
			switch(action) {
			case "page":
				inter = ReservationPageService.instance();
				break;
			case "pending-create":
				inter = CreatePendingReservationService.instance();
				break;
			case "payment-success":
			    inter = PaymentSuccessService.instance();
			    break;
			case "payment-fail":
			    inter = PaymentFailService.instance();
			    break;
			case "status":
				inter = ReservationStatusService.instance();
				break;
			case "accept":
				inter = ReservationAcceptService.instance();
				break;
			case "reject":
				inter = ReservationRejectService.instance();
				break;
			case "planner":
				inter = ReservationToPlannerService.instance();
				break;
			case "room-info":
				inter = RoomInfoService.instance();
				break;
			default:
			    ViewUtil.forwardError(req, res, "잘못된 요청입니다.");
			    return;
			}
            if (inter != null) {
                inter.dataCon(req, res);
            }
		} catch(Exception e) {
			printFailLog(e);
			throw new ServletException("ReservationController 처리 중 오류 발생", e);
		}
	}
	
}
