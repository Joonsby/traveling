<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.Enumeration"%>
<jsp:useBean id="db" class="com.hh.db.ControlDB" />
<jsp:useBean id="obj" class="com.hh.db.ReviewObj" />
<%
	request.setCharacterEncoding("UTF-8");

	String uploadPath = request.getRealPath("/images/review");
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
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8",
				new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();

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
				obj.setImage_path01(imageName);
			} else if (i == 1) {
				obj.setImage_path02(imageName);
			} else if (i == 2) {
				obj.setImage_path03(imageName);
			} else if (i == 3) {
				obj.setImage_path04(imageName);
			} else if (i == 4) {
				obj.setImage_path05(imageName);
			}
		}

		obj.setReservation_id(rid);
		obj.setRtitle(rtitle);
		obj.setRcontent(rcontent);
		obj.setRating(rating);

	} catch (Exception e) {
		e.printStackTrace();
	}

	db.insertReview(obj);
	response.sendRedirect("my_info.jsp");
%>