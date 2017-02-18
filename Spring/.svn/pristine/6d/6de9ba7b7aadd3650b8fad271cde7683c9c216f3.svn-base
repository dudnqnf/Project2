package com.sportsfactory.sportforall;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sportsfactory.sportforall.dao.AccountDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.ClubDto;
import com.sportsfactory.sportforall.dto.ClubInviteDto;
import com.sportsfactory.sportforall.dto.HomeAlarmDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.service.AccountService;
import com.sportsfactory.sportforall.service.ClubService;
import com.sportsfactory.sportforall.util.CommonUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/home")
public class HomeController {
	
	private static Logger log = Logger.getLogger(HomeController.class);
	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "/index.do")
	public String index(Model model, @CookieValue("user_id") String user_id) {
		accountService.getHomeInfo(model, user_id);
		return "home/index";
	}
	@RequestMapping(value = "/search.do")
	public String search() {
		return "home/search";
	}
	@RequestMapping(value = "/notice.do")
	public String notice() {
		return "home/notice";
	}
	
	@RequestMapping(value = "/alarm.do")
	public String alarm(@ModelAttribute HomeAlarmDto dto, Model model, @CookieValue("user_id") String user_id) {
		accountService.getAlarmList(dto, model, user_id);
		return "home/alarm";
	}
	
	@RequestMapping(value = "/read_alarm.do")
	public @ResponseBody Object read_alarm(@ModelAttribute HomeAlarmDto dto, Model model, @CookieValue("user_id") String user_id) {
		accountService.readAlarm(dto, model, user_id);
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	@RequestMapping(value = "/get_alarm_more.do")
	public @ResponseBody Object get_alarm_more(@ModelAttribute HomeAlarmDto dto, Model model, @CookieValue("user_id") String user_id) {
		return accountService.getAlarmList(dto, model, user_id);
	}
	
	@RequestMapping(value = "/accept_club_invite.do")
	public @ResponseBody Object accept_club_invite(@ModelAttribute ClubInviteDto dto, @CookieValue("user_id") String user_id){
		dto.setUSER_ID(Integer.parseInt(user_id));
		Object vo = accountService.acceptClubInvite(dto);
		return vo;
	}
	
	@RequestMapping(value = "/reject_club_invite.do")
	public @ResponseBody Object reject_club_invite(@ModelAttribute ClubInviteDto dto, @CookieValue("user_id") String user_id){
		dto.setUSER_ID(Integer.parseInt(user_id));
		Object vo = accountService.rejectClubInvite(dto);
		return vo;
	}
	
	@RequestMapping(value = "/test.do")
	public String test(Model model, @CookieValue("user_id") String user_id) {
		return "home/test";
	}
}