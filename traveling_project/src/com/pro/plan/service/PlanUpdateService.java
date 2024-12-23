package com.pro.plan.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.plan.dao.PlanManageDAO;
import com.pro.plan.dto.DetailPlan;

public class PlanUpdateService implements ControlQuery {
	static PlanUpdateService planUpdateService = new PlanUpdateService();

	public static PlanUpdateService instance() {
		return planUpdateService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		int pid = new Integer(req.getParameter("pid"));
		
		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		
		planManageDAO.update(dp);
		
		return null;
	}
}