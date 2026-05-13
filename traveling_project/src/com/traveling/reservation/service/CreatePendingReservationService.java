package com.traveling.reservation.service;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.ParsingCommon;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.signup.dto.UserInfo;

public class CreatePendingReservationService implements DataControl{
	static CreatePendingReservationService createPendingReservationService = new CreatePendingReservationService(); // 싱글톤 방식으로 객체 생성
	public static CreatePendingReservationService instance() {
		return createPendingReservationService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		String userId = (String) req.getSession().getAttribute("id");
		String jsonStr = req.getParameter("reservation");
		JsonObject json = Json.createReader(new StringReader(jsonStr)).readObject();
		
	    Map<String, String> map = new HashMap<>();

	    map.put("userId", userId);
	    map.put("roomId", json.getString("roomId"));
	    map.put("checkInDate", json.getString("checkInDate"));
	    map.put("checkOutDate", json.getString("checkOutDate"));
	    map.put("people", json.getString("people"));
	    
	    ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
	    
		String price = calculatePrice(map);
		String orderId = "RES_" + System.currentTimeMillis();
		 
		map.put("orderId", orderId);
		map.put("orderId", orderId);
		map.put("price",price);
		map.put("status", "PENDING");
		map.put("paymentStatus", "READY");
		
		int cnt = reservationManageDAO.insertReservation(map);
		if(cnt <= 0) {
			throw new RuntimeException("예약 초안 생성 실패");
		}
		  
		// JSON 응답
		Map<String, Object> result = new HashMap<>();
		result.put("result", "SUCCESS");
		result.put("orderId", orderId);
		result.put("amount", price);
		result.put("orderName", "숙소 예약");
		result.put("customerName",userId);
		
		UserInfo userInfo = reservationManageDAO.getUserInfo(userId);
		result.put("customerName",userInfo.getName());
		result.put("customerEmail",userInfo.getEmail());
		result.put("customerMobilePhone",userInfo.getPhone());
		  
		ParsingCommon.writeJson(res, result);
	}
	
	public String calculatePrice(Map<String,String> map) {
		ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
		
		int roomId = Integer.parseInt(String.valueOf(map.get("roomId")));
	    String checkInDate = String.valueOf(map.get("checkInDate"));
	    String checkOutDate = String.valueOf(map.get("checkOutDate"));
	    
	    int basePrice = reservationManageDAO.getRoomPrice(roomId);
	    
	    java.time.LocalDate inDate = java.time.LocalDate.parse(checkInDate);
	    java.time.LocalDate outDate = java.time.LocalDate.parse(checkOutDate);
	    
	    int nights = (int) java.time.temporal.ChronoUnit.DAYS.between(inDate, outDate);
	    
	    if (nights <= 0) {
	        throw new RuntimeException("숙박일수가 올바르지 않습니다.");
	    }
	    
	    return Integer.toString(nights * basePrice);
	}
}
