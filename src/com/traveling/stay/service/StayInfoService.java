package com.traveling.stay.service;

import java.util.List;

// ...existing imports...
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class StayInfoService implements DataControl  {
	
	static StayInfoService stayInfoService = new StayInfoService(); // 싱글톤 방식으로 객체 생성
	public static StayInfoService instance() {
		return stayInfoService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String host_id = (String) req.getSession().getAttribute("host_id");
		List<StayInfo> stayInfo =  stayManagementDAO.selectStayInfo(host_id);
		req.setAttribute("stayInfo", stayInfo);
		// Host view with css/js
		String[] cssList = new String[] {
			"/css/common/reset.css",
			"/css/stay/add_stay.css",
			"/css/host/host_common.css",
			"/css/stay/stay_info.css"
		};
		String[] jsList = new String[] {
			"/js/stay/add_stay.js"
		};
		LayoutForward.host(req, res, "숙소 정보", "/webPage/stay/stay_info.jsp", cssList, jsList);
	}

}
