package com.traveling.room.service;

import com.traveling.stay.dao.StayManagementDAO;

public class CountStayIdService{
	
	public int selStayId(String hostId) throws Exception {
		StayManagementDAO stayManagementDAO = StayManagementDAO.instance();
		int stayId = stayManagementDAO.countStayId(hostId);
		return stayId;
	}
}
