package com.traveling.plan.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.plan.dao.PlanManageDAO;
import com.traveling.plan.dto.DetailPlan;

public class PlanSelectService implements ControlQuery {
	static PlanSelectService planSelectService = new PlanSelectService();

	public static PlanSelectService instance() {
		return planSelectService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		int pid = new Integer(req.getParameter("planId"));
		String chk = req.getParameter("planDate");

		DetailPlan dp = new DetailPlan();
		dp.setPlan_id(pid);
		dp.setCheck_in_date(chk);

		List<DetailPlan> dpList = planManageDAO.sel(dp);
		
		String data = "";
		for (int i = 0; i < dpList.size(); i++) {
			data += "<div>";
			data += "<p id='ajax_pdate" + i + "'>" + dpList.get(i).getPlan_date() + "</p>";
			data += "<p id='ajax_pst" + i + "'>" + dpList.get(i).getPlan_start_time() + "</p>";
			data += "<p id='ajax_pet" + i + "'>" + dpList.get(i).getPlan_end_time() + "</p>";
			data += "<p id='ajax_pcont" + i + "'>" + dpList.get(i).getPlan_content() + "</p>";
			data += "</div>";
		}
		
	    // Content-Type 설정
	    res.setContentType("text/html");
	    res.setCharacterEncoding("UTF-8");

	    // 데이터를 응답에 기록
	    PrintWriter out = res.getWriter();
	    out.print(data);
	    out.flush();
	}
}
