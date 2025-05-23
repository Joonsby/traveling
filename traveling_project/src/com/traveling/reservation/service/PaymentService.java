package com.traveling.reservation.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;
import com.traveling.reservation.dao.ReservationManageDAO;
import com.traveling.reservation.dto.ReservationInfo;

public class PaymentService implements ControlQuery {
	static PaymentService paymentService = new PaymentService();
	public static PaymentService instance() {
		return paymentService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String customerParam = req.getParameter("customer");
		HttpSession session = req.getSession();
		Map<String,String> reservationInfo = new HashMap<String,String>();
		ReservationManageDAO reservationManageDAO = ReservationManageDAO.instance();
		
		// JSON 파서 생성
		javax.json.JsonReader jsonReader = Json.createReader(new java.io.StringReader(java.net.URLDecoder.decode(customerParam, "UTF-8")));
		JsonObject customerJson = jsonReader.readObject();
		
		// JSON 객체에서 필요한 값을 추출
		String userId = customerJson.getString("userId");
		reservationInfo.put("userId",(String) session.getAttribute("id"));
		reservationInfo.put("price",customerJson.getString("price"));
		reservationInfo.put("roomName",customerJson.getString("roomName"));
		reservationInfo.put("roomId",customerJson.getString("roomId"));
		reservationInfo.put("checkInDate",customerJson.getString("checkInDate"));
		reservationInfo.put("checkOutDate",customerJson.getString("checkOutDate"));
		reservationInfo.put("people",customerJson.getString("people"));
		reservationInfo.put("checkInTime",customerJson.getString("checkInTime"));
		reservationInfo.put("checkOutTime",customerJson.getString("checkOutTime"));
		
		List<ReservationInfo> roomInfo = reservationManageDAO.getRoomInfo2(reservationInfo);
		
		reservationInfo.put("userId",userId);
		reservationInfo.put("name", roomInfo.get(0).getName());
		reservationInfo.put("roomName", roomInfo.get(0).getRoomName());
		reservationInfo.put("stayName", roomInfo.get(0).getStayName());
		
		int cnt = reservationManageDAO.reservationInsert(reservationInfo);
		if(cnt > 0) {
			req.setAttribute("reservationInfo", reservationInfo);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/reservation/pay_success.jsp");
			dispatcher.forward(req, res);
		}
		jsonReader.close();
	}
}
