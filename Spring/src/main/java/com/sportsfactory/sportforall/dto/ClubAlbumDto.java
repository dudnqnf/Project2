package com.sportsfactory.sportforall.dto;

public class ClubAlbumDto {
	
	private int ALBUM_CODE;
	private int CLUB_CODE;
	private int FED_CODE;
	private int USER_ID;
	private String TITLE;
	private int IS_CLOSED;
	private int IS_DELETED;
	private String CREATE_DATE;
	private String DELETE_DATE;
	
	private String FILE_NAME;
	private String FILE_MIME_TYPE;
	
	private int LIMIT_START;
	private int POINT;
	
	private int LIKE_NUM;
	private int REPLY_NUM;
	
	public int getLIMIT_START() {
		return LIMIT_START;
	}
	public void setLIMIT_START(int lIMIT_START) {
		LIMIT_START = lIMIT_START;
	}
	public int getALBUM_CODE() {
		return ALBUM_CODE;
	}
	public void setALBUM_CODE(int aLBUM_CODE) {
		ALBUM_CODE = aLBUM_CODE;
	}
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
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public int getIS_CLOSED() {
		return IS_CLOSED;
	}
	public void setIS_CLOSED(int iS_CLOSED) {
		IS_CLOSED = iS_CLOSED;
	}
	public int getIS_DELETED() {
		return IS_DELETED;
	}
	public void setIS_DELETED(int iS_DELETED) {
		IS_DELETED = iS_DELETED;
	}
	public String getCREATE_DATE() {
		return CREATE_DATE;
	}
	public void setCREATE_DATE(String cREATE_DATE) {
		CREATE_DATE = cREATE_DATE;
	}
	public String getDELETE_DATE() {
		return DELETE_DATE;
	}
	public void setDELETE_DATE(String dELETE_DATE) {
		DELETE_DATE = dELETE_DATE;
	}
	public String getFILE_NAME() {
		return FILE_NAME;
	}
	public void setFILE_NAME(String fILE_NAME) {
		FILE_NAME = fILE_NAME;
	}
	public String getFILE_MIME_TYPE() {
		return FILE_MIME_TYPE;
	}
	public void setFILE_MIME_TYPE(String fILE_MIME_TYPE) {
		FILE_MIME_TYPE = fILE_MIME_TYPE;
	}
	public int getPOINT() {
		return POINT;
	}
	public void setPOINT(int pOINT) {
		POINT = pOINT;
	}
	public int getLIKE_NUM() {
		return LIKE_NUM;
	}
	public void setLIKE_NUM(int lIKE_NUM) {
		LIKE_NUM = lIKE_NUM;
	}
	public int getREPLY_NUM() {
		return REPLY_NUM;
	}
	public void setREPLY_NUM(int rEPLY_NUM) {
		REPLY_NUM = rEPLY_NUM;
	}
	public int getFED_CODE() {
		return FED_CODE;
	}
	public void setFED_CODE(int fED_CODE) {
		FED_CODE = fED_CODE;
	}
	
}
