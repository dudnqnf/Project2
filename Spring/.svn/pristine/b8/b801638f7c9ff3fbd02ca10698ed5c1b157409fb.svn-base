package com.sportsfactory.sportforall.service;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.util.CookieGenerator;

import com.sportsfactory.sportforall.AccountController;
import com.sportsfactory.sportforall.dao.AccountDao;
import com.sportsfactory.sportforall.dao.ClubDao;
import com.sportsfactory.sportforall.dao.InfoDao;
import com.sportsfactory.sportforall.dao.LocationDao;
import com.sportsfactory.sportforall.dao.SportsTypeDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.ClubUserDto;
import com.sportsfactory.sportforall.dto.InfoDto;
import com.sportsfactory.sportforall.dto.InfoEventDto;
import com.sportsfactory.sportforall.dto.InfoNewsDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.dto.LocationDto;
import com.sportsfactory.sportforall.dto.SportsTypeDto;
import com.sportsfactory.sportforall.dto.StateDto;
import com.sportsfactory.sportforall.util.CommonUtil;

public class InfoService {
	
	private static Logger log = Logger.getLogger(InfoService.class);
	@Autowired
	SqlSession sqlSession;
	
	public void getInfo(StateDto Sdto, Model model, String user_id){
		// Sdtos의 첫번째 객체(Sdtos.get(0))는 대회소식 목록 State
		// 두번째 객체는 체육시설 목록 State고
		ArrayList<StateDto> Sdtos = getUserSetting(model, user_id);
		//Sdto = getLastState(Sdto, model);
		StateDto TSdto = new StateDto();
		if(Sdto.getPAGE_TAG() == null){
			Sdto.setPAGE_TAG("news");
		}
		if(Sdto.getKEYWORD() == null){
			Sdto.setKEYWORD("");
		}
		switch(Sdto.getPAGE_TAG()){
		case "news":
			TSdto = Sdtos.get(0);
			if(Sdto.getSI() != null && !Sdto.getSI().equals("")){
				TSdto.setSI(Sdto.getSI());
			}
			if(Sdto.getEVENT() != null && !Sdto.getEVENT().equals("")){
				TSdto.setEVENT(Sdto.getEVENT());
			}
			Sdtos.set(0, TSdto);
			break;
		case "facility":
			TSdto = Sdtos.get(1);
			if(Sdto.getSI() != null && !Sdto.getSI().equals("")){
				TSdto.setSI(Sdto.getSI());
			}
			if(Sdto.getGU() != null && !Sdto.getGU().equals("")){
				TSdto.setGU(Sdto.getGU());
			}
			if(Sdto.getDONG() != null && !Sdto.getDONG().equals("")){
				TSdto.setDONG(Sdto.getDONG());
			}
			if(Sdto.getEVENT() != null && !Sdto.getEVENT().equals("")){
				TSdto.setEVENT(Sdto.getEVENT());
			}
			Sdtos.set(1, Sdto);
			break;
		}
		
		getSi(model);
		getGu(Sdtos.get(1), model);
		getDong(Sdtos.get(1), model);
		getEventDropdown(null, model);
		
		getInfoContent(Sdtos, model);
		
		model.addAttribute("page_tag", Sdto.getPAGE_TAG());
		
		// 기존 코드
		/*getSi(model);
		getCategory(model);
		String keyword = Sdto.getKEYWORD();
		
		Sdto = getLastState(Sdto, model);
		if(Sdto.getFLAG() == 0){
			Sdto = getUserSetting(model, user_id);
		}
		getGu(Sdto, model);
		//getDong(Sdto, model);
		getEventDropdown(Sdto, model);

		if(keyword != null && !keyword.equals("")){
			Sdto.setKEYWORD(keyword);
		}
		else{
			Sdto.setKEYWORD("");
		}
		getInfoContent(Sdto, model);*/
	}

