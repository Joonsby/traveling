package com.traveling.review.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.traveling.common.ControlQuery;
import com.traveling.review.dao.ReviewManageDAO;

public class ReviewDeleteService implements ControlQuery{
	static ReviewDeleteService reviewDeleteService = new ReviewDeleteService();
	public static ReviewDeleteService instance() {
		return reviewDeleteService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ReviewManageDAO reviewManageDAO = ReviewManageDAO.instance();
		reviewManageDAO.reviewDelete(req.getParameter("reservationId"));
		return null;
	}
}
