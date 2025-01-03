package com.traveling.plan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.controller.ControlQuery;
import com.traveling.plan.service.PlanDeleteService;
import com.traveling.plan.service.PlanInsertService;
import com.traveling.plan.service.PlanSelectService;
import com.traveling.plan.service.PlanUpdateService;
import com.traveling.plan.service.SelectMyPlanService;

public class PlanServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ControlQuery inter = null;

		req.setCharacterEncoding("UTF-8");
		String requestType = req.getParameter("requestType");
		System.out.println("requestType=" + requestType);
		try {
			switch (requestType) {
			case "myplan":
				inter = SelectMyPlanService.instance();
				inter.dataCon(req, res);
				break;
			case "plan_sel":
				inter = PlanSelectService.instance();
				inter.dataCon(req, res);
				break;
			case "delPlan":
				inter = PlanDeleteService.instance();
				inter.dataCon(req, res);
				break;
			case "insPlan":
				inter = PlanInsertService.instance();
				inter.dataCon(req, res);
				break;
			case "upPlan":
				inter = PlanUpdateService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
