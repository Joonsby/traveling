package com.pro.plan.dto;

public class DetailPlan {
	private int plan_id;
	private String plan_date, plan_start_time, plan_end_time, plan_content, check_in_date;

	public int getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getPlan_start_time() {
		return plan_start_time;
	}

	public void setPlan_start_time(String plan_start_time) {
		this.plan_start_time = plan_start_time;
	}

	public String getPlan_end_time() {
		return plan_end_time;
	}

	public void setPlan_end_time(String plan_end_time) {
		this.plan_end_time = plan_end_time;
	}

	public String getPlan_content() {
		return plan_content;
	}

	public void setPlan_content(String plan_content) {
		this.plan_content = plan_content;
	}

	public String getCheck_in_date() {
		return check_in_date;
	}

	public void setCheck_in_date(String check_in_date) {
		this.check_in_date = check_in_date;
	}

}
