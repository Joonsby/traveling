package com.traveling.plan.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.plan.dao.PlanManageDAO;
import com.traveling.plan.dto.DetailPlan;

public class PlanDeleteService implements ControlQuery{
	static PlanDeleteService planDeleteService = new PlanDeleteService();
	
	public static PlanDeleteService instance() {
		return planDeleteService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		int pid = new Integer(req.getParameter("pid"));
		
		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		
		planManageDAO.del(dp);
		
		
		return null;
	}
}
