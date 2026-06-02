package com.traveling.common;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ParsingCommon {
	public static final Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
	
    public static void writeJson(HttpServletResponse res, Object data) throws IOException {
        res.setContentType("application/json; charset=UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(gson.toJson(data));
    }
}