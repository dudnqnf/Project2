package com.sportsfactory.sportforall.service;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Base64;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sportsfactory.sportforall.dao.AccountDao;
import com.sportsfactory.sportforall.dao.ClubDao;
import com.sportsfactory.sportforall.dao.HomeDao;
import com.sportsfactory.sportforall.dao.LocationDao;
import com.sportsfactory.sportforall.dao.SportsTypeDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.AlbumLikeDto;
import com.sportsfactory.sportforall.dto.AlbumReplyDto;
import com.sportsfactory.sportforall.dto.AlbumZzimDto;
import com.sportsfactory.sportforall.dto.BoardZzimDto;
import com.sportsfactory.sportforall.dto.ClubAlbumDto;
import com.sportsfactory.sportforall.dto.ClubBoardDto;
import com.sportsfactory.sportforall.dto.ClubDto;
import com.sportsfactory.sportforall.dto.ClubFeeDto;
import com.sportsfactory.sportforall.dto.ClubInquiryDto;
import com.sportsfactory.sportforall.dto.ClubInviteDto;
import com.sportsfactory.sportforall.dto.ClubPointDto;
import com.sportsfactory.sportforall.dto.ClubUserAddressDto;
import com.sportsfactory.sportforall.dto.ClubSearchLogDto;
import com.sportsfactory.sportforall.dto.ClubUserDto;
import com.sportsfactory.sportforall.dto.ClubUserFeeAddressDto;
import com.sportsfactory.sportforall.dto.ClubUserFeeDto;
import com.sportsfactory.sportforall.dto.ClubUserPaidAddressDto;
import com.sportsfactory.sportforall.dto.ClubUserPaidDto;
import com.sportsfactory.sportforall.dto.CommentDto;
import com.sportsfactory.sportforall.dto.FedManagerDto;
import com.sportsfactory.sportforall.dto.HomeAlarmDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.dto.LikeDto;
import com.sportsfactory.sportforall.dto.LocationDto;
import com.sportsfactory.sportforall.dto.SportsTypeDto;
import com.sportsfactory.sportforall.dto.UserInterestDto;
import com.sportsfactory.sportforall.dto.UserPhotoDto;
import com.sportsfactory.sportforall.util.CommonUtil;
import com.sportsfactory.sportforall.util.FileUtil;
import com.sportsfactory.sportforall.util.Info;

@Service("ClubService")
public class ClubService {
	
	private Logger log = Logger.getLogger(ClubService.class);
	
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private LocationService locationService;
	@Autowired
	private SportsTypeService sportsTypeService;
	@Autowired
	private ServletContext servletContext;
	
	
	@Resource(name="fileUtil")
    private FileUtil fileUtil;
	
	public void getClubList(HttpServletRequest request, Model model, int user_id){
		//계정정보 가져오기
		AccountDao Adao = sqlSession.getMapper(AccountDao.class);
		
		AccountDto Adto = new AccountDto();
		Adto.setUSER_ID(user_id);
		AccountDto user_info = Adao.getUserInfo(Adto);
		ClubDto TCdto = new ClubDto();
		
//		UserInterestDto UIdto = new UserInterestDto();
//		UIdto.setUSER_ID(user_id);
//		UserInterestDto user_interest = Adao.getOneUserInterest(UIdto);
//		model.addAttribute("user_interest", user_interest);
		
		//클럽정보 가져오기
		ClubDao Cdao = sqlSession.getMapper(ClubDao.class);
		String sortingSi = user_info.getLOCATION_SI();
		String sortingGu = user_info.getLOCATION_GU();
		String sortingCategory = request.getParameter("category");
		String sortingSportsName = Info.All;
		
		String page = request.getParameter("page");
		if(page == null || page.equals("")){
			page = "0";
		}
		int page_num = Integer.parseInt(page);
		
		ClubDto Cdto = new ClubDto();
		Cdto.setSI(sortingSi);
		Cdto.setGU(sortingGu);
		Cdto.setCATEGORY(sortingCategory);
		Cdto.setSPORTS_NAME(sortingSportsName);
		Cdto.setPAGE_NUM(page_num*5);
		
		ArrayList<ClubDto> sortedSportsName = Cdao.getCategoryClubList(Cdto);
		for(int i = 0; i < sortedSportsName.size(); i++){
			Cdto = sortedSportsName.get(i);
			TCdto = Cdao.getClubRankCategory(Cdto);
			if(TCdto.getRANKING() > 3){
				break;
			}
			Cdto.setRANKING(TCdto.getRANKING());
			sortedSportsName.set(i, Cdto);
		}
		
		model.addAttribute("sortingSi", sortingSi);
		model.addAttribute("sortingGu", sortingGu);
		model.addAttribute("sortingCategory", sortingCategory);
		model.addAttribute("sortingeSportsName", sortingSportsName);
		model.addAttribute("all", Info.All);
		model.addAttribute("ClubList", sortedSportsName);
		
		
		//시정보 가져오기
		LocationDao Sdao = sqlSession.getMapper(LocationDao.class);
		model.addAttribute("LocationSI", Sdao.getSi());
		
		
		//구정보 가져오기
		LocationDao Gdao = sqlSession.getMapper(LocationDao.class);
		String paramLoca = request.getParameter("location");
		String si = null;
		
		if(paramLoca!=null)
			si = paramLoca;
		else if(sortingSi!=null)
			si = sortingSi.toString();
		
		LocationDto Gdto = new LocationDto();
		Gdto.setSI(si);
		model.addAttribute("LocationGU", Gdao.getGu(Gdto));
		
		
		//카테고리 가져오기
		SportsTypeDao STdao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> STDto = STdao.getCategory();
		model.addAttribute("category", STDto);
		
		
		//스포츠 종목가져오기
		String paramCate = request.getParameter("category");
		String category = null;
		
		if(paramCate!=null)
			category = paramCate;
		else if(sortingCategory!=null)
			category = sortingCategory.toString();
		
		SportsTypeDto STdto = new SportsTypeDto();
		STdto.setCATEGORY(category);
		
		ArrayList<SportsTypeDto> Dto = STdao.getSportsName(STdto);
		model.addAttribute("sports_name", Dto);
		
		
		//연합회정보 가져오기
		ClubDto Fdto = new ClubDto();
		Fdto.setSI(sortingSi);
		Fdto.setGU(sortingGu);
		Fdto.setCATEGORY(sortingCategory);
		Fdto.setSPORTS_NAME(sortingSportsName);
		
		ArrayList<ClubDto> FedList = Cdao.getFedList(Fdto);
		model.addAttribute("FedList", FedList);
	}
	
	public Object getSortedClubList(HttpServletRequest request, Model model){
		//클럽내용 가져오기
		ClubDao Cdao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubDto> returnObj = null;
		ClubDto TCdto = new ClubDto();
		
		String sortingSi = request.getParameter("si");
		String sortingGu = request.getParameter("gu");
		String sortingCategory = request.getParameter("category");
		String sortingSportsName = request.getParameter("sportsName");

		ArrayList<ClubDto> sortedAllSportsName = null;
		ArrayList<ClubDto> sortedSportsName = null;
		
		String page = request.getParameter("page");
		if(page == null || page.equals("")){
			page = "0";
		}
		int page_num = Integer.parseInt(page);
		log.error(page_num);
		
		ClubDto Cdto = new ClubDto();
		Cdto.setSI(sortingSi);
		Cdto.setGU(sortingGu);
		Cdto.setCATEGORY(sortingCategory);
		Cdto.setSPORTS_NAME(sortingSportsName);
		Cdto.setPAGE_NUM(page_num*5);

		if(sortingSportsName.equalsIgnoreCase(Info.All)){
			sortedAllSportsName = Cdao.getCategoryClubList(Cdto);
			returnObj = sortedAllSportsName;
		} else {
			sortedSportsName = Cdao.getClubList(Cdto);
			returnObj = sortedSportsName;
		}
		for(int i = 0; i < returnObj.size(); i++){
			Cdto = returnObj.get(i);
			TCdto = Cdao.getClubRankCategory(Cdto);
			if(TCdto.getRANKING() > 3){
				break;
			}
			Cdto.setRANKING(TCdto.getRANKING());
			returnObj.set(i, Cdto);
		}
		model.addAttribute("ClubList", returnObj);
		
		model.addAttribute("sortingSi", sortingSi);
		model.addAttribute("sortingGu", sortingGu);
		model.addAttribute("sortingCategory", sortingCategory);
		model.addAttribute("sortingeSportsName", sortingSportsName);
		model.addAttribute("all", Info.All);
		
		//시 내용 가져오기
		LocationDao Sdao = sqlSession.getMapper(LocationDao.class);
		model.addAttribute("LocationSI", Sdao.getSi());
		
		//구 내용 가져오기
		LocationDao Gdao = sqlSession.getMapper(LocationDao.class);
		
		String param = request.getParameter("location");
		String si = null;
		
		if(param!=null)
			si = param;
		else if(sortingSi!=null)
			si = sortingSi.toString();
		
		LocationDto Gdto = new LocationDto();
		Gdto.setSI(si);
		
		model.addAttribute("LocationGU", Gdao.getGu(Gdto));
		
		//카테고리가져오기
		SportsTypeDao STdao = sqlSession.getMapper(SportsTypeDao.class);
		ArrayList<SportsTypeDto> STDto = STdao.getCategory();
		model.addAttribute("category", STDto);
		
		//스포츠 이름 가져오기
		String paramCate = request.getParameter("category");
		String category = null;
		
		if(paramCate!=null)
			category = paramCate;
		else if(sortingCategory!=null)
			category = sortingCategory.toString();
		
		SportsTypeDto STdto = new SportsTypeDto();
		STdto.setCATEGORY(category);
		
		ArrayList<SportsTypeDto> Dto = STdao.getSportsName(STdto);
		model.addAttribute("sports_name", Dto);
		
		
		//연합회정보 가져오기
		sortedAllSportsName = null;
		
		Cdto = new ClubDto();
		Cdto.setSI(sortingSi);
		Cdto.setGU(sortingGu);
		Cdto.setCATEGORY(sortingCategory);
		Cdto.setSPORTS_NAME(sortingSportsName);
		
		ArrayList<ClubDto> FedList = Cdao.getFedList(Cdto);
		model.addAttribute("FedList", FedList);

		return returnObj;
	}
	
	public void getFedList(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		AccountDto dto = (AccountDto)request.getAttribute("user_info");
		String sortingSi = dto.getLOCATION_SI();
		String sortingGu = dto.getLOCATION_GU();
		String sortingCategory = request.getParameter("category");
		String sortingSportsName = Info.All;
		
		ClubDto Cdto = new ClubDto();
		Cdto.setSI(sortingSi);
		Cdto.setGU(sortingGu);
		Cdto.setCATEGORY(sortingCategory);
		Cdto.setSPORTS_NAME(sortingSportsName);
		
		//클럽 내용
		ArrayList<ClubDto> sortedSportsName = dao.getFedList(Cdto);
		
		model.addAttribute("sortingSi", sortingSi);
		model.addAttribute("sortingGu", sortingGu);
		model.addAttribute("sortingCategory", sortingCategory);
		model.addAttribute("sortingeSportsName", sortingSportsName);
		model.addAttribute("FedList", sortedSportsName);
	}
	
