package com.traveling.stay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.stay.dto.CheckInInfo;
import com.traveling.stay.dto.FilterStayInfo;
import com.traveling.stay.dto.ReviewInfo;
import com.traveling.stay.dto.RoomInfo;
import com.traveling.stay.dto.StayInfo;

public class StayManagementDAO {
	static StayManagementDAO stmd = new StayManagementDAO();

	public static StayManagementDAO instance() {
		return stmd;
	}

	SqlSessionFactory f = DBCon.getSqlSession();

	// 체크인 정보
	public List<CheckInInfo> checkInSelect(String hostId) {
		SqlSession s = f.openSession();
		List<CheckInInfo> checkInList = s.selectList("checkInInfoSelect", hostId);
		s.close();
		return checkInList;
	}
	
	// 체크아웃 정보
	public List<CheckInInfo> checkOutSelect(String hostId){
		SqlSession s = f.openSession();
		List<CheckInInfo> checkOutList = s.selectList("checkOutInfoSelect", hostId);
		s.close();
		return checkOutList;
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
		List<StayInfo> stayInfo = s.selectList("selectStayInfo", host_id);
		return stayInfo;
	}

	// 숙소ID 개수
	public int countStayId(String hostId) {
		SqlSession s = f.openSession();
		int stayId = s.selectOne("stayIdCount", hostId);
		s.close();
		return stayId;
	}

	// 인기 숙소 선택
	public List<StayInfo> popStaySelect() {
		SqlSession s = f.openSession();
		List<StayInfo> stayList = s.selectList("popStaySelect");
		s.close();
		return stayList;
	}

	// 리뷰 높은 숙소 선택
	public List<StayInfo> bestReviewStaySelect() {
		SqlSession s = f.openSession();
		List<StayInfo> stayList = s.selectList("bestReviewStaySelect");
		s.close();
		return stayList;
	}

	// 가격이 저렴한 숙소 선택
	public List<StayInfo> cheepStaySelect() {
		SqlSession s = f.openSession();
		List<StayInfo> stayList = s.selectList("cheepStaySelect");
		s.close();
		return stayList;
	}
	
	// 필터링된 숙소 선택
	public List<FilterStayInfo> getFilterStay(Map<String,Object> stayInfo) {
		SqlSession s = f.openSession();
		List<FilterStayInfo> stayList = s.selectList("filterStaySelect", stayInfo);
		s.close();
		return stayList;
	}

	// 숙소 상세 정보
	public List<StayInfo> selectStayInfo(int stay_id) {
		SqlSession s = f.openSession();
		List<StayInfo> detailStayList = s.selectList("detailStaySelect", stay_id);
		s.close();
		return detailStayList;
	}

	// 객실 정보
	public List<RoomInfo> selectRoomInfo(int stay_id) {
		SqlSession s = f.openSession();
		List<RoomInfo> roomList = s.selectList("roomSelect", stay_id);
		s.close();
		return roomList;
	}

	// 리뷰 정보
	public List<ReviewInfo> selectReview(int stay_id) {
		SqlSession s = f.openSession();
		List<ReviewInfo> reviewList = s.selectList("reviewList", stay_id);
		return reviewList;
	}
}
