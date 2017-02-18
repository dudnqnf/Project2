package com.sportsfactory.sportforall;

import java.text.ParseException;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UrlPathHelper;

import com.sportsfactory.sportforall.dto.ClubFeeDto;
import com.sportsfactory.sportforall.dto.ClubInquiryDto;
import com.sportsfactory.sportforall.dao.ClubDao;
import com.sportsfactory.sportforall.dto.AccountDto;
import com.sportsfactory.sportforall.dto.AlbumReplyDto;
import com.sportsfactory.sportforall.dto.BoardZzimDto;
import com.sportsfactory.sportforall.dto.ClubBoardDto;
import com.sportsfactory.sportforall.dto.ClubDto;
import com.sportsfactory.sportforall.dto.ClubInviteDto;
import com.sportsfactory.sportforall.dto.ClubPointDto;
import com.sportsfactory.sportforall.dto.ClubUserAddressDto;
import com.sportsfactory.sportforall.dto.ClubSearchLogDto;
import com.sportsfactory.sportforall.dto.ClubUserDto;
import com.sportsfactory.sportforall.dto.ClubUserFeeDto;
import com.sportsfactory.sportforall.dto.ClubUserPaidAddressDto;
import com.sportsfactory.sportforall.dto.CommentDto;
import com.sportsfactory.sportforall.dto.JsonDto;
import com.sportsfactory.sportforall.dto.LikeDto;
import com.sportsfactory.sportforall.dto.UserPhotoDto;
import com.sportsfactory.sportforall.service.AccountService;
import com.sportsfactory.sportforall.service.ClubService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/club")
public class ClubController {
	
