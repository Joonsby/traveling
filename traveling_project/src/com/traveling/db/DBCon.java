package com.traveling.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBCon { // DB 연결옹 클래스
	
	private static SqlSessionFactory sqlSession;
	// SqlSessionFactory : DB와 연결 해주는 역할 (mybatis 안에 있는 클래스)

	public static SqlSessionFactory getSqlSession() { // static 으로 올려줌 (싱글톤 타입)
		return sqlSession;
	}

	static {
		try {
			String resource = "com/traveling/db/dbcon.xml"; // xml 파일의 경로가 들어감 (패키지도 적어줘야 함)
			Reader reader = Resources.getResourceAsReader(resource); // resource(xml 파일)를 읽어줌
			SqlSessionFactoryBuilder factory = new SqlSessionFactoryBuilder();
			sqlSession = factory.build(reader);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}