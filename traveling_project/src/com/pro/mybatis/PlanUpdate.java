package com.pro.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.DetailPlan;

public class PlanUpdate {
	
	static PlanUpdate pup = new PlanUpdate();
	public static PlanUpdate instance() {
		return pup;
	}
	
	SqlSessionFactory sqlSession = DBCon.getSqlSession();
	
	public void update(DetailPlan dp) {
		SqlSession sqls = sqlSession.openSession();
		
		sqls.update("planUpdate", dp);
		sqls.commit();
		sqls.close();
	}

}
