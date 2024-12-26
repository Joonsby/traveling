package com.pro.signup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.signup.service.HostEmailCheckService;
import com.pro.signup.service.HostIdCheckService;
import com.pro.signup.service.InsertHostInfoService;
import com.pro.signup.service.InsertUserInfoService;
import com.pro.signup.service.UserEmailCheckService;
import com.pro.signup.service.UserIdCheckService;

public class SignupServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		ControlQuery inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		try {
			switch(requestType) {
				case "checkUserId":
					inter = UserIdCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "checkUserEmail":
					inter = UserEmailCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "insertUserInfo":
					inter = InsertUserInfoService.instance();
					inter.dataCon(req, res);
					break;
				case "checkHostId":
					inter = HostIdCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "checkHostEmail":
					inter = HostEmailCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "insertHostInfo":
					inter = InsertHostInfoService.instance();
					inter.dataCon(req, res);
					break;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
