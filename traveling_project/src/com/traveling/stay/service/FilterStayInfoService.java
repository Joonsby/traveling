package com.traveling.stay.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.common.ParsingCommon;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.FilterStayInfo;

public class FilterStayInfoService implements ControlQuery {
	
	static FilterStayInfoService filterStayInfoService = new FilterStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static FilterStayInfoService instance() {
		return filterStayInfoService;
	}
	
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		StayManagementDAO stayManagementDAO =StayManagementDAO.instance();
		double rating = 0.0;
		int minPrice = 0;
		int maxPrice = 500000;
		
		String ratingParam = req.getParameter("rating");
		String minPriceParam = req.getParameter("minPrice");
		String maxPriceParam = req.getParameter("maxPrice");
		
		if (ratingParam != null && !ratingParam.isEmpty()) {
			rating = Double.parseDouble(ratingParam);
		}
		if (minPriceParam != null && !minPriceParam.isEmpty()) {
			minPrice = Integer.parseInt(minPriceParam);
		}
		if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
			maxPrice = Integer.parseInt(maxPriceParam);
		}
		
		Map<String, Object> stayInfo = new HashMap<>();
		stayInfo.put("min_price", minPrice);
		stayInfo.put("max_price", maxPrice);
		stayInfo.put("rating", rating);
		
		List<FilterStayInfo> filterStayInfo = stayManagementDAO.getFilterStay(stayInfo);
		ParsingCommon.writeJson(res, filterStayInfo);
	}
}
