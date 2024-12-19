package com.pro.stay.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.stay.service.CheckInListService;
import com.pro.stay.service.DetailStayInfoService;
import com.pro.stay.service.InsertStayInfoService;
import com.pro.stay.service.PopStayInfoService;
import com.pro.stay.service.StayCntService;
import com.pro.stay.service.StayInfoService;

public class StayServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub

		ControlQuery inter = null;

		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		try {
			switch (requestType) {
			case "getCheckInList":
				inter = CheckInListService.instance();
				inter.dataCon(req, res);
				break;
			case "insertStayInfo":
				inter = InsertStayInfoService.instance();
				inter.dataCon(req, res);
				break;
			case "getStayInfo":
				inter = StayInfoService.instance();
				inter.dataCon(req, res);
				break;
			case "getStayCnt":
				inter = StayCntService.instance();
				inter.dataCon(req, res);
				break;
			case "getPopStayInfo":
				inter = PopStayInfoService.instance();
				inter.dataCon(req, res);
				break;
			case "getDetailStayInfo":
				inter = DetailStayInfoService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
