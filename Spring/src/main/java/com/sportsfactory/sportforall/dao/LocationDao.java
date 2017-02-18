package com.sportsfactory.sportforall.dao;

import java.util.ArrayList;

import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.LocationDto;
import com.sportsfactory.sportforall.dto.SportsTypeDto;
import com.sportsfactory.sportforall.dto.StateDto;

public interface LocationDao {
	public ArrayList<LocationDto> getSi();
	public ArrayList<LocationDto> getGu(LocationDto dto);
	public ArrayList<LocationDto> getAllGu();
	public ArrayList<LocationDto> getDongFacility(LocationDto ldto);
}