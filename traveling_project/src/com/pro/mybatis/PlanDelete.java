package com.pro.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.DetailPlan;

public class PlanDelete {
	
	static PlanDelete pdel = new PlanDelete();
	
	public static PlanDelete instance() {
		return pdel;
	}
	
	SqlSessionFactory sqlSession = DBCon.getSqlSession();
	
	public void del(DetailPlan dp) {
		SqlSession sqls = sqlSession.openSession();
		
		sqls.delete("planDelete", dp);
		sqls.commit();
		sqls.close();
	}

}
