package com.traveling.room.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.room.dto.RoomInfo;

public class RoomManagementDAO {
	static RoomManagementDAO roomManagementDAO = new RoomManagementDAO();

	public static RoomManagementDAO instance() {
		return roomManagementDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 객실 등록
	public void roomInsert(RoomInfo roomInfo) {
		SqlSession s = f.openSession();
		s.insert("roomInfoInsert", roomInfo);
		s.commit();
		s.close();
	}	
}
