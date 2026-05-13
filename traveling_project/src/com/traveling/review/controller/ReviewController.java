package com.traveling.review.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.review.service.ReviewDeleteService;
import com.traveling.review.service.ReviewInsertService;
import com.traveling.review.service.ReviewUpdateService;

public class ReviewController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/review/");
		printRequestLog(req,"ReviewController",action);
		try {
			switch(action) {
				case "insert":
					inter = ReviewInsertService.instance();
					inter.dataCon(req, res);
					break;
				case "update":
					inter = ReviewUpdateService.instance();
					inter.dataCon(req, res);
				case "delete":
					inter = ReviewDeleteService.instance();
					inter.dataCon(req, res);
				default:
				    ViewUtil.forwardError(req, res, "잘못된 요청입니다.");
				    return;
			}
            if (inter != null) {
                inter.dataCon(req, res);
            }
		} catch(Exception e) {
			printFailLog(e);
			throw new ServletException("StayController 처리 중 오류 발생", e);
		}
	}
	
}
