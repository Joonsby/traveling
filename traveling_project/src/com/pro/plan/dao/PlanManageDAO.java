package com.pro.plan.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.DBCon;
import com.pro.plan.dto.DetailPlan;
import com.pro.plan.dto.MyPlanner;

public class PlanManageDAO {
	static PlanManageDAO plmd = new PlanManageDAO();

	public static PlanManageDAO instance() {
		return plmd;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	public List<DetailPlan> sel(DetailPlan dp) {
		SqlSession s = f.openSession();
		
		List<DetailPlan> dpList = s.selectList("planSelect", dp);
		s.close();
		return dpList;
	}
	
	public void ins(DetailPlan dp) {
		SqlSession s = f.openSession();
		
		s.insert("planInsert", dp);

		s.commit();
		s.close();
	}
	
	public void update(DetailPlan dp) {
		SqlSession s = f.openSession();
		
		s.update("planUpdate", dp);
		s.commit();
		s.close();
	}
	
	public void del(DetailPlan dp) {
		SqlSession s = f.openSession();
		
		s.delete("planDelete", dp);
		s.commit();
		s.close();
	}
	
	public List<MyPlanner> sel(MyPlanner mp) {
		SqlSession s = f.openSession();
		
		List<MyPlanner> selList = s.selectList("myPlannerSelect", mp);
		
		s.close();
		
		return selList;
	}
}
