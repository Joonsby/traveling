package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.dto.DetailPlan;
import com.pro.mybatis.PlanDelete;

public class PlanDel implements ControlQuery{
	
	static PlanDel pdel = new PlanDel();
	
	public static PlanDel instance() {
		return pdel;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanDelete planDel = PlanDelete.instance();
		
		int pid = new Integer(req.getParameter("pid"));
		
		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		
		planDel.del(dp);
		
		
		return null;
	}
	
	

}
