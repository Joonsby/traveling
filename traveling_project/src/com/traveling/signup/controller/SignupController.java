package com.traveling.signup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.signup.service.HostEmailCheckService;
import com.traveling.signup.service.HostIdCheckService;
import com.traveling.signup.service.InsertHostInfoService;
import com.traveling.signup.service.InsertUserInfoService;
import com.traveling.signup.service.UserEmailCheckService;
import com.traveling.signup.service.UserIdCheckService;

public class SignupController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/signup/");
		try {
			System.out.println("[SignupController] action = " + action);
			switch(action) {
				case "user-id-check":
					inter = UserIdCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "user-email-check":
					inter = UserEmailCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "user-create":
					inter = InsertUserInfoService.instance();
					inter.dataCon(req, res);
					break;
				case "host-id-check":
					inter = HostIdCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "host-email-check":
					inter = HostEmailCheckService.instance();
					inter.dataCon(req, res);
					break;
				case "host-create":
					inter = InsertHostInfoService.instance();
					inter.dataCon(req, res);
					break;
				default:
				    ViewUtil.forwardError(req, res, "잘못된 회원가입 요청입니다.");
				    return;
				}
		} catch(Exception e) {
			handleControllerException(req,res,e,"SignupController",action);
		}
	}
	
}
