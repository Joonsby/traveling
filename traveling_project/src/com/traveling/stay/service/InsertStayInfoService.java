package com.traveling.stay.service;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.traveling.controller.ControlQuery;
import com.traveling.stay.dao.StayManagementDAO;
import com.traveling.stay.dto.StayInfo;

public class InsertStayInfoService implements ControlQuery  {
	
	static InsertStayInfoService insertStayInfoService = new InsertStayInfoService(); // 싱글톤 방식으로 객체 생성
	public static InsertStayInfoService instance() {
		return insertStayInfoService;
	}

	@Override
	public String dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		StayInfo stayInfo = new StayInfo();
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		String hostId = (String) session.getAttribute("host_id");
		String uploadPath = req.getRealPath("/images//stay_images");
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

		// 편의 시설
		String tub = "";
		String bathSupplies = "";
		String hairDryer = "";
		String towel = "";
		String bedding = "";
		String washingMachine = "";
		String dryingMachine = "";
		String pool = "";
		String arcadeGame = "";
		String gym = "";
		String tv = "";
		String boardGame = "";
		String airConditioner = "";
		String fan = "";
		String heatingSystem = "";
		String carbonMonoxideAlarm = "";
		String fireExtinguisher = "";
		String aidKit = "";
		String fireAlarm = "";
		String workspace = "";
		String wirelessInternet = "";
		String barbecueTool = "";
		String basicCookware = "";
		String diningTable = "";
		String cutlery = "";
		String refrigerator = "";
		String microwave = "";
		String electricRiceCooker = "";
		String gasStoveOrInduction = "";
		String electricVehicleChargingFacilities = "";
		String parkingLot = "";
		String breakfast = "";
		String cleanService = "";
		String luggageStorage = "";

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
			tub = multi.getParameter("tub");
			bathSupplies = multi.getParameter("bath_supplies");
			hairDryer = multi.getParameter("hair_dryer");
			towel = multi.getParameter("towel");
			bedding = multi.getParameter("bedding");
			washingMachine = multi.getParameter("washing_machine");
			dryingMachine = multi.getParameter("drying_machine");
			pool = multi.getParameter("pool");
			arcadeGame = multi.getParameter("arcade_game");
			gym = multi.getParameter("gym");
			tv = multi.getParameter("tv");
			boardGame = multi.getParameter("board_game");
			airConditioner = multi.getParameter("air_conditioner");
			fan = multi.getParameter("fan");
			heatingSystem = multi.getParameter("heating_system");
			carbonMonoxideAlarm = multi.getParameter("carbon_monoxide");
			fireExtinguisher = multi.getParameter("fire_extinguisher");
			aidKit = multi.getParameter("aid_kit");
			fireAlarm = multi.getParameter("fire_alarm");
			workspace = multi.getParameter("workspace");
			wirelessInternet = multi.getParameter("wireless_internet");
			barbecueTool = multi.getParameter("barbecue_tool");
			basicCookware = multi.getParameter("basic_cookware");
			diningTable = multi.getParameter("dining_table");
			cutlery = multi.getParameter("cutlery");
			refrigerator = multi.getParameter("refrigerator");
			microwave = multi.getParameter("microwave");
			electricRiceCooker = multi.getParameter("electric_rice_cooker");
			gasStoveOrInduction = multi.getParameter("gas_stove_or_induction");
			electricVehicleChargingFacilities = multi.getParameter("electric_vehicle_charging_facilities");
			parkingLot = multi.getParameter("parking_lot");
			breakfast = multi.getParameter("breakfast");
			cleanService = multi.getParameter("clean_service");
			luggageStorage = multi.getParameter("luggage_storage");

			// 이미지 업로드
			String[] fieldNames = { "image1", "image2", "image3", "image4", "image5" };

			for (int i = 0; i < fieldNames.length; i++) {
				String fieldName = fieldNames[i];
				String imageName = multi.getFilesystemName(fieldName);

				// 이미지를 stayInfo 객체에 설정
				if (i == 0) {
					stayInfo.setImage1(imageName);
				} else if (i == 1) {
					stayInfo.setImage2(imageName);
				} else if (i == 2) {
					stayInfo.setImage3(imageName);
				} else if (i == 3) {
					stayInfo.setImage4(imageName);
				} else if (i == 4) {
					stayInfo.setImage5(imageName);
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

		// 편의 시설
		stayInfo.setTub(tub);
		stayInfo.setBath_supplies(bathSupplies);
		stayInfo.setHair_dryer(hairDryer);
		stayInfo.setTowel(towel);
		stayInfo.setBedding(bedding);
		stayInfo.setWashing_machine(washingMachine);
		stayInfo.setDrying_machine(dryingMachine);
		stayInfo.setPool(pool);
		stayInfo.setArcade_game(arcadeGame);
		stayInfo.setGym(gym);
		stayInfo.setTv(tv);
		stayInfo.setBoard_game(boardGame);
		stayInfo.setAir_conditioner(airConditioner);
		stayInfo.setFan(fan);
		stayInfo.setHeating_system(heatingSystem);
		stayInfo.setCarbon_monoxide_alarm(carbonMonoxideAlarm);
		stayInfo.setFire_extinguisher(fireExtinguisher);
		stayInfo.setAid_kit(aidKit);
		stayInfo.setFire_alarm(fireAlarm);
		stayInfo.setWorkspace(workspace);
		stayInfo.setWireless_internet(wirelessInternet);
		stayInfo.setBarbecue_tool(barbecueTool);
		stayInfo.setBasic_cookware(basicCookware);
		stayInfo.setDining_table(diningTable);
		stayInfo.setCutlery(cutlery);
		stayInfo.setRefrigerator(refrigerator);
		stayInfo.setMicrowave(microwave);
		stayInfo.setElectric_rice_cooker(electricRiceCooker);
		stayInfo.setGas_stove_or_induction(gasStoveOrInduction);
		stayInfo.setElectric_vehicle_charging_facilities(electricVehicleChargingFacilities);
		stayInfo.setParking_lot(parkingLot);
		stayInfo.setContent(content);
		stayInfo.setBreakfast(breakfast);
		stayInfo.setClean_service(cleanService);
		stayInfo.setLuggage_storage(luggageStorage);
		
		stayManagementDAO.stayInsert(stayInfo);
		res.sendRedirect("webPage/stay/add_stay_result.jsp");
		return null;
	}

}
