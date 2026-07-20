package com.traveling.db;

import java.io.Reader;
import java.util.Properties;

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
			String env = System.getProperty("env", getEnv("APP_ENV", "local"));

			String dbHost = getEnv("DB_HOST", "localhost");
			String dbPort = getEnv("DB_PORT", "3306");
			String dbName = getEnv("DB_NAME", "traveling");
			String dbUser = getEnv("DB_USER", "traveling");
			String dbPassword = getEnv("DB_PASSWORD", "traveling_local");

            String dbUrl =
                    "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
                    + "?serverTimezone=Asia/Seoul"
                    + "&characterEncoding=UTF-8"
                    + "&useSSL=false"
                    + "&allowPublicKeyRetrieval=true";

			Properties props = new Properties();
			props.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
			props.setProperty("db.url", dbUrl);
			props.setProperty("db.username", dbUser);
			props.setProperty("db.password", dbPassword);

			String resource = "mybatis/dbcon.xml"; // xml 파일의 경로가 들어감 (패키지도 적어줘야 함)
			Reader reader = Resources.getResourceAsReader(resource); // resource(xml 파일)를 읽어줌

			SqlSessionFactoryBuilder factory = new SqlSessionFactoryBuilder();			
			sqlSession = factory.build(reader, env, props); // build() : SqlSessionFactory 객체를 만들어줌

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("MyBatis SqlSessionFactory 초기화 실패 : " + e);
		}
	}

	private static String getEnv(String key, String defaultValue) {
		String value = System.getenv(key);
		return value == null || value.isBlank() ? defaultValue : value;
	}

}