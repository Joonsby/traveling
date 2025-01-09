package com.traveling.common;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ParsingCommon {
	public static final Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
}
