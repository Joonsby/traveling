package com.pro.plan.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.controller.ControlQuery;
import com.pro.plan.dao.PlanManageDAO;
import com.pro.plan.dto.MyPlanner;

public class SelectMyPlanService implements ControlQuery {
	static SelectMyPlanService selectMyPlanService = new SelectMyPlanService(); // 싱글톤 방식으로 객체 생성
	public static SelectMyPlanService instance() {
		return selectMyPlanService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
		
		// 세션 가져오기
        HttpSession session = req.getSession();
        // 세션에서 사용자 ID 가져오기
        String user_id = (String) session.getAttribute("id");
        MyPlanner mp = new MyPlanner();
        mp.setUser_id(user_id);
		
		List<MyPlanner> selList = planManageDAO.sel(mp);
		
		req.setAttribute("selList", selList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/user/planner.jsp");
		dispatcher.forward(req, res);
		return null;
	}
}
