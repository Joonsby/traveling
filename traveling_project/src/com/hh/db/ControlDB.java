package com.hh.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.traveling.review.dto.MyPageInfo;

public class ControlDB {
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	// connect용 메소드
	public void conn() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf-8", "root","xhddlf336!");
			stmt = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// close용 메소드
	public void close() {
		try {
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 리뷰 수정 update
	public void reviewUpdate(ReviewObj obj) {
		try {
			conn();
			stmt.executeUpdate("UPDATE review_info SET review_title = '" + obj.getRtitle()
							+ "', review_content = '" + obj.getRcontent()
							+ "', rating = " + obj.getRating()
							+ ", review_time = now(), image_path01 = '" + obj.getImage_path01() + "', image_path02 = '" + obj.getImage_path02()
							+ "', image_path03 = '" + obj.getImage_path03() + "', image_path04 = '" + obj.getImage_path04() + "', image_path05 = '" + obj.getImage_path05()
							+ "' WHERE reservation_id = " + obj.getReservation_id() + ";");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	// 리뷰 삭제
	public void reviewDelete(String rid) {
		try {
			conn();
			stmt.executeUpdate("DELETE FROM review_info WHERE reservation_id = " + rid + ";");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public RoomReserv roomDetail(int rid) {
		RoomReserv rv = new RoomReserv();
		
		try {
			conn();
			rs = stmt.executeQuery("SELECT * FROM room_info WHERE room_id = " + rid);
			
			if (rs.next()) {
				rv.setRoom_id(rs.getInt("room_id"));
				rv.setStay_id(rs.getInt("stay_id"));
				rv.setRoom_name(rs.getString("room_name"));
				rv.setContent(rs.getString("content"));
				rv.setCheck_in_time(rs.getString("check_in_time"));
				rv.setCheck_out_time(rs.getString("check_out_time"));
				rv.setPrice(rs.getInt("price"));
				rv.setStandard_people(rs.getInt("standard_people"));
				rv.setMaximum_people(rs.getInt("maximum_people"));
				rv.setImage1(rs.getString("image1"));
				rv.setImage2(rs.getString("image2"));
				rv.setImage3(rs.getString("image3"));
				rv.setImage4(rs.getString("image4"));
				rv.setImage5(rs.getString("image5"));
				rv.setImage6(rs.getString("image6"));
				rv.setImage7(rs.getString("image7"));
				rv.setImage8(rs.getString("image8"));
				rv.setImage9(rs.getString("image9"));
				rv.setImage10(rs.getString("image10"));				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return rv;
	}
	
	public void reservInsert(ReservationInsert rinfo) {
		
		String uid = rinfo.getUser_id();
		int rid = rinfo.getRoom_id();
		String chkin = rinfo.getCheck_in_date();
		String chkout = rinfo.getCheck_out_date();
		String chkinTime = rinfo.getCheck_in_time();
		String chkoutTime = rinfo.getCheck_out_time();
		int people = rinfo.getPeople();
		int price = rinfo.getPrice();
		
		try {
			conn();
			stmt.executeUpdate(
					"INSERT INTO reservation (user_id, room_id, check_in_date, check_out_date, "
					+ "check_in_time, check_out_time, people, price, payment_time, status) "
					+ "VALUES ('" + uid + "', " + rid + ", '" + chkin + "', '" + chkout + "', '"
					+ chkinTime + "', '" + chkoutTime + "', " + people + ", " + price + ", now(), '예약 대기');");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}