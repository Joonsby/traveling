package com.traveling.mypage.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.mypage.dto.MyPageInfo;

public class MyPageManageDAO {
	static MyPageManageDAO myPageManageDAO = new MyPageManageDAO();

	public static MyPageManageDAO instance() {
		return myPageManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 예약정보(사용자)
	public List<MyPageInfo> getUserReservationInfo(String userId){
		SqlSession s = f.openSession();
		List<MyPageInfo> reservationInfoList = s.selectList("getUserReservationInfo",userId);
		s.close();
		return reservationInfoList;
	}
	
	// 리뷰 유무 검증
	public List<Integer> hasReview(String id){
		SqlSession s = f.openSession();
		List<Integer> reviews = s.selectList("hasReview",id);
		s.close();
		return reviews;
	}
	
	// 마이페이지 상태창 - 합산 가격 추출
	public int statusPrice(String id) {
		SqlSession s = f.openSession();
		int sum = s.selectOne("getStatusPrice",id);
		s.close();
		return sum; 
	}
	
	// 마지막 여행 다녀온지 n일 추출
	public int lastTravel(String id) {
		SqlSession s = f.openSession();
		int ndays = s.selectOne("getLastTravel",id);
		s.close();
		return ndays;
	}
	
	// 현재날짜 기준 총 숙박일수 추출
	public int totalStay(String id) {
		SqlSession s = f.openSession();
		int totalStays = s.selectOne("getTotalStays",id);
		s.close();
		return totalStays;
	}
	
	// 로그인 한 사용자의 누적 마일리지 추출
	public int totalMileage(String id) {
		SqlSession s = f.openSession();
		Integer cnt = s.selectOne("getTotalMileage",id);
		int totalMileage = (cnt != null) ? cnt : 0; // 기본값 0 설정
		s.close();
		return totalMileage;
	}
}
