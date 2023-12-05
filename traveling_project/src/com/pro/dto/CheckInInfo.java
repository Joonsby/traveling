package com.pro.dto;

public class CheckInInfo {
	int reservationId, roomId, people, price;
	String roomName, hostId, userName, checkInDate, checkOutDate, checkInTime, checkOutTime, paymentTime, status;

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public int getReservationId() {
		return reservationId;
	}

	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public int getPeople() {
		return people;
	}

	public void setPeople(int people) {
		this.people = people;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}

	public String getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(String checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public String getCheckInTime() {
		return checkInTime;
	}

	public void setCheckInTime(String checkInTime) {
		this.checkInTime = checkInTime;
	}

	public String getCheckOutTime() {
		return checkOutTime;
	}

	public void setCheckOutTime(String checkOutTime) {
		this.checkOutTime = checkOutTime;
	}

	public String getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
