package com.pro.plan.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.plan.dao.PlanManageDAO;
import com.pro.plan.dto.DetailPlan;

public class PlanInsertService implements ControlQuery {
	static PlanInsertService planInsertService = new PlanInsertService();
	
	public static PlanInsertService instance() {
		return planInsertService;
	}
	
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		DetailPlan dp = new DetailPlan();
		int pid = new Integer(req.getParameter("pid"));
		String pdate = req.getParameter("pdate");
		String pst = req.getParameter("pst");
		String pet = req.getParameter("pet");
		String pcon = req.getParameter("pcon");
		
		dp.setPlan_id(pid);
		dp.setPlan_date(pdate);
		dp.setPlan_start_time(pst);
		dp.setPlan_end_time(pet);
		dp.setPlan_content(pcon);
		
		planManageDAO.ins(dp);
		return null;
	}
}
