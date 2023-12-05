package com.pro.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.dto.DetailPlan;

public class PlanInsert {

	static PlanInsert pins = new PlanInsert();

	public static PlanInsert instance() {
		return pins;
	}

	SqlSessionFactory sqlSession = DBCon.getSqlSession();

	public void ins(DetailPlan dp) {
		SqlSession sqls = sqlSession.openSession();
		
		sqls.insert("planInsert", dp);

		sqls.commit();
		sqls.close();
		
	}

}
