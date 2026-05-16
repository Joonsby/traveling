package com.traveling.stay.service;

import java.util.List;

// ...existing imports...
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class StayRankListService implements DataControl {

	static StayRankListService stayRankListService = new StayRankListService(); // 싱글톤 방식으로 객체 생성
	public static StayRankListService instance() {
		return stayRankListService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		String uri = req.getRequestURI();
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		List<StayInfo> stayList;
		if (uri.endsWith("/popular")) {
			stayList = stayManagementDAO.popStaySelect();

		} else if (uri.endsWith("/top-rated")) {
			stayList = stayManagementDAO.bestReviewStaySelect();

		} else if (uri.endsWith("/low-price")) {
			stayList = stayManagementDAO.cheapStaySelect();

		} else {
			throw new IllegalArgumentException("잘못된 숙소 목록 요청: " + uri);
		}
		req.setAttribute("stayList", stayList);
		String[] cssList = new String[] { "/css/stay/all_stays.css", "/css/stay/all_stays_aside.css" };
		String[] jsList = new String[] { "/js/stay/stay_map.js", "/js/stay/all_stays.js" };
		LayoutForward.user(req, res, "숙소 목록", "/webPage/stay/all_stays.jsp", cssList, jsList);
	}

}
