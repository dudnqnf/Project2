package com.sportsfactory.sportforall.dto;

public class ClubSearchLogDto {
	private int SEARCH_ID;
	private int USER_ID;
	private String KEYWORD;
	private String SEARCH_DATE;
	private String SEARCH_TIME;
	
	// 중복갯수
	private int COUNT;
	private int INTERVAL;
	
	public int getSEARCH_ID() {
		return SEARCH_ID;
	}
	public void setSEARCH_ID(int sEARCH_ID) {
		SEARCH_ID = sEARCH_ID;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getKEYWORD() {
		return KEYWORD;
	}
	public void setKEYWORD(String kEYWORD) {
		KEYWORD = kEYWORD;
	}
	public String getSEARCH_DATE() {
		return SEARCH_DATE;
	}
	public void setSEARCH_DATE(String sEARCH_DATE) {
		SEARCH_DATE = sEARCH_DATE;
	}
	public String getSEARCH_TIME() {
		return SEARCH_TIME;
	}
	public void setSEARCH_TIME(String sEARCH_TIME) {
		SEARCH_TIME = sEARCH_TIME;
	}
	
	public int getCOUNT() {
		return COUNT;
	}
	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}
	public int getINTERVAL() {
		return INTERVAL;
	}
	public void setINTERVAL(int iNTERVAL) {
		INTERVAL = iNTERVAL;
	}

}
