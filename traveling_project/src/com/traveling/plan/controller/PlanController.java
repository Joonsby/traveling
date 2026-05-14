package com.traveling.plan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.BaseController;
import com.traveling.common.DataControl;
import com.traveling.common.ViewUtil;
import com.traveling.plan.service.PlanDeleteService;
import com.traveling.plan.service.PlanInsertService;
import com.traveling.plan.service.PlanSelectService;
import com.traveling.plan.service.PlanUpdateService;
import com.traveling.plan.service.SelectMyPlanService;

public class PlanController extends BaseController {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DataControl inter = null;
		req.setCharacterEncoding("UTF-8");
		String action = getAction(req, "/plan/");
		printRequestLog(req,"PlanController",action);
		try {
			switch (action) {
			case "my":
				inter = SelectMyPlanService.instance();
				inter.dataCon(req, res);
				break;
			case "detail":
				inter = PlanSelectService.instance();
				inter.dataCon(req, res);
				break;
			case "delete":
				inter = PlanDeleteService.instance();
				inter.dataCon(req, res);
				break;
			case "insert":
				inter = PlanInsertService.instance();
				inter.dataCon(req, res);
				break;
			case "update":
				inter = PlanUpdateService.instance();
				inter.dataCon(req, res);
				break;
			default:
			    forwardError(req, res, "잘못된 요청입니다.");
			    return;
			}
		} catch (Exception e) {
			handleControllerException(req,res,e,"PlanController",action);
		}
	}

}
