package com.sportsfactory.sportforall.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

public class JsonUtil {
	
	public static JSONObject parse(InputStream in) throws IOException {
		String inputStr;
		BufferedReader br = new BufferedReader(new InputStreamReader(in, "UTF-8")); 
		StringBuilder strb = new StringBuilder();
		
		while ((inputStr = br.readLine()) != null) {
			strb.append(inputStr);	
		}
		
		return new JSONObject(strb.toString());
	}
}
