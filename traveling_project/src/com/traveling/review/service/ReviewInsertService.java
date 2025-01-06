package com.traveling.review.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.traveling.controller.ControlQuery;
import com.traveling.review.dao.ReviewManageDAO;
import com.traveling.review.dto.ReviewInfo;

public class ReviewInsertService implements ControlQuery{
	static ReviewInsertService reviewInsertService = new ReviewInsertService(); // 싱글톤 방식으로 객체 생성
	public static ReviewInsertService instance() {
		return reviewInsertService;
	}
	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		String uploadPath = req.getRealPath("/images/review");
		int size = 10 * 1024 * 1024;
		
		// 리뷰 정보
		int rid = 0;
		String rtitle = "";
		String rcontent = "";
		double rating = 0;
		
		// 이미지
		String imagename1 = "";
		String imagename2 = "";
		String imagename3 = "";
		String imagename4 = "";
		String imagename5 = "";
		String origimagename1 = "";
		String origimagename2 = "";
		String origimagename3 = "";
		String origimagename4 = "";
		String origimagename5 = "";
		
		try {
			MultipartRequest multi = new MultipartRequest(req, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			ReviewInfo reviewInfo = new ReviewInfo();
			ReviewManageDAO reviewManageDAO = ReviewManageDAO.instance();
			
			rid = Integer.parseInt(multi.getParameter("rid"));
			rtitle = multi.getParameter("rtitle");
			rcontent = multi.getParameter("rcontent");
			rating = Double.parseDouble(multi.getParameter("rating"));

			imagename1 = multi.getParameter("r_image1");
			imagename2 = multi.getParameter("r_image2");
			imagename3 = multi.getParameter("r_image3");
			imagename4 = multi.getParameter("r_image4");
			imagename5 = multi.getParameter("r_image5");

			// 이미지 업로드
			String[] fieldNames = { "r_image1", "r_image2", "r_image3", "r_image4", "r_image5" };

			for (int i = 0; i < fieldNames.length; i++) {
				String fieldName = fieldNames[i];
				String imageName = multi.getFilesystemName(fieldName);

				if (i == 0) {
					reviewInfo.setImage_path01(imageName);
				} else if (i == 1) {
					reviewInfo.setImage_path02(imageName);
				} else if (i == 2) {
					reviewInfo.setImage_path03(imageName);
				} else if (i == 3) {
					reviewInfo.setImage_path04(imageName);
				} else if (i == 4) {
					reviewInfo.setImage_path05(imageName);
				}
			}
			reviewInfo.setReservation_id(rid);
			reviewInfo.setRtitle(rtitle);
			reviewInfo.setRcontent(rcontent);
			reviewInfo.setRating(rating);
			int cnt = reviewManageDAO.insertReviewInfo(reviewInfo);
			if(cnt > 0) {
				res.sendRedirect("/webPage/login/my_info.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
