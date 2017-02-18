package com.sportsfactory.sportforall.dto;

public class ClubUserAddressDto {
	private int USER_ADDRESS_CODE;
	private String USER_NAME;
	private String CREATED_DATE;
	private String DELETED_DATE;
	
	private int CLUB_CODE;
	
	public int getUSER_ADDRESS_CODE() {
		return USER_ADDRESS_CODE;
	}
	public void setUSER_ADDRESS_CODE(int uSER_ADDRESS_CODE) {
		USER_ADDRESS_CODE = uSER_ADDRESS_CODE;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
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
	public int getCLUB_CODE() {
		return CLUB_CODE;
	}
	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
	}
	
}
