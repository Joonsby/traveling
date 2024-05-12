package com.pro.reservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class ReservationAcception {
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	// Connection
	// db 비밀번호
	public void connect() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf-8", "root", "xhddlf336!");
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	// Close	
	public void close() {
		try {
			stmt.close();
			conn.close();
		} catch (Exception e){
			System.out.println(e);
		}		
	}
	
	// 예약 상태가 예약 대기중인 예약 정보 추출
	public ArrayList<ReservationInfo> reservationWaiting(String hostId) {
		ArrayList<ReservationInfo> arr = new ArrayList<ReservationInfo>();
		try {
			connect();
			rs = stmt.executeQuery(
					"SELECT r.reservation_id,u.name,ro.room_name,r.check_in_date,r.check_out_date,r.check_in_time,r.check_out_time,r.people,r.price,r.payment_time,r.status "
					+ "FROM reservation r " 
					+ "JOIN room_info ro ON ro.room_id = r.room_id "
					+ "JOIN stay_info s ON s.stay_id = ro.stay_id "
					+ "JOIN host_info h ON h.host_id = s.host_id AND h.host_id = '"+ hostId + "' "
					+ "INNER JOIN user_info u ON u.user_id = r.user_id "
					+ "where r.status='예약 대기';"
					);
			while(rs.next()) {
				ReservationInfo rsInfo = new ReservationInfo();
				rsInfo.setReservationId(rs.getInt("reservation_id"));
				rsInfo.setUserId(rs.getString("name"));				
				rsInfo.setRoomName(rs.getString("room_name"));
				rsInfo.setCheckInDate(rs.getString("check_in_date"));
				rsInfo.setCheckOutDate(rs.getString("check_out_date"));
				rsInfo.setCheckInTime(rs.getString("check_in_time"));
				rsInfo.setCheckOutTime(rs.getString("check_out_time"));
				rsInfo.setPeople(rs.getInt("people"));
				rsInfo.setPrice(rs.getInt("price"));
				rsInfo.setPaymentTime(rs.getString("payment_time"));
				rsInfo.setStatus(rs.getString("status"));
				arr.add(rsInfo);
			}
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
		return arr;
	}
	
	// 예약 상태가 에약 확정인 예약 정보 추출
	public ArrayList<ReservationInfo> reservationConfirmed(String hostId) {
		ArrayList<ReservationInfo> arr = new ArrayList<ReservationInfo>();
		try {
			connect();
			rs = stmt.executeQuery(
					"SELECT r.reservation_id,u.name,ro.room_name,r.check_in_date,r.check_out_date,r.check_in_time,r.check_out_time,r.people,r.price,r.payment_time,r.status "
					+ "FROM reservation r " 
					+ "JOIN room_info ro ON ro.room_id = r.room_id "
					+ "JOIN stay_info s ON s.stay_id = ro.stay_id "
					+ "JOIN host_info h ON h.host_id = s.host_id AND h.host_id = '"+ hostId + "' "
					+ "INNER JOIN user_info u ON u.user_id = r.user_id "
					+ "where r.status='예약 확정';"
					);
			while(rs.next()) {
				ReservationInfo rsInfo = new ReservationInfo();
				rsInfo.setReservationId(rs.getInt("reservation_id"));
				rsInfo.setUserId(rs.getString("name"));
				rsInfo.setRoomName(rs.getString("room_name"));				
				rsInfo.setCheckInDate(rs.getString("check_in_date"));
				rsInfo.setCheckOutDate(rs.getString("check_out_date"));
				rsInfo.setCheckInTime(rs.getString("check_in_time"));
				rsInfo.setCheckOutTime(rs.getString("check_out_time"));
				rsInfo.setPeople(rs.getInt("people"));
				rsInfo.setPrice(rs.getInt("price"));
				rsInfo.setPaymentTime(rs.getString("payment_time"));
				rsInfo.setStatus(rs.getString("status"));
				arr.add(rsInfo);
			}
		} catch(Exception e) {
			System.out.println(e);			
		}
		return arr;
	}
	
	// 예약 상태가 예약 거부됨인 예약 정보 추출
	public ArrayList<ReservationInfo> reservationRejected(String hostId) {
		ArrayList<ReservationInfo> arr = new ArrayList<ReservationInfo>();
		try {
			connect();
			rs = stmt.executeQuery(
					"SELECT r.reservation_id,u.name,ro.room_name,r.check_in_date,r.check_out_date,r.check_in_time,r.check_out_time,r.people,r.price,r.payment_time,r.status "
					+ "FROM reservation r " 
					+ "JOIN room_info ro ON ro.room_id = r.room_id "
					+ "JOIN stay_info s ON s.stay_id = ro.stay_id "
					+ "JOIN host_info h ON h.host_id = s.host_id AND h.host_id = '"+ hostId + "' "
					+ "INNER JOIN user_info u ON u.user_id = r.user_id "
					+ "where r.status='예약 거부';"
					);
			while(rs.next()) {
				ReservationInfo rsInfo = new ReservationInfo();
				rsInfo.setReservationId(rs.getInt("reservation_id"));
				rsInfo.setUserId(rs.getString("name"));
				rsInfo.setRoomName(rs.getString("room_name"));
				rsInfo.setCheckInDate(rs.getString("check_in_date"));
				rsInfo.setCheckOutDate(rs.getString("check_out_date"));
				rsInfo.setCheckInTime(rs.getString("check_in_time"));
				rsInfo.setCheckOutTime(rs.getString("check_out_time"));
				rsInfo.setPeople(rs.getInt("people"));
				rsInfo.setPrice(rs.getInt("price"));
				rsInfo.setPaymentTime(rs.getString("payment_time"));
				rsInfo.setStatus(rs.getString("status"));
				arr.add(rsInfo);
			}
		} catch(Exception e) {
			System.out.println(e);			
		}
		return arr;
	}
	
	// 예약 상태가 예약 취소됨인 예약 정보 추출
		public ArrayList<ReservationInfo> reservationCancelled(String hostId) {
			ArrayList<ReservationInfo> arr = new ArrayList<ReservationInfo>();
			try {
				connect();
				rs = stmt.executeQuery(
						"SELECT r.reservation_id,u.name,ro.room_name,r.check_in_date,r.check_out_date,r.check_in_time,r.check_out_time,r.people,r.price,r.payment_time,r.status "
						+ "FROM reservation r " 
						+ "JOIN room_info ro ON ro.room_id = r.room_id "
						+ "JOIN stay_info s ON s.stay_id = ro.stay_id "
						+ "JOIN host_info h ON h.host_id = s.host_id AND h.host_id = '"+ hostId + "' "
						+ "INNER JOIN user_info u ON u.user_id = r.user_id "
						+ "where r.status='예약 취소';"
						);
				while(rs.next()) {
					ReservationInfo rsInfo = new ReservationInfo();
					rsInfo.setReservationId(rs.getInt("reservation_id"));
					rsInfo.setUserId(rs.getString("name"));
					rsInfo.setRoomName(rs.getString("room_name"));
					rsInfo.setCheckInDate(rs.getString("check_in_date"));
					rsInfo.setCheckOutDate(rs.getString("check_out_date"));
					rsInfo.setCheckInTime(rs.getString("check_in_time"));
					rsInfo.setCheckOutTime(rs.getString("check_out_time"));
					rsInfo.setPeople(rs.getInt("people"));
					rsInfo.setPrice(rs.getInt("price"));
					rsInfo.setPaymentTime(rs.getString("payment_time"));
					rsInfo.setStatus(rs.getString("status"));
					arr.add(rsInfo);
				}
			} catch(Exception e) {
				System.out.println(e);			
			}
			return arr;
		}
			
	// 예약 승인
	public void reservationAccept(String reservationId) {
		try {
			connect();
			stmt.executeUpdate("UPDATE reservation SET status='예약 확정' WHERE status='예약 대기' AND reservation_id ='" + reservationId + "';");
			reservationToPlanner(reservationId);
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
	}
	
	// 예약 승인 -> 플래너 등록
	public void reservationToPlanner(String reservationId) {
		try {
			connect();
			stmt.executeUpdate("INSERT INTO planner (reservation_id, modified_date) VALUES (" + reservationId + ", now());");
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
	}
	
	
	// 예약 거부
	public void reservationReject(String reservationId) {
		try {
			connect();
			stmt.executeUpdate("update reservation set status='예약 거부' where status='예약 대기' and reservation_id ='" + reservationId + "';");
		} catch(Exception e) {
			System.out.println(e);
		} finally {
			close();
		}
	}

}