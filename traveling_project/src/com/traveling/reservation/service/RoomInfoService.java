package com.traveling.reservation.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;

public class RoomInfoService implements ControlQuery{
	static RoomInfoService roomInfoService = new RoomInfoService();
	public static RoomInfoService instance() {
		return roomInfoService;
	}
	
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
	}
	
}
