package com.sportsfactory.sportforall;

import java.io.Console;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sportsfactory.sportforall.dao.AccountDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.ClubDto;
import com.sportsfactory.sportforall.dto.ClubUserDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.dto.LocationDto;
import com.sportsfactory.sportforall.dto.UserInterestListDto;
import com.sportsfactory.sportforall.dto.UserPhotoDto;
import com.sportsfactory.sportforall.service.AccountService;
import com.sportsfactory.sportforall.service.LocationService;
import com.sportsfactory.sportforall.service.MyprofileService;
import com.sportsfactory.sportforall.util.CommonUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/myprofile")
public class MyprofileController {
	
	private static Logger log = Logger.getLogger(MyprofileController.class);
	
	@Autowired
	MyprofileService myprofileService;
	
	/*
	 * 프로필 index페이지
	 */
	@RequestMapping(value = "/index.do")
	public String index(Model model, @CookieValue("user_id") int user_id) {
		myprofileService.getIndexInfo(model, user_id);
		return "myprofile/index";
	}
	
	/*
	 * 설정
	 */
	@RequestMapping(value = "/profile_setting.do")
	public String profileSetting(Model model, @CookieValue("user_id") int user_id) {
		myprofileService.getProfileSetting(model, user_id);
		return "myprofile/profile_setting";
	}
	
	/*
	 * 로그아웃
	 */
	@RequestMapping(value = "/logout.do")
	public @ResponseBody Object logout(HttpServletResponse response) {
		Object vo = myprofileService.logout(response);
		return vo;
	}
	
	/*
	 * 푸쉬알람 ON
	 */
	@RequestMapping(value = "/push_check.do")
	public @ResponseBody Object push_check(@CookieValue("user_id") int user_id) {
		Object vo = myprofileService.pushCheck(user_id);
		return vo;
	}
	
	/*
	 * 푸쉬알람 OFF
	 */
	@RequestMapping(value = "/push_check_cancel.do")
	public @ResponseBody Object push_check_cancel(@CookieValue("user_id") int user_id) {
		Object vo = myprofileService.pushCheckCancel(user_id);
		return vo;
	}
	
	/*
	 * 계정 설정 PAGE
	 */
	@RequestMapping(value = "/account_info.do")
	public String profile_account_info(Model model, @CookieValue("user_id") int user_id) {
		myprofileService.getProfile(model, user_id);
		return "myprofile/account_info";
	}
	
	/*
	 * 비밀번호 변경
	 */
	@RequestMapping(value = "/password_update.do")
	public @ResponseBody Object password_update(@ModelAttribute AccountDto dto, @CookieValue("user_id") int user_id) {
		Object vo = myprofileService.passwordUpdate(dto, user_id);
		return vo;
	}
	
	/*
	 * 회원탈퇴 하기
	 */
	@RequestMapping(value = "/drop_out.do")
	public @ResponseBody Object drop_out(HttpServletResponse response, @CookieValue("user_id") int user_id) {
		Object vo = myprofileService.dropOut(response, user_id);
		return vo;
	}
	
	/*
	 * 계정 설정 수정 PAGE
	 */
	@RequestMapping(value = "/profile_modify.do")
	public String profile_modify(Model model, @CookieValue("user_id") int user_id) {
		myprofileService.getProfileModify(model, user_id);
		return "myprofile/profile_modify";
	}
	
	/*
	 * 구 정보 가져오기
	 */
	@RequestMapping(value = "/getGU.do")
	public @ResponseBody Object getGU(LocationDto dto) {
		Object vo = myprofileService.getGU(dto);
		return vo;
	}
	
	/*
	 * 프로필 정보 변경
	 */
	@RequestMapping(value = "/update_profile.do")
	public @ResponseBody Object profile_upload(@ModelAttribute AccountDto Adto, 
												@RequestParam(value="code_arr") List<Integer> code_arr,
												@RequestParam(value="career_arr") List<Integer> career_arr,
												@RequestParam(value="level_arr") List<Integer> level_arr,
												@CookieValue("user_id") int user_id) {
		
		UserInterestListDto UILdto = new UserInterestListDto();
		UILdto.setCode_arr(code_arr);
		UILdto.setCareer_arr(career_arr);
		UILdto.setLevel_arr(level_arr);
		Object vo = myprofileService.updateProfile(Adto, UILdto, user_id);
		return vo;
	}
	
	/*
	 * 유저 사진 변경
	 */
	@RequestMapping(value = "/user_photo_upload.do")
	public @ResponseBody Object user_photo_upload(@ModelAttribute UserPhotoDto dto, @CookieValue("user_id") int user_id) {
		Object vo = myprofileService.userPhotoUpload(dto, user_id);
		return vo;
	}
	
	/*
	 * 보관함 보기PAGE
	 */
	@RequestMapping(value = "/zzim_locker.do")
	public String zzim_locker(Model model, @CookieValue("user_id") int user_id) {
		myprofileService.getZzimLocker(model, user_id);
		return "myprofile/zzim_locker";
	}
	
	/*
	 * 버전정보
	 */
	@RequestMapping(value = "/get_version.do")
	public @ResponseBody Object get_version() {
		Object vo = myprofileService.getVersion();
		return vo;
	}
	
	/*
	 * 유저의 PHOTO_SEQ번째 사진 가져오기
	 */
	@RequestMapping(value = "/get_user_photo_by_seq.do")
	public @ResponseBody Object get_user_photo_by_seq(@ModelAttribute UserPhotoDto dto) {
		Object vo = myprofileService.getUserPhotoBySeq(dto);
		return vo;
	}
	
	/*
	 * 유저의 PHOTO_SEQ번째 사진 삭제
	 */
	@RequestMapping(value = "/user_photo_delete.do")
	public @ResponseBody Object user_photo_delete(@ModelAttribute UserPhotoDto dto) {
		return myprofileService.deleteUserPhotoBySeq(dto);
	}
	
	/*
	 * 동호회 탈퇴하기
	 */
	@RequestMapping(value = "/getout_from_club.do")
	public @ResponseBody Object getout_from_club(@ModelAttribute ClubUserDto dto, @CookieValue("user_id") int user_id) {
		Object vo = myprofileService.getoutFromClub(dto, user_id);
		return vo;
	}
	
	/*
	 * 유저 정보
	 */
	@RequestMapping(value = "/user_info.do")
	public String user_info(Model model, @RequestParam(value="user_id") int user_id) {
		myprofileService.getIndexInfo(model, user_id);
		return "myprofile/user_info";
	}
	
}
