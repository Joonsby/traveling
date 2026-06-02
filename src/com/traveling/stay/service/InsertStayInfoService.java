package com.traveling.stay.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.traveling.common.DataControl;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class InsertStayInfoService implements DataControl  {
	
	static InsertStayInfoService insertStayInfoService = new InsertStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static InsertStayInfoService instance() {
		return insertStayInfoService;
	}

	@Override
	public void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		StayInfo stayInfo = new StayInfo();
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String hostId = (String) session.getAttribute("host_id");
		String uploadPath = req.getRealPath("/images/stay_images");
		int size = 10 * 1024 * 1024;
		String stayName = "";
		String latitude = "";
		String longitude = "";
		String postCode = "";
		String roadAddr = "";
		String jibunAddr = "";
		String detailAddr = "";
		String referenceAddr = "";
		String hostPhone = "";
		String content = "";

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
			stayName = multi.getParameter("stay_name");
			latitude = multi.getParameter("latitude");
			longitude = multi.getParameter("longitude");
			postCode = multi.getParameter("post_code");
			roadAddr = multi.getParameter("road_addr");
			jibunAddr = multi.getParameter("jibun_addr");
			detailAddr = multi.getParameter("detail_addr");
			referenceAddr = multi.getParameter("reference_addr");
			hostPhone = multi.getParameter("host_phone");
			content = multi.getParameter("content");
			imagename1 = multi.getParameter("image1");
			imagename2 = multi.getParameter("image2");
			imagename3 = multi.getParameter("image3");
			imagename4 = multi.getParameter("image4");
			imagename5 = multi.getParameter("image5");

			// 이미지 업로드
			String[] fieldNames = { "image1", "image2", "image3", "image4", "image5" };

			for (int i = 0; i < fieldNames.length; i++) {
				String fieldName = fieldNames[i];
				String imageName = multi.getFilesystemName(fieldName);

				// 이미지를 stayInfo 객체에 설정
				switch (i) {
				case 0 :
					stayInfo.setImage1(imageName);
					break;
				case 1 :
					stayInfo.setImage2(imageName);
					break;
				case 2 :
					stayInfo.setImage3(imageName);
					break;
				case 3 :
					stayInfo.setImage4(imageName);
					break;
				case 4 :
					stayInfo.setImage5(imageName);
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		res.setCharacterEncoding("UTF-8");
		stayInfo.setHost_id(hostId);
		stayInfo.setStay_name(stayName);
		stayInfo.setLatitude(latitude);
		stayInfo.setLongitude(longitude);
		stayInfo.setPost_code(postCode);
		stayInfo.setRoad_addr(roadAddr);
		stayInfo.setJibun_addr(jibunAddr);
		stayInfo.setDetail_addr(detailAddr);
		stayInfo.setReference_addr(referenceAddr);
		stayInfo.setHost_phone(hostPhone);
		stayInfo.setContent(content);
		
		stayManagementDAO.stayInsert(stayInfo);
		res.sendRedirect("webPage/stay/add_stay_result.jsp");
	}

}
