package com.pro.index;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.HashMap;

import com.pro.dto.PopStayInfo;

public class IndexDAO{
	
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	NumberFormat nf = NumberFormat.getInstance();
	
	//connect
	public void connect() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://15.164.100.42:3306/project", "joonsby", "xhddlf336!");
			stmt = con.createStatement();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// close
	public void close() {		
		try {			
			rs.close();
			stmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	// 인기 숙소 정보 출력
	public HashMap<Integer, PopStayInfo> selectPopStays() {
		HashMap<Integer, PopStayInfo> popStays = new HashMap<Integer, PopStayInfo>();
		nf.setGroupingUsed(true);
		int rowCount = 0;
		try {
			connect();
			rs = stmt.executeQuery("SELECT " +
					"si.stay_id AS stay_id, " +
					"si.stay_name AS stay_name, " + 
					"si.road_addr AS stay_addr, " + 
					"si.image1 AS image1, " + 
					"si.image2 AS image2, " + 
					"MIN(ri.price) AS min_room_price, " + 
					"MAX(rev.review_time) AS latest_review_time, " + 
					"SUBSTRING_INDEX(GROUP_CONCAT(rev.review_content ORDER BY rev.review_time DESC), ',', 1) AS review_content, " + 
					"COUNT(res.room_id) AS room_count " + 
					"FROM stay_info si " + 
					"JOIN room_info ri ON si.stay_id = ri.stay_id " + 
					"LEFT JOIN reservation res ON ri.room_id = res.room_id " + 
					"LEFT JOIN review_info rev ON res.reservation_id = rev.reservation_id " + 
					"GROUP BY si.stay_id, si.stay_name, si.road_addr, si.image1, si.image2 "  + 
					"ORDER BY room_count DESC;");
			while (rs.next()) {				
				String formattedPrice = nf.format(rs.getInt("min_room_price"));
				PopStayInfo popStayInfo = new PopStayInfo();
				popStayInfo.setStay_id(rs.getInt("stay_id"));
				popStayInfo.setStayName(rs.getString("stay_name"));
				popStayInfo.setStayAddr(rs.getString("stay_addr"));
				popStayInfo.setImage1(rs.getString("image1"));
				popStayInfo.setImage2(rs.getString("image2"));
				popStayInfo.setPrice(formattedPrice);
				popStayInfo.setReviewContent(rs.getString("review_content"));
				popStays.put(rowCount, popStayInfo);
				rowCount++;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
		return popStays;
	}
	
	// 리뷰 평점 높은 순서대로 숙소 정보 출력
	public HashMap<Integer, PopStayInfo> selectBestReviewStays(){
		HashMap<Integer, PopStayInfo> bestReviewStays = new HashMap<Integer, PopStayInfo>();
		nf.setGroupingUsed(true);
		int rowCount = 0;
		try {
			connect();
			rs = stmt.executeQuery("SELECT " +
				  "si.stay_id AS stay_id, " +
				  "si.stay_name AS stay_name, " + 
				  "si.road_addr AS stay_addr, " +
				  "si.image1 AS image1, " +
				  "si.image2 AS image2, " +
				  "MIN(ri.price) AS min_room_price, " +
				  "MAX(rev.review_time) AS latest_review_time, " + 
				  "AVG(rev.rating) AS avg_rating, " +
				  "SUBSTRING_INDEX(GROUP_CONCAT(rev.review_content ORDER BY rev.review_time DESC), ',', 1) AS review_content " + 
				  "FROM stay_info si " +
				  "JOIN room_info ri ON si.stay_id = ri.stay_id " +
				  "LEFT JOIN reservation res ON ri.room_id = res.room_id " +
				  "LEFT JOIN review_info rev ON res.reservation_id = rev.reservation_id " +
				  "GROUP BY si.stay_id, si.stay_name, si.road_addr, si.image1, si.image2 " +
				  "ORDER BY avg_rating DESC, latest_review_time DESC;");
			while(rs.next()) {
				String formattedPrice = nf.format(rs.getInt("min_room_price"));
				PopStayInfo popStayInfo = new PopStayInfo();
				popStayInfo.setStay_id(rs.getInt("stay_id"));
				popStayInfo.setStayName(rs.getString("stay_name"));
				popStayInfo.setStayAddr(rs.getString("stay_addr"));
				popStayInfo.setImage1(rs.getString("image1"));
				popStayInfo.setImage2(rs.getString("image2"));
				popStayInfo.setPrice(formattedPrice);
				bestReviewStays.put(rowCount, popStayInfo);
				rowCount++;
			}
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
		return bestReviewStays;
	}
	
	// 가장 저렴한 숙소 정보 출력
	public HashMap<Integer, PopStayInfo> selectCheepStays(){
		HashMap<Integer, PopStayInfo> cheepStays = new HashMap<Integer, PopStayInfo>();
		nf.setGroupingUsed(true);
		int rowCount = 0;
		try {
			connect();
			rs = stmt.executeQuery("SELECT " +
					"si.stay_id AS stay_id, " + 
					"si.stay_name AS stay_name, " + 
					"si.road_addr AS stay_addr, " + 
					"si.image1 AS image1, " + 
					"si.image2 AS image2, " + 
					"MIN(ri.price) AS min_room_price, " + 
					"MAX(rev.review_time) AS latest_review_time, " + 
					"AVG(rev.rating) AS avg_rating, " + 
					"SUBSTRING_INDEX(GROUP_CONCAT(rev.review_content ORDER BY rev.review_time DESC), ',', 1) AS review_content " + 
					"FROM stay_info si " + 
					"JOIN room_info ri ON si.stay_id = ri.stay_id " + 
					"LEFT JOIN reservation res ON ri.room_id = res.room_id " + 
					"LEFT JOIN review_info rev ON res.reservation_id = rev.reservation_id " + 
					"GROUP BY si.stay_id, si.stay_name, si.road_addr, si.image1, si.image2 " + 
					"ORDER BY min_room_price ASC, avg_rating DESC, latest_review_time DESC;");
			while(rs.next()) {
				String formattedPrice = nf.format(rs.getInt("min_room_price"));
				PopStayInfo popStayInfo = new PopStayInfo();
				popStayInfo.setStay_id(rs.getInt("stay_id"));
				popStayInfo.setStayName(rs.getString("stay_name"));
				popStayInfo.setStayAddr(rs.getString("stay_addr"));
				popStayInfo.setImage1(rs.getString("image1"));
				popStayInfo.setImage2(rs.getString("image2"));
				popStayInfo.setPrice(formattedPrice);
				popStayInfo.setReviewContent(rs.getString("review_content"));			
				cheepStays.put(rowCount, popStayInfo);
				rowCount++;
			}
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
		return cheepStays;
	}
}
