package com.pro.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.MyPlanner;

public class SelMyPlan {
	
	static SelMyPlan sel = new SelMyPlan();
	public static SelMyPlan instance() {
		return sel;
	}
	
	SqlSessionFactory sqlSession = DBCon.getSqlSession();
	
	public List<MyPlanner> sel(MyPlanner mp) {
		SqlSession sqls = sqlSession.openSession();
		
		List<MyPlanner> selList = sqls.selectList("myPlannerSelect", mp);
		
		sqls.close();
		
		return selList;
	}
}
