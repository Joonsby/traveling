package com.pro.room.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.room.service.RoomInsertService;

public class RoomServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ControlQuery inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		
		try {
			switch(requestType) {
			case "room_ins":
				inter = RoomInsertService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
