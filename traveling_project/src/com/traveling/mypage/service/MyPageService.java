package com.traveling.mypage.service;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.traveling.common.ControlQuery;
import com.traveling.mypage.dao.MyPageManageDAO;
import com.traveling.mypage.dto.MyPageInfo;

public class MyPageService implements ControlQuery {
	static MyPageService mypageService = new MyPageService();
	public static MyPageService instance() {
		return mypageService;
	}
	
	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("id");
		MyPageManageDAO myPageManageDAO = MyPageManageDAO.instance();
		List<MyPageInfo> reservationList = myPageManageDAO.getUserReservationInfo(userId);
		List<Integer> reviewList = myPageManageDAO.hasReview(userId);
		
		req.setAttribute("reservationList", reservationList);
		req.setAttribute("reviewList", reviewList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/webPage/login/my_info.jsp");
		dispatcher.forward(req, res);
	}
	
}
