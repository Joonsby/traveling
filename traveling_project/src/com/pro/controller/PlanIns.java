package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.dto.DetailPlan;
import com.pro.mybatis.PlanInsert;

public class PlanIns implements ControlQuery {

	static PlanIns pins = new PlanIns();
	
	public static PlanIns instance() {
		return pins;
	}
	
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanInsert planIns = PlanInsert.instance();
		
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
		
		planIns.ins(dp);		
		return null;
	}
}
