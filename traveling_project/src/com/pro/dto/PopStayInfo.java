package com.pro.dto;

public class PopStayInfo {
	int stay_id;
	String stayName,stayAddr,image1,image2,price,reviewContent;

	
	public int getStay_id() {
		return stay_id;
	}

	public void setStay_id(int stay_id) {
		this.stay_id = stay_id;
	}

	public String getStayName() {
		return stayName;
	}

	public void setStayName(String stayName) {
		this.stayName = stayName;
	}

	public String getStayAddr() {
		return stayAddr;
	}

	public void setStayAddr(String stayAddr) {
		this.stayAddr = stayAddr;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
}
