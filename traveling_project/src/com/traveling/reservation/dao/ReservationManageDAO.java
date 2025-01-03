package com.traveling.reservation.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.reservation.dto.ReservationInfo;

public class ReservationManageDAO {
	static ReservationManageDAO reservationManageDAO = new ReservationManageDAO();

	public static ReservationManageDAO instance() {
		return reservationManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 예약정보
	public List<ReservationInfo> getReservationInfo(String hostId){
		SqlSession s = f.openSession();
		List<ReservationInfo> reservationList = s.selectList("getReservationInfo",hostId);
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
}