	private void getSi(Model model){
		LocationDao dao = sqlSession.getMapper(LocationDao.class);
		ArrayList<LocationDto> Ldtos = dao.getSi();
		model.addAttribute("si",Ldtos);
	}

	public Object getGu(StateDto Sdto, Model model) {
		LocationDao dao = sqlSession.getMapper(LocationDao.class);
		LocationDto Ldto = new LocationDto();
		Ldto.setSI(Sdto.getSI());
		ArrayList<LocationDto> Ldtos = dao.getGu(Ldto);
		model.addAttribute("gu", Ldtos);
		return Ldtos;
	}
	
	private void getCategory(Model model) {
		SportsTypeDao STdao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> STdtos = STdao.getAllEvents();
		model.addAttribute("category",STdtos);
	}
	
	public Object getEventDropdown(StateDto Sdto, Model model){
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		ArrayList<StateDto> Sdtos = null;
		if(Sdto == null){
			Sdtos = Idao.getNewsEvent();
			model.addAttribute("event_news", Sdtos);
		}
		else{
			// State가 있을 경우인데 아직 필요 없으므로..
		}
		// 만약 종목 앞에 카테고리 드롭박스를 만들어야 한다면 다시 활용 할 수 있도록 
		return null;
		
		/*SportsTypeDao STdao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> STdtos = STdao.getAllSports();
		model.addAttribute("event_facility", STdtos);
		if(Sdto.getPAGE_TAG() != null && Sdto.getPAGE_TAG().equals("news")){
			SportsTypeDto STdto = new SportsTypeDto();
			STdto.setCATEGORY(Sdto.getCATEGORY());
			STdtos = STdao.getSports(STdto);
			model.addAttribute("event_news", STdtos);
		}
		else{
			model.addAttribute("event_news", STdtos);
		}
		return STdtos;*/
	}

	private StateDto getLastState(StateDto Sdto, Model model) {
		return Sdto;
	}


	private ArrayList<StateDto> getUserSetting(Model model, String user_id) {
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		
		AccountDto Adto = new AccountDto();
		Adto.setUSER_ID(Integer.parseInt(user_id));
		Adto = Idao.getUserSetting(Adto);
		
		ArrayList<StateDto> Sdtos = new ArrayList<StateDto>();
		StateDto NSdto = new StateDto();
		StateDto FSdto = new StateDto();
		StateDto ESdto = new StateDto();
		NSdto.setPAGE_TAG("news");
		NSdto.setKEYWORD("");
		FSdto.setPAGE_TAG("facility");
		FSdto.setKEYWORD("");
		ESdto.setPAGE_TAG("event");
		ESdto.setKEYWORD("");
		
		// 다른 지역 추가하기 전에는 무조건 서울특별시
		NSdto.setSI("전국");
		FSdto.setSI("서울특별시");
		
		// 역시 다른 지역 추가하기 전에 서울특별시가 아니면 강남구로 강제 지정
		if(Adto.getLOCATION_SI().equals("서울특별시")){
			FSdto.setGU(Adto.getLOCATION_GU());
		}
		else{
			FSdto.setGU("강남구");
		}
		
		// 동은 추가되기 전엔 그냥 전체
		FSdto.setDONG("전체");
		
		// 대회소식 부분 종목은
		// 개인이 관심있는 종목에 대한 대회소식이 있으면 그 종목으로 하고
		// 아닐 경우에는 전체 종목
		//ArrayList<StateDto> ESdtos = Idao.getAllUserEventMatchNews(Adto);
		//if(ESdtos.size() > 0){
			//NSdto.setEVENT(ESdtos.get(0).getEVENT());
		//}
		//else{
			NSdto.setEVENT("모든 종목");
		//}
		model.addAttribute("news_state", NSdto);
		Sdtos.add(NSdto);
		
		// 체육시설 부분 종목은 무조건 모든 종목으로
		//FSdto.setEVENT(Adto.getSPORTS_NAME());
		FSdto.setEVENT("모든 종목");
		model.addAttribute("facility_state", FSdto);
		Sdtos.add(FSdto);
		
		Sdtos.add(ESdto);
		
		return Sdtos;
	}
	/*private StateDto getUserSetting(Model model, String user_id) {
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		AccountDto Adto = new AccountDto();
		Adto.setUSER_ID(Integer.parseInt(user_id));
		Adto = Idao.getUserSetting(Adto);
		StateDto Sdto = new StateDto();
		if(Adto == null){
			Sdto.setSI("서울특별시");
			Sdto.setGU("시군구");
			Sdto.setDONG("전체");
			Sdto.setCATEGORY("모든 카테고리");
			Sdto.setEVENT("모든 종목");
			Sdto.setFLAG(0);
		}
		else{
			Sdto.setSI(Adto.getLOCATION_SI());
			Sdto.setGU(Adto.getLOCATION_GU());
			Sdto.setDONG("전체");
			Sdto.setCATEGORY(Adto.getSPORTS_CATEGORY());
			Sdto.setEVENT(Adto.getSPORTS_NAME());
			Sdto.setFLAG(1);
		}
		Sdto.setPAGE_TAG("news");
		model.addAttribute("news_state", Sdto);
		switch(Sdto.getEVENT()){
		case "축구":
		case "풋살":
		case "농구":
		case "야구":
		case "족구":
		case "테니스":
		case "배드민턴":
		case "수영":
		case "게이트볼":
			break;
		default:
			Sdto.setEVENT("모든 종목");
			break;
		}
		model.addAttribute("facility_state", Sdto);
		return Sdto;
	}*/

