package com.sportsfactory.sportforall;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sportsfactory.sportforall.service.AccountService;
import com.sportsfactory.sportforall.service.BasicService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BasicController {
	
	private static Logger log = LoggerFactory.getLogger(BasicController.class);
	
	@Autowired
	private BasicService basicService;
	
	//index페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(HttpServletRequest request, Model model) {
		
		//user_id 쿠키가 존재하면 자동 로그인
		Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(int i=0;i<cookies.length;i++){
				if(cookies[i].getName().equalsIgnoreCase("user_id")){
					return "redirect:/home/index.do";
				}
			}
		}
		
		return "index";
	}
	
	//버전 체크
	@RequestMapping(value = "/version_check.do")
	public @ResponseBody Object version_check(){
		log.error("호출됨");
		Object vo = basicService.versionCheck();
		return vo;
	}

	@RequestMapping(value = "/excel_form.do")
	public String excel_form(){
		return "/common/excel_form";
	}
}
