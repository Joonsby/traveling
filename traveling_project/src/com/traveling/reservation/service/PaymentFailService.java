package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;

public class PaymentFailService implements DataControl{
	
	static PaymentFailService paymentFailService = new PaymentFailService();
	public static PaymentFailService instance() {
		return paymentFailService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub

	}

}
