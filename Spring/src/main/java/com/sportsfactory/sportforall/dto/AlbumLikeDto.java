package com.sportsfactory.sportforall.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class AlbumLikeDto {

	private int LIKE_CODE;
	private int ALBUM_CODE;
	private int USER_ID;
	
	private int COUNT;
	private int IS_LIKED;
	
	public int getLIKE_CODE() {
		return LIKE_CODE;
	}
	public void setLIKE_CODE(int lIKE_CODE) {
		LIKE_CODE = lIKE_CODE;
	}
	public int getALBUM_CODE() {
		return ALBUM_CODE;
	}
	public void setALBUM_CODE(int aLBUM_CODE) {
		ALBUM_CODE = aLBUM_CODE;
	}
	public int getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(int uSER_ID) {
		USER_ID = uSER_ID;
	}
	public int getCOUNT() {
		return COUNT;
	}
	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}
	public int getIS_LIKED() {
		return IS_LIKED;
	}
	public void setIS_LIKED(int iS_LIKED) {
		IS_LIKED = iS_LIKED;
	}
	
}