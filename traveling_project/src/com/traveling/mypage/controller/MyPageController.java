package com.traveling.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.mypage.service.MyPageService;

public class MyPageController extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		DataControl inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType=req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		try {
			switch(requestType) {
			case "getMyPageInfo":
				inter = MyPageService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
