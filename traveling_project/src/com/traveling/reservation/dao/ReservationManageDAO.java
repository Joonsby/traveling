package com.traveling.reservation.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.reservation.dto.ReservationInfo;
import com.traveling.reservation.dto.RoomInfo;
import com.traveling.signup.dto.UserInfo;

public class ReservationManageDAO {
	static ReservationManageDAO reservationManageDAO = new ReservationManageDAO();

	public static ReservationManageDAO instance() {
		return reservationManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 예약정보(호스트)
	public List<ReservationInfo> getHostReservationInfo(String hostId){
		SqlSession s = f.openSession();
		List<ReservationInfo> reservationList = s.selectList("getHostReservationInfo",hostId);
		s.close();
		return reservationList;
	}
	
	// 예약 승인/거부
	public int reservationUpdate(HashMap<String,String> updateInfo) {
		SqlSession s = f.openSession();
		int cnt = s.update("reservationUpdate",updateInfo);
		s.commit();
		s.close();
		return cnt;
	}
	
	// 객실 정보
	public List<RoomInfo> getRoomInfo(int room_id){
		SqlSession s = f.openSession();
		List<RoomInfo> roomList = s.selectList("getRoomInfo",room_id);
		s.close();
		return roomList;
	}
	
	// 객실 가격 정보 가져오기
	public int getRoomPrice(int roomId) {
		SqlSession s = f.openSession();
		int basePrice = s.selectOne("getRoomPrice",roomId);
		s.close();
		return basePrice;
	}
	
	// 예약 고객 사용자 정보
	public UserInfo getUserInfo(String userId){
		SqlSession s = f.openSession();
		UserInfo userInfo = s.selectOne("getReservationUserInfo", userId);
		s.close();
		return userInfo;
	}
	
	// 객실 기준 인원
	public int getStandardPeople(int roomId) {
	    SqlSession s = f.openSession();
	    int standardPeople = s.selectOne("getStandardPeople", roomId);
	    s.close();
	    return standardPeople;
	}
	
	// 객실 추가 요금
	public int getExtraPersonFee(int roomId) {
	    SqlSession s = f.openSession();
	    int fee = s.selectOne("getExtraPersonFee", roomId);
	    s.close();
	    return fee;
	}
	
	public int insertPendingReservation(Map<String, String> reservationInfo) {
	    SqlSession s = f.openSession();
	    int cnt = s.insert("insertPendingReservation", reservationInfo);
	    s.commit();
	    s.close();
	    return cnt;
	}

	public Map<String, Object> getPendingReservationByOrderId(String orderId) {
	    SqlSession s = f.openSession();
	    Map<String, Object> pending = s.selectOne("getPendingReservationByOrderId", orderId);
	    s.close();
	    return pending;
	}

	public int insertReservationFromPending(Map<String, Object> reservationInfo) {
	    SqlSession s = f.openSession();
	    int cnt = s.insert("insertReservationFromPending", reservationInfo);
	    s.commit();
	    s.close();
	    return cnt;
	}

	public int updatePendingPaymentDone(String orderId) {
	    SqlSession s = f.openSession();
	    int cnt = s.update("updatePendingPaymentDone", orderId);
	    s.commit();
	    s.close();
	    return cnt;
	}

	public int updatePendingPaymentFail(String orderId) {
	    SqlSession s = f.openSession();
	    int cnt = s.update("updatePendingPaymentFail", orderId);
	    s.commit();
	    s.close();
	    return cnt;
	}
	
	public ReservationInfo getReservationSuccessInfo(String orderId) {
	    SqlSession s = f.openSession();
	    ReservationInfo info = s.selectOne("getReservationSuccessInfo", orderId);
	    s.close();
	    return info;
	}
}
