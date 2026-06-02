package com.traveling.plan.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.traveling.db.DBCon;
import com.traveling.plan.dto.DetailPlan;
import com.traveling.plan.dto.MyPlanner;

public class PlanManageDAO {
	static PlanManageDAO planManageDAO = new PlanManageDAO();

	public static PlanManageDAO instance() {
		return planManageDAO;
	}
	
	SqlSessionFactory f = DBCon.getSqlSession();
	
	public List<DetailPlan> sel(DetailPlan detailPlan) {
		SqlSession s = f.openSession();
		List<DetailPlan> detailPlanList = s.selectList("planSelect", detailPlan);
		s.close();
		return detailPlanList;
	}
	
	public void ins(DetailPlan detailPlan) {
		SqlSession s = f.openSession();
		s.insert("planInsert", detailPlan);
		s.commit();
		s.close();
	}
	
	public void update(DetailPlan detailPlan) {
		SqlSession s = f.openSession();
		s.update("planUpdate", detailPlan);
		s.commit();
		s.close();
	}
	
	public void del(DetailPlan detailPlan) {
		SqlSession s = f.openSession();
		s.delete("planDelete", detailPlan);
		s.commit();
		s.close();
	}
	
	public List<MyPlanner> sel(MyPlanner myPlanner) {
		SqlSession s = f.openSession();
		List<MyPlanner> planList = s.selectList("myPlannerSelect", myPlanner);
		s.close();
		return planList;
	}
}