	private static Logger log = Logger.getLogger(ClubController.class);
	
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "/index.do")
	public String index() {
		return "club/index";
	}
	@RequestMapping(value = "/test.do")
	public String test2() {
		return "club/test";
	}
	
	@RequestMapping(value = "/club_list.do")
	public String club_list(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.getClubList(request, model, user_id);
		return "club/club_list";
	}
	
	@RequestMapping(value = "/sorted_club_list.do")
	public String sorted_club_list(HttpServletRequest request, Model model) {
		clubService.getSortedClubList(request, model);
		return "club/club_list";
	}
	
	@RequestMapping(value = "/club_detail.do")
	public String club_detail(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("IS_FED", 0);
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubAlbum(request, model);
		clubService.getClubBoard(request, model);
		clubService.getClubDetail(request, model);
		clubService.getClubUser(request, model, user_id);
		clubService.returnPageControll(request, model);
		clubService.isClubZzimed(request, model, user_id);
		return "club/club_detail";
	}
	
	@RequestMapping(value = "/club_detail_board_view.do")
	public String club_detail_board_view(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		model.addAttribute("scrollTop",request.getParameter("scrollTop"));
		model.addAttribute("keyword",request.getParameter("keyword"));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubBoardView(request, model);
		clubService.getBoardViewComment(request, model, ""+user_id);
		clubService.getBoardViewLike(request, model, user_id);
		clubService.isWriter(request, model, user_id);
		clubService.getBoardViewZzim(request, model, user_id);
		model.addAttribute("IS_FED", 0);
		return "club/club_detail_board_view";
	}
	
	@RequestMapping(value = "/club_detail_board_write.do")
	public String club_detail_board_write(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		model.addAttribute("scrollTop",request.getParameter("scrollTop"));
		model.addAttribute("keyword",request.getParameter("keyword"));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.arrangeWrite(request, model);
		return "club/club_detail_board_write";
	}
	
	//좋아요 누르기
	//ajax
	@RequestMapping(value = "/like_this.do")
	public @ResponseBody Object like_this(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id){
		clubService.likeThis(request, user_id);
		Object vo = clubService.getBoardViewLike(request, model, user_id);
		return vo;
	}
	
	//댓글 입력
	//ajax
	@RequestMapping(value = "/insert_comment.do")
	public @ResponseBody Object insert_comment(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id){
		clubService.insertComment(request, user_id);
		Object vo = clubService.getBoardViewComment(request, model, ""+user_id);
		return vo;
	}
	
	//사진첩 게시글 만들기
	@RequestMapping(value = "/make_album.do")
	public @ResponseBody Object make_album(HttpServletRequest request){
		log.error(request.getRemoteAddr());
		Object vo = clubService.makeAlbum(request);
		return vo;
	}
	
	
	//이미지 여러장 업로드 
	//ajax
	@RequestMapping(value = "/upload_images.do")
	public @ResponseBody Object upload_images(HttpServletRequest request, HttpServletResponse response){
		Object vo = clubService.uploadImages(request);
		return vo;
	}
	
	//사진첩제목 변경
	//ajax
	@RequestMapping(value = "/update_title.do")
	public @ResponseBody Object update_title(HttpServletRequest request, HttpServletResponse response){
		Object vo = clubService.updateAlbumTitle(request);
		return vo;
	}
	
	@RequestMapping(value = "/album.do")
	public String album(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.getClubAlbumView(request, model, user_id);
		return "club/club_detail_album_view";
	}
	
	@RequestMapping(value = "/insert_album_reply.do")
	public @ResponseBody Object insert_album_reply(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = clubService.insertAlbumReply(request, model, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/album_like.do")
	public @ResponseBody Object album_like(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = clubService.albumLike(request, model, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/album_dislike.do")
	public @ResponseBody Object album_dislike(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = clubService.albumDislike(request, model, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/album_del.do")
	public @ResponseBody Object album_del(HttpServletRequest request, Model model) {
		clubService.AlbumDelete(request, model);
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		return Jdto;
	}
	
	// 사용자의 권한을 json으로 받아서 사용할 때 사용
	@RequestMapping(value = "/auth_check.do")
	public @ResponseBody Object auth_check(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id){
		clubService.getClubUserLevel(request, model, user_id);
		Object vo = (ClubUserDto) request.getAttribute("user_level");
		
		if(vo == null){
			ClubUserDto CUDto = new ClubUserDto();
			CUDto.setUSER_LEVEL(-1);
			vo = CUDto;
		}
		
		return vo;
	}
	
	@RequestMapping(value = "/club_board_insert.do")
	public @ResponseBody Object insert_board(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = null;
		String is_modify = request.getParameter("is_modify");
		if(is_modify == null || is_modify.equals("") || is_modify.equals("0")){
			vo = clubService.insertBoard(request, model, user_id);
		}
		else{
			vo = clubService.updateBoard(request, model, user_id);
		}
		return vo;
	}
	
	@RequestMapping(value = "/club_board_delete.do")
	public String delete_board(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.deleteBoard(request, user_id);
		return "club/club_detail";
	}
	
	@RequestMapping(value = "/album_update.do")
	public @ResponseBody Object album_update(HttpServletRequest request, Model model) {
		Object vo = clubService.AlbumUpdate(request, model);
		return vo;
	}
	
	
	//회원관리
	@RequestMapping(value = "/club_user.do")
	public String club_user(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("IS_FED", 0);
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubAlbum(request, model);
		clubService.getClubBoard(request, model);
		clubService.getClubDetail(request, model);
		clubService.getClubUser(request, model, user_id);
		clubService.returnPageControll(request, model);
		return "club/club_user";
	}
	@RequestMapping(value = "/club_user_add.do")
	public String club_user_add(@ModelAttribute AccountDto dto, HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		accountService.searchUserInvite(dto, request, model, ""+user_id);
		return "club/club_user_add";
	}
	
	@RequestMapping(value = "/club_info_inquiry.do")
	public String club_info_inquiry(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		model.addAttribute("mode",request.getParameter("mode"));
		clubService.getClubUserLevel(request, model, user_id);
		model.addAttribute("is_modify", 0);
		model.addAttribute("IS_FED", 0);
		return "club/club_detail_info_inquiry";
	}
	
	@RequestMapping(value = "/club_manager.do")
	public String club_manager(HttpServletRequest request, Model model) {
		clubService.getManager(request, model);
		return "club/club_manager";
	}
	
	@RequestMapping(value = "/club_point.do")
	public String club_point(Model mode, @ModelAttribute ClubDto dto) {
		clubService.getClubPointList(mode, dto);
		return "club/club_point";
	}
	
	@RequestMapping(value = "/club_close.do")
	public String club_close(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.init_club_close(request, model, ""+user_id);
		return "club/club_close";
	}
	
	//클럽 생성하기.
	@RequestMapping(value = "/create_club.do")
	public String createClub(HttpServletRequest request, Model model) {
		clubService.createClub(request, model);
		return "club/create_club";
	}
	
	@RequestMapping(value = "/album_zzim.do")
	public @ResponseBody Object album_zzim(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = clubService.album_zzim(request, model, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/album_zzim_cancel.do")
	public @ResponseBody Object album_zzim_cancel(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo = clubService.album_zzim_cancel(request, model, user_id);
		return vo;
	}
	
	//테스트용
	@RequestMapping(value = "/scrollEventTest.do")
	public String test() {
		return "club/scrollEventTest";
	}
	
	@RequestMapping(value = "/club_board_select_more.do")
	public @ResponseBody Object club_board_select_more(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.getClubUserLevel(request, model, user_id);
		Object vo = clubService.getClubBoard(request, model);
		return vo;
	}
	
	//게시글 찜버튼 누르기
	//ajax
	@RequestMapping(value = "/zzim_this.do")
	public @ResponseBody Object zzim_this(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id){
		clubService.zzimThis(request, user_id);
		Object vo = clubService.getBoardViewZzim(request, model, user_id);
		return vo;
	}

	@RequestMapping(value = "/club_inquiry_insert.do")
	public @ResponseBody Object club_inquiry_insert(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		Object vo;
		String is_modify = request.getParameter("is_modify");
		if(is_modify == null || is_modify.equals("") || is_modify.equals("0")){
			vo = clubService.insertInquiry(request, model, user_id);
		}
		else{
			vo = clubService.updateInquiry(request, model, user_id);
		}
		return vo;
	}
	
	@RequestMapping(value = "/club_admin_inquiry.do")
	public String club_admin_inquiry(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("club_code",Integer.parseInt(request.getParameter("club_code")));
		model.addAttribute("mode",request.getParameter("mode"));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubInquiry(request, model);
		return "club/club_detail_admin_inquiry";
	}
	
	@RequestMapping(value = "/album_search.do")
	public @ResponseBody Object album_search(HttpServletRequest request, Model model) {
		Object vo = clubService.getAlbumSearch(request, model);
		return vo;
	}
	
	@RequestMapping(value = "/album_more.do")
	public @ResponseBody Object album_more(HttpServletRequest request, Model model) {
		Object vo = clubService.getAlbumMore(request, model);
		return vo;
	}
	
	@RequestMapping(value = "/album_search_more.do")
	public @ResponseBody Object album_search_more(HttpServletRequest request, Model model) {
		Object vo = clubService.getAlbumSearchMore(request, model);
		return vo;
	}
	
	@RequestMapping(value = "/club_admin_inquiry_view.do")
	public String club_admin_inquiry_view(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubInquiryView(request, model);
		return "club/club_detail_admin_inquiry_view";
	}
	
	@RequestMapping(value = "/club_admin_inquiry_write.do")
	public String club_admin_inquiry_write(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id) {
		clubService.getClubUserLevel(request, model, user_id);
		model.addAttribute("IS_FED", 0);
		return "club/club_detail_admin_inquiry_write";
	}
	
	@RequestMapping(value = "/get_paid_list.do")
	public @ResponseBody Object get_paid_list(HttpServletRequest request, Model model) throws ParseException {
		Object vo = clubService.getPaidList(request);
		return vo;
	}
	
	@RequestMapping(value = "/user_paid.do")
	public @ResponseBody Object user_paid(HttpServletRequest request, Model model) {
		Object vo = clubService.userPaidCheck(request);
		return vo;
	}
	
	@RequestMapping(value = "/user_paid_cancel.do")
	public @ResponseBody Object user_paid_cancel(HttpServletRequest request, Model model) {
		Object vo = clubService.userPaidUncheck(request);
		return vo;
	}
	
	@RequestMapping(value = "/club_fee.do")
	public String club_fee() {
		return "club/club_fee";
	}

	@RequestMapping(value = "/submit_club_create.do")
	public @ResponseBody Object submit_club_create(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) throws ParseException {
		Object vo = clubService.submitClubCreate(request, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/get_fee_list.do")
	public @ResponseBody Object get_fee_list(HttpServletRequest request, Model model) throws ParseException {
		Object vo = clubService.getFeeList(request);
		return vo;
	}
	
	@RequestMapping(value = "/fee_update.do")
	public @ResponseBody Object fee_update(HttpServletRequest request, Model model) throws ParseException, org.json.simple.parser.ParseException {
		Object vo = clubService.FeeUpdate(request);
		return vo;
	}
	
	@RequestMapping(value = "/edit_club_info.do")
	public @ResponseBody Object edit_club_info(HttpServletRequest request) {
		Object vo = clubService.editClubInfo(request);
		return vo;
	}

	@RequestMapping(value = "/change_club_image.do")
	public @ResponseBody Object change_club_image(HttpServletRequest request) {
		Object vo = clubService.changeClubImage(request);
		return vo;
	}
	
	@RequestMapping(value = "/club_agree_delete.do")
	public @ResponseBody Object club_agree_delete(HttpServletRequest request) {
		Object vo = clubService.club_agree_delete(request);
		return vo;
	}
	
	@RequestMapping(value = "/confirm_delete_club.do")
	public @ResponseBody Object confirm_delete_club(HttpServletRequest request, @CookieValue("user_id") int user_id) {
		Object vo = clubService.confirm_delete_club(request, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/club_detail_modify.do")
	public String club_detail_modify(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("ClubCode",Integer.parseInt(request.getParameter("club_code")));
		clubService.getClubUserLevel(request, model, user_id);
		clubService.getClubDetail(request, model);
		clubService.getClubUser(request, model, user_id);
		clubService.returnPageControll(request, model);
		clubService.getAllClubTarget(request, model);
		return "club/club_detail_modify";
	}
	
	@RequestMapping(value = "/insert_address_user.do")
	public @ResponseBody Object insert_address_user(ClubUserAddressDto dto) throws ParseException {
		Object vo = clubService.insertAddressUser(dto);
		return vo;
	}
	
	@RequestMapping(value = "/invite_user.do")
	public @ResponseBody Object invite_user(@ModelAttribute ClubInviteDto dto, HttpServletRequest request, @CookieValue("user_id") int user_id) {
		Object vo = clubService.invite_user(dto, request, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/club_list_search.do")
	public String club_list_search(@ModelAttribute ClubDto dto, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		clubService.get_search_log(model, user_id);
		clubService.get_club_search_result(dto, model);
		return "club/search";
	}
	
	@RequestMapping(value = "/add_log_search.do")
	public @ResponseBody Object add_log_search(@ModelAttribute ClubSearchLogDto dto, HttpServletRequest request, @CookieValue("user_id") int user_id) {
		Object vo = clubService.add_log_search(dto, request, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/delete_address_user.do")
	public @ResponseBody Object delete_address_user(@ModelAttribute ClubUserAddressDto dto) {
		Object vo = clubService.deleteAddressUser(dto);
		return vo;
	}
	
	@RequestMapping(value = "/paid_address.do")
	public @ResponseBody Object paid_address(@ModelAttribute ClubUserPaidAddressDto dto) {
		Object vo = clubService.paidAddress(dto);
		return vo;
	}
	
	@RequestMapping(value = "/paid_cancel_address.do")
	public @ResponseBody Object paid_cancel_address(@ModelAttribute ClubUserPaidAddressDto dto) {
		Object vo = clubService.paidCancelAddress(dto);
		return vo;
	}
	@RequestMapping(value = "/club_album_reply_edit.do")
	public String club_album_reply_edit(@ModelAttribute AlbumReplyDto dto, Model model) {
		clubService.getAlbumReply(dto, model);
		return "club/club_album_reply_edit";
	}
	
	@RequestMapping(value = "/album_reply_edit.do")
	public @ResponseBody Object album_reply_edit(@ModelAttribute AlbumReplyDto dto) {
		Object vo = clubService.albumReplyUpdate(dto);
		return vo;
	}
	
	@RequestMapping(value = "/album_reply_delete.do")
	public @ResponseBody Object album_reply_delete(@ModelAttribute AlbumReplyDto dto) {
		Object vo = clubService.albumReplyDelete(dto);
		return vo;
	}

	@RequestMapping(value = "/club_list_more.do")
	public @ResponseBody Object club_list_more(HttpServletRequest request, Model model) {
		return clubService.getSortedClubList(request, model);
	}
	
	@RequestMapping(value = "/club_list_search_more.do")
	public @ResponseBody Object club_list_search_more(@ModelAttribute ClubDto dto, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id) {
		return clubService.get_club_search_result(dto, model);
	}
	
	@RequestMapping(value = "/zzim_club.do")
	public @ResponseBody Object zzim_club(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue("user_id") int user_id){
		Object vo = clubService.zzimClub(request, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/club_main_pic_upload.do")
	public @ResponseBody Object club_main_pic_upload(@ModelAttribute ClubDto dto) {
		Object vo = clubService.clubMainPicUpload(dto);
		return vo;
	}

	@RequestMapping(value = "/club_inquiry_response_view.do")
	public String club_inquiry_response_view(@ModelAttribute ClubInquiryDto dto, Model model) {
		clubService.getClubInquiryResponseView(dto, model);
		return "club/club_inquiry_response_view";
	}
	
	@RequestMapping(value = "/fed_detail.do")
	public String fed_detail(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.getFedDetail(dto, model, user_id);
		return "club/club_detail";
	}
	
	@RequestMapping(value = "/fed_info_inquiry.do")
	public String fed_info_inquiry(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("IS_FED", 1);
		model.addAttribute("is_modify", 0);
		return "club/club_detail_info_inquiry";
	}

	@RequestMapping(value = "/fed_inquiry_insert.do")
	public @ResponseBody Object fed_inquiry_insert(@ModelAttribute ClubInquiryDto dto, @CookieValue("user_id") int user_id) {
		return clubService.insertFedInquirySwitch(dto, user_id);
	}

	@RequestMapping(value = "/change_club_user_level.do")
	public @ResponseBody Object change_club_user_level(@ModelAttribute ClubUserDto dto) {
		return clubService.changeClubUserLevel(dto);
	}

	@RequestMapping(value = "/fed_member.do")
	public String fed_member(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.getFedMember(dto, model, user_id);
		return "club/club_user";
	}

	@RequestMapping(value = "/drop_fed_member.do")
	public @ResponseBody Object drop_fed_member(@ModelAttribute ClubDto dto) {
		return clubService.dropFedMember(dto);
	}
	
	@RequestMapping(value = "/club_user_search.do")
	public String club_user_search(@ModelAttribute ClubUserDto dto, Model model, @CookieValue("user_id") int user_id){
		clubService.getClubUserSearch(dto, model, user_id);
		return "club/club_user";
	}
	
	@RequestMapping(value = "/fed_member_search.do")
	public String fed_member_search(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id){
		clubService.getFedMemberSearch(dto, model, user_id);
		return "club/club_user";
	}
	
	@RequestMapping(value = "/fed_manager_add.do")
	public String fed_manager_add(@ModelAttribute AccountDto dto, Model model, @CookieValue("user_id") int user_id){
		clubService.searchUserInviteForFed(dto, model, user_id);
		return "club/club_user_add";
	}
	
	@RequestMapping(value = "/invite_manager.do")
	public @ResponseBody Object invite_manager(@ModelAttribute ClubUserDto dto, @CookieValue("user_id") int user_id) {
		Object vo = clubService.invite_manager(dto, user_id);
		return vo;
	}
	
	@RequestMapping(value = "/fed_member_add.do")
	public String fed_member_add(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id){
		clubService.searchClubInviteForFed(dto, model, user_id);
		return "club/club_user_add";
	}
	
	@RequestMapping(value = "/invite_member.do")
	public @ResponseBody Object invite_member(@ModelAttribute ClubDto dto, @CookieValue("user_id") int user_id) {
		Object vo = clubService.invite_member(dto, user_id);
		return vo;
	}

	@RequestMapping(value = "/fed_manager.do")
	public String fed_manager(@ModelAttribute ClubUserDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.getFedManager(dto, model, user_id);
		return "club/club_user";
	}

	@RequestMapping(value = "/drop_fed_manager.do")
	public @ResponseBody Object drop_fed_manager(@ModelAttribute ClubUserDto dto) {
		return clubService.dropFedManager(dto);
	}
	
	@RequestMapping(value = "/fed_admin_inquiry.do")
	public String fed_admin_inquiry(@ModelAttribute ClubInquiryDto dto, Model model, @CookieValue("user_id") int user_id){
		clubService.getFedInquiry(dto, model);
		return "club/club_detail_admin_inquiry";
	}
	
	@RequestMapping(value = "/get_club_inquiry_more.do")
	public @ResponseBody Object get_club_inquiry_more(HttpServletRequest request, Model model, @CookieValue("user_id") int user_id){
		return clubService.getClubInquiry(request, model);
	}
	
	@RequestMapping(value = "/get_fed_inquiry_more.do")
	public @ResponseBody Object get_fed_inquiry_more(@ModelAttribute ClubInquiryDto dto, Model model, @CookieValue("user_id") int user_id){
		return clubService.getFedInquiry(dto, model);
	}
	
	@RequestMapping(value = "/fed_admin_inquiry_view.do")
	public String fed_admin_inquiry_view(@ModelAttribute ClubInquiryDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.getFedInquiryView(dto, model);
		return "club/club_detail_admin_inquiry_view";
	}
	
	@RequestMapping(value = "/fed_admin_inquiry_write.do")
	public String fed_admin_inquiry_write(Model model, @CookieValue("user_id") int user_id) {
		model.addAttribute("IS_FED", 1);
		return "club/club_detail_admin_inquiry_write";
	}
	
	@RequestMapping(value = "/fed_detail_board_write.do")
	public String fed_detail_board_write(@ModelAttribute ClubBoardDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.arrangeWrite(dto, model);
		return "club/club_detail_board_write";
	}
	
	@RequestMapping(value = "/fed_board_select_more.do")
	public @ResponseBody Object fed_board_select_more(@ModelAttribute ClubDto dto, Model model, @CookieValue("user_id") int user_id) {
		return clubService.getFedBoardMore(dto, model, user_id);
	}
	
	@RequestMapping(value = "/fed_detail_board_view.do")
	public String fed_detail_board_view(@ModelAttribute ClubBoardDto dto, Model model, @CookieValue("user_id") int user_id) {
		clubService.getFedBoardView(dto, model, user_id);
		return "club/club_detail_board_view";
	}
	
	@RequestMapping(value = "/zzim_fed_board.do")
	public @ResponseBody Object zzim_fed_board(BoardZzimDto BZdto, Model model, @CookieValue("user_id") int user_id){
		return clubService.zzimFedBoard(BZdto, user_id);
	}
	
	@RequestMapping(value = "/like_fed_board.do")
	public @ResponseBody Object like_fed_board(LikeDto Ldto, @CookieValue("user_id") int user_id){
		return clubService.likeFedBoard(Ldto, user_id);
	}
	
	@RequestMapping(value = "/modify_comment.do")
	public @ResponseBody Object modify_comment(CommentDto Cdto){
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		clubService.modifyComment(Cdto);
		return Jdto;
	}
	
	@RequestMapping(value = "/modify_fed_comment.do")
	public @ResponseBody Object modify_fed_comment(CommentDto Cdto){
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		clubService.modifyFedComment(Cdto);
		return Jdto;
	}
	
	@RequestMapping(value = "/delete_comment.do")
	public @ResponseBody Object delete_comment(CommentDto Cdto, @CookieValue("user_id") int user_id){
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		clubService.deleteComment(Cdto, user_id);
		return Jdto;
	}
	
	@RequestMapping(value = "/delete_fed_comment.do")
	public @ResponseBody Object delete_fed_comment(CommentDto Cdto, @CookieValue("user_id") int user_id){
		JsonDto Jdto = new JsonDto();
		Jdto.setRESULT(1);
		clubService.deleteFedComment(Cdto, user_id);
		return Jdto;
	}
	
	@RequestMapping(value = "/insert_fed_comment.do")
	public @ResponseBody Object insert_fed_comment(CommentDto Cdto, Model model, @CookieValue("user_id") int user_id){
		return clubService.insertFedCommentBranch(Cdto, model, user_id);
	}
	
	@RequestMapping(value = "/fed_board_insert.do")
	public @ResponseBody Object fed_board_insert(ClubBoardDto CBdto, @CookieValue("user_id") int user_id) {
		return clubService.insertFedBoardBranch(CBdto, user_id);
	}
	
	@RequestMapping(value = "/delete_fed_board.do")
	public @ResponseBody Object delete_fed_board(ClubBoardDto CBdto, @CookieValue("user_id") int user_id) {
		return clubService.deleteFedBoard(CBdto, user_id);
	}
	
	@RequestMapping(value = "/delete_club_board.do")
	public @ResponseBody Object delete_club_board(ClubBoardDto CBdto, @CookieValue("user_id") int user_id) {
		return clubService.deleteClubBoard(CBdto, user_id);
	}
	
	@RequestMapping(value = "/club_name_overlap_check.do")
	public @ResponseBody Object club_name_overlap_check(ClubDto Cdto) {
		return clubService.isOverlapClubName(Cdto);
	}

	@RequestMapping(value = "/fed_inquiry_response_view.do")
	public String fed_inquiry_response_view(@ModelAttribute ClubInquiryDto dto, Model model) {
		clubService.getFedInquiryResponseView(dto, model);
		return "club/club_inquiry_response_view";
	}
	
	@RequestMapping(value = "/default_main_picture.do")
	public @ResponseBody Object default_main_picture(@ModelAttribute ClubDto dto){
		Object vo = clubService.default_main_picture(dto);
		return vo;
	}
	
	/*
	 * 동호회 회원 퇴출
	 */
	@RequestMapping(value = "/drop_club_manager.do")
	public @ResponseBody Object drop_club_manager(@ModelAttribute ClubUserDto dto) {
		Object vo = clubService.dropClubManager(dto);
		return vo;
	}
	
}
