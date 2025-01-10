package com.traveling.reservation.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.reservation.dto.ReservationInfo;
import com.traveling.reservation.dto.RoomInfo;
import com.traveling.review.dto.MyPageInfo;

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
	
	public List<RoomInfo> getRoomInfo(int room_id){
		SqlSession s = f.openSession();
		List<RoomInfo> roomList = s.selectList("getRoomInfo",room_id);
		s.close();
		return roomList;
	}
	
	public List<ReservationInfo> getRoomInfo2(Map<String, String> reservationInfo){
		SqlSession s = f.openSession();
		List<ReservationInfo> roomList = s.selectList("getRoomInfo2",reservationInfo);
		s.close();
		return roomList;
	}
	
	public int reservationInsert(Map<String, String> reservationInfo) {
		SqlSession s = f.openSession();
		int cnt = s.insert("insertReservationInfo",reservationInfo);
		s.commit();
		s.close();
		return cnt;
	}
	
}
