package com.pro.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.DetailPlan;

public class PlanSelect {
	
	static PlanSelect psel = new PlanSelect();
	public static PlanSelect instance() {
		return psel;
	}
	
	SqlSessionFactory sqlSession = DBCon.getSqlSession();
	
	public List<DetailPlan> sel(DetailPlan dp) {
		SqlSession sqls = sqlSession.openSession();
		
		List<DetailPlan> dpList = sqls.selectList("planSelect", dp);
		sqls.close();
		
		return dpList;
	}

}
