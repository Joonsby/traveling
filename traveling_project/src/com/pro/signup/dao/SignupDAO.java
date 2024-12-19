package com.pro.signup.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.DBCon;
import com.pro.signup.dto.HostInfo;
import com.pro.signup.dto.UserInfo;

public class SignupDAO {
	static SignupDAO signupDAO = new SignupDAO();

	public static SignupDAO instance() {
		return signupDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	public int checkUserId(String userId) {
		SqlSession s = f.openSession();
		int cnt = s.selectOne("checkUserId", userId);
		s.close();
		return cnt;
	}
	
	public int insertUserInfo(UserInfo userInfo) {
		SqlSession s = f.openSession();
		int cnt = s.insert("insertUserInfo",userInfo);
		s.commit();
		s.close();
		return cnt;
	}
	
	public int checkHostId(String hostId) {
		SqlSession s = f.openSession();
		int cnt = s.selectOne("checkHostId", hostId);
		s.close();
		return cnt;
	}
	
	public int insertHostInfo(HostInfo hostInfo) {
		SqlSession s = f.openSession();
		int cnt = s.insert("insertHostInfo",hostInfo);
		s.commit();
		s.close();
		return cnt;
	}
}
