package com.traveling.plan.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;
import com.traveling.plan.dao.PlanManageDAO;
import com.traveling.plan.dto.MyPlanner;

public class SelectMyPlanService implements ControlQuery {
	static SelectMyPlanService selectMyPlanService = new SelectMyPlanService(); // 싱글톤 방식으로 객체 생성
	public static SelectMyPlanService instance() {
		return selectMyPlanService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("id");
        MyPlanner myPlanner = new MyPlanner();
        myPlanner.setUser_id(userId);
		List<MyPlanner> planList = planManageDAO.sel(myPlanner);
		req.setAttribute("planList", planList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/user/planner.jsp");
		dispatcher.forward(req, res);
		return null;
	}
}
