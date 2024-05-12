package com.pro.svc;

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.FilterStayInfo;

public class FilterPriceService implements ControlQuery{

	static FilterPriceService fp = new FilterPriceService();

	public static FilterPriceService instance() {
		return fp;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		List<FilterStayInfo> stayList = stayManagementDAO.filterStay(req,res);
		res.getWriter().write(getJSON(stayList));
		return null;
	}
	
	public String getJSON(List<FilterStayInfo> stayList) {		
	    StringBuffer result = new StringBuffer("");	
	    result.append("{\"result\":[");
	    for (int i = 0; i < stayList.size(); i++) {
	        result.append("{");
	        result.append("\"stayId\": \"" + stayList.get(i).getStay_id() + "\",");
	        result.append("\"stayName\": \"" + stayList.get(i).getStay_name() + "\",");
	        result.append("\"roadAddr\": \"" + stayList.get(i).getRoad_addr() + "\",");
	        result.append("\"image\": \"" + stayList.get(i).getImage1() + "\",");
	        result.append("\"price\": \"" + stayList.get(i).getMin_room_price() + "\",");
	        result.append("\"avgRating\": \"" + stayList.get(i).getAvg_rating() + "\",");
	        result.append("\"latitude\": \"" + stayList.get(i).getLatitude() + "\",");
	        result.append("\"longitude\": \"" + stayList.get(i).getLongitude() + "\",");
	        result.append("\"ratingCount\": \"" + stayList.get(i).getRating_count() + "\"}");
	        if (i < stayList.size() - 1) {
	            result.append(",");
	        }
	    }
	    result.append("]}");
	    return result.toString();				
	}
}
