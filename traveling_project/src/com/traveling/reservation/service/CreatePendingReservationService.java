package com.traveling.reservation.service;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.common.ParsingCommon;
import com.traveling.reservation.dao.ReservationManageDAO;

public class CreatePendingReservationService implements ControlQuery{
	static CreatePendingReservationService createPendingReservationService = new CreatePendingReservationService(); // 싱글톤 방식으로 객체 생성
	public static CreatePendingReservationService instance() {
		return createPendingReservationService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReservationManageDAO reservationManageDAO = new ReservationManageDAO();
		String userId = (String) req.getSession().getAttribute("id");
		String jsonStr = req.getParameter("reservation");
		JsonObject json = Json.createReader(new StringReader(jsonStr)).readObject();
		
	    Map<String, Object> map = new HashMap<>();

	    map.put("userId", userId);
	    map.put("roomId", json.getString("roomId"));
	    map.put("checkInDate", json.getString("checkInDate"));
	    map.put("checkOutDate", json.getString("checkOutDate"));
	    map.put("people", String.valueOf(json.getInt("people")));
	    
	    System.out.println(map.get("userId"));
	    System.out.println(map.get("roomId"));
	    System.out.println(map.get("checkInDate"));
	    System.out.println(map.get("checkOutDate"));
	    System.out.println(map.get("people"));
	    
		
		int price = ReservationManageDAO.instance().calculatePrice(map);
		  
		String orderId = "RES_" + System.currentTimeMillis();
		 
		map.put("orderId", orderId); map.put("orderId", orderId); map.put("price",price); map.put("status", "PENDING"); map.put("paymentStatus", "READY");
		  
		reservationManageDAO.insertReservation(map);
		  
		//👉 JSON 응답
		Map<String, Object> result = new HashMap<>();
		result.put("result", "SUCCESS"); result.put("orderId", orderId);
		result.put("amount", price); result.put("orderName", "숙소 예약");
		  
		ParsingCommon.writeJson(res, result);
		 
	}
}
