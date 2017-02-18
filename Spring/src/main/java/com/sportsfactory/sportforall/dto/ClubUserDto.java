package com.sportsfactory.sportforall.dto;

import java.sql.Timestamp;

public class ClubUserDto {

	//club_user 테이블
	private int CLUB_CODE;
	private int USER_ID;
	private int USER_LEVEL;
	private int IS_DELETED;
	private int AGREE_DELETE;
	private String CREATED_DATE;
	private int POINT;
	
	//user_info 테이블
	private String USER_NAME;
	private String PROFILE;
	private String EMAIL;
	private String SI;
	private String GU;
	
	private String KEYWORD;
	private int FED_CODE;
	
	public int getCLUB_CODE() {
		return CLUB_CODE;
	}
	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public int getUSER_LEVEL() {
		return USER_LEVEL;
	}
	public void setUSER_LEVEL(int uSER_LEVEL) {
		USER_LEVEL = uSER_LEVEL;
	}
	public int getIS_DELETED() {
		return IS_DELETED;
	}
	public void setIS_DELETED(int iS_DELETED) {
		IS_DELETED = iS_DELETED;
	}
	public int getAGREE_DELETE() {
		return AGREE_DELETE;
	}
	public void setAGREE_DELETE(int aGREE_DELETE) {
		AGREE_DELETE = aGREE_DELETE;
	}
	public String getCREATED_DATE() {
		return CREATED_DATE;
	}
	public void setCREATED_DATE(String cREATED_DATE) {
		CREATED_DATE = cREATED_DATE;
	}
	public int getPOINT() {
		return POINT;
	}
	public void setPOINT(int pOINT) {
		POINT = pOINT;
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
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public String getSI() {
		return SI;
	}
	public void setSI(String sI) {
		SI = sI;
	}
	public String getGU() {
		return GU;
	}
	public void setGU(String gU) {
		GU = gU;
	}
	
	public String getKEYWORD() {
		return KEYWORD;
	}
	public void setKEYWORD(String kEYWORD) {
		KEYWORD = kEYWORD;
	}
	public int getFED_CODE() {
		return FED_CODE;
	}
	public void setFED_CODE(int fED_CODE) {
		FED_CODE = fED_CODE;
	}
	
}