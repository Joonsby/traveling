package com.traveling.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
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
			case "select":
				LayoutForward.user(req, res, "로그인선택", "/webPage/login/login_select.jsp", new String[] {"/css/login/login_select.css"}, new String[] {});
				break;
			case "page":
				LayoutForward.user(req, res, "로그인", "/webPage/login/login.jsp", new String[] {"/css/login/login.css"}, new String[] {"/js/login/login.js"});
				break;
			case "user":
				inter = UserLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "host":
				inter = HostLoginService.instance();
				inter.dataCon(req, res);
				break;
			case "find-id":
				LayoutForward.user(req, res, "아이디찾기", "/webPage/login/find_id.jsp", new String[] {"/css/login/find.css"}, new String[] {"/js/login/find_id.js"});
				break;
			case "find-pw":
				LayoutForward.user(req, res, "비밀번호찾기", "/webPage/login/find_pw.jsp", new String[] {"/css/login/find.css"}, new String[] {"/js/login/find_pw.js"});
				break;
			case "logout":
				inter = UserLogOutService.instance();
				inter.dataCon(req, res);
				break;
			default:
				forwardError(req,res,"잘못된 요청입니다.");
			}
		} catch(Exception e) {
			handleControllerException(req,res,e,"LoginController",action);
		}
	}
	
}
