package com.traveling.stay.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.traveling.common.DataControl;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.FacilityCategoryInfo;
import com.traveling.stay.dto.FacilityInfo;
import com.traveling.stay.dto.ReviewInfo;
import com.traveling.stay.dto.RoomInfo;
import com.traveling.stay.dto.StayInfo;

public class DetailStayInfoService implements DataControl  {
	
	static DetailStayInfoService detailStayInfoService = new DetailStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static DetailStayInfoService instance() {
		return detailStayInfoService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		int stayId = Integer.parseInt((String) req.getParameter("stay_id"));
		
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		
		List<StayInfo> detailStayList =  stayManagementDAO.selectStayInfo(stayId); 		// 숙소 정보
		List<RoomInfo> roomList = stayManagementDAO.selectRoomInfo(stayId); 			// 객실 정보
		List<ReviewInfo> reviewList = stayManagementDAO.selectReview(stayId); 			// 리뷰 정보
		List<FacilityInfo> facilityInfoList = stayManagementDAO.selectFacility(stayId); // 편의시설 정보
		
		
		Map<String,FacilityCategoryInfo> facilityCategoryMap = new LinkedHashMap<>();
		
		for(FacilityInfo item : facilityInfoList) {
			String categoryName = item.getCategoryName();
			
			FacilityCategoryInfo category = facilityCategoryMap.get(categoryName);
			
			if(category == null) {
				category = new FacilityCategoryInfo();
				category.setCategoryName(categoryName);
				category.setFacilityList(new ArrayList<>());
				facilityCategoryMap.put(categoryName,category);
			}
			
			category.getFacilityList().add(item.getFacilityName());
		}
		
		req.setAttribute("detailStayList", detailStayList);
		req.setAttribute("roomList", roomList);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("facilityList", new ArrayList<>(facilityCategoryMap.values()));
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/stay/detail_stay.jsp");
		dispatcher.forward(req, res);
	}

}
