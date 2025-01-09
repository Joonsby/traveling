package com.traveling.review.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.controller.ControlQuery;
import com.traveling.review.service.ReviewDeleteService;
import com.traveling.review.service.ReviewInsertService;
import com.traveling.review.service.ReviewUpdateService;

public class ReviewServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ControlQuery inter = null;
		
		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		try {
			switch(requestType) {
				case "reviewInsert":
					inter = ReviewInsertService.instance();
					inter.dataCon(req, res);
					break;
				case "reviewUpdate":
					inter = ReviewUpdateService.instance();
					inter.dataCon(req, res);
				case "reviewDelete":
					inter = ReviewDeleteService.instance();
					inter.dataCon(req, res);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