	private void getInfoContent(ArrayList<StateDto> Sdtos, Model model) {
		log.error("!");
		getNewsContent(Sdtos.get(0), model);
		getFacilityContent(Sdtos.get(1), model);
		//getEventContent(Sdtos.get(2), model);
	}

	public Object getNewsContent(StateDto Sdto, Model model){
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		InfoNewsDto Idto = new InfoNewsDto();
		model.addAttribute("keyword", Sdto.getKEYWORD());
		
		if(Sdto != null && Sdto.getPAGE_TAG() != null && Sdto.getPAGE_TAG().equals("news")){
			if(Sdto.getSI() == null || Sdto.getSI().equals("") || Sdto.getSI().equals("전국")){
				Idto.setSI("all");
			}
			else{
				Idto.setSI(Sdto.getSI());
			}
				
			if(Sdto.getEVENT() == null || Sdto.getEVENT().equals("") || Sdto.getEVENT().equals("종목") || Sdto.getEVENT().equals("모든 종목")){
				Idto.setEVENT("all");
			}
			else{
				Idto.setEVENT(Sdto.getEVENT());
				//Idto.setEVENT("all");
			}
			
			Idto.setPAGE(Sdto.getPAGE()*10);
			
			if(Sdto.getKEYWORD() != ""){
				Idto.setKEYWORD("%"+Sdto.getKEYWORD()+"%");
			}
			else{
				Idto.setKEYWORD("");
			}
		}
		else{
			Idto.setSI("전국");
			Idto.setEVENT("all");
			Idto.setPAGE(0);
			Idto.setKEYWORD("");
		}
		
		log.error(Idto.getSI()+"/"+Idto.getEVENT()+"/"+Idto.getPAGE()+"/"+Idto.getKEYWORD());
		
		ArrayList<InfoNewsDto> Idtos = Idao.getNewsList(Idto);
		
		model.addAttribute("result_news", Idtos);
		log.error(Idtos.size());
		return Idtos;
	}
	
