package com.traveling.room.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.room.service.RoomInsertService;

public class RoomController extends BaseController {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/room/");
		printRequestLog(req,"ReservationController",action);
		try {
			switch(action) {
				case "insert":
					inter = RoomInsertService.instance();
					break;
				default:
				    forwardError(req, res, "잘못된 요청입니다.");
				    return;
			}
            if (inter != null) {
                inter.dataCon(req, res);
            }
		} catch(Exception e) {
			handleControllerException(req,res,e,"RoomController",action);
		}
	}
}
