package com.sportsfactory.sportforall.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class AlbumReplyDto {

	private int REPLY_CODE;
	private int ALBUM_CODE;
	private int USER_ID;
	private String REPLY;
	private String CREATED_DATE;
	private String DELETED_DATE;
	
	private String USER_NAME;
	private String PROFILE;
	
	public int getREPLY_CODE() {
		return REPLY_CODE;
	}
	public void setREPLY_CODE(int rEPLY_CODE) {
		REPLY_CODE = rEPLY_CODE;
	}
	public int getALBUM_CODE() {
		return ALBUM_CODE;
	}
	public void setALBUM_CODE(int aLBUM_CODE) {
		ALBUM_CODE = aLBUM_CODE;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getREPLY() {
		return REPLY;
	}
	public void setREPLY(String rEPLY) {
		REPLY = rEPLY;
	}
	public String getCREATED_DATE() {
		return CREATED_DATE;
	}
	public void setCREATED_DATE(String cREATED_DATE) {
		CREATED_DATE = cREATED_DATE;
	}
	public String getDELETED_DATE() {
		return DELETED_DATE;
	}
	public void setDELETED_DATE(String dELETED_DATE) {
		DELETED_DATE = dELETED_DATE;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getPROFILE() {
		return PROFILE;
	}
	public void setPROFILE(String pROFILE) {
		PROFILE = pROFILE;
	}
	
}