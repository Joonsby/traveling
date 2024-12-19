package com.pro.login.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.DBCon;
import com.pro.login.dto.HostInfo;
import com.pro.login.dto.UserInfo;

public class LoginDAO {
	static LoginDAO loginDAO = new LoginDAO();

	public static LoginDAO instance() {
		return loginDAO;
	}

	SqlSessionFactory f = DBCon.getSqlSession();

	public int checkUserInfo(UserInfo userInfo) {
		SqlSession s = f.openSession();
		int cnt = s.selectOne("getUserInfo", userInfo);
		s.close();
		return cnt;
	}
	
	public int checkHostInfo(UserInfo userInfo) {
		SqlSession s = f.openSession();
		int cnt = s.selectOne("getHostInfo", userInfo);
		s.close();
		return cnt;
	}
	
	public List<HostInfo> getHostInfo(UserInfo userInfo){
		SqlSession s = f.openSession();
		List<HostInfo> hostList = s.selectList("selectHostInfo",userInfo);
		s.close();
		return hostList;
	}
}