	public Object getFacilityContent(StateDto Sdto, Model model) {
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		InfoDto Idto = new InfoDto();
		model.addAttribute("keyword", Sdto.getKEYWORD());

		if(Sdto != null && ((Sdto.getPAGE_TAG() != null && Sdto.getPAGE_TAG().equals("facility")) || Sdto.getFLAG() == 1)){
			log.error("!!");
			if(Sdto == null || Sdto.getSI() == null || Sdto.getSI().equals("")){
				Idto.setSI("서울특별시");
				Idto.setGU("all");
				Idto.setDONG("all");
			}
			else{
				Idto.setSI(Sdto.getSI());

				if(Sdto == null || Sdto.getGU() == null || Sdto.getGU().equals("") || Sdto.getGU().equals("시군구")){
					Idto.setGU("all");
					Idto.setDONG("all");
				}
				else{
					Idto.setGU(Sdto.getGU());

					if(Sdto == null || Sdto.getDONG() == null || Sdto.getDONG().equals("") || Sdto.getDONG().equals("전체")){
						Idto.setDONG("all");
					}
					else{
						Idto.setDONG(Sdto.getDONG());
					}
				}
			}
			
			if(Sdto.getEVENT() == null || Sdto.getEVENT().equals("") || Sdto.getEVENT().equals("종목") || Sdto.getEVENT().equals("모든 종목")){
				Idto.setEVENT("all");
			}
			else{
				log.error("!!!");
				Idto.setEVENT(Sdto.getEVENT());
			}
			
			if(Sdto == null || Sdto.getPAGE() == 0){
				Idto.setPAGE(0);
			}
			else{
				Idto.setPAGE(Sdto.getPAGE()*20);
			}
			
			if(Sdto.getKEYWORD() != ""){
				Idto.setKEYWORD("%"+Sdto.getKEYWORD()+"%");
			}
			else{
				Idto.setKEYWORD("");
			}
		}
		else{
			Idto.setSI("서울특별시");
			Idto.setGU("all");
			Idto.setDONG("all");
			Idto.setEVENT("all");
			Idto.setPAGE(0);
			Idto.setKEYWORD("");
		}
		
		log.error(Idto.getSI()+"/"+Idto.getGU()+"/"+Idto.getDONG()+"/"+Idto.getEVENT()+"/"+Idto.getPAGE()+"/"+Idto.getKEYWORD());
		
		ArrayList<InfoDto> Idtos = Idao.getFacilityList(Idto);
		
		log.error(Idtos.size());
		
		model.addAttribute("result_facility", Idtos);
		return Idtos;
	}

	public Object getDong(StateDto Sdto, Model model) {
		LocationDao dao = sqlSession.getMapper(LocationDao.class);
		LocationDto Ldto = new LocationDto();
		Ldto.setGU(Sdto.getGU());
		ArrayList<LocationDto> Ldtos = dao.getDongFacility(Ldto);
		model.addAttribute("dong_facility", Ldtos);
		return Ldtos;
	}

	public void getFacilityInfo(InfoDto Idto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		Idto = dao.getFacilityInfo(Idto);
		Idto.setWRITE_USER(Integer.parseInt(user_id));
		Idto = (InfoDto) getFacilityIsZzimed(Idto);
		model.addAttribute("info", Idto);
		ArrayList<InfoDto> Idtos = dao.getFacilityPicture(Idto);
		model.addAttribute("album_list", Idtos);
	}

	public Object zzimInfoNews(InfoNewsDto INdto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		INdto.setWRITE_USER(Integer.parseInt(user_id));
		INdto = (InfoNewsDto) getNewsIsZzimed(INdto);
		if(INdto.getIS_ZZIMED() == 0){
			dao.zzimThisNews(INdto);
		}
		else{
			dao.diszzimThisNews(INdto);
		}
		return (InfoNewsDto) getNewsIsZzimed(INdto);
	}

	public Object zzimInfoFacility(InfoDto Idto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		Idto.setWRITE_USER(Integer.parseInt(user_id));
		Idto = (InfoDto) getFacilityIsZzimed(Idto);
		if(Idto.getIS_ZZIMED() == 0){
			dao.zzimThisFacility(Idto);
		}
		else{
			dao.diszzimThisFacility(Idto);
		}
		return (InfoDto) getFacilityIsZzimed(Idto);
	}

