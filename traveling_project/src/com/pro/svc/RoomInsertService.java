package com.pro.svc;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pro.controller.ControlQuery;
import com.pro.dao.StayManagementDAO;
import com.pro.dto.RoomInfo;

public class RoomInsertService implements ControlQuery {
	static RoomInsertService roomIns = new RoomInsertService();

	public static RoomInsertService instance() {
		return roomIns;
	}

	@Override
	public String dataCon(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		// TODO Auto-generated method stub
		rs.setCharacterEncoding("UTF-8");
		HttpSession session = rq.getSession();
		String hostId = (String) session.getAttribute("host_id");		
		String uploadPath = rq.getRealPath("/images/room_images");
		int size = 10 * 1024 * 1024;		
		String roomName = "";
		String content = "";
		String checkInTime = "";
		String checkOutTime = "";
		int price = 0;
		int stdPeople = 0;
		int maxPeople = 0;
		String imagename1 = "";
		String imagename2 = "";
		String imagename3 = "";
		String imagename4 = "";
		String imagename5 = "";
		String imagename6 = "";
		String imagename7 = "";
		String imagename8 = "";
		String imagename9 = "";
		String imagename10 = "";
		String origimagename1 = "";
		String origimagename2 = "";
		String origimagename3 = "";
		String origimagename4 = "";
		String origimagename5 = "";
		String origimagename6 = "";
		String origimagename7 = "";
		String origimagename8 = "";
		String origimagename9 = "";
		String origimagename10 = "";
		try {
			MultipartRequest multi = new MultipartRequest(rq, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			roomName = multi.getParameter("room_name");
			content = multi.getParameter("content");
			checkInTime = multi.getParameter("check_in_time");
			checkOutTime = multi.getParameter("check_out_time");
			price = Integer.parseInt(multi.getParameter("price"));			
			stdPeople = Integer.parseInt(multi.getParameter("std_people"));
			maxPeople = Integer.parseInt(multi.getParameter("max_people"));			
			imagename1 = multi.getParameter("image1");
			imagename2 = multi.getParameter("image2");
			imagename3 = multi.getParameter("image3");
			imagename4 = multi.getParameter("image4");
			imagename5 = multi.getParameter("image5");
			imagename6 = multi.getParameter("image6");
			imagename7 = multi.getParameter("image7");
			imagename8 = multi.getParameter("image8");
			imagename9 = multi.getParameter("image9");
			imagename10 = multi.getParameter("image10");

			// 이미지 업로드
			String image1 = (String) files.nextElement();
			imagename1 = multi.getFilesystemName(image1);
			origimagename1 = multi.getOriginalFileName(image1);

			String image2 = (String) files.nextElement();
			imagename2 = multi.getFilesystemName(image2);
			origimagename2 = multi.getOriginalFileName(image2);

			String image3 = (String) files.nextElement();
			imagename3 = multi.getFilesystemName(image3);
			origimagename3 = multi.getOriginalFileName(image3);

			String image4 = (String) files.nextElement();
			imagename4 = multi.getFilesystemName(image4);
			origimagename4 = multi.getOriginalFileName(image4);

			String image5 = (String) files.nextElement();
			imagename5 = multi.getFilesystemName(image5);
			origimagename5 = multi.getOriginalFileName(image5);

			String image6 = (String) files.nextElement();
			imagename6 = multi.getFilesystemName(image6);
			origimagename6 = multi.getOriginalFileName(image6);

			String image7 = (String) files.nextElement();
			imagename7 = multi.getFilesystemName(image7);
			origimagename7 = multi.getOriginalFileName(image7);

			String image8 = (String) files.nextElement();
			imagename8 = multi.getFilesystemName(image8);
			origimagename8 = multi.getOriginalFileName(image8);

			String image9 = (String) files.nextElement();
			imagename9 = multi.getFilesystemName(image9);
			origimagename9 = multi.getOriginalFileName(image9);

			String image10 = (String) files.nextElement();
			imagename10 = multi.getFilesystemName(image10);
			origimagename10 = multi.getOriginalFileName(image10);
			
			StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
			CountStayIdService stayIdSel = new CountStayIdService();
			int stayId = stayIdSel.selStayId(hostId);
			
			RoomInfo roomInfo = new RoomInfo();			
			roomInfo.setStayId(stayId);
			roomInfo.setRoomName(roomName);
			roomInfo.setContent(content);			
			roomInfo.setCheckInTime(checkInTime);
			roomInfo.setCheckOutTime(checkOutTime);
			roomInfo.setPrice(price);
			roomInfo.setStdPeople(stdPeople);
			roomInfo.setMaxPeople(maxPeople);
			roomInfo.setImage1(imagename1);
			roomInfo.setImage2(imagename2);
			roomInfo.setImage3(imagename3);
			roomInfo.setImage4(imagename4);
			roomInfo.setImage5(imagename5);
			roomInfo.setImage6(imagename6);
			roomInfo.setImage7(imagename7);
			roomInfo.setImage8(imagename8);
			roomInfo.setImage9(imagename9);
			roomInfo.setImage10(imagename10);
			
			stayManagementDAO.roomInsert(roomInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
