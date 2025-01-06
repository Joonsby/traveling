package com.traveling.review.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.review.dto.ReviewInfo;

public class ReviewManageDAO {
	static ReviewManageDAO reviewManageDAO = new ReviewManageDAO();
	
	public static ReviewManageDAO instance() {
		return reviewManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	public int insertReviewInfo(ReviewInfo reviewInfo) {
		SqlSession s = f.openSession();
		int cnt = s.insert("insertReviewInfo");
		s.commit();
		s.close();
		return cnt;
	}
}
