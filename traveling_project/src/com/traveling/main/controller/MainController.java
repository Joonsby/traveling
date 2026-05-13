package com.traveling.main.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.main.service.MainService;

public class MainController extends BaseController{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		printRequestLog(req,"MainController","");
		try {
			DataControl inter = MainService.instance();
			inter.dataCon(req, res);
		} catch(Exception e) {
			printFailLog(e);
		    e.printStackTrace();
			throw new ServletException("MainController 처리 중 오류 발생", e);
		}
	}
}
