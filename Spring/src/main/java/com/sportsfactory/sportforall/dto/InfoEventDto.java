package com.sportsfactory.sportforall.dto;

import java.sql.Timestamp;

public class InfoEventDto {
	private int EVENT_CODE;
	private String EVENT_NAME;
	private String HOME_PIC;
	private String FRONT_PIC;
	private String MAIN_PIC;
	private String UPLOAD_DATE;
	
	private int PAGE;
	private String KEYWORD;
	private int WRITE_USER;
	private int IS_ZZIMED;

	private int EL_CODE;
	private String HREF;
	private double TOP_P;
	private double LEFT_P;
	private double WIDTH_S;
	private double HEIGHT_S;
	
	public int getEVENT_CODE() {
		return EVENT_CODE;
	}
	public void setEVENT_CODE(int eVENT_CODE) {
		EVENT_CODE = eVENT_CODE;
	}
	public String getEVENT_NAME() {
		return EVENT_NAME;
	}
	public void setEVENT_NAME(String eVENT_NAME) {
		EVENT_NAME = eVENT_NAME;
	}
	public String getFRONT_PIC() {
		return FRONT_PIC;
	}
	public void setFRONT_PIC(String fRONT_PIC) {
		FRONT_PIC = fRONT_PIC;
	}
	public String getMAIN_PIC() {
		return MAIN_PIC;
	}
	public void setMAIN_PIC(String mAIN_PIC) {
		MAIN_PIC = mAIN_PIC;
	}
	public String getUPLOAD_DATE() {
		return UPLOAD_DATE;
	}
	public void setUPLOAD_DATE(String uPLOAD_DATE) {
		UPLOAD_DATE = uPLOAD_DATE;
	}
	
	public int getPAGE() {
		return PAGE;
	}
	public void setPAGE(int pAGE) {
		PAGE = pAGE;
	}
	public String getKEYWORD() {
		return KEYWORD;
	}
	public void setKEYWORD(String kEYWORD) {
		KEYWORD = kEYWORD;
	}
	public int getWRITE_USER() {
		return WRITE_USER;
	}
	public void setWRITE_USER(int wRITE_USER) {
		WRITE_USER = wRITE_USER;
	}
	public int getIS_ZZIMED() {
		return IS_ZZIMED;
	}
	public void setIS_ZZIMED(int iS_ZZIMED) {
		IS_ZZIMED = iS_ZZIMED;
	}
	public String getHOME_PIC() {
		return HOME_PIC;
	}
	public void setHOME_PIC(String hOME_PIC) {
		HOME_PIC = hOME_PIC;
	}
	public String getHREF() {
		return HREF;
	}
	public void setHREF(String hREF) {
		HREF = hREF;
	}
	public double getTOP_P() {
		return TOP_P;
	}
	public void setTOP_P(double tOP_P) {
		TOP_P = tOP_P;
	}
	public double getLEFT_P() {
		return LEFT_P;
	}
	public void setLEFT_P(double lEFT_P) {
		LEFT_P = lEFT_P;
	}
	public double getWIDTH_S() {
		return WIDTH_S;
	}
	public void setWIDTH_S(double wIDTH_S) {
		WIDTH_S = wIDTH_S;
	}
	public double getHEIGHT_S() {
		return HEIGHT_S;
	}
	public void setHEIGHT_S(double hEIGHT_S) {
		HEIGHT_S = hEIGHT_S;
	}
	public int getEL_CODE() {
		return EL_CODE;
	}
	public void setEL_CODE(int eL_CODE) {
		EL_CODE = eL_CODE;
	}
}