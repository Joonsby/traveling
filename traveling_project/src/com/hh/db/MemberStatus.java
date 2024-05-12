package com.hh.db;

public class MemberStatus {
	
	// 합산 가격을 통해 멤버십 등급 추출
	public String userGrade(int sum) {
		String grade = null;
		if (sum >= 3000000) { // 결제금액 300만원 이상
			grade = "VIP";
		} else if (sum >= 1000000) { // 100만원 이상
			grade = "GOLD";
		} else {
			grade = "SILVER"; // 기본 등급
		}
		return grade;
	}
	
	// 등급별 적립율 추출
	public int gradePer(String grade) {
		int per = 0;
		if (grade.equals("VIP")) {
			per = 5;
		} else if (grade.equals("GOLD")) {
			per = 3;
		} else {
			per = 1;
		}
		return per;
	}

}