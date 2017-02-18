package com.sportsfactory.sportforall.dto;

public class HomeAlarmDto {
	private int ALARM_ID;
	private int BOARD_TYPE;
	private int BOARD_ID;
	private int SUB_TYPE;
	private int USER_ID;
	private int WRITE_USER;
	private String WRITE_DATE;
	private String FORMATTED_WRITE_DATE;
	private String WRITE_TIME;
	private String FORMATTED_WRITE_TIME;
	private int CLUB_CODE;
	private int IS_READ;
	private int FED_CODE;
	
	private String CLUB_NAME;
	private String FED_NAME;
	private int CATEGORY_CODE;
	private String NAME;
	private String USER_NAME;
	private int USER_LEVEL;
	
	private int PAGE;
	private int ALARM_COUNT;
	
	public int getALARM_ID() {
		return ALARM_ID;
	}
	public void setALARM_ID(int aLARM_ID) {
		ALARM_ID = aLARM_ID;
	}
	public int getBOARD_TYPE() {
		return BOARD_TYPE;
	}
	public void setBOARD_TYPE(int bOARD_TYPE) {
		BOARD_TYPE = bOARD_TYPE;
	}
	public int getBOARD_ID() {
		return BOARD_ID;
	}
	public void setBOARD_ID(int bOARD_ID) {
		BOARD_ID = bOARD_ID;
	}
	public int getSUB_TYPE() {
		return SUB_TYPE;
	}
	public void setSUB_TYPE(int sUB_TYPE) {
		SUB_TYPE = sUB_TYPE;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public int getWRITE_USER() {
		return WRITE_USER;
	}
	public void setWRITE_USER(int wRITE_USER) {
		WRITE_USER = wRITE_USER;
	}
	public String getWRITE_DATE() {
		return WRITE_DATE;
	}
	public void setWRITE_DATE(String wRITE_DATE) {
		WRITE_DATE = wRITE_DATE;
	}
	public String getFORMATTED_WRITE_DATE() {
		return FORMATTED_WRITE_DATE;
	}
	public void setFORMATTED_WRITE_DATE(String fORMATTED_WRITE_DATE) {
		FORMATTED_WRITE_DATE = fORMATTED_WRITE_DATE;
	}
	public String getWRITE_TIME() {
		return WRITE_TIME;
	}
	public String getFORMATTED_WRITE_TIME() {
		return FORMATTED_WRITE_TIME;
	}
	public void setFORMATTED_WRITE_TIME(String fORMATTED_WRITE_TIME) {
		FORMATTED_WRITE_TIME = fORMATTED_WRITE_TIME;
	}
	public void setWRITE_TIME(String wRITE_TIME) {
		WRITE_TIME = wRITE_TIME;
	}
	public int getCLUB_CODE() {
		return CLUB_CODE;
	}
	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
	}
	public int getIS_READ() {
		return IS_READ;
	}
	public void setIS_READ(int iS_READ) {
		IS_READ = iS_READ;
	}
	
	public String getCLUB_NAME() {
		return CLUB_NAME;
	}
	public void setCLUB_NAME(String cLUB_NAME) {
		CLUB_NAME = cLUB_NAME;
	}
	public int getCATEGORY_CODE() {
		return CATEGORY_CODE;
	}
	public void setCATEGORY_CODE(int cATEGORY_CODE) {
		CATEGORY_CODE = cATEGORY_CODE;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public int getUSER_LEVEL() {
		return USER_LEVEL;
	}
	public void setUSER_LEVEL(int uSER_LEVEL) {
		USER_LEVEL = uSER_LEVEL;
	}
	
	public int getPAGE() {
		return PAGE;
	}
	public void setPAGE(int pAGE) {
		PAGE = pAGE;
	}
	public int getALARM_COUNT() {
		return ALARM_COUNT;
	}
	public void setALARM_COUNT(int aLARM_COUNT) {
		ALARM_COUNT = aLARM_COUNT;
	}
	
	public int getFED_CODE() {
		return FED_CODE;
	}
	public void setFED_CODE(int fED_CODE) {
		FED_CODE = fED_CODE;
	}
	public String getFED_NAME() {
		return FED_NAME;
	}
	public void setFED_NAME(String fED_NAME) {
		FED_NAME = fED_NAME;
	}
}
