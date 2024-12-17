package com.pro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.svc.DetailStayService;
import com.pro.svc.FilterPriceService;
import com.pro.svc.PopStayService;
import com.pro.svc.ReservationSelectService;
import com.pro.svc.RoomInsertService;
import com.pro.svc.SelectStayInfoService;
import com.pro.svc.StayInsertService;
import com.pro.svc.StaySelectService;

public class ServletFile extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		ControlQuery inter = null;

		req.setCharacterEncoding("UTF-8");
		String comm = req.getParameter("comm");
		try {
			switch (comm) {
			case "myplan":
				inter = SelMyPlanInfo.instance();
				inter.dataCon(req, res);
				break;
			case "hostData":
				inter = ReservationSelectService.instance();
				inter.dataCon(req, res);
				break;
			case "stay_ins":
				inter = StayInsertService.instance();
				inter.dataCon(req, res);
				break;
			case "room_ins":
				inter = RoomInsertService.instance();
				inter.dataCon(req, res);
				break;
			case "edit_stay":
				inter = SelectStayInfoService.instance();
				inter.dataCon(req, res);
				break;
			case "stay_sel":
				inter = StaySelectService.instance();
				inter.dataCon(req, res);
				break;
			case "plan_sel":
				inter = PlanSel.instance();
				inter.dataCon(req, res);
				break;
			case "delPlan":
				inter = PlanDel.instance();
				inter.dataCon(req, res);
				break;
			case "insPlan":
				inter = PlanIns.instance();
				inter.dataCon(req, res);
				break;
			case "upPlan":
				inter = PlanUp.instance();
				inter.dataCon(req, res);
				break;
			case "pop_stays":
				inter = PopStayService.instance();
				inter.dataCon(req, res);
				break;
			case "filter":
				inter = FilterPriceService.instance();
				inter.dataCon(req, res);
				break;
			case "stay_info":
				inter = DetailStayService.instance();
				inter.dataCon(req, res);
				break;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
