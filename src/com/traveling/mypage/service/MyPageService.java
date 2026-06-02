package com.traveling.mypage.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// import com.google.gson.Gson; // unused
import com.traveling.common.DataControl;
import com.traveling.common.LayoutForward;
import com.traveling.mypage.dao.MyPageManageDAO;
import com.traveling.mypage.dto.MyPageInfo;

public class MyPageService implements DataControl {
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
		String[] cssList = new String[] {
			"/css/login/member.css",
			"/css/login/my_info.css",
			"/css/review/review_modal.css"
		};
		String[] jsList = new String[] {
			"/js/review/review_modal.js",
			"/js/user/my_info.js"
		};
		LayoutForward.user(req, res, "내 정보", "/webPage/login/my_info.jsp", cssList, jsList);
	}
	
}
