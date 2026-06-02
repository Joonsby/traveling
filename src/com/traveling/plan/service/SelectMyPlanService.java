package com.traveling.plan.service;

import java.util.List;

// ...existing imports...
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.plan.dao.PlanManageDAO;
import com.traveling.plan.dto.MyPlanner;

public class SelectMyPlanService implements DataControl {
	static SelectMyPlanService selectMyPlanService = new SelectMyPlanService(); // 싱글톤 방식으로 객체 생성
	public static SelectMyPlanService instance() {
		return selectMyPlanService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		PlanManageDAO planManageDAO = PlanManageDAO.instance();
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("id");
        MyPlanner myPlanner = new MyPlanner();
        myPlanner.setUser_id(userId);
		List<MyPlanner> planList = planManageDAO.sel(myPlanner);
		req.setAttribute("planList", planList);
		String[] cssList = new String[] {
			"/css/login/member.css",
			"/css/reservation/nav.css",
			"/css/user/planner.css"
		};
		String[] jsList = new String[] { "/js/user/planner.js" };
		LayoutForward.user(req, res, "나의 플래너", "/webPage/user/planner.jsp", cssList, jsList);
	}
}
