package com.pro.dto;

import java.util.List;

public class FilterStayInfo {		
	String stay_name, road_addr, image1, parking;
	int stay_id, min_room_price, rating_count;
	double avg_rating, rating, latitude, longitude;
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getStay_name() {
		return stay_name;
	}
	public void setStay_name(String stay_name) {
		this.stay_name = stay_name;
	}
	public String getRoad_addr() {
		return road_addr;
	}
	public void setRoad_addr(String road_addr) {
		this.road_addr = road_addr;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public int getStay_id() {
		return stay_id;
	}
	public void setStay_id(int stay_id) {
		this.stay_id = stay_id;
	}
	public int getMin_room_price() {
		return min_room_price;
	}
	public void setMin_room_price(int min_room_price) {
		this.min_room_price = min_room_price;
	}
	public int getRating_count() {
		return rating_count;
	}
	public void setRating_count(int rating_count) {
		this.rating_count = rating_count;
	}
	public double getAvg_rating() {
		return avg_rating;
	}
	public void setAvg_rating(double avg_rating) {
		this.avg_rating = avg_rating;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	
}
