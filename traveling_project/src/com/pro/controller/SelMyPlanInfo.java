package com.pro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.dto.MyPlanner;
import com.pro.mybatis.SelMyPlan;

public class SelMyPlanInfo implements ControlQuery {
	
	static SelMyPlanInfo sel = new SelMyPlanInfo(); // 싱글톤 방식으로 객체 생성
	public static SelMyPlanInfo instance() {
		return sel;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		SelMyPlan selinfo = SelMyPlan.instance();
		
		// 세션 가져오기
        HttpSession session = req.getSession();
        // 세션에서 사용자 ID 가져오기
        String user_id = (String) session.getAttribute("id");
        MyPlanner mp = new MyPlanner();
        mp.setUser_id(user_id);
		
		List<MyPlanner> selList = selinfo.sel(mp);
		
		req.setAttribute("selList", selList);
		return null;
	}

}