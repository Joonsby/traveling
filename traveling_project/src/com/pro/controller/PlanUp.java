package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.dto.DetailPlan;
import com.pro.mybatis.PlanUpdate;

public class PlanUp implements ControlQuery {
	
	static PlanUp pup = new PlanUp();

	public static PlanUp instance() {
		return pup;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanUpdate planUp = PlanUpdate.instance();
		
		int pid = new Integer(req.getParameter("pid"));
		
		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		
		planUp.update(dp);
		
		return null;
	}

}
