package com.traveling.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.login.service.HostLoginService;
import com.traveling.login.service.UserLogOutService;
import com.traveling.login.service.UserLoginService;

public class LoginController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/login/");
		printRequestLog(req,"LoginController",action);
		try {
			switch(action) {
			case "user":
				inter = UserLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "host":
				inter = HostLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "logout":
				inter = UserLogOutService.instance();
				inter.dataCon(req, res);
				break;
			default:
				forwardError(req,res,"잘못된 요청입니다.");
			}
		} catch(Exception e) {
			printFailLog(e);
			throw new ServletException("LoginController 처리 중 오류 발생", e);
		}
	}
	
}
