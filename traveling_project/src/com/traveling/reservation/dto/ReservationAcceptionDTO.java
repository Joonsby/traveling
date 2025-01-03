package com.traveling.reservation.dto;

public class ReservationAcceptionDTO {
	private int reservation_id, price;
	private String name, room_name, check_in_date, check_out_date, check_in_time, check_out_time,
	people, payment_time, status;
	public int getReservation_id() {
		return reservation_id;
	}
	public void setReservation_id(int reservation_id) {
		this.reservation_id = reservation_id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getCheck_in_date() {
		return check_in_date;
	}
	public void setCheck_in_date(String check_in_date) {
		this.check_in_date = check_in_date;
	}
	public String getCheck_out_date() {
		return check_out_date;
	}
	public void setCheck_out_date(String check_out_date) {
		this.check_out_date = check_out_date;
	}
	public String getCheck_in_time() {
		return check_in_time;
	}
	public void setCheck_in_time(String check_in_time) {
		this.check_in_time = check_in_time;
	}
	public String getCheck_out_time() {
		return check_out_time;
	}
	public void setCheck_out_time(String check_out_time) {
		this.check_out_time = check_out_time;
	}
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public String getPayment_time() {
		return payment_time;
	}
	public void setPayment_time(String payment_time) {
		this.payment_time = payment_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
