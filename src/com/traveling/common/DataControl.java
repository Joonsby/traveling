package com.traveling.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface DataControl {
	void dataCon(HttpServletRequest req, HttpServletResponse res) throws Exception;
}
