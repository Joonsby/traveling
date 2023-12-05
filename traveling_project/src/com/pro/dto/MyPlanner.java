package com.pro.dto;

public class MyPlanner {
	// 내 일정 페이지에 출력할 값
	private String plan_id, user_id, stay_name, location, check_in_date, check_out_date, modified_date, days_count;

	public String getStay_name() {
		return stay_name;
	}

	public void setStay_name(String stay_name) {
		this.stay_name = stay_name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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

	public String getModified_date() {
		return modified_date;
	}

	public void setModified_date(String modified_date) {
		this.modified_date = modified_date;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(String plan_id) {
		this.plan_id = plan_id;
	}

	public String getDays_count() {
		return days_count;
	}

	public void setDays_count(String days_count) {
		this.days_count = days_count;
	}

}