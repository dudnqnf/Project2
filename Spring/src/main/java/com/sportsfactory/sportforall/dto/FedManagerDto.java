package com.sportsfactory.sportforall.dto;

public class FedManagerDto {
	private int FED_CODE;
	private int USER_ID;
	private int USER_LEVEL;
	private int IS_DELETED;
	private String CREATED_DATE;
	private String DELETED_DATE;
	private int AGREE_DELETE;
	private int POINT;
	
	public int getFED_CODE() {
		return FED_CODE;
	}
	public void setFED_CODE(int fED_CODE) {
		FED_CODE = fED_CODE;
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
	public int getAGREE_DELETE() {
		return AGREE_DELETE;
	}
	public void setAGREE_DELETE(int aGREE_DELETE) {
		AGREE_DELETE = aGREE_DELETE;
	}
	public int getPOINT() {
		return POINT;
	}
	public void setPOINT(int pOINT) {
		POINT = pOINT;
	}
	
}
