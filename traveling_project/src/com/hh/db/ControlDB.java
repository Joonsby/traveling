package com.hh.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ControlDB {
	Connection con = null;
	Statement sta = null;
	ResultSet rs = null;

	// connect용 메소드
	// db 비밀번호
	public void condb() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://15.164.100.42:3306/project?characterEncoding=utf-8", "joonsby","xhddlf336!");
			sta = con.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// close용 메소드
	public void discon() {
		try {
			sta.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 리뷰 DB 입력용 메소드
	public void insertReview(ReviewObj obj) {
		try {
			condb();
			sta.executeUpdate(
					"INSERT INTO review_info VALUES ("
							+ obj.getReservation_id() + ", '" + obj.getRtitle() + "', '" + obj.getRcontent() + "', "
							+ obj.getRating() + ", now(), '" + obj.getImage_path01() + "', '" + obj.getImage_path02()
							+ "', '" + obj.getImage_path03() + "', '" + obj.getImage_path04() + "', '" + obj.getImage_path05()
							+ "');");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
	}

	// 마이페이지 - 예약정보 추출용 메소드
	public ArrayList<MyPageObj> getReservInfo(String user_id) {
		ArrayList<MyPageObj> rinfoList = new ArrayList<MyPageObj>();
		try {
			condb();
			// 예약번호, 체크인&아웃 날짜, 인원수 추출
			rs = sta.executeQuery(
					"SELECT r.reservation_id, DATE_FORMAT(r.check_in_date, '%Y.%m.%d') AS check_in_date, DATE_FORMAT(r.check_out_date, '%Y.%m.%d') AS check_out_date, r.people, r.status, si.stay_name, si.location "
							+ "FROM reservation r " + "JOIN room_info ri ON r.room_id = ri.room_id "
							+ "JOIN stay_info si ON ri.stay_id = si.stay_id WHERE user_id = '" + user_id + "';");
			while (rs.next()) {
				MyPageObj rinfo = new MyPageObj();
				rinfo.setReservation_id(rs.getString("reservation_id"));
				rinfo.setCheckInDate(rs.getString("check_in_date"));
				rinfo.setCheckOutDate(rs.getString("check_out_date"));
				rinfo.setPeople(rs.getInt("people"));
				rinfo.setStatus(rs.getString("status"));
				rinfo.setStayName(rs.getString("stay_name"));
				rinfo.setLocation(rs.getString("location"));
				rinfoList.add(rinfo);
			}
		} catch (Exception e) {

		} finally {
			discon();
		}
		return rinfoList;
	}
	
	// 리뷰 작성 여부를 캐싱하기 위한 전역 변수
	private Map<String, List<Integer>> userReviewCache = new HashMap<>();

	// 리뷰 작성했는지 여부 조회용
	public List<Integer> hasReview(String id) {
	    // 캐시에서 리뷰 정보를 가져오기 시도
	    List<Integer> cachedReviews = userReviewCache.get(id);

	    if (cachedReviews != null) {
	        // 캐시에서 리뷰 정보를 찾았을 경우 바로 반환
	        return cachedReviews;
	    } else {
	        // 캐시에 리뷰 정보가 없을 경우 데이터베이스 조회
	        List<Integer> reviews = new ArrayList<>();
	        try {
	            condb();
	            rs = sta.executeQuery(
	            		"SELECT re.reservation_id AS review_exists "
	            		+ "FROM reservation r "
	            		+ "LEFT JOIN review_info re ON r.reservation_id = re.reservation_id "
	            		+ "WHERE r.user_id = '" + id + "';"
	            );
	            while (rs.next()) {
	                int reviewId = rs.getInt("review_exists");
	                reviews.add(reviewId);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            discon();
	        }

	        // 조회한 리뷰 정보를 캐시에 저장
	        userReviewCache.put(id, reviews);

	        return reviews;
	    }
	}


	// 로그인 유효성 체크
	public LoginObj chkLoginId(String id, String pw) {
		LoginObj logChk = new LoginObj();
		try {
			condb();
			rs = sta.executeQuery("SELECT user_id, pw FROM user_join WHERE user_id = '" + id + "';");
			while (rs.next()) {
				logChk.setId(rs.getString("user_id"));
				logChk.setPw(rs.getString("pw"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return logChk;
	}

	// 마이페이지 상태창 - 합산 가격 추출
	public int statusPrice(String id) {
		int sum = 0;
		try {
			condb();
			rs = sta.executeQuery("SELECT SUM(price) FROM reservation WHERE user_id = '" + id + "';");
			while (rs.next()) {
				sum = rs.getInt("SUM(price)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return sum;
	}
	
	// 마지막 여행 다녀온지 n일 추출
	public int lastTravel(String id) {
		int ndays = 0;
		try {
			condb();
			rs = sta.executeQuery(
					"SELECT DATEDIFF(NOW(), MAX(check_out_date)) AS days_since_last_travel "
					+ "FROM reservation "
					+ "WHERE user_id = '" + id + "' "
					+ "AND check_out_date < CURDATE();");
			while (rs.next()) {
				ndays = rs.getInt("days_since_last_travel");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return ndays;
	}
	
	// 현재날짜 기준 총 숙박일수 추출
	public int totalStay(String id) {
		int tstay = 0;
		try {
			condb();
			rs = sta.executeQuery(
					"SELECT SUM(DATEDIFF(check_out_date, check_in_date)) AS total_stay "
					+ "FROM reservation "
					+ "WHERE user_id = '" + id + "' "
					+ "AND check_out_date < CURDATE();");
			while (rs.next()) {
				tstay = rs.getInt("total_stay");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return tstay;
	}
	
	// 로그인 한 사용자의 누적 마일리지 추출
	public int totalMileage(String id) {
		int mil = 0;
		try {
			condb();
			rs = sta.executeQuery("SELECT total_mileage FROM mileage WHERE user_id = '" + id + "';");
			while (rs.next()) {
				mil = rs.getInt("total_mileage");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return mil;
	}
	
	// 작성한 리뷰 목록 추출
	public ArrayList<MyPageObj> reviewControlPage(String id) {
		ArrayList<MyPageObj> rivConList = new ArrayList<MyPageObj>();
		try {
			condb();
			rs = sta.executeQuery(
					"SELECT r.reservation_id, si.stay_name, si.location, DATE_FORMAT(r.check_in_date, '%Y.%m.%d') AS check_in_date, "
					+ "DATE_FORMAT(r.check_out_date, '%Y.%m.%d') AS check_out_date, DATE_FORMAT(rv.review_time, '%Y.%m.%d') AS review_time " 
					+ "FROM reservation AS r "
					+ "JOIN room_info AS ri ON r.room_id = ri.room_id "
					+ "JOIN stay_info AS si ON ri.stay_id = si.stay_id "
					+ "JOIN review_info AS rv ON r.reservation_id = rv.reservation_id "
					+ "WHERE r.user_id = '" + id + "' AND rv.review_time IS NOT NULL;"
					);
			while(rs.next()) {
				MyPageObj rivCon = new MyPageObj();
				rivCon.setReservation_id(rs.getString("reservation_id"));
				rivCon.setStayName(rs.getString("stay_name"));
				rivCon.setLocation(rs.getString("location"));
				rivCon.setCheckInDate(rs.getString("check_in_date"));
				rivCon.setCheckOutDate(rs.getString("check_out_date"));
				rivCon.setReviewTime(rs.getString("review_time"));
				rivConList.add(rivCon);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return rivConList;
	}
	
	// 리뷰 수정 버튼 클릭시 리뷰 내용 추출
	public ReviewObj reviewReplace(String rid) {
		ReviewObj riv = new ReviewObj();
		try {
			condb();
			rs = sta.executeQuery("SELECT * FROM review_info WHERE reservation_id = " + rid + ";");
			while (rs.next()) {
				riv.setRtitle(rs.getString("review_title"));
				riv.setRcontent(rs.getString("review_content"));
				riv.setRating(rs.getDouble("rating"));
				riv.setImage_path01(rs.getString("image_path01"));
				riv.setImage_path02(rs.getString("image_path02"));
				riv.setImage_path03(rs.getString("image_path03"));
				riv.setImage_path04(rs.getString("image_path04"));
				riv.setImage_path05(rs.getString("image_path05"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
		return riv;
	}
	
	// 리뷰 수정 update
	public void reviewUpdate(ReviewObj obj) {
		try {
			condb();
			sta.executeUpdate("UPDATE review_info SET review_title = '" + obj.getRtitle()
							+ "', review_content = '" + obj.getRcontent()
							+ "', rating = " + obj.getRating()
							+ ", review_time = now(), image_path01 = '" + obj.getImage_path01() + "', image_path02 = '" + obj.getImage_path02()
							+ "', image_path03 = '" + obj.getImage_path03() + "', image_path04 = '" + obj.getImage_path04() + "', image_path05 = '" + obj.getImage_path05()
							+ "' WHERE reservation_id = " + obj.getReservation_id() + ";");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
	}
	
	// 리뷰 삭제
	public void reviewDelete(String rid) {
		try {
			condb();
			sta.executeUpdate("DELETE FROM review_info WHERE reservation_id = " + rid + ";");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
	}
	
	public RoomReserv roomDetail(int rid) {
		RoomReserv rv = new RoomReserv();
		
		try {
			condb();
			rs = sta.executeQuery("SELECT * FROM room_info WHERE room_id = " + rid);
			
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
			discon();
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
			condb();
			sta.executeUpdate(
					"INSERT INTO reservation (user_id, room_id, check_in_date, check_out_date, "
					+ "check_in_time, check_out_time, people, price, payment_time, status) "
					+ "VALUES ('" + uid + "', " + rid + ", '" + chkin + "', '" + chkout + "', '"
					+ chkinTime + "', '" + chkoutTime + "', " + people + ", " + price + ", now(), '예약 대기');");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			discon();
		}
	}
}