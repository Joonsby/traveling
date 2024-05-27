package com.pro.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.FilterStayInfo;
import com.pro.dto.PopStayInfo;
import com.pro.mybatis.DBCon;

public class MainDAO {
	static MainDAO md = new MainDAO();
	
	public static MainDAO instance() {
		return md;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	// 인기 숙소 정보 출력
	public List<FilterStayInfo> selectPopStays(){
		SqlSession s = f.openSession();
		List<FilterStayInfo> stayList = s.selectList("popStaySelect");
		s.close();
		return stayList;
	}
}
