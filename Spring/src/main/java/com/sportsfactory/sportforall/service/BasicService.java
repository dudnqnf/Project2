package com.sportsfactory.sportforall.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.sportsfactory.sportforall.dao.AccountDao;
import com.sportsfactory.sportforall.dao.CertifiDao;
import com.sportsfactory.sportforall.dao.ClubDao;
import com.sportsfactory.sportforall.dao.HomeDao;
import com.sportsfactory.sportforall.dao.InfoDao;
import com.sportsfactory.sportforall.dao.VersionDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.CertificationDto;
import com.sportsfactory.sportforall.dto.ClubAlbumDto;
import com.sportsfactory.sportforall.dto.ClubDto;
import com.sportsfactory.sportforall.dto.ClubInviteDto;
import com.sportsfactory.sportforall.dto.ClubUserDto;
import com.sportsfactory.sportforall.dto.HomeAlarmDto;
import com.sportsfactory.sportforall.dto.InfoDto;
import com.sportsfactory.sportforall.dto.InfoEventDto;
import com.sportsfactory.sportforall.dto.InfoNewsDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.dto.UserInterestDto;
import com.sportsfactory.sportforall.dto.VersionDto;
import com.sportsfactory.sportforall.sms.CertificationKeyGenerator;
import com.sportsfactory.sportforall.sms.SMSFactory;
import com.sportsfactory.sportforall.util.CommonUtil;

public class BasicService {
	
	private static Logger log = Logger.getLogger(BasicService.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	public JsonDto versionCheck(){
	    VersionDao dao = sqlSession.getMapper(VersionDao.class);
	    VersionDto dto = dao.versionCheck();
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(dto);
		
		return vo;
	}
}