	public void getNewsInfo(InfoNewsDto INdto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		INdto = dao.getNewsInfo(INdto);
		INdto.setWRITE_USER(Integer.parseInt(user_id));
		INdto = (InfoNewsDto) getNewsIsZzimed(INdto);
		model.addAttribute("NEWS", INdto);
		ArrayList<InfoNewsDto> INdtos = dao.getNewsPicture(INdto);
		model.addAttribute("album_list", INdtos);
	}
	
	private Object getNewsIsZzimed(InfoNewsDto INdto) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		int is_zzimed = dao.newsIsZzimed(INdto);
		INdto.setIS_ZZIMED(is_zzimed);
		return INdto;
	}
	
	private Object getFacilityIsZzimed(InfoDto Idto) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		int is_zzimed = dao.facilityIsZzimed(Idto);
		Idto.setIS_ZZIMED(is_zzimed);
		return Idto;
	}
	
	public Object getEventContent(StateDto Sdto, Model model) {
		InfoDao Idao = sqlSession.getMapper(InfoDao.class);
		InfoEventDto IEdto = new InfoEventDto();
		model.addAttribute("keyword", Sdto.getKEYWORD());
		
		IEdto.setPAGE(Sdto.getPAGE()*20);
		
		if(Sdto != null && !Sdto.getKEYWORD().equals("")){
			IEdto.setKEYWORD("%"+Sdto.getKEYWORD()+"%");
		}
		else{
			IEdto.setKEYWORD("");
		}
		
		log.error(IEdto.getPAGE()+"/"+IEdto.getKEYWORD());
		
		ArrayList<InfoEventDto> IEdtos = Idao.getEventList(IEdto);
		
		log.error(IEdtos.size());
		
		model.addAttribute("result_event", IEdtos);
		return IEdtos;
	}

	public void getEventInfo(InfoEventDto IEdto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		IEdto = dao.getEventInfo(IEdto);
		IEdto.setWRITE_USER(Integer.parseInt(user_id));
		IEdto = (InfoEventDto) getEventIsZzimed(IEdto);
		model.addAttribute("EVENT", IEdto);
		ArrayList<InfoEventDto> IEdtos = dao.getEventLink(IEdto);
		if(IEdtos.size() != 0){
			model.addAttribute("LINK", IEdtos.get(0));
		}
	}
	
	private Object getEventIsZzimed(InfoEventDto IEdto) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		int is_zzimed = dao.eventIsZzimed(IEdto);
		IEdto.setIS_ZZIMED(is_zzimed);
		return IEdto;
	}

	public Object zzimInfoEvent(InfoEventDto IEdto, Model model, String user_id) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		IEdto.setWRITE_USER(Integer.parseInt(user_id));
		IEdto = (InfoEventDto) getEventIsZzimed(IEdto);
		if(IEdto.getIS_ZZIMED() == 0){
			dao.zzimThisEvent(IEdto);
		}
		else{
			dao.diszzimThisEvent(IEdto);
		}
		return (InfoEventDto) getEventIsZzimed(IEdto);
	}

	public void insertInfoContentLink(InfoEventDto IEdto) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		//EVENT_CODE, HREF, TOP, LEFT, WIDTH, HEIGHT
		log.error(IEdto.getEVENT_CODE()+"/"+IEdto.getHREF()+" / "+IEdto.getTOP_P()+" / "+IEdto.getLEFT_P()+" / "+IEdto.getWIDTH_S()+" / "+IEdto.getHEIGHT_S());
		dao.insertInfoContentLink(IEdto);
	}

	public void getEventEditor(InfoEventDto IEdto, Model model, String user_id) {
		getEventInfo(IEdto, model, user_id);
		getEventLink(IEdto, model);
	}

	private void getEventLink(InfoEventDto IEdto, Model model) {
		InfoDao dao = sqlSession.getMapper(InfoDao.class);
		ArrayList<InfoEventDto> IEdtos = dao.getEventLink(IEdto);
		model.addAttribute("EventLink", IEdtos);
	}
}
