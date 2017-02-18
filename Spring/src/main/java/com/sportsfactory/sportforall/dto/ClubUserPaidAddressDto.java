package com.sportsfactory.sportforall.dto;

public class ClubUserPaidAddressDto {
	private int USER_PAID_ADDRESS_CODE;
	private int CLUB_CODE;
	private int USER_ADDRESS_CODE;
	private String DATE;
	
	private String USER_NAME;

	public int getUSER_PAID_ADDRESS_CODE() {
		return USER_PAID_ADDRESS_CODE;
	}

	public void setUSER_PAID_ADDRESS_CODE(int uSER_PAID_ADDRESS_CODE) {
		USER_PAID_ADDRESS_CODE = uSER_PAID_ADDRESS_CODE;
	}

	public int getCLUB_CODE() {
		return CLUB_CODE;
	}

	public void setCLUB_CODE(int cLUB_CODE) {
		CLUB_CODE = cLUB_CODE;
	}

	public int getUSER_ADDRESS_CODE() {
		return USER_ADDRESS_CODE;
	}

	public void setUSER_ADDRESS_CODE(int uSER_ADDRESS_CODE) {
		USER_ADDRESS_CODE = uSER_ADDRESS_CODE;
	}

	public String getDATE() {
		return DATE;
	}

	public void setDATE(String dATE) {
		DATE = dATE;
	}

	public String getUSER_NAME() {
		return USER_NAME;
	}

	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
}
