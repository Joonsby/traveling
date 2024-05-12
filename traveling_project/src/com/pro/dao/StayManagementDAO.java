package com.pro.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.CheckInInfo;
import com.pro.dto.FilterStayInfo;
import com.pro.dto.ReviewInfo;
import com.pro.dto.RoomInfo;
import com.pro.dto.StayInfo;
import com.pro.mybatis.DBCon;

public class StayManagementDAO {
	static StayManagementDAO stmd = new StayManagementDAO();

	public static StayManagementDAO instance() {
		return stmd;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 체크인 정보
	public List<CheckInInfo> checkInSelect(CheckInInfo checkInInfo) {
		SqlSession s = f.openSession();		
		List<CheckInInfo> checkInList = s.selectList("checkInInfoSelect", checkInInfo);		
		s.close();		
		return checkInList;
	}
	
	// 숙소 등록
	public void stayInsert(StayInfo stayInfo) {		
		SqlSession s = f.openSession();
		s.insert("stayInfoInsert", stayInfo);			
		s.commit();
		s.close();
	}
	
	// 숙소 정보
	public List<StayInfo> selectStayInfo(String host_id) {
		SqlSession s = f.openSession();
		List<StayInfo> stayInfo = s.selectList("selectStayInfo",host_id);
		return stayInfo;
	}	
	
	// 숙소ID 개수
	public int countStayId(String hostId) {
		SqlSession s = f.openSession();		
		int stayId = s.selectOne("stayIdCount" , hostId);		
		s.close();
		return stayId;
	}
	
	// 객실 등록
	public void roomInsert(RoomInfo roomInfo) {
		SqlSession s = f.openSession();
		s.insert("roomInfoInsert", roomInfo);
		s.commit();
		s.close();
	}	
	
	
	// 인기 숙소 선택
	public List<FilterStayInfo> popStaySelect() {
		SqlSession s = f.openSession();
		List<FilterStayInfo> stayList = s.selectList("popStaySelect");
		s.close();
		return stayList;
	}	
	
	// 필터링된 숙소 선택
	public String getParameterOrNull(HttpServletRequest req, String paramName) {
	    String paramValue = req.getParameter(paramName);
	    return (paramValue != null && paramValue.isEmpty()) ? null : paramValue;
	}
	
	public List<FilterStayInfo> filterStay(HttpServletRequest req, HttpServletResponse res) {
		SqlSession s = f.openSession();
		double rating = 0.0; // 기본값을 0으로 초기화
		int minPrice = 0;
		int maxPrice = 500000;
		String parking = getParameterOrNull(req, "parking");
		String wireless_internet = getParameterOrNull(req, "wireless_internet");
		String tub = getParameterOrNull(req, "tub");
		String washing_machine = getParameterOrNull(req, "washing_machine");
		String drying_machine = getParameterOrNull(req, "drying_machine");
		String air_conditioner = getParameterOrNull(req, "air_conditioner");
		String fan = getParameterOrNull(req, "fan");
		String heating_system = getParameterOrNull(req, "heating_system");
		String pool = getParameterOrNull(req, "pool");
		String arcade_game = getParameterOrNull(req, "arcade_game");
		String gym = getParameterOrNull(req, "gym");
		String board_game = getParameterOrNull(req, "board_game");
		String barbecue_tool = getParameterOrNull(req, "barbecue_tool");
		String basic_cookware = getParameterOrNull(req, "basic_cookware");
		String breakfast = getParameterOrNull(req, "breakfast");
		String clean_service = getParameterOrNull(req, "clean_service");
		String luggage_storage = getParameterOrNull(req, "luggage_storage");
	    String ratingParam = req.getParameter("rating");
	    String minPriceParam = req.getParameter("minPrice");
	    String maxPriceParam = req.getParameter("maxPrice");
	    if (ratingParam != null && !ratingParam.isEmpty()) {
	        rating = Double.parseDouble(ratingParam);
	    }
	    if(minPriceParam != null && !minPriceParam.isEmpty()) {
	    	minPrice = Integer.parseInt(minPriceParam);
	    }
	    if(maxPriceParam != null && !maxPriceParam.isEmpty()) {
	    	maxPrice = Integer.parseInt(maxPriceParam);
	    }
		Map<String, Object> filter = new HashMap<>();
		filter.put("minPrice", minPrice);
		filter.put("maxPrice", maxPrice);
		filter.put("rating",rating);
		filter.put("parking",parking);
		filter.put("wireless_internet",wireless_internet);
		filter.put("tub",tub);
		filter.put("washing_machine",washing_machine);
		filter.put("drying_machine",drying_machine);
		filter.put("air_conditioner",air_conditioner);
		filter.put("fan",fan);
		filter.put("heating_system",heating_system);
		filter.put("pool",pool);
		filter.put("arcade_game",arcade_game);
		filter.put("gym",gym);
		filter.put("board_game",board_game);
		filter.put("barbecue_tool",barbecue_tool);
		filter.put("basic_cookware",basic_cookware);
		filter.put("breakfast",breakfast);
		filter.put("clean_service",clean_service);
		filter.put("luggage_storage",luggage_storage);
		List<FilterStayInfo> stayList = s.selectList("filterStaySelect", filter);		
		s.close();
		return stayList;
	}
	
	// 숙소 상세 정보
	public List<StayInfo> selectStayInfo(int stay_id) {
		SqlSession s = f.openSession();		
		List<StayInfo> detailStayList =  s.selectList("detailStaySelect",stay_id);		
		s.close();
		return detailStayList;
	}
	
	// 객실 정보
	public List<RoomInfo> selectRoomInfo(int stay_id) {		
		SqlSession s = f.openSession();
		List<RoomInfo> roomList = s.selectList("roomSelect",stay_id);
		s.close();
		return roomList;		
	}
	
	// 리뷰 정보
	public List<ReviewInfo> selectReview(int stay_id){
		SqlSession s = f.openSession();
		List<ReviewInfo> reviewList = s.selectList("reviewList",stay_id);
		return reviewList;
	}
}
