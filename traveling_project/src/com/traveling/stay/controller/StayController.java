package com.traveling.stay.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.stay.service.CheckInListService;
import com.traveling.stay.service.CheckOutListService;
import com.traveling.stay.service.DetailStayInfoService;
import com.traveling.stay.service.FilterStayInfoService;
import com.traveling.stay.service.InsertStayInfoService;
import com.traveling.stay.service.StayRankListService;
import com.traveling.stay.service.StayCntService;
import com.traveling.stay.service.StayInfoService;

public class StayController extends BaseController {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/stay/");
		printRequestLog(req,"StayController",action);
		try {
			switch (action) {
			case "check-in-list":
				inter = CheckInListService.instance();
				break;
			case "check-out-list":
				inter = CheckOutListService.instance();
				break;
			case "create":
				inter = InsertStayInfoService.instance();
				break;
			case "list":
				inter = StayInfoService.instance();
				break;
			case "count":
				inter = StayCntService.instance();
				break;
			case "popular":
			case "top-rated":
			case "low-price":
				inter = StayRankListService.instance();
				break;
			case "detail":
				inter = DetailStayInfoService.instance();
				break;
			case "filter":
				inter = FilterStayInfoService.instance();
				break;
			default:
			    ViewUtil.forwardError(req, res, "잘못된 요청입니다.");
			    return;
			}
            if (inter != null) {
                inter.dataCon(req, res);
            }
		} catch (Exception e) {
			printFailLog(e);
			throw new ServletException("StayController 처리 중 오류 발생", e);
		}
	}

}
