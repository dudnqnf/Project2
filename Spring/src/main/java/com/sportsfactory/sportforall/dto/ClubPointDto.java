package com.sportsfactory.sportforall.dto;

public class ClubPointDto {
	private int POINT_CATEGORY;
	private int COUNT;
	private int POINTS;
	private String ISSUE_DATE;
	private int CLUB_CODE;
	private String LIMIT_DATE;
	
	public int getPOINT_CATEGORY() {
		return POINT_CATEGORY;
	}
	public void setPOINT_CATEGORY(int pOINT_CATEGORY) {
		POINT_CATEGORY = pOINT_CATEGORY;
	}
	public int getCOUNT() {
		return COUNT;
	}
	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}
	public int getPOINTS() {
		return POINTS;
	}
	public void setPOINTS(int pOINTS) {
		POINTS = pOINTS;
	}
	public String getISSUE_DATE() {
		return ISSUE_DATE;
	}
	public void setISSUE_DATE(String iSSUE_DATE) {
		ISSUE_DATE = iSSUE_DATE;
	}
	public int getCLUB_CODE() {
		return CLUB_CODE;
	}
	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
	}
	public String getLIMIT_DATE() {
		return LIMIT_DATE;
	}
	public void setLIMIT_DATE(String lIMIT_DATE) {
		LIMIT_DATE = lIMIT_DATE;
	}
}
