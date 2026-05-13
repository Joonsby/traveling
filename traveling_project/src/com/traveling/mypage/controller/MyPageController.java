package com.traveling.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.mypage.service.MyPageService;

public class MyPageController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		DataControl inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/mypage/");
		printRequestLog(req,"MyPageController",action);
		try {
			switch(action) {
			case "home":
				inter = MyPageService.instance();
				break;
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
