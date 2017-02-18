package com.sportsfactory.sportforall.dto;

public class ClubUserFeeDto {
	private int USER_FEE_CODE;
	private int CLUB_CODE;
	private int USER_ID;
	private int FEE;
	private int YEAR;
	private int MONTH;
	private String CREATED_DATE;
	private String DELETED_DATE;
	
	private String USER_NAME;
	private String PROFILE;
	
	
	public int getCLUB_CODE() {
		return CLUB_CODE;
	}
	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
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
	public int getUSER_FEE_CODE() {
		return USER_FEE_CODE;
	}
	public void setUSER_FEE_CODE(int uSER_FEE_CODE) {
		USER_FEE_CODE = uSER_FEE_CODE;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public int getFEE() {
		return FEE;
	}
	public void setFEE(int fEE) {
		FEE = fEE;
	}
	public int getYEAR() {
		return YEAR;
	}
	public void setYEAR(int yEAR) {
		YEAR = yEAR;
	}
	public int getMONTH() {
		return MONTH;
	}
	public void setMONTH(int mONTH) {
		MONTH = mONTH;
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
	
	
}
