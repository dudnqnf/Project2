package com.sportsfactory.sportforall.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.sportsfactory.sportforall.dao.SportsTypeDao;
import com.sportsfactory.sportforall.dto.SportsTypeDto;

public class SportsTypeService {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static Logger log = Logger.getLogger(SportsTypeService.class);
	private static final String CATEGORY_BALL = "구기";
	private static final String CATEGORY_RACKET = "라켓";
	private static final String CATEGORY_MARTIAL = "무술";
	private static final String CATEGORY_FITNESS = "피트니스";
	private static final String CATEGORY_ETC = "기타";
	
	public void getAllSports(Model model){
		SportsTypeDao dao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> Dto = dao.getAllSports();
		
		ArrayList<SportsTypeDto> type_ball = new ArrayList<SportsTypeDto>();
		ArrayList<SportsTypeDto> type_racket = new ArrayList<SportsTypeDto>();
		ArrayList<SportsTypeDto> type_martial = new ArrayList<SportsTypeDto>();
		ArrayList<SportsTypeDto> type_fitness = new ArrayList<SportsTypeDto>();
		ArrayList<SportsTypeDto> type_etc = new ArrayList<SportsTypeDto>();
		
		for(int i=0;i<Dto.size();i++){
			switch(Dto.get(i).getCATEGORY()){
				case CATEGORY_BALL :
					SportsTypeDto ball_dto = new SportsTypeDto();
					ball_dto.setCATEGORY_CODE(Dto.get(i).getCATEGORY_CODE());
					ball_dto.setNAME(Dto.get(i).getNAME());
					ball_dto.setEVENTS_TAG(Dto.get(i).getEVENTS_TAG());
					type_ball.add(ball_dto);
					break;
				
				case CATEGORY_RACKET :
					SportsTypeDto racket_dto = new SportsTypeDto();
					racket_dto.setCATEGORY_CODE(Dto.get(i).getCATEGORY_CODE());
					racket_dto.setNAME(Dto.get(i).getNAME());
					racket_dto.setEVENTS_TAG(Dto.get(i).getEVENTS_TAG());
					type_racket.add(racket_dto);
					break;
					
				case CATEGORY_MARTIAL :
					SportsTypeDto martial_dto = new SportsTypeDto();
					martial_dto.setCATEGORY_CODE(Dto.get(i).getCATEGORY_CODE());
					martial_dto.setNAME(Dto.get(i).getNAME());
					martial_dto.setEVENTS_TAG(Dto.get(i).getEVENTS_TAG());
					type_martial.add(martial_dto);
					break;
					
				case CATEGORY_FITNESS :
					SportsTypeDto fitness_dto = new SportsTypeDto();
					fitness_dto.setCATEGORY_CODE(Dto.get(i).getCATEGORY_CODE());
					fitness_dto.setNAME(Dto.get(i).getNAME());
					fitness_dto.setEVENTS_TAG(Dto.get(i).getEVENTS_TAG());
					type_fitness.add(fitness_dto);
					break;
					
				case CATEGORY_ETC :
					SportsTypeDto etc_dto = new SportsTypeDto();
					etc_dto.setCATEGORY_CODE(Dto.get(i).getCATEGORY_CODE());
					etc_dto.setNAME(Dto.get(i).getNAME());
					etc_dto.setEVENTS_TAG(Dto.get(i).getEVENTS_TAG());
					type_etc.add(etc_dto);
					break;
					
				default :
					break;
			}
		}
		
		model.addAttribute("type_all", Dto);
		model.addAttribute("type_ball", type_ball);
		model.addAttribute("type_racket", type_racket);
		model.addAttribute("type_martial", type_martial);
		model.addAttribute("type_fitness", type_fitness);
		model.addAttribute("type_etc", type_etc);
	}
	
	public void getCategory(HttpServletRequest request, Model model){
		SportsTypeDao dao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> Dto = dao.getCategory();
		model.addAttribute("category", Dto);
	}
	
	public void getSportsName(HttpServletRequest request, Model model){
		SportsTypeDao dao = sqlSession.getMapper(SportsTypeDao.class);
		
		String param = request.getParameter("category");
		Object attri = request.getAttribute("sortingCategory");
		String category = null;
		
		if(param!=null)
			category = param;
		else if(attri!=null)
			category = attri.toString();
		
		SportsTypeDto Sdto = new SportsTypeDto();
		Sdto.setCATEGORY(category);
		
		ArrayList<SportsTypeDto> Dto = dao.getSportsName(Sdto);
		model.addAttribute("sports_name", Dto);
	}
	
	public void getEach(HttpServletRequest request, Model model){
		SportsTypeDao dao = sqlSession.getMapper(SportsTypeDao.class);
		
		String param = request.getParameter("category");
		Object attri = request.getAttribute("sortingCategory");
		String category = null;
		
		if(param!=null)
			category = param;
		else if(attri!=null)
			category = attri.toString();
		
		SportsTypeDto Sdto = new SportsTypeDto();
		Sdto.setCATEGORY(category);
		
		ArrayList<SportsTypeDto> Dto = dao.getSportsName(Sdto);
		model.addAttribute("sports_name", Dto);
	}
	
	public void getGroupedSports(HttpServletRequest request, Model model){
		SportsTypeDao dao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> STdtos = null;
		STdtos = dao.getAllEvents();
		model.addAttribute("events", STdtos);
		STdtos = dao.getAllSports();
		model.addAttribute("sports", STdtos);
	}
}