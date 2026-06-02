package com.traveling.review.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.DataControl;
import com.traveling.review.dao.ReviewManageDAO;

public class ReviewDeleteService implements DataControl{
	static ReviewDeleteService reviewDeleteService = new ReviewDeleteService();
	public static ReviewDeleteService instance() {
		return reviewDeleteService;
	}
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReviewManageDAO reviewManageDAO = ReviewManageDAO.instance();
		reviewManageDAO.reviewDelete(req.getParameter("reservationId"));
	}
}
