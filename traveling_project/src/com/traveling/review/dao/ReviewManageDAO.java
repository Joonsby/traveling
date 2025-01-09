package com.traveling.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.review.dto.MyPageInfo;
import com.traveling.review.dto.ReviewInfo;

public class ReviewManageDAO {
	static ReviewManageDAO reviewManageDAO = new ReviewManageDAO();
	
	public static ReviewManageDAO instance() {
		return reviewManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 리뷰 신규 등록
	public int insertReviewInfo(ReviewInfo reviewInfo) {
		SqlSession s = f.openSession();
		int cnt = s.insert("insertReviewInfo",reviewInfo);
		s.commit();
		s.close();
		return cnt;
	}
	
	// 리뷰 유무 검증
	public List<Integer> hasReview(String id){
		SqlSession s = f.openSession();
		List<Integer> reviews = s.selectList("hasReview",id);
		s.close();
		return reviews;
	}
	
	// 작성한 리뷰 목록 추출
	public List<MyPageInfo> getReviewList(String id){
		SqlSession s = f.openSession();
		List<MyPageInfo> reviewList = s.selectList("getUserReviewList",id);
		s.close();
		return reviewList;
	}
	
	public List<ReviewInfo> reviewReplace(String reservationId) {
		SqlSession s = f.openSession();
		List<ReviewInfo> reviewList = s.selectList("getReviewList",reservationId);
		s.close();
		return reviewList;
	}
	
	public int updateReview(ReviewInfo reviewInfo){
		SqlSession s = f.openSession();
		int cnt = s.update("updateReview",reviewInfo);
		s.commit();
		s.close();
		return cnt;
	}
	
	public int reviewDelete(String reservationId) {
		SqlSession s = f.openSession();
		int cnt = s.delete("reviewDelete",reservationId);
		s.commit();
		s.close();
		return cnt;
	}
}
