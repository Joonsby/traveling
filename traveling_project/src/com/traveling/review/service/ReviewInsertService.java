package com.traveling.review.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.traveling.common.ControlQuery;
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
		String uploadPath = req.getServletContext().getRealPath("/images/review");
		int size = 10 * 1024 * 1024;
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
			
			reviewInfo.setReservation_id(Integer.parseInt(multi.getParameter("rid")));
			reviewInfo.setRtitle(multi.getParameter("rtitle"));
			reviewInfo.setRcontent(multi.getParameter("rcontent"));
			reviewInfo.setRating(Double.parseDouble(multi.getParameter("rating")));

			// 이미지 업로드
			String[] fieldNames = { "r_image1", "r_image2", "r_image3", "r_image4", "r_image5" };

			for (int i = 0; i < fieldNames.length; i++) {
				String fieldName = fieldNames[i];
				String imageName = multi.getFilesystemName(fieldName);
				System.out.println(imageName);
				switch(i) {
					case 0:
						reviewInfo.setImage_path01(imageName);
						break;
					case 1:
						reviewInfo.setImage_path02(imageName);
						break;
					case 2:
						reviewInfo.setImage_path03(imageName);
						break;
					case 3:
						reviewInfo.setImage_path04(imageName);
						break;
					case 4:
						reviewInfo.setImage_path05(imageName);
						break;
				}
			}
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
