package com.traveling.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.login.service.HostLoginService;
import com.traveling.login.service.UserLogOutService;
import com.traveling.login.service.UserLoginService;

public class LoginServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		ControlQuery inter = null;
	
		req.setCharacterEncoding("UTF-8");
		String requestType=req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		try {
			switch(requestType) {
			case "getUserInfo":
				inter = UserLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "getHostInfo":
				inter = HostLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "logOut":
				inter = UserLogOutService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
