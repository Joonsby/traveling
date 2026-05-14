package com.traveling.reservation.service;

import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.reservation.dto.ReservationInfo;

public class PaymentSuccessService implements DataControl{
	
	static PaymentSuccessService paymentSuccessService = new PaymentSuccessService();
	public static PaymentSuccessService instance() {
		return paymentSuccessService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
		
		
		// TODO Auto-generated method stub
		String paymentKey = req.getParameter("paymentKey");
		String orderId = req.getParameter("orderId");
		String amount = req.getParameter("amount");
		
		Map<String, Object> pending = reservationManageDAO.getPendingReservationByOrderId(orderId);
		
		if (pending == null) {
		    throw new RuntimeException("임시 예약 정보가 없습니다.");
		}
		
		int dbAmount = Integer.parseInt(String.valueOf(pending.get("amount")));
		int requestAmount = Integer.parseInt(amount);
		
		if (dbAmount != requestAmount) {
		    throw new RuntimeException("금액 위변조");
		}
		
		// 토스 승인 API 호출
		String result = PaymentConfirmService.confirm(paymentKey, orderId, amount);
		JsonObject obj = Json.createReader(new StringReader(result)).readObject();
		
		String tossStatus = obj.getString("status");
		
		if (!"DONE".equals(tossStatus)) {
		    throw new RuntimeException("결제 실패 상태");
		}
		
		pending.put("paymentKey", paymentKey);
		pending.put("orderId", orderId);
		
		int insertCnt = reservationManageDAO.insertReservationFromPending(pending);
		
		if (insertCnt <= 0) {
		    throw new RuntimeException("예약 생성 실패");
		}
		
		reservationManageDAO.updatePendingPaymentDone(orderId);
	    
	    // 5. 성공 페이지 이동
	    if(insertCnt > 0) {
	    	ReservationInfo reservationInfo = reservationManageDAO.getReservationSuccessInfo(orderId);
	    	req.setAttribute("reservationInfo", reservationInfo);
	    	res.sendRedirect(req.getContextPath() + "/webPage/reservation/pay_success.jsp");
	    } else {
	    	ViewUtil.forwardError(req,res,"결제 처리 중 오류가 발생했습니다.");
	    }
	}

}
