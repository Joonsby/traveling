package com.traveling.plan.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.plan.dao.PlanManageDAO;
import com.traveling.plan.dto.DetailPlan;

public class PlanUpdateService implements DataControl {
	static PlanUpdateService planUpdateService = new PlanUpdateService();

	public static PlanUpdateService instance() {
		return planUpdateService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		int pid = Integer.parseInt(req.getParameter("pid"));
		
		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		
		planManageDAO.update(dp);
	}
}
