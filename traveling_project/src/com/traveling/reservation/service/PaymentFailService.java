package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.reservation.dao.ReservationManageDAO;

public class PaymentFailService implements DataControl{
	
	static PaymentFailService paymentFailService = new PaymentFailService();
	public static PaymentFailService instance() {
		return paymentFailService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    String orderId = req.getParameter("orderId");

	    if (orderId != null && !orderId.trim().isEmpty()) {
	        ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
	        reservationManageDAO.updatePendingPaymentFail(orderId);
	    }

	    res.sendRedirect(req.getContextPath() + "/webPage/reservation/reservation.jsp");
	}
}
