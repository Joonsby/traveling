package com.traveling.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		int cnt = s.insert("insertReviewInfo");
		s.commit();
		s.close();
		return cnt;
	}
	
	// 리뷰 유무 검증
	public List<Integer> hasReview(String id){
		Map<String, List<Integer>> userReviewCache = new HashMap<>();
		List<Integer> cachedReviews = userReviewCache.get(id);
		if(cachedReviews != null) {
			return cachedReviews;
		} else {
			SqlSession s = f.openSession();
			List<Integer> reviews = s.selectList("hasReview",id);
			s.close();
			userReviewCache.put(id,reviews);
			return reviews;
		}
	}
	
	// 작성한 리뷰 목록 추출
	public List<MyPageInfo> getReviewList(String id){
		SqlSession s = f.openSession();
		List<MyPageInfo> reviewList = s.selectList("getReviewList",id);
		s.close();
		return reviewList;
	}
	
	public List<ReviewInfo> reviewReplace(String reservationId) {
		SqlSession s = f.openSession();
		List<ReviewInfo> reviewList = s.selectList("getReviewList",reservationId);
		s.close();
		return reviewList;
	}
}
