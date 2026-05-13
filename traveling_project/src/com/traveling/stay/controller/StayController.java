package com.traveling.stay.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.stay.service.CheckInListService;
import com.traveling.stay.service.CheckOutListService;
import com.traveling.stay.service.DetailStayInfoService;
import com.traveling.stay.service.FilterStayInfoService;
import com.traveling.stay.service.InsertStayInfoService;
import com.traveling.stay.service.PopStayInfoService;
import com.traveling.stay.service.StayCntService;
import com.traveling.stay.service.StayInfoService;
import com.traveling.stay.service.StayMainService;

public class StayController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DataControl inter = null;

		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		
        if (requestType == null || requestType.trim().equals("")) {
            requestType = "main";
        }
		
		System.out.println("requestType = " + requestType);
		try {
			switch (requestType) {
			case "main":
				inter = StayMainService.instance();
				break;
			case "getCheckInList":
				inter = CheckInListService.instance();
				break;
			case "getCheckOutList":
				inter = CheckOutListService.instance();
				break;
			case "insertStayInfo":
				inter = InsertStayInfoService.instance();
				break;
			case "getStayInfo":
				inter = StayInfoService.instance();
				break;
			case "getStayCnt":
				inter = StayCntService.instance();
				break;
			case "getPopStayInfo":
				inter = PopStayInfoService.instance();
				break;
			case "getDetailStayInfo":
				inter = DetailStayInfoService.instance();
				break;
			case "getFilterStayInfo":
				inter = FilterStayInfoService.instance();
				break;
            default:
                inter = StayMainService.instance();
                break;
			}
            if (inter != null) {
                inter.dataCon(req, res);
            }
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("StayController 처리 중 오류 발생", e);
		}
	}

}
