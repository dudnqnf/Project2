package com.sportsfactory.sportforall.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommonUtil {
	
	public static int isBoxChecked(String c){
		if(c=="on")
			return 1;
		else
			return 0;
	}
	
	public static boolean checkUserCookie(HttpServletRequest request, HttpServletResponse response){
		
		String user_id = null;
		Cookie[] cookie = request.getCookies();
		for(int i=0;i<cookie.length;i++){
			if(cookie[i].getName().equalsIgnoreCase("user_id"))
				user_id=cookie[i].getValue();
		}
		
		if(user_id==null)
			return false;
		else
			return true;
	}
	
	public static String getRandomString(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
	
	public static String dateForm(String year, String month) throws ParseException{
		
		month = String.format("%02d", Integer.parseInt(month)); 
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sql_format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date parse_date = format.parse(year+month+"01000000");
		String date = sql_format.format(parse_date);
		
		return date;
	}
	
	public static String nextMonthForm(String year, String month) throws ParseException{
		
		month = String.format("%02d", Integer.parseInt(month)); 
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sql_format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date parse_date = format.parse(year+month+"01000000");
		Calendar cal  = Calendar.getInstance();
		cal.setTime(parse_date);
		cal.add(Calendar.MONTH, 1);
		parse_date = cal.getTime();
		String date = sql_format.format(parse_date);
		
		return date;
	}
		
}
