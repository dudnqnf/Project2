package com.sportsfactory.sportforall.dto;

public class BoardZzimDto {
	private int ZZIM_ID;
	private int BOARD_ID;
	private int BOARD_TYPE;
	private int WRITE_USER;
	private String WRITE_DATE;
	private String FORMATED_WRITE_DATE;
	private String WRITE_TIME;
	private String FORMATED_WRITE_TIME;
	private int IS_DELETED;
	private int DELETE_USER;
	private String DELETE_DATE;
	private String DELETE_TIME;
	
	private int IS_ZZIM;
	
	String DATETIME;
	public String getDATETIME(){
		return getWRITE_DATE() +" "+ getWRITE_TIME();
	}
	
	public int getZZIM_ID() {
		return ZZIM_ID;
	}
	public void setZZIM_ID(int zZIM_ID) {
		ZZIM_ID = zZIM_ID;
	}
	public int getBOARD_ID() {
		return BOARD_ID;
	}
	public void setBOARD_ID(int bOARD_ID) {
		BOARD_ID = bOARD_ID;
	}
	public int getBOARD_TYPE() {
		return BOARD_TYPE;
	}
	public void setBOARD_TYPE(int bOARD_TYPE) {
		BOARD_TYPE = bOARD_TYPE;
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
	public String getFORMATED_WRITE_DATE() {
		return FORMATED_WRITE_DATE;
	}
	public void setFORMATED_WRITE_DATE(String fORMATED_WRITE_DATE) {
		FORMATED_WRITE_DATE = fORMATED_WRITE_DATE;
	}
	public String getWRITE_TIME() {
		return WRITE_TIME;
	}
	public void setWRITE_TIME(String wRITE_TIME) {
		WRITE_TIME = wRITE_TIME;
	}
	public String getFORMATED_WRITE_TIME() {
		return FORMATED_WRITE_TIME;
	}
	public void setFORMATED_WRITE_TIME(String fORMATED_WRITE_TIME) {
		FORMATED_WRITE_TIME = fORMATED_WRITE_TIME;
	}
	public int getIS_DELETED() {
		return IS_DELETED;
	}
	public void setIS_DELETED(int iS_DELETED) {
		IS_DELETED = iS_DELETED;
	}
	public int getDELETE_USER() {
		return DELETE_USER;
	}
	public void setDELETE_USER(int dELETE_USER) {
		DELETE_USER = dELETE_USER;
	}
	public String getDELETE_DATE() {
		return DELETE_DATE;
	}
	public void setDELETE_DATE(String dELETE_DATE) {
		DELETE_DATE = dELETE_DATE;
	}
	public String getDELETE_TIME() {
		return DELETE_TIME;
	}
	public void setDELETE_TIME(String dELETE_TIME) {
		DELETE_TIME = dELETE_TIME;
	}

	public int getIS_ZZIM() {
		return IS_ZZIM;
	}
	public void setIS_ZZIM(int iS_ZZIM) {
		IS_ZZIM = iS_ZZIM;
	}
	
}
