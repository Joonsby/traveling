package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;

public class PaymentFailService implements ControlQuery{
	
	static PaymentFailService paymentFailService = new PaymentFailService();
	public static PaymentFailService instance() {
		return paymentFailService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub

	}

}