	public void getSortedFedList(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		String sortingSi = request.getParameter("si");
		String sortingGu = request.getParameter("gu");
		String sortingCategory = request.getParameter("category");
		String sortingSportsName = request.getParameter("sportsName");

		//클럽 내용
		ArrayList<ClubDto> sortedAllSportsName = null;
		
		ClubDto Cdto = new ClubDto();
		Cdto.setSI(sortingSi);
		Cdto.setGU(sortingGu);
		Cdto.setCATEGORY(sortingCategory);
		Cdto.setSPORTS_NAME(sortingSportsName);
		
		//클럽 내용
		ArrayList<ClubDto> sortedSportsName = dao.getFedList(Cdto);
		
		model.addAttribute("sortingSi", sortingSi);
		model.addAttribute("sortingGu", sortingGu);
		model.addAttribute("sortingCategory", sortingCategory);
		model.addAttribute("sortingeSportsName", sortingSportsName);
		model.addAttribute("FedList", sortedSportsName);
	}
	
	public void getClubAlbum(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubAlbumDto Cdto = new ClubAlbumDto();
		int club_code = Integer.parseInt(request.getParameter("club_code"));
		Cdto.setCLUB_CODE(club_code);
		ArrayList<ClubAlbumDto> result = dao.getAllClubAlbum(Cdto);
		
		model.addAttribute("ClubAlbum", result);
		model.addAttribute("club_code", club_code);
	}
	
	public Object getClubBoard(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubBoardDto> result = null;
		String validate = request.getParameter("keyword");
		//ClubUserDto CUdto = (ClubUserDto) request.getAttribute("user_level");
		
		ClubBoardDto Cdto = new ClubBoardDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		
		String last_bid = request.getParameter("last_bid");
		if(last_bid == null || last_bid.equals("")){
			last_bid = "-1";
		}
		Cdto.setBOARD_ID(Integer.parseInt(last_bid));

		if(validate == null || validate.equals("")) {
			Cdto.setCONTENT("%");
		}
		else{
			Cdto.setCONTENT("%"+validate+"%");
		}
		/*if(CUdto == null){
			result = dao.getClubBoardRestricted(Cdto);
		}
		else{*/
			result = dao.getClubNotice(Cdto);
		//}
		model.addAttribute("ClubNotice", result);
		
		String num_load = request.getParameter("num_load");
		if(num_load == null || num_load.equals("")){
			num_load = "10";
		}
		Cdto.setNUM_LOAD(Integer.parseInt(num_load));
		/*if(CUdto == null){
			result = dao.getClubBoardRestricted(Cdto);
		}
		else{*/
			result = dao.getClubBoard(Cdto);
		//}
		for(int i = 0; i < result.size(); i++){
			Cdto = result.get(i);
			Cdto.setCOUNT_LIKE(dao.getCountLike(Cdto).getRESULT());
			Cdto.setCOUNT_COMMENT(dao.getCountComment(Cdto).getRESULT());
			result.set(i, Cdto);
		}
		model.addAttribute("ClubBoard", result);
		return result;
	}
	
	public void getClubDetail(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubDto Cdto = new ClubDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		ClubDto result = dao.getClubInfo(Cdto);
		
		ClubDto Pdto = calcClubPoint(model, result);

		Pdto.setCATEGORY(result.getCATEGORY());
		Pdto.setACTIVE_POINTS(Pdto.getPOINTS());
		Pdto = dao.getClubRankCategory(Pdto);
		
		String user_number = dao.getClubUserNumber(Cdto);
		
		model.addAttribute("ClubInfo", result);
		model.addAttribute("UserNumber", user_number);
		model.addAttribute("ClubRanking", Pdto.getRANKING());
	}
	
	public void likeThis(HttpServletRequest request, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);

		ClubBoardDto CBdto = new ClubBoardDto();
		CBdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
		CBdto.setWRITE_USER(user_id);
		
		int ifLike = 0;
		ifLike = dao.ifLike(CBdto);
		
