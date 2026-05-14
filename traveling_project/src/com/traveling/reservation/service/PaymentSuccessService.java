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
		
		// 1. DB조회
		List<ReservationInfo> reservationList = reservationManageDAO.getByOrderId(orderId);
		
		// 2. 금액 검증
		if (reservationList.get(0).getPrice() != Integer.parseInt(amount)) {
			throw new RuntimeException("금액 위변조");
		}
		
		// 3. 토스 승인 API 호출
		String result = PaymentConfirmService.confirm(paymentKey,orderId,amount);
		JsonObject obj = Json.createReader(new StringReader(result)).readObject();
		
		String status = obj.getString("status");
		
	    if (!"DONE".equals(status)) {
	        throw new RuntimeException("결제 실패 상태");
	    }
	    
	    // 4. DB UPDATE
	    Map<String, Object> updateMap = new HashMap<>();
	    updateMap.put("orderId", orderId);
	    updateMap.put("paymentKey", paymentKey);
	    updateMap.put("paymentStatus", status);
	    updateMap.put("status", "예약 대기");
	    updateMap.put("paidAmount", amount);
	    
	    int cnt = reservationManageDAO.updatePaymentSuccess(updateMap);
	    
	    // 5. 성공 페이지 이동
	    if(cnt > 0) {
	    	res.sendRedirect(req.getContextPath() + "/webPage/reservation/pay_success.jsp");
	    } else {
	    	ViewUtil.forwardError(req,res,"결제 처리 중 오류가 발생했습니다.");
	    }
	}

}
