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
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
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
		stayInfo.put("parking", getParameterOrNull(req, "parking"));
		stayInfo.put("wireless_internet", getParameterOrNull(req, "wireless_internet"));
		stayInfo.put("tub", getParameterOrNull(req, "tub"));
		stayInfo.put("washing_machine", getParameterOrNull(req, "washing_machine"));
		stayInfo.put("drying_machine", getParameterOrNull(req, "drying_machine"));
		stayInfo.put("air_conditioner",getParameterOrNull(req, "air_conditioner"));
		stayInfo.put("fan", getParameterOrNull(req, "fan"));
		stayInfo.put("heating_system", getParameterOrNull(req, "heating_system"));
		stayInfo.put("pool", getParameterOrNull(req, "pool"));
		stayInfo.put("arcade_game", getParameterOrNull(req, "arcade_game"));
		stayInfo.put("gym", getParameterOrNull(req, "gym"));
		stayInfo.put("board_game", getParameterOrNull(req, "board_game"));
		stayInfo.put("barbecue_tool", getParameterOrNull(req, "barbecue_tool"));
		stayInfo.put("basic_cookware", getParameterOrNull(req, "basic_cookware"));
		stayInfo.put("breakfast", getParameterOrNull(req, "breakfast"));
		stayInfo.put("clean_service", getParameterOrNull(req, "clean_service"));
		stayInfo.put("luggage_storage", getParameterOrNull(req, "luggage_storage"));
		
		List<FilterStayInfo> filterStayInfo = stayManagementDAO.getFilterStay(stayInfo);
		res.getWriter().write(ParsingCommon.gson.toJson(filterStayInfo));
		return null;
	}
	
	// 필터링된 숙소 선택
	private String getParameterOrNull(HttpServletRequest req, String paramName) {
		String paramValue = req.getParameter(paramName);
		return (paramValue != null && paramValue.isEmpty()) ? null : paramValue;
	}
	
}