		if(ifLike == 0){
			dao.likeThis(CBdto);
		}
		else{
			dao.dislikeThis(CBdto);
		}
	}
	
	public void insertComment(HttpServletRequest request, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		CommentDto Cdto = new CommentDto();
		Cdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
		Cdto.setCONTENT(request.getParameter("content"));
		Cdto.setWRITE_USER(user_id);
		Cdto.setIS_REPLY(Integer.parseInt(request.getParameter("is_reply")));
		Cdto.setPARENT_ID(Integer.parseInt(request.getParameter("parent_id")));

		dao.insertCommentBoard(Cdto);
	}
	
	public JsonDto makeAlbum(HttpServletRequest request){

	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubAlbumDto dto = new ClubAlbumDto();
	    
	    dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
	    Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	    dto.setUSER_ID(Integer.parseInt(request.getParameter("user_id")));
	    dto.setCREATE_DATE(timeStamp.toString().substring(0, 19));
	    
	    dao.insertClubAlbum(dto);
	    ClubAlbumDto reDto = dao.getCreatedClubAlbum(dto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(reDto.getALBUM_CODE());
		
		return vo;
	}
	
	public JsonDto uploadImages(HttpServletRequest request){
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	    MultipartFile f = null;
	    
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubAlbumDto dto = new ClubAlbumDto();
	    dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
	    
	    while(iterator.hasNext()){
	        f = multipartHttpServletRequest.getFile(iterator.next());
	        if(f.isEmpty() == false){
	        	try {
//	        		String type = f.getContentType().substring(f.getContentType().indexOf("/")+1);
	        		String type = "jpg";
	        		String origin = f.getOriginalFilename();
	        		String newname = origin.substring(0, origin.indexOf(".")) + "_" + System.currentTimeMillis() + "." + type;
	        		String path = request.getSession().getServletContext().getRealPath("../upload");
	                byte[] b = f.getBytes();
	                File file = new File(path+File.separator+newname);
	                FileOutputStream fos = new FileOutputStream(file);
	                fos.write(b);
	                fos.close();
	                
	                
	        	    //이미지 thumbnail이미지 생성
	        	    int width = 300;
	        	    int height = 300;
	        	    String format = "jpg";
	        	    BufferedImage inputImage = ImageIO.read(f.getInputStream());
	        	    BufferedImage outputImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	        	    Graphics2D g = outputImage.createGraphics();
	        	    g.drawImage(inputImage, 0, 0, width, height, null);
	        	    File resizeFile = new File(path + File.separator + "thumbnail" + File.separator + newname);
	        	    log.error(path + File.separator + "thumbnail" + File.separator + newname);
	        	    FileOutputStream resizeFos = new FileOutputStream(resizeFile);
	        	    ImageIO.write(outputImage, format, resizeFos);
	        	    
	        	    
	        	    dto.setFILE_NAME(newname);
	        	    dto.setFILE_MIME_TYPE(type);
	        	    dto.setPOINT(10);
	        	    dao.insertClubPicture(dto);
	        	    
	        	    
	            } catch (IOException e){
	                System.out.println(e.getMessage());
	            }
	        }
	    }
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		
		return vo;
	}
	
	public void getClubUserLevel(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubUserDto Cdto = new ClubUserDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		Cdto.setUSER_ID(user_id);
		ClubUserDto result = dao.getClubLevel(Cdto);

		if(result == null)
			model.addAttribute("user_level", -1);
		else
			model.addAttribute("user_level", result.getUSER_LEVEL());
		request.setAttribute("user_level", result);
		model.addAttribute("user_id", user_id);
	}
	
	public void getClubBoardView(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubBoardDto CBdto = new ClubBoardDto();
	    CBdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
	    CBdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
	    CBdto = dao.getClubBoardView(CBdto);
	    model.addAttribute("BoardView", CBdto);
		request.setAttribute("BoardView", CBdto);
	}
	
	public Object getBoardViewComment(HttpServletRequest request, Model model, String user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);

		int user_id_int = -1;

		if(user_id != null){
			user_id_int = Integer.parseInt(user_id);
		}
		
		ClubBoardDto CBdto = new ClubBoardDto();
	    CBdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
	    ArrayList<CommentDto> Cdtos = new ArrayList<CommentDto>();
	    //ArrayList<CommentDto> Rdtos = new ArrayList<CommentDto>();
	    //ArrayList<CommentDto> CommentResult =  new ArrayList<CommentDto>();
	    CommentDto Cdto = null;
	    //CommentDto Rdto = null;
	    Cdtos = dao.getMainComment(CBdto);
	    for(int i = 0; i < Cdtos.size(); i++){
	    	Cdto = Cdtos.get(i);
	    	if(Cdto.getWRITE_USER() == user_id_int){
	    		Cdto.setIS_WRITER(1);
	    	}
	    	else{
	    		Cdto.setIS_WRITER(0);
	    	}
	    	Cdtos.set(i, Cdto);
	    	/*CommentResult.add(Cdto);
	    	Rdtos = dao.getReplyComment(Cdto);
	    	for(int j = 0; j < Rdtos.size(); j++){
	    		Rdto = Rdtos.get(j);
	    		if(Rdto.getWRITE_USER() == user_id_int){
	    			Rdto.setIS_WRITER(1);
	    		}
	    		else{
	    			Rdto.setIS_WRITER(0);
	    		}
		    	Rdtos.set(j, Rdto);
	    	}
	    	CommentResult.addAll(Rdtos);*/
	    }
	    //model.addAttribute("BoardComment", CommentResult);
	    model.addAttribute("BoardComment", Cdtos);
	    
	    return Cdtos;
	}
	
	public Object getBoardViewLike(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ArrayList<LikeDto> Ldtos = new ArrayList<LikeDto>();
		ClubBoardDto CBdto = new ClubBoardDto();
		LikeDto Ldto = new LikeDto();
	    CBdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
	    Ldtos = dao.getLike(CBdto);
	    model.addAttribute("LikeUsers",Ldtos);

		CBdto.setWRITE_USER(user_id);
		int isLike = dao.ifLike(CBdto);
	    model.addAttribute("IsLike",isLike);
	    Ldto.setIsLike(isLike);

	    JsonDto Jdto = dao.getCountLike(CBdto);
	    model.addAttribute("CountLike",Jdto.getRESULT());
	    Ldto.setCountLike(Jdto.getRESULT());
	    
	    return Ldto;
	}
	
	public JsonDto updateAlbumTitle(HttpServletRequest request){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
	    ClubAlbumDto dto = new ClubAlbumDto();
	    
	    dto.setTITLE(request.getParameter("title"));
	    dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
	    dto.setIS_CLOSED(Integer.parseInt(request.getParameter("is_closed")));
	    dao.updateClubTitle(dto);
	    
	    ClubAlbumDto reDto = dao.getClubAlbum(dto);
	    
		HomeAlarmDto HAdto = new HomeAlarmDto();
		HAdto.setBOARD_TYPE(2);
		HAdto.setBOARD_ID(reDto.getALBUM_CODE());
		if(reDto.getIS_CLOSED() == 0){
			HAdto.setSUB_TYPE(1);
		}
		else if(reDto.getIS_CLOSED() == 1){
			HAdto.setSUB_TYPE(2);
		}
		HAdto.setWRITE_USER(reDto.getUSER_ID());
		HAdto.setCLUB_CODE(reDto.getCLUB_CODE());
		HAdto.setUSER_LEVEL(1);
		makeAlarm(HAdto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(reDto);
		
		return vo;
	}
	
	public void getClubAlbumView(HttpServletRequest request, Model model, int user_id){
		ClubDao CDao = sqlSession.getMapper(ClubDao.class);
		AccountDao aDao = sqlSession.getMapper(AccountDao.class);
		
		int album_code = Integer.parseInt(request.getParameter("album_code"));
		
		//작성글 정보
		ClubAlbumDto cDto = new ClubAlbumDto();
		cDto.setALBUM_CODE(album_code);
		ArrayList<ClubAlbumDto> Pictures = CDao.getClubAlbumView(cDto);
		ClubAlbumDto AlbumInfo = CDao.getClubAlbum(cDto);
		
		//작성자 정보
		AccountDto aDto = new AccountDto();
		aDto.setUSER_ID(AlbumInfo.getUSER_ID());
		AccountDto WriterInfo = aDao.getUserInfo(aDto);
		
		//댓글정보
		AlbumReplyDto rDto = new AlbumReplyDto();
		rDto.setALBUM_CODE(album_code);
		ArrayList<AlbumReplyDto> ReplyInfo = CDao.getAllAlbumReply(rDto);
		
		//좋아요정보
		AlbumLikeDto lDto = new AlbumLikeDto();
		lDto.setALBUM_CODE(album_code);
		lDto.setUSER_ID(user_id);
		AlbumLikeDto LikeInfo = CDao.getAlbumLike(lDto);
		
		//찜정보
		AlbumZzimDto zDto = new AlbumZzimDto();
		zDto.setALBUM_CODE(album_code);
		zDto.setUSER_ID(user_id);
		AlbumZzimDto ZzimInfo = CDao.getAlbumZzim(zDto);
		
		model.addAttribute("Pictures", Pictures);
		model.addAttribute("AlbumInfo", AlbumInfo);
		model.addAttribute("WriterInfo", WriterInfo);
		model.addAttribute("ReplyInfo", ReplyInfo);
		model.addAttribute("LikeInfo", LikeInfo);
		model.addAttribute("ZzimInfo", ZzimInfo);
		model.addAttribute("UserId", user_id);
	}
	
	public JsonDto insertAlbumReply(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		AlbumReplyDto dto = new AlbumReplyDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setREPLY(request.getParameter("reply"));
		dto.setUSER_ID(user_id);
		Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	    dto.setCREATED_DATE(timeStamp.toString().substring(0, 19));
		dao.insertAlbumReply(dto);
		
		AlbumReplyDto reDto = dao.getAlbumReply(dto);
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(reDto);
		return vo;
	}
	
	public JsonDto albumLike(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		AlbumLikeDto dto = new AlbumLikeDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setUSER_ID(user_id);
		dao.likeAlbum(dto);
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public JsonDto albumDislike(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		AlbumLikeDto dto = new AlbumLikeDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setUSER_ID(user_id);
		dao.dislikeAlbum(dto);
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public void AlbumDelete(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto dto = new ClubAlbumDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setIS_DELETED(1);
	    dao.albumDelete(dto);
	}
	
	public JsonDto AlbumUpdate(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto dto = new ClubAlbumDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setTITLE(request.getParameter("title"));
	    dao.albumUpdate(dto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public void getClubUser(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubUserDto Cdto = new ClubUserDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		ArrayList<ClubUserDto> ClubUserInfo = dao.getClubUser(Cdto);
		
		//유저가 클럽 일원인지 확인
		boolean IsMemberFlag = false;
		for(ClubUserDto dto : ClubUserInfo){
			if(dto.getUSER_ID()==user_id)
				IsMemberFlag = true;
		}
		model.addAttribute("IsMemberFlag", IsMemberFlag);
		model.addAttribute("ClubUserInfo", ClubUserInfo);
	}
	
	public Object insertBoard(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubBoardDto CBDto = new ClubBoardDto();
		JsonDto JDto = new JsonDto();

		CBDto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		CBDto.setTITLE(request.getParameter("title"));
		CBDto.setCONTENT(request.getParameter("content"));
		CBDto.setIS_OPEN(Integer.parseInt(request.getParameter("is_open")));
		CBDto.setNOTICE_TYPE(Integer.parseInt(request.getParameter("notice_type")));
		CBDto.setWRITE_USER(user_id);
		CBDto.setPOINT(10);
		dao.insertClubBoard(CBDto);
		
		HomeAlarmDto HAdto = new HomeAlarmDto();
		HAdto.setBOARD_TYPE(1);
		HAdto.setBOARD_ID(CBDto.getBOARD_ID());
		if(CBDto.getNOTICE_TYPE() == 0){
			if(CBDto.getIS_OPEN() == 1){
				HAdto.setSUB_TYPE(1);
			}
			else if(CBDto.getIS_OPEN() == 0){
				HAdto.setSUB_TYPE(2);
			}
		}
		else if(CBDto.getNOTICE_TYPE() == 1){
			if(CBDto.getIS_OPEN() == 1){
				HAdto.setSUB_TYPE(3);
			}
			else if(CBDto.getIS_OPEN() == 0){
				HAdto.setSUB_TYPE(4);
			}
		}
		HAdto.setWRITE_USER(CBDto.getWRITE_USER());
		HAdto.setCLUB_CODE(CBDto.getCLUB_CODE());
		HAdto.setUSER_LEVEL(1);
		makeAlarm(HAdto);
		
		JDto.setRESULT(1);
		
		return JDto;
	}

	public JsonDto album_zzim(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		AlbumZzimDto dto = new AlbumZzimDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setUSER_ID(user_id);
		dao.zzimAlbum(dto);
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public JsonDto album_zzim_cancel(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		AlbumZzimDto dto = new AlbumZzimDto();
		dto.setALBUM_CODE(Integer.parseInt(request.getParameter("album_code")));
		dto.setUSER_ID(user_id);
		dao.ZzimCancel(dto);
		
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public Object updateBoard(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubBoardDto CBDto = new ClubBoardDto();
		JsonDto JDto = new JsonDto();
		
		CBDto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
		CBDto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		CBDto.setTITLE(request.getParameter("title"));
		CBDto.setCONTENT(request.getParameter("content"));
		CBDto.setIS_OPEN(Integer.parseInt(request.getParameter("is_open")));
		CBDto.setNOTICE_TYPE(Integer.parseInt(request.getParameter("notice_type")));
		CBDto.setMODIFY_USER(user_id);
		dao.updateClubBoard(CBDto);
		
		JDto.setRESULT(1);
		
		return JDto;
	}
	
	public Object deleteBoard(HttpServletRequest request, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubBoardDto CBDto = new ClubBoardDto();
		JsonDto JDto = new JsonDto();

		CBDto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
		CBDto.setDELETE_USER(user_id);
		dao.deleteClubBoard(CBDto);
		
		JDto.setRESULT(1);
		
		return JDto;
	}
	
	public void isWriter(HttpServletRequest request, Model model, int user_id){
		
		ClubBoardDto CBDto = (ClubBoardDto) request.getAttribute("BoardView");
		int write_user = CBDto.getWRITE_USER();
		
		if(user_id == write_user)
			model.addAttribute("is_writer", 1);
		else
			model.addAttribute("is_writer", 0);
		
	}
	
	public void arrangeWrite(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubBoardDto Cdto = new ClubBoardDto();
		String is_modify = request.getParameter("is_modify");
		String club_code = request.getParameter("club_code");
		String board_id = request.getParameter("board_id");
		if(is_modify == null || is_modify.equals("")){
			is_modify = "0";
		}
		model.addAttribute("is_modify", is_modify);
		
		if(is_modify.equals("1")){
			Cdto.setCLUB_CODE(Integer.parseInt(club_code));
			Cdto.setBOARD_ID(Integer.parseInt(board_id));
			Cdto = dao.getClubBoardView(Cdto);
		}
		else{
			Cdto.setCONTENT("");
			Cdto.setIS_OPEN(1);
			Cdto.setNOTICE_TYPE(0);
			Cdto.setTITLE("");
		}
		model.addAttribute("original", Cdto);
		model.addAttribute("IS_FED", 0);
	}
	
	public Object getBoardViewZzim(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		BoardZzimDto Zdto = new BoardZzimDto();
		Zdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));

		Zdto.setWRITE_USER(user_id);
		int isZzim = dao.ifBoardZzim(Zdto);
		log.error(isZzim+"\n");
		Zdto.setIS_ZZIM(isZzim);
		
	    model.addAttribute("IsZzim",isZzim);

	    return Zdto;
	}
	
	public void zzimThis(HttpServletRequest request, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		BoardZzimDto Zdto = new BoardZzimDto();
		Zdto.setBOARD_ID(Integer.parseInt(request.getParameter("board_id")));
		Zdto.setWRITE_USER(user_id);
		int isZzim = dao.ifBoardZzim(Zdto);
		if(isZzim == 0){
			dao.zzimThis(Zdto);
		}
		else{
			dao.diszzimThis(Zdto);
		}
	}
	
	public Object insertInquiry(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		ClubInquiryDto CIDto = new ClubInquiryDto();
		ClubInquiryDto RCIDto = null;

		CIDto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		CIDto.setTITLE(request.getParameter("title"));
		CIDto.setCONTENT(request.getParameter("content"));
		String inquiry_type = request.getParameter("inquiry_type");
		if(inquiry_type != null && !inquiry_type.equals("")){
			CIDto.setINQUIRY_TYPE(Integer.parseInt(inquiry_type));
		}
		CIDto.setWRITE_USER(user_id);
		String depth = request.getParameter("depth");
		// DEPTH가 1일경우 5점(답변), 0일경우(값 입력안했을경우) 0점;
		CIDto.setPOINT(5);
		if(depth != null && !depth.equals("")){
			CIDto.setDEPTH(Integer.parseInt(depth));
			CIDto.setPOINT(0);
		}
		String parent_id = request.getParameter("parent_id");
		if(parent_id != null && !parent_id.equals("")){
			CIDto.setPARENT_ID(Integer.parseInt(parent_id));
		}
		dao.insertClubInquiry(CIDto);
		
		if(depth != null && depth.equals("1")){
			RCIDto = new ClubInquiryDto();
			RCIDto.setINQUIRY_ID(Integer.parseInt(parent_id));
			RCIDto = dao.getClubInquiryView(RCIDto);
		}
	    
		HomeAlarmDto HAdto = new HomeAlarmDto();
		HAdto.setBOARD_TYPE(3);
		HAdto.setBOARD_ID(CIDto.getINQUIRY_ID());
		HAdto.setWRITE_USER(CIDto.getWRITE_USER());
		HAdto.setCLUB_CODE(CIDto.getCLUB_CODE());
		if(CIDto.getDEPTH() == 0){
			HAdto.setSUB_TYPE(1);
			HAdto.setUSER_LEVEL(2);
			makeAlarm(HAdto);
		}
		else if(CIDto.getDEPTH() == 1){
			HAdto.setSUB_TYPE(2);
			HAdto.setUSER_ID(RCIDto.getWRITE_USER());
			makeAlarmForOne(HAdto);
		}

		Jdto.setRESULT(1);
		
		return Jdto;
	}
	
	private void makeAlarmForOne(HomeAlarmDto HAdto) {
		HomeDao dao = sqlSession.getMapper(HomeDao.class);
		dao.makeAlarmForOne(HAdto);
	}

	public Object updateInquiry(HttpServletRequest request, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		ClubInquiryDto CIDto = new ClubInquiryDto();

		CIDto.setINQUIRY_ID(Integer.parseInt(request.getParameter("inquiry_id")));
		CIDto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		CIDto.setTITLE(request.getParameter("title"));
		CIDto.setCONTENT(request.getParameter("content"));
		CIDto.setINQUIRY_TYPE(Integer.parseInt(request.getParameter("notice_type")));
		CIDto.setMODIFY_USER(user_id);
		dao.updateClubInquiry(CIDto);
		
		Jdto.setRESULT(1);
		
		return Jdto;
	}
	
	public void returnPageControll(HttpServletRequest request, Model model){
		String mode = request.getParameter("mode");
		if(mode != null) {
			model.addAttribute("mode", mode);
		}
	}
	
	public Object getAlbumSearch(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto dto = new ClubAlbumDto();
		
		dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		dto.setTITLE(request.getParameter("word"));
		ArrayList<ClubAlbumDto> reDto = dao.getAlbumSearch(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		Jdto.setVALUE(reDto);
		
		return Jdto;
	}
	
	public Object getClubInquiry(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 0);
		ArrayList<ClubInquiryDto> result = null;
		
		ClubInquiryDto Cdto = new ClubInquiryDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		
		String last_iid = request.getParameter("last_iid");
		if(last_iid == null || last_iid.equals("")){
			last_iid = "-1";
		}
		Cdto.setINQUIRY_ID(Integer.parseInt(last_iid));
		
		String num_load = request.getParameter("num_load");
		if(num_load == null || num_load.equals("")){
			num_load = "10";
		}
		Cdto.setNUM_LOAD(Integer.parseInt(num_load));
		
		String inquiry_type = request.getParameter("inquiry_type");
		if(inquiry_type == null || inquiry_type.equals("")){
			inquiry_type = "-1";
		}
		Cdto.setINQUIRY_TYPE(Integer.parseInt(inquiry_type));
		
		Cdto.setDEPTH(0);
		
		result = dao.getClubInquiry(Cdto);
		
		for(int i = 0; i < result.size(); i++){
			Cdto = result.get(i);
			Cdto.setIS_RESPONSED(dao.ifResponsed(Cdto));
			result.set(i, Cdto);
		}
		
		model.addAttribute("ClubAdminInquiry", result);
		return result;
	}
	
	public Object getAlbumMore(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto dto = new ClubAlbumDto();
		
		log.error(request.getParameter("club_code"));
		log.error(request.getParameter("page"));
		dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		dto.setLIMIT_START(Integer.parseInt(request.getParameter("page"))*6);
		ArrayList<ClubAlbumDto> reDto = dao.getAlbumMore(dto);
		
		JsonDto Jdto = new JsonDto();
		if(reDto.isEmpty()){
			Jdto.setRESULT(0);
		} else {
			Jdto.setRESULT(1);
			Jdto.setVALUE(reDto);
		}
		
		return Jdto;
	} 
	
	public Object getAlbumSearchMore(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto dto = new ClubAlbumDto();
		
		dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		dto.setTITLE(request.getParameter("word"));
		dto.setLIMIT_START(Integer.parseInt(request.getParameter("search_page"))*6);
		ArrayList<ClubAlbumDto> reDto = dao.getAlbumSearchMore(dto);
		
		JsonDto Jdto = new JsonDto();
		if(reDto.isEmpty()){
			Jdto.setRESULT(0);
		} else {
			Jdto.setRESULT(1);
			Jdto.setVALUE(reDto);
		}
		
		return Jdto;
	} 
	
	public void getManager(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		int club_code = Integer.parseInt(request.getParameter("club_code"));
		
		//동호회 정보
		ClubDto Cdto = new ClubDto();
		Cdto.setCLUB_CODE(club_code);
		ClubDto club_info = dao.getClubInfo(Cdto);
		
		model.addAttribute("club_info", club_info);
	}
	
	public void getClubInquiryView(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubInquiryDto CIdto = new ClubInquiryDto();
		
		CIdto.setINQUIRY_ID(Integer.parseInt(request.getParameter("inquiry_id")));
		
		CIdto = dao.getClubInquiryView(CIdto);
		
		model.addAttribute("ClubInquiryView", CIdto);
		model.addAttribute("IS_FED", 0);
	}
	
	public JsonDto getPaidList(HttpServletRequest request) throws ParseException{
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
		int club_code = Integer.parseInt(request.getParameter("club_code"));
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = CommonUtil.dateForm(year, month);
		
		//유저 회비 지불체크
		ClubUserPaidDto Pdto = new ClubUserPaidDto();
		Pdto.setCLUB_CODE(club_code);
		Pdto.setDATE(date);
		ArrayList<ClubUserPaidDto> user_info_check = dao.getClubUserPaid(Pdto);
		
		//주소록 추가 유저 회비 지불체크
		ClubUserPaidAddressDto CUPdto = new ClubUserPaidAddressDto();
		CUPdto.setDATE(date);
		CUPdto.setCLUB_CODE(club_code);
		ArrayList<ClubUserPaidAddressDto> user_address_info_check = dao.getClubUserAddressPaid(CUPdto);
		
		//유저 회비 지불내역
		ClubUserFeeDto Fdto = new ClubUserFeeDto();
		Fdto.setCLUB_CODE(club_code);
		Fdto.setCREATED_DATE(date);
		ArrayList<ClubUserFeeDto> user_info = dao.getClubUserFee(Fdto);
		
		//주소록 추가 유저 회비 지불내역
		ClubUserFeeAddressDto CUAdto = new ClubUserFeeAddressDto();
		CUAdto.setCREATED_DATE(date);
		CUAdto.setCLUB_CODE(club_code);
		ArrayList<ClubUserFeeAddressDto> user_address_info = dao.getClubUserAddressFee(CUAdto);
		
		//fee_list에 요금내역만 순서대로 넣기
		ArrayList<Integer> fee_list = new ArrayList<>();
		for(int i=0;i<user_info.size();i++)
			fee_list.add(user_info.get(i).getFEE());
		
		for(int i=0;i<user_address_info.size();i++)
			fee_list.add(user_address_info.get(i).getFEE());
		
		ArrayList<ArrayList> value = new ArrayList<ArrayList>();
		value.add(user_info_check);
		value.add(user_address_info_check);
		value.add(fee_list);
	    
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(value);
		return vo;
	}
	
	public JsonDto userPaidCheck(HttpServletRequest request){
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubUserPaidDto dto = new ClubUserPaidDto();
	    
	    String date = "0000-01-01 00:00:00";
	    try {
			date = CommonUtil.dateForm(request.getParameter("year"), request.getParameter("month"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
	    dto.setUSER_ID(Integer.parseInt(request.getParameter("user_id")));
	    dto.setDATE(date);
	    
	    dao.userPaidCheck(dto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public JsonDto userPaidUncheck(HttpServletRequest request){
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubUserPaidDto dto = new ClubUserPaidDto();
	    
	    String date = "0000-01-01 00:00:00";
	    try {
			date = CommonUtil.dateForm(request.getParameter("year"), request.getParameter("month"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    dto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
	    dto.setUSER_ID(Integer.parseInt(request.getParameter("user_id")));
	    dto.setDATE(date);
	    
	    dao.userPaidUncheck(dto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	public void getAllClubType(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubDto> Cdtos = dao.getAllClubType();
		model.addAttribute("club_type", Cdtos);
	}
	
	public void getAllClubTarget(HttpServletRequest request, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubDto> Cdtos = dao.getAllClubTarget();
		model.addAttribute("club_target", Cdtos);
	}

	public void createClub(HttpServletRequest request, Model model) {
		locationService.getSi(model);
		locationService.getAllGu(request, model);
		sportsTypeService.getGroupedSports(request, model);
		getAllClubType(request, model);
		getAllClubTarget(request, model);
	}
	
	public JsonDto submitClubCreate(HttpServletRequest request, int user_id) throws ParseException {
		// 클럽정보 INSERT
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubDto Cdto = new ClubDto();
		Cdto.setCLUB_NAME(request.getParameter("club_name"));
		Cdto.setMEMBER_NUM(Integer.parseInt(request.getParameter("member_num")));
		Cdto.setINTRODUCTION(request.getParameter("introduction"));
		Cdto.setLOCATION_CODE(Integer.parseInt(request.getParameter("location_code")));
		Cdto.setSPORTS_TYPE_CODE(Integer.parseInt(request.getParameter("sports_type_code")));
		Cdto.setESTABLISHMENT_YEAR(request.getParameter("establishment_year"));
		Cdto.setCLUB_TYPE_CODE(Integer.parseInt(request.getParameter("club_type_code")));
		Cdto.setCLUB_TARGET_CODE(Integer.parseInt(request.getParameter("club_target_code")));
		dao.makeClub(Cdto);
		
		log.error(Cdto.getCLUB_CODE());
		
		// 클럽회원에 작성자 추가
		JsonDto Jdto = insertClubUser(request, Cdto, "new", user_id);
		
		return Jdto;
	}
	
	// 동호회 회원 추가
	public JsonDto insertClubUser(HttpServletRequest request, ClubDto Cdto, String form, int user_id) throws ParseException {
		JsonDto Jdto = new JsonDto();
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubUserDto CUdto = new ClubUserDto();
		
		int club_code = Cdto.getCLUB_CODE();
		CUdto.setCLUB_CODE(club_code);
		
		if(form == "new"){
			CUdto.setUSER_LEVEL(2);
		}
		else{
			CUdto.setUSER_LEVEL(1);
		}
		Timestamp timeStamp = new Timestamp(System.currentTimeMillis());
	    String year = timeStamp.toString().substring(0, 4);
	    String month = timeStamp.toString().substring(5, 7);
	    String date = CommonUtil.dateForm(year, month);
		
		CUdto.setUSER_ID(user_id);
		CUdto.setCREATED_DATE(date);
		CUdto.setPOINT(500);
		dao.insertClubUser(CUdto);
		
		//유저 회비 입력
		ClubUserFeeDto UFdto = new ClubUserFeeDto();
		
	    UFdto.setCLUB_CODE(club_code);
	    UFdto.setUSER_ID(user_id);
		ClubFeeDto Fdto = new ClubFeeDto();
		Fdto.setFIRST_DAY_OF_MONTH(CommonUtil.dateForm(year, month));
	    ClubFeeDto club_fee = dao.getClubFee(Fdto);
		
	    if(form == "new" || club_fee==null){
	    	UFdto.setFEE(0);
		} else {
			UFdto.setFEE(club_fee.getFEE());
		}
	    
		UFdto.setCREATED_DATE(CommonUtil.dateForm(year, month));
	    dao.insertUserFee(UFdto);
		
		Jdto.setRESULT(Cdto.getCLUB_CODE());
		
		return Jdto;
	}
	
	public JsonDto getFeeList(HttpServletRequest request) throws ParseException{
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
		int club_code = Integer.parseInt(request.getParameter("club_code"));
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		String date = CommonUtil.dateForm(year, month);
		log.error(date);
		
		//유저 회비 지불내역
		ClubUserFeeDto Fdto = new ClubUserFeeDto();
		Fdto.setCLUB_CODE(club_code);
		Fdto.setCREATED_DATE(date);
		ArrayList<ClubUserFeeDto> user_info = dao.getClubUserFee(Fdto);
		
		//주소록 추가 유저 회비 지불내역
		ClubUserFeeAddressDto CUAdto = new ClubUserFeeAddressDto();
		CUAdto.setCREATED_DATE(date);
		CUAdto.setCLUB_CODE(club_code);
		ArrayList<ClubUserFeeAddressDto> user_address_info = dao.getClubUserAddressFee(CUAdto);
		
		ArrayList<ArrayList> value = new ArrayList<ArrayList>();
		value.add(user_info);
		value.add(user_address_info);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		vo.setVALUE(value);
		return vo;
	}
	
	public JsonDto FeeUpdate(HttpServletRequest request) throws ParseException, org.json.simple.parser.ParseException{
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    
	    int club_code = Integer.parseInt(request.getParameter("club_code"));
	    String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = CommonUtil.dateForm(year, month);
	    
	    //일반유저
	    ClubUserFeeDto Fdto = new ClubUserFeeDto();
	    Fdto.setCLUB_CODE(club_code);
	    Fdto.setCREATED_DATE(date);
	    
	    //주소록추가 유저
	    ClubUserFeeAddressDto FAdto = new ClubUserFeeAddressDto();
	    FAdto.setCREATED_DATE(date);
	    FAdto.setCLUB_CODE(club_code);
	    
	    //기존에 그 달에 존재하는 데이터 다 지우기
	    dao.deleteFeeList(Fdto);
	    dao.deleteAddressFeeList(FAdto);
	    
	    //insert
	    String json_info = request.getParameter("json_user");
	    JSONParser jsonParser = new JSONParser();
	    JSONArray jsonArr = (JSONArray)jsonParser.parse(json_info);
	    for(int i=0;i<jsonArr.size();i++){
	    	JSONObject obj = (JSONObject)jsonArr.get(i);
	    	Fdto.setUSER_ID(Integer.parseInt(obj.get("user_id").toString()));
	    	Fdto.setFEE(Integer.parseInt(obj.get("fee").toString()));
	    	dao.insertUserFee(Fdto);
	    }
	    
	    String json_info_address = request.getParameter("json_address_user");
	    JSONParser jsonParser_address = new JSONParser();
	    JSONArray jsonArr_address = (JSONArray)jsonParser_address.parse(json_info_address);
	    for(int i=0;i<jsonArr_address.size();i++){
	    	JSONObject obj = (JSONObject)jsonArr_address.get(i);
	    	FAdto.setUSER_ADDRESS_CODE(Integer.parseInt(obj.get("user_address_code").toString()));
	    	FAdto.setFEE(Integer.parseInt(obj.get("fee").toString()));
	    	dao.insertAddressUserFee(FAdto);
	    }
	    
	    //기본금액 저장
	    //기본 -1 / -1이 아닐경우 insert
	    int basic_cost = Integer.parseInt(request.getParameter("fee"));
	    if(basic_cost != -1){
	    	ClubFeeDto CFdto = new ClubFeeDto();
		    CFdto.setCLUB_CODE(club_code);
		    CFdto.setFIRST_DAY_OF_MONTH(CommonUtil.dateForm(year, month));
		    CFdto.setFEE(basic_cost);
		    dao.insertClubFee(CFdto);
	    }
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	
	
	public JsonDto editClubInfo(HttpServletRequest request){
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubDto Cdto = new ClubDto();
	    String column = request.getParameter("dbMapColumn");
	    String type = request.getParameter("dbMapType");
	    String value = request.getParameter("value");
	    String club_code = request.getParameter("club_code");
    	Cdto.setCLUB_CODE(Integer.parseInt(club_code));
	    
	    if(column.equals("CLUB_NAME")){
	    	Cdto.setCLUB_NAME(value);
	    	dao.updateClubInfoClubName(Cdto);
	    }
	    else if(column.equals("SKILL_POINT")){
	    	Cdto.setSKILL_POINT(Integer.parseInt(value));
	    	dao.updateClubInfoSkillPoint(Cdto);
	    }
	    else if(column.equals("MATCH_DATE")){
	    	Cdto.setMATCH_DATE(value);
	    	dao.updateClubInfoMatchDate(Cdto);
	    }
	    else if(column.equals("EXERCISE_PLACE")){
	    	Cdto.setEXERCISE_PLACE(value);
	    	dao.updateClubInfoExercisePlace(Cdto);
	    }
	    else if(column.equals("EXERCISE_TIME")){
	    	Cdto.setEXERCISE_TIME(value);
	    	dao.updateClubInfoExerciseTime(Cdto);
	    }
	    else if(column.equals("CLUB_TARGET_CODE")){
	    	Cdto.setCLUB_TARGET_CODE(Integer.parseInt(value));
	    	dao.updateClubInfoClubTargetCode(Cdto);
	    }
	    else if(column.equals("INTRODUCTION")){
	    	Cdto.setINTRODUCTION(value);
	    	dao.updateClubInfoIntroduction(Cdto);
	    }
	    else if(column.equals("MEMBER_NUM")){
	    	Cdto.setMEMBER_NUM(Integer.parseInt(value));
	    	dao.updateClubInfoMemberNum(Cdto);
	    }
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);

		return vo;
	}
	
	public JsonDto changeClubImage(HttpServletRequest request){
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
	    ClubDto Cdto = new ClubDto();
	    String club_code = request.getParameter("club_code");
	    String file_name = request.getParameter("file_name");
	    String ts = Long.toString(System.currentTimeMillis());
	    Cdto.setCLUB_CODE(Integer.parseInt(club_code));
	    Base64.Decoder decoder = Base64.getDecoder();
	    
	    String imageData = request.getParameter("imageData");
	    String typename = imageData.split("/")[1].split(";")[0];
	    String resultImageDirectorySuffix = "resources/upload/club/"+file_name+"_"+ts+"."+typename;
	    String resultImageDirectory = servletContext.getRealPath("/")+resultImageDirectorySuffix;
	    try {
			new FileOutputStream(resultImageDirectory).write(decoder.decode(imageData.split(",")[1]));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    resultImageDirectorySuffix = "/SportForAll/"+resultImageDirectorySuffix;
	    log.error(resultImageDirectorySuffix);
	    Cdto.setMAIN_PIC(resultImageDirectorySuffix);
	    
	    dao.updateClubInfoMainPic(Cdto);
	    
	    JsonDto vo = new JsonDto();
		vo.setRESULT(1);

		return vo;
	}

	public void init_club_close(HttpServletRequest request, Model model, String user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubUserDto> CUdtos = null;
		ClubUserDto CUdto = new ClubUserDto();
		CUdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		if(user_id != null && !user_id.equals("")){
			CUdto.setUSER_ID(Integer.parseInt(user_id));
		}
		CUdtos = dao.getManagers(CUdto);
		request.setAttribute("managers", CUdtos);
		request.setAttribute("user_id", user_id);
	}
	

	public Object club_agree_delete(HttpServletRequest request) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubUserDto CUdto = new ClubUserDto();
		JsonDto Jdto = new JsonDto();
		
		String club_code = request.getParameter("club_code");
		CUdto.setCLUB_CODE(Integer.parseInt(club_code));
		String user_id = request.getParameter("user_id");
		CUdto.setUSER_ID(Integer.parseInt(user_id));
		
		if(dao.isAgreedDeleteClub(CUdto) == 1){
			CUdto.setAGREE_DELETE(0);
		}
		else{
			CUdto.setAGREE_DELETE(1);
		}
		dao.agreeDeleteClub(CUdto);
		Jdto.setRESULT(1);
		if(dao.countNotAgreedDeleteClub(CUdto) == 0){
			Jdto.setRESULT(2);
		}
		return Jdto;
	}

	public Object confirm_delete_club(HttpServletRequest request, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubDto Cdto = new ClubDto();
		JsonDto Jdto = new JsonDto();
		
		String club_code = request.getParameter("club_code");
		Cdto.setCLUB_CODE(Integer.parseInt(club_code));
		Cdto.setDELETE_USER(user_id);
		
		dao.confirmDeleteClub(Cdto);
		
		Jdto.setRESULT(1);
		
		return Jdto;
	}
	
	public JsonDto insertAddressUser(ClubUserAddressDto dto) throws ParseException {
	    ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
//	    //클럽 이번달 회비 받아오기
	    String year = dto.getCREATED_DATE().substring(0, 4);
		String month = dto.getCREATED_DATE().substring(5, 7);
		ClubFeeDto CFdto = new ClubFeeDto();
		CFdto.setFIRST_DAY_OF_MONTH(CommonUtil.dateForm(year, month));
		ClubFeeDto club_fee = dao.getClubFee(CFdto);
		int basic_fee;
		
		//이번달 회비
		if(club_fee==null){
			basic_fee = 0;
		} else {
			basic_fee = club_fee.getFEE();
		}
		
		//입력
		dao.insertAddressUser(dto);
		ClubUserAddressDto inserted_user = dao.getAddressUser(dto);
		
		//기본금액으로 회비 등록
		ClubUserFeeAddressDto CUFdto = new ClubUserFeeAddressDto();
		CUFdto.setUSER_ADDRESS_CODE(inserted_user.getUSER_ADDRESS_CODE());
		CUFdto.setFEE(basic_fee);
		CUFdto.setCREATED_DATE(CommonUtil.dateForm(year, month));
		CUFdto.setCLUB_CODE(dto.getCLUB_CODE());
		
		dao.insertAddressUserFee(CUFdto);
		
	    JsonDto vo = new JsonDto();
	    vo.setRESULT(1);
	    vo.setVALUE(CUFdto);
		return vo;
	}

	public Object invite_user(ClubInviteDto CIdto, HttpServletRequest request, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubInviteDto> CIdtos = null;
		JsonDto Jdto = new JsonDto();
		
		/*dto.setUSER_LEVEL(1);
		dto.setPOINT(500);
		dao.insertClubUser(dto);*/
		
		Jdto.setRESULT(1);
		
		int user_id_int = user_id;
		CIdto.setINVITE_USER(user_id_int);
		
		CIdtos = dao.getSameInvite(CIdto);
		
		if(CIdtos.size() == 0){
			dao.inviteUser(CIdto);
			HomeAlarmDto HAdto = new HomeAlarmDto();
			HomeDao Hdao = sqlSession.getMapper(HomeDao.class);
			HAdto.setUSER_ID(CIdto.getUSER_ID());
			HAdto.setWRITE_USER(user_id_int);
			HAdto.setCLUB_CODE(CIdto.getCLUB_CODE());
			HAdto.setBOARD_TYPE(7);
			HAdto.setSUB_TYPE(1);
			HAdto.setBOARD_ID(CIdto.getINVITE_ID());
			log.error(CIdto.getINVITE_ID());
			Hdao.makeAlarmForOne(HAdto);
			Jdto.setRESULT(0);
		}
		else{
			if(CIdtos.get(0).getINVITE_STATE() == 0){	// 아직 초대에 대한 응답을 안한 유저는 스택만 증가
				dao.incrementStackInvite(CIdto);
				Jdto.setRESULT(1);
			}
			else if(CIdtos.get(0).getINVITE_STATE() == 1){	// 이전에 초대를 거절했을 경우 다시 새로운 초대
				dao.inviteUser(CIdto);
				HomeAlarmDto HAdto = new HomeAlarmDto();
				HomeDao Hdao = sqlSession.getMapper(HomeDao.class);
				HAdto.setUSER_ID(CIdto.getUSER_ID());
				HAdto.setWRITE_USER(user_id_int);
				HAdto.setCLUB_CODE(CIdto.getCLUB_CODE());
				HAdto.setBOARD_TYPE(7);
				HAdto.setSUB_TYPE(1);
				HAdto.setBOARD_ID(CIdto.getINVITE_ID());
				log.error(CIdto.getINVITE_ID());
				Hdao.makeAlarmForOne(HAdto);
				Jdto.setRESULT(2);
			}
			else if(CIdtos.get(0).getINVITE_STATE() == 2){	// 초대를 이미 승낙한 사용자를 초대했을 경우
				Jdto.setRESULT(3);
			}
		}
		
		return Jdto;
	}

	public void get_search_log(Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubSearchLogDto CSdto = new ClubSearchLogDto();
		
		CSdto.setUSER_ID(user_id);
		ArrayList<ClubSearchLogDto> CSdtos = dao.getClubSearchLog(CSdto);
		model.addAttribute("search_log_recent", CSdtos);
		
		CSdto.setUSER_ID(-1);
		CSdto.setINTERVAL(7);
		CSdtos = dao.getClubSearchLog(CSdto);
		model.addAttribute("search_log_popular", CSdtos);
	}

	public Object add_log_search(ClubSearchLogDto CSdto, HttpServletRequest request, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		CSdto.setUSER_ID(user_id);
		dao.insertLogSearch(CSdto);
		Jdto.setRESULT(1);
		return Jdto;
	}

	public Object get_club_search_result(ClubDto Cdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		String keyword = "%"+Cdto.getCLUB_NAME()+"%";
		Cdto.setCLUB_NAME(keyword);
		Cdto.setSI(keyword);
		Cdto.setGU(keyword);
		Cdto.setCATEGORY(keyword);
		Cdto.setSPORTS_NAME(keyword);
		Cdto.setPAGE_NUM(Cdto.getPAGE_NUM()*5);
		
		ArrayList<ClubDto> Cdtos = dao.getClubSearchResult(Cdto);
		
		model.addAttribute("search_club_list", Cdtos);
		
		return Cdtos;
	}
	
	public Object deleteAddressUser(ClubUserAddressDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.deleteUserAddress(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	public Object paidAddress(ClubUserPaidAddressDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.insertUserPaidAddress(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	public Object paidCancelAddress(ClubUserPaidAddressDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.deleteUserPaidAddress(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	

	public void getClubPointList(Model model, ClubDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		Cdto = dao.getClubInfo(Cdto);
		calcClubPoint(model, Cdto);
	}

	private ClubDto calcClubPoint(Model model, ClubDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubPointDto> CPdtos = new ArrayList<ClubPointDto>();
		ClubPointDto CPdto = null;
		int point_total = 0;
		
		CPdto = dao.getUserPoint(Cdto);
		CPdto.setPOINT_CATEGORY(0);
		CPdtos.add(CPdto);
		point_total += CPdto.getPOINTS();
		
		CPdto = dao.getBoardPoint(Cdto);
		CPdto.setPOINT_CATEGORY(1);
		CPdtos.add(CPdto);
		point_total += CPdto.getPOINTS();
		
		CPdto = dao.getAlbumPoint(Cdto);
		CPdto.setPOINT_CATEGORY(2);
		CPdtos.add(CPdto);
		point_total += CPdto.getPOINTS();
		
		CPdto = dao.getInquiryPoint(Cdto);
		CPdto.setPOINT_CATEGORY(3);
		CPdtos.add(CPdto);
		point_total += CPdto.getPOINTS();
		
		model.addAttribute("point_list", CPdtos);
		model.addAttribute("point_total", point_total);
		Cdto.setPOINTS(point_total);
		return Cdto;
		/*
		ArrayList<ClubPointDto> CPdtos = new ArrayList<ClubPointDto>();
		ArrayList<ClubPointDto> PPdtos = null;
		ClubPointDto CPdto = null, PPdto = null;
		int bitmask_category = 0x0;
		int club_code = Cdto.getCLUB_CODE();
		int count = 0;
		int point_total = 0;
		String limit_date = "";
		PPdtos = dao.getPointPolicy();
		
		for(int i = 0; i < PPdtos.size(); i++){
			PPdto = PPdtos.get(i);
			if(PPdto.getPOINT_CATEGORY() == 0){
				if((bitmask_category & 0x1) == 0x0){
					if(CPdto != null){
						CPdtos.add(CPdto);
					}
					bitmask_category |= 0x1;
					limit_date = "9999-12-31";
					CPdto = new ClubPointDto();
					CPdto.setPOINT_CATEGORY(0);
					CPdto.setPOINTS(0);
					CPdto.setCOUNT(0);
				}
				PPdto.setCLUB_CODE(club_code);
				PPdto.setLIMIT_DATE(limit_date);
				count = dao.getCountClubUserForPoints(PPdto);
				CPdto.setCOUNT(CPdto.getCOUNT() + count);
				CPdto.setPOINTS(CPdto.getPOINTS() + count*PPdto.getPOINTS());
				point_total += count*PPdto.getPOINTS();
				limit_date = PPdto.getISSUE_DATE();
			}
			else if(PPdto.getPOINT_CATEGORY() == 1){
				if((bitmask_category & 0x10) == 0x00){
					if(CPdto != null){
						CPdtos.add(CPdto);
					}
					bitmask_category |= 0x10;
					limit_date = "9999-12-31";
					CPdto = new ClubPointDto();
					CPdto.setPOINT_CATEGORY(1);
					CPdto.setPOINTS(0);
					CPdto.setCOUNT(0);
				}
				PPdto.setCLUB_CODE(club_code);
				PPdto.setLIMIT_DATE(limit_date);
				count = dao.getCountClubBoardForPoints(PPdto);
				CPdto.setCOUNT(CPdto.getCOUNT() + count);
				CPdto.setPOINTS(CPdto.getPOINTS() + count*PPdto.getPOINTS());
				point_total += count*PPdto.getPOINTS();
				limit_date = PPdto.getISSUE_DATE();
			}
			else if(PPdto.getPOINT_CATEGORY() == 2){
				if((bitmask_category & 0x100) == 0x000){
					if(CPdto != null){
						CPdtos.add(CPdto);
					}
					bitmask_category |= 0x100;
					limit_date = "9999-12-31";
					CPdto = new ClubPointDto();
					CPdto.setPOINT_CATEGORY(2);
					CPdto.setPOINTS(0);
					CPdto.setCOUNT(0);
				}
				PPdto.setCLUB_CODE(club_code);
				PPdto.setLIMIT_DATE(limit_date);
				count = dao.getCountClubAlbumForPoints(PPdto);
				CPdto.setCOUNT(CPdto.getCOUNT() + count);
				CPdto.setPOINTS(CPdto.getPOINTS() + count*PPdto.getPOINTS());
				point_total += count*PPdto.getPOINTS();
				limit_date = PPdto.getISSUE_DATE();
			}
			else if(PPdto.getPOINT_CATEGORY() == 3){
				if((bitmask_category & 0x1000) == 0x0000){
					if(CPdto != null){
						CPdtos.add(CPdto);
					}
					bitmask_category |= 0x1000;
					limit_date = "9999-12-31";
					CPdto = new ClubPointDto();
					CPdto.setPOINT_CATEGORY(3);
					CPdto.setPOINTS(0);
					CPdto.setCOUNT(0);
				}
				PPdto.setCLUB_CODE(club_code);
				PPdto.setLIMIT_DATE(limit_date);
				count = dao.getCountClubInquiryResponseForPoints(PPdto);
				CPdto.setCOUNT(CPdto.getCOUNT() + count);
				CPdto.setPOINTS(CPdto.getPOINTS() + count*PPdto.getPOINTS());
				point_total += count*PPdto.getPOINTS();
				limit_date = PPdto.getISSUE_DATE();
			}
		}
		CPdtos.add(CPdto);
		model.addAttribute("point_list", CPdtos);
		model.addAttribute("other_point", Cdto.getPOINTS());
		model.addAttribute("point_total", Cdto.getPOINTS() + point_total);
		Cdto.setPOINTS(Cdto.getPOINTS() + point_total);
		return Cdto;
		*/
	}
	
	public void getAlbumReply(AlbumReplyDto dto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		AlbumReplyDto reply_info = dao.getAlbumReplyById(dto);
		log.error(reply_info.getREPLY());
		
		model.addAttribute("reply_info", reply_info);
	}
	
	public Object albumReplyUpdate(AlbumReplyDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.updateAlbumReply(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	public Object albumReplyDelete(AlbumReplyDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.deleteAlbumReply(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}

	public Object isClubZzimed(HttpServletRequest request, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubDto Cdto = new ClubDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));

		Cdto.setWRITE_USER(user_id);
		int isZzimed = dao.isClubZzimed(Cdto);
		log.error(isZzimed+"\n");
		Cdto.setIS_ZZIMED(isZzimed);
		
	    model.addAttribute("IS_ZZIMED",isZzimed);

	    return Cdto;
	}
	
	public Object zzimClub(HttpServletRequest request, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubDto Cdto = new ClubDto();
		Cdto.setCLUB_CODE(Integer.parseInt(request.getParameter("club_code")));
		Cdto.setWRITE_USER(user_id);
		int isZzim = dao.isClubZzimed(Cdto);
		if(isZzim == 0){
			dao.zzimClub(Cdto);
		}
		else{
			dao.diszzimClub(Cdto);
		}
		Cdto.setIS_ZZIMED(dao.isClubZzimed(Cdto));
		return Cdto;
	}
	
	public Object clubMainPicUpload(ClubDto dto){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
	   
	    Base64.Decoder decoder = Base64.getDecoder();
	    try {
	    	String imageData = dto.getMAIN_PIC();
		    String typename = imageData.split("/")[1].split(";")[0];
		    String newname = "main_" + System.currentTimeMillis()+"."+typename;
		    String resultImageDirectorySuffix = "resources/upload/club/main/"+newname;
		    String resultImageDirectory = servletContext.getRealPath("/")+resultImageDirectorySuffix;
			new FileOutputStream(resultImageDirectory).write(decoder.decode(imageData.split(",")[1]));
			
			dto.setMAIN_PIC(newname);
			dao.updateMainPic(dto);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		JsonDto vo = new JsonDto();
		vo.setRESULT(1);
		return vo;
	}
	private void makeAlarm(HomeAlarmDto HAdto) {
		HomeDao dao = sqlSession.getMapper(HomeDao.class);
		dao.makeAlarm(HAdto);
	}

	public void getClubInquiryResponseView(ClubInquiryDto CIdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CIdto = dao.getClubInquiryView(CIdto);
		model.addAttribute("response", CIdto);
		CIdto.setINQUIRY_ID(CIdto.getPARENT_ID());
		CIdto = dao.getClubInquiryView(CIdto);
		model.addAttribute("inquiry", CIdto);
	}

	public void getFedDetail(ClubDto Cdto, Model model, int user_id) {
		int user_level = getFedUserLevel(Cdto, model, user_id).getUSER_LEVEL();
		model.addAttribute("IS_FED", 1);
		model.addAttribute("user_id", user_id);
		model.addAttribute("IsMemberFlag", user_level);
		
		Cdto.setUSER_LEVEL(user_level);
		getFedInfo(Cdto, model);
		getFedAlbumInfo(Cdto, model);
		getFedBoard(Cdto, model);
		getFedManagerLevel(Cdto, model, user_id);
		
		int club_code = getFedClubCode(Cdto);
		model.addAttribute("club_code", club_code);
		getFedClubAlbum(club_code, model);
		
		ClubUserDto CUdto = new ClubUserDto();
		CUdto.setFED_CODE(Cdto.getFED_CODE());
		getFedManager2(Cdto, model);
	}
	
	public void getFedManagerLevel(ClubDto dto, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		FedManagerDto Fdto = new FedManagerDto();
		Fdto.setUSER_ID(user_id);
		Fdto.setFED_CODE(dto.getFED_CODE());
		Fdto = dao.getFedManagerLevel(Fdto);
		if(Fdto != null){
			int level = Fdto.getUSER_LEVEL();
			model.addAttribute("user_level", level);
		}
	}
	
	private int getFedClubCode(ClubDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		int club_code = dao.getFedClubCode(Cdto).getCLUB_CODE();
		return club_code;
	}
	
	public void getFedClubAlbum(int club_code, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		ClubAlbumDto Cdto = new ClubAlbumDto();
		Cdto.setCLUB_CODE(club_code);
		ArrayList<ClubAlbumDto> result = dao.getAllClubAlbum(Cdto);
		
		model.addAttribute("ClubAlbum", result);
	}

	private void getFedInfo(ClubDto Cdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		Cdto = dao.getFedInfo(Cdto);
		model.addAttribute("ClubInfo", Cdto);
		
		ArrayList<ClubDto> Cdtos = dao.getFedMember(Cdto);
		Cdtos.addAll(dao.getFedMemberNotJoined(Cdto));
		model.addAttribute("FedMemberList", Cdtos);
	}

	public Object insertFedInquirySwitch(ClubInquiryDto Cdto, int user_id) {
		JsonDto Jdto = new JsonDto();
		if(Cdto.getIS_MODIFY() == 0){
			insertFedInquiry(Cdto, user_id);
		}
		else{
			updateFedInquiry(Cdto, user_id);
		}
		Jdto.setRESULT(1);
		return Jdto;
	}

	private void updateFedInquiry(ClubInquiryDto CIdto, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CIdto.setMODIFY_USER(user_id);
		dao.updateFedInquiry(CIdto);
	}
	
	private void insertFedInquiry(ClubInquiryDto CIdto, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubInquiryDto RCIdto = null;
		CIdto.setPOINT(5);
		if(CIdto.getDEPTH() == 0){
			CIdto.setPOINT(0);
		}
		CIdto.setWRITE_USER(user_id);
		dao.insertFedInquiry(CIdto);
		if(CIdto.getDEPTH() == 1){
			RCIdto = new ClubInquiryDto();
			RCIdto.setINQUIRY_ID(CIdto.getPARENT_ID());
			RCIdto = dao.getFedInquiryView(RCIdto);
		}
	    
		HomeAlarmDto HAdto = new HomeAlarmDto();
		HAdto.setBOARD_TYPE(6);
		HAdto.setBOARD_ID(CIdto.getINQUIRY_ID());
		HAdto.setWRITE_USER(CIdto.getWRITE_USER());
		HAdto.setCLUB_CODE(CIdto.getFED_CODE());
		if(CIdto.getDEPTH() == 0){
			HAdto.setSUB_TYPE(1);
			HAdto.setUSER_LEVEL(1);
			makeFedAlarm(HAdto);
		}
		else if(CIdto.getDEPTH() == 1){
			HAdto.setSUB_TYPE(2);
			HAdto.setUSER_ID(RCIdto.getWRITE_USER());
			makeFedAlarmForOne(HAdto);
		}
	}
	
	private void makeFedAlarm(HomeAlarmDto HAdto) {
		HomeDao dao = sqlSession.getMapper(HomeDao.class);
		dao.makeFedAlarm(HAdto);
	}
	
	private void makeFedAlarmForOne(HomeAlarmDto HAdto) {
		HomeDao dao = sqlSession.getMapper(HomeDao.class);
		dao.makeFedAlarmForOne(HAdto);
	}

	public Object changeClubUserLevel(ClubUserDto CUdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		if(CUdto.getUSER_LEVEL() == 1){
			int countManager = dao.getCountClubManager(CUdto);
			if(countManager < 6){
				CUdto.setUSER_LEVEL(2);
			}
			else{
				CUdto.setUSER_LEVEL(-1);
				return CUdto;
			}
		}
		else if(CUdto.getUSER_LEVEL() == 2){
			CUdto.setUSER_LEVEL(1);
		}
		dao.setClubUserLevel(CUdto);
		return CUdto;
	}

	public void getFedMember(ClubDto Cdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		model.addAttribute("IS_MEMBER", 1);
		ArrayList<ClubDto> Cdtos = dao.getFedMember(Cdto);
		model.addAttribute("FedMemberInfo", Cdtos);
	}

	public Object dropFedMember(ClubDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		dao.dropFedMember(Cdto);
		return Jdto;
	}

	public void getClubUserSearch(ClubUserDto CUdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 0);
		model.addAttribute("search_keyword", CUdto.getKEYWORD());
		CUdto.setKEYWORD("%"+CUdto.getKEYWORD()+"%");
		ArrayList<ClubUserDto> CUdtos = dao.getClubUser(CUdto);
		model.addAttribute("ClubUserInfo", CUdtos);
	}

	public void getFedMemberSearch(ClubDto Cdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		model.addAttribute("IS_MEMBER", 1);
		model.addAttribute("search_keyword", Cdto.getKEYWORD());
		Cdto.setKEYWORD("%"+Cdto.getKEYWORD()+"%");
		ArrayList<ClubDto> Cdtos = dao.getFedMember(Cdto);
		model.addAttribute("FedMemberInfo", Cdtos);
	}

	public Object invite_manager(ClubUserDto CUdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		
		CUdto.setUSER_LEVEL(1);
		CUdto.setPOINT(0);
		dao.insertFedManager(CUdto);
		
		Jdto.setRESULT(1);
		return Jdto;
	}

	public void searchClubInviteForFed(ClubDto Cdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		model.addAttribute("IS_MEMBER", 1);
		model.addAttribute("search_keyword", Cdto.getKEYWORD());
		Cdto.setKEYWORD("%"+Cdto.getKEYWORD()+"%");
		ArrayList<ClubDto> Cdtos = dao.getClubSearchForFed(Cdto);
		model.addAttribute("clubListInvite", Cdtos);
	}

	public Object invite_member(ClubDto Cdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		
		Cdto.setMEMBER_STATUS(0);
		dao.insertFedMember(Cdto);
		
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	public void searchUserInviteForFed(AccountDto Adto, Model model, int user_id){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		model.addAttribute("IS_MANAGER", 1);
		model.addAttribute("search_keyword", Adto.getKEYWORD());
		Adto.setKEYWORD("%"+Adto.getKEYWORD()+"%");
		ArrayList<AccountDto> Adtos = dao.getUserSearchForFed(Adto);
		model.addAttribute("userListInvite", Adtos);
	}

	public void getFedManager(ClubUserDto CUdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		model.addAttribute("IS_MANAGER", 1);
		ArrayList<ClubUserDto> CUdtos = dao.getFedManager(CUdto);
		model.addAttribute("ClubUserInfo", CUdtos);
	}
	
	public void getFedManager2(ClubDto dto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubUserDto CUdto = new ClubUserDto();
		CUdto.setFED_CODE(dto.getFED_CODE());
		ArrayList<ClubUserDto> redto = dao.getFedManager(CUdto);
		model.addAttribute("FedManagers", redto);
	}

	public Object dropFedManager(ClubUserDto CUdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		dao.dropFedManager(CUdto);
		return Jdto;
	}

	public Object getFedInquiry(ClubInquiryDto CIdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		model.addAttribute("IS_FED", 1);
		CIdto.setDEPTH(0);
		if(CIdto.getNUM_LOAD() == 0){
			CIdto.setNUM_LOAD(10);
		}
		ArrayList<ClubInquiryDto> CIdtos = dao.getFedInquiry(CIdto);
		
		for(int i = 0; i < CIdtos.size(); i++){
			CIdto = CIdtos.get(i);
			CIdto.setIS_RESPONSED(dao.ifResponsedFed(CIdto));
			CIdtos.set(i, CIdto);
		}
		
		model.addAttribute("ClubAdminInquiry", CIdtos);
		return CIdtos;
	}
	
	public void getFedAlbumInfo(ClubDto dto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubAlbumDto CAdto = new ClubAlbumDto();
		CAdto.setFED_CODE(dto.getFED_CODE());
		
		ArrayList<ClubAlbumDto> club_album = dao.getAllClubAlbum(CAdto);
		model.addAttribute("ClubAlbum", club_album);
	}
	
	
	public void getFedInquiryView(ClubInquiryDto CIdto, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CIdto = dao.getFedInquiryView(CIdto);
		model.addAttribute("ClubInquiryView", CIdto);
		model.addAttribute("IS_FED", 1);
	}
	
	public Object getFedBoardMore(ClubDto Cdto, Model model, int user_id){
		Cdto.setUSER_LEVEL(getFedUserLevel(Cdto, model, user_id).getUSER_LEVEL());
		return getFedBoard(Cdto, model);
	}
	
	public Object getFedBoard(ClubDto Cdto, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ArrayList<ClubBoardDto> result = null;
		ClubBoardDto CBdto = new ClubBoardDto();
		
		CBdto.setUSER_LEVEL(Cdto.getUSER_LEVEL());
		if(Cdto.getKEYWORD() == null || Cdto.getKEYWORD().equals("")){
			CBdto.setKEYWORD("%");
		}
		else{
			CBdto.setKEYWORD("%"+Cdto.getKEYWORD()+"%");
		}
		CBdto.setFED_CODE(Cdto.getFED_CODE());
		if(Cdto.getLAST_BID() == 0){
			CBdto.setBOARD_ID(-1);
		}
		else{
			CBdto.setBOARD_ID(Cdto.getLAST_BID());
		}
		
		result = dao.getFedNotice(CBdto);
		model.addAttribute("ClubNotice", result);
		
		
		if(Cdto.getNUM_LOAD() == 0){
			CBdto.setNUM_LOAD(10);
		}
		else{
			CBdto.setNUM_LOAD(Cdto.getNUM_LOAD());
		}
		result = dao.getFedBoard(CBdto);
		for(int i = 0; i < result.size(); i++){
			CBdto = result.get(i);
			CBdto.setCOUNT_LIKE(dao.getCountLikeFed(CBdto).getRESULT());
			CBdto.setCOUNT_COMMENT(dao.getCountCommentFed(CBdto).getRESULT());
			result.set(i, CBdto);
		}
		model.addAttribute("ClubBoard", result);
		
		return result;
	}
	
	public void arrangeWrite(ClubBoardDto CBdto, Model model){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		
		if(CBdto.getIS_MODIFY() == 1){
			CBdto = dao.getFedBoardView(CBdto);
		}
		else{
			CBdto.setCONTENT("");
			CBdto.setNOTICE_TYPE(0);
			CBdto.setTITLE("");
		}
		model.addAttribute("original", CBdto);
		model.addAttribute("IS_FED", 1);
	}

	private ClubUserDto getFedUserLevel(ClubDto Cdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		ClubUserDto CUdto = new ClubUserDto();
		CUdto.setFED_CODE(Cdto.getFED_CODE());
		CUdto.setUSER_ID(user_id);
		CUdto = dao.getFedUserLevel(CUdto);
		return CUdto;
	}

	public void getFedBoardView(ClubBoardDto CBdto, Model model, int user_id) {
		CBdto = getBoardContent(CBdto, model);
		getIsFedUser(CBdto, model, user_id);
		getFedBoardComment(CBdto, model, ""+user_id);
		getFedBoardIsZzimed(CBdto, model, user_id);
		getFedBoardIsLiked(CBdto, model, user_id);
		getIsWriter(CBdto, model, user_id);
		model.addAttribute("IS_FED", 1);
	}

	private void getIsFedUser(ClubBoardDto CBdto, Model model, int user_id) {
		ClubDto Cdto = new ClubDto();
		Cdto.setFED_CODE(CBdto.getFED_CODE());
		model.addAttribute("user_level", getFedUserLevel(Cdto, model, user_id).getUSER_LEVEL());
	}

	private ClubBoardDto getBoardContent(ClubBoardDto CBdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CBdto = dao.getFedBoardView(CBdto);
		model.addAttribute("BoardView", CBdto);
		return CBdto;
	}

	private Object getFedBoardComment(ClubBoardDto CBdto, Model model, String user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);

		int user_id_int = -1;

		if(user_id != null){
			user_id_int = Integer.parseInt(user_id);
		}
		
	    ArrayList<CommentDto> Cdtos = new ArrayList<CommentDto>();
	    //ArrayList<CommentDto> Rdtos = new ArrayList<CommentDto>();
	    //ArrayList<CommentDto> CommentResult =  new ArrayList<CommentDto>();
	    CommentDto Cdto = null;
	    //CommentDto Rdto = null;
	    Cdtos = dao.getMainCommentFed(CBdto);
	    for(int i = 0; i < Cdtos.size(); i++){
	    	Cdto = Cdtos.get(i);
	    	if(Cdto.getWRITE_USER() == user_id_int){
	    		Cdto.setIS_WRITER(1);
	    	}
	    	else{
	    		Cdto.setIS_WRITER(0);
	    	}
	    	Cdtos.set(i, Cdto);
	    }
	    /*for(int i = 0; i < Cdtos.size(); i++){
	    	Cdto = Cdtos.get(i);
	    	if(Cdto.getWRITE_USER() == user_id_int){
	    		Cdto.setIS_WRITER(1);
	    	}
	    	else{
	    		Cdto.setIS_WRITER(0);
	    	}
	    	Cdtos.set(i, Cdto);
	    	CommentResult.add(Cdto);
	    	Rdtos = dao.getReplyCommentFed(Cdto);
	    	for(int j = 0; j < Rdtos.size(); j++){
	    		Rdto = Rdtos.get(j);
	    		if(Rdto.getWRITE_USER() == user_id_int){
	    			Rdto.setIS_WRITER(1);
	    		}
	    		else{
	    			Rdto.setIS_WRITER(0);
	    		}
		    	Rdtos.set(j, Rdto);
	    	}
	    	CommentResult.addAll(Rdtos);
	    }*/
	    //model.addAttribute("BoardComment", CommentResult);
	    model.addAttribute("BoardComment", Cdtos);
	    return Cdtos;
	}

	private void getFedBoardIsZzimed(ClubBoardDto CBdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		BoardZzimDto BZdto = new BoardZzimDto();
		BZdto.setBOARD_ID(CBdto.getBOARD_ID());
		BZdto.setWRITE_USER(user_id);
		int IsZzim = dao.getFedBoardIsZzimed(BZdto);
		model.addAttribute("IsZzim", IsZzim);
	}

	private void getFedBoardIsLiked(ClubBoardDto CBdto, Model model, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		LikeDto Ldto = new LikeDto();
		Ldto.setBOARD_ID(CBdto.getBOARD_ID());
		Ldto.setWRITE_USER(user_id);
		
		int IsLike = dao.getFedBoardIsLiked(Ldto);
		model.addAttribute("IsLike", IsLike);
		
		int CountLike = dao.getFedBoardCountLike(Ldto);
		model.addAttribute("CountLike", CountLike);
	}

	private void getIsWriter(ClubBoardDto CBdto, Model model, int user_id) {
		if(CBdto.getWRITE_USER() == user_id){
			model.addAttribute("is_writer", 1);
		}
		else{
			model.addAttribute("is_writer", 0);
		}
	}

	public Object zzimFedBoard(BoardZzimDto BZdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		BZdto.setWRITE_USER(user_id);
		int isZzim = dao.getFedBoardIsZzimed(BZdto);
		if(isZzim == 0){
			dao.zzimFedBoard(BZdto);
		}
		else{
			dao.diszzimFedBoard(BZdto);
		}
		isZzim = dao.getFedBoardIsZzimed(BZdto);
		BZdto.setIS_ZZIM(isZzim);
		return BZdto;
	}

	public Object likeFedBoard(LikeDto Ldto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		Ldto.setWRITE_USER(user_id);
		int isLike = dao.getFedBoardIsLiked(Ldto);
		if(isLike == 0){
			dao.likeFedBoard(Ldto);
		}
		else{
			dao.dislikeFedBoard(Ldto);
		}
		isLike = dao.getFedBoardIsLiked(Ldto);
		int countLike = dao.getFedBoardCountLike(Ldto);
		Ldto.setCountLike(countLike);
		Ldto.setIsLike(isLike);
		return Ldto;
	}

	public void modifyComment(CommentDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.modifyComment(Cdto);
	}

	public void modifyFedComment(CommentDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.modifyFedComment(Cdto);
	}

	public void deleteComment(CommentDto Cdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		Cdto.setWRITE_USER(user_id);
		dao.deleteComment(Cdto);
	}

	public void deleteFedComment(CommentDto Cdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		Cdto.setWRITE_USER(user_id);
		dao.deleteFedComment(Cdto);
	}

	public Object insertFedCommentBranch(CommentDto Cdto, Model model, int user_id) {
		Cdto.setWRITE_USER(user_id);
		insertFedComment(Cdto);
		ClubBoardDto CBdto = new ClubBoardDto();
		CBdto.setBOARD_ID(Cdto.getBOARD_ID());
		return getFedBoardComment(CBdto, model, ""+user_id);
	}

	private void insertFedComment(CommentDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.insertCommentBoardFed(Cdto);
	}

	public Object insertFedBoardBranch(ClubBoardDto CBdto, int user_id) {
		JsonDto JDto = new JsonDto();
		CBdto.setWRITE_USER(user_id);
		if(CBdto.getIS_MODIFY() == 0){
			insertFedBoard(CBdto);
		}
		else{
			updateFedBoard(CBdto);
		}
		
		/*HomeAlarmDto HAdto = new HomeAlarmDto();
		HAdto.setBOARD_TYPE(1);
		HAdto.setBOARD_ID(CBDto.getBOARD_ID());
		if(CBDto.getNOTICE_TYPE() == 0){
			if(CBDto.getIS_OPEN() == 1){
				HAdto.setSUB_TYPE(1);
			}
			else if(CBDto.getIS_OPEN() == 0){
				HAdto.setSUB_TYPE(2);
			}
		}
		else if(CBDto.getNOTICE_TYPE() == 1){
			if(CBDto.getIS_OPEN() == 1){
				HAdto.setSUB_TYPE(3);
			}
			else if(CBDto.getIS_OPEN() == 0){
				HAdto.setSUB_TYPE(4);
			}
		}
		HAdto.setWRITE_USER(CBDto.getWRITE_USER());
		HAdto.setCLUB_CODE(CBDto.getCLUB_CODE());
		HAdto.setUSER_LEVEL(1);
		makeAlarm(HAdto);*/
		
		JDto.setRESULT(1);
		
		return JDto;
	}
	
	private void insertFedBoard(ClubBoardDto CBdto){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CBdto.setPOINT(10);
		dao.insertFedBoard(CBdto);
	}
	
	private void updateFedBoard(ClubBoardDto CBdto){
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CBdto.setPOINT(10);
		dao.updateFedBoard(CBdto);
	}

	public Object deleteFedBoard(ClubBoardDto CBdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto JDto = new JsonDto();
		CBdto.setDELETE_USER(user_id);
		dao.deleteFedBoard(CBdto);
		JDto.setRESULT(1);
		return JDto;
	}

	public Object deleteClubBoard(ClubBoardDto CBdto, int user_id) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		JsonDto JDto = new JsonDto();
		CBdto.setDELETE_USER(user_id);
		dao.deleteClubBoard(CBdto);
		JDto.setRESULT(1);
		return JDto;
	}

	public ClubDto isOverlapClubName(ClubDto Cdto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		return dao.isOverlapClubName(Cdto);
	}

	public void getFedInquiryResponseView(ClubInquiryDto CIdto, Model model) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		CIdto = dao.getFedInquiryView(CIdto);
		model.addAttribute("response", CIdto);
		CIdto.setINQUIRY_ID(CIdto.getPARENT_ID());
		CIdto = dao.getFedInquiryView(CIdto);
		model.addAttribute("inquiry", CIdto);
	}
	
	public Object default_main_picture(ClubDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.default_main_picture(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	public Object dropClubManager(ClubUserDto dto) {
		ClubDao dao = sqlSession.getMapper(ClubDao.class);
		dao.dropClubManager(dto);
		
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	
}
