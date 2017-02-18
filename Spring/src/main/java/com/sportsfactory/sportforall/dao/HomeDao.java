package com.sportsfactory.sportforall.dao;

import java.util.ArrayList;

import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.HomeAlarmDto;
import com.sportsfactory.sportforall.dto.LocationDto;
import com.sportsfactory.sportforall.dto.SportsTypeDto;

public interface HomeDao {
	ArrayList<HomeAlarmDto> getAlarmList(HomeAlarmDto hAdto);
	void makeAlarm(HomeAlarmDto hAdto);
	void readAlarm(HomeAlarmDto hAdto);
	void makeAlarmForOne(HomeAlarmDto hAdto);
	ArrayList<HomeAlarmDto> getResponseAlarmListWeek(HomeAlarmDto hAdto);
	HomeAlarmDto getAlarmCount(AccountDto adto);
	void makeFedAlarm(HomeAlarmDto hAdto);
	void makeFedAlarmForOne(HomeAlarmDto hAdto);
	void updateSubType(HomeAlarmDto hAdto);
}