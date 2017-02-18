<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<link href="<c:url value='/resources/css/header.css?ver=2'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/footer.css?ver=3'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/home_alarm.css?ver=16'/>" rel="stylesheet">
		<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/ajax.js?ver=4'/>"></script>
	</head>
	<body>
		<%@ include file="../common/backeventjs.jsp" %>
		<div class="header">
			<div class="left_btn"><img src="<c:url value="/resources/images/icon_back_white.png" />"  onclick="history.back();"></div>
			<div class="title">알림</div>
			<div class="right_btn"></div>
		</div>
		<script>
			$(".left_btn").click(function() {
				//location.replace("../home/index.do?branchhome=branchhome");
				history.back();
			});
		</script>
		<div id="contents_container">
			<c:forEach items="${top_alarm_list}" var="top_list">
				<div class="content readflag${top_list.IS_READ} week_top_content">
					<img class="pictogram" src="<c:url value="/resources/images/zzim_club.png" />" />
					<div class="text_wrapper">
						<div class="message_container">
							<span class="message">${top_list.USER_NAME}님이 ${top_list.CLUB_NAME}에서 문의에 대한 답변 메세지를 보냈습니다.</span>
						</div>
						<div class="datetime_container">
							<span class="datetime">${top_list.FORMATTED_WRITE_DATE}&nbsp;${top_list.FORMATTED_WRITE_TIME}</span>
						</div>
					</div>
					<input class="alarm_id" type="hidden" value="${top_list.ALARM_ID}" />
					<input class="board_type" type="hidden" value="${top_list.BOARD_TYPE}" />
					<input class="board_id" type="hidden" value="${top_list.BOARD_ID}" />
					<input class="sub_type" type="hidden" value="${top_list.SUB_TYPE}" />
					<input class="club_code" type="hidden" value="${top_list.CLUB_CODE}" />
				</div>
			</c:forEach>
			<c:forEach items="${alarm_list}" var="list">
				<div class="content readflag${list.IS_READ}">
					<c:choose>
						<c:when test="${(list.BOARD_TYPE eq 3 || list.BOARD_TYPE eq 6)}">
							<img class="pictogram" src="<c:url value="/resources/images/inquiry_alarm.png" />" />
						</c:when>
						<c:otherwise>
							<img class="pictogram" src="<c:url value="/resources/images/zzim_club.png" />" />
						</c:otherwise>
					</c:choose>
					<div class="text_wrapper">
						<div class="message_container">
							<c:choose>
								<c:when test="${list.BOARD_TYPE eq 1}">
									<c:choose>
										<c:when test="${list.SUB_TYPE eq 1}">
											<span class="message">${list.CLUB_NAME}에서 게시글이 게시되었습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 2}">
											<span class="message">${list.CLUB_NAME}에서 비밀글이 게시되었습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 3}">
											<span class="message">${list.CLUB_NAME}에서 공지글이 게시되었습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 4}">
											<span class="message">${list.CLUB_NAME}에서 비밀공지글이 게시되었습니다.</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${list.BOARD_TYPE eq 2}">
									<c:choose>
										<c:when test="${list.SUB_TYPE eq 1}">
											<span class="message">${list.CLUB_NAME}에서 앨범이 게시되었습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 2}">
											<span class="message">${list.CLUB_NAME}에서 비밀앨범이 게시되었습니다.</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${list.BOARD_TYPE eq 3}">
									<c:choose>
										<c:when test="${list.SUB_TYPE eq 1}">
											<span class="message">${list.USER_NAME}님이 ${list.CLUB_NAME}에서 문의 메세지를 보냈습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 2}">
											<span class="message">${list.USER_NAME}님이 ${list.CLUB_NAME}에서 문의에 대한 답변 메세지를 보냈습니다.</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${list.BOARD_TYPE eq 6}">
									<c:choose>
										<c:when test="${list.SUB_TYPE eq 1}">
											<span class="message">${list.USER_NAME}님이 ${list.CLUB_NAME}에서 문의 메세지를 보냈습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 2}">
											<span class="message">${list.USER_NAME}님이 ${list.CLUB_NAME}에서 문의에 대한 답변 메세지를 보냈습니다.</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${list.BOARD_TYPE eq 7}">
									<c:choose>
										<c:when test="${list.SUB_TYPE eq 1}">
											<span class="message">${list.USER_NAME}님이 ${list.CLUB_NAME}로 초대하였습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 2}">
											<span class="message">${list.CLUB_NAME}에 가입했습니다.</span>
										</c:when>
										<c:when test="${list.SUB_TYPE eq 3}">
											<span class="message">${list.CLUB_NAME}으로의 초대를 거절했습니다.</span>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</div>
						<div class="datetime_container">
							<span class="datetime">${list.FORMATTED_WRITE_DATE}&nbsp;${list.FORMATTED_WRITE_TIME}</span>
							<c:choose>
								<c:when test="${list.BOARD_TYPE eq 7 && list.SUB_TYPE eq 1}">
									<span class="reject_invite">거절</span>
									<span class="accept_invite">가입</span>
								</c:when>
								<c:when test="${list.BOARD_TYPE eq 7 && list.SUB_TYPE eq 2}">
									<span class="go_club">동호회로 바로가기</span>
								</c:when>
							</c:choose>
						</div>
					</div>
					<input class="alarm_id" type="hidden" value="${list.ALARM_ID}" />
					<input class="board_type" type="hidden" value="${list.BOARD_TYPE}" />
					<input class="board_id" type="hidden" value="${list.BOARD_ID}" />
					<input class="sub_type" type="hidden" value="${list.SUB_TYPE}" />
					<input class="club_code" type="hidden" value="${list.CLUB_CODE}" />
					<input class="club_name" type="hidden" value="${list.CLUB_NAME}" />
				</div>
				<div class="line"></div>
			</c:forEach>
		</div>
		<script>
			var load_flag = 0;
			var page = 0;
			$(function() {
				$(".pictogram").css("height", $(".pictogram").width());
			});
			$(".content").click(function() {
				clickContent($(this));
			});
			$(".accept_invite").click(function(){
				clickAccept($(this));
			});
			$(".reject_invite").click(function(){
				clickReject($(this));
			});
			$(".go_club").click(function(){
				clickGoClub($(this));
			});
			$(window).scroll(function() {
				scroll_loading();
			});
			function scroll_loading(){
				if(load_flag == 0 && $(".header").height() + $("#contents_container").height() - $(window).width()*22.77/100 < $(window).scrollTop() + $(window).height()){
					load_flag = 1;
					page += 1;
					ajax_get_alarm_more(page, function(json) {
						var jsonObj = JSON.parse(JSON.stringify(json));
						var format = "";
						console.log(jsonObj);
						jsonObj.forEach(function(element) {
							format =		"<div class='content readflag"+element.is_READ+"'>"
									+			"<img class='pictogram' src=\"<c:url value='/resources/images/Info/zzim_club.png' />\" />"
									+			"<div class='text_wrapper'>"
									+				"<div class='message_container'>";
							if(element.board_TYPE == 1){
								if(element.sub_TYPE == 1){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 게시글이 게시되었습니다.</span>";
								}
								else if(element.sub_TYPE == 2){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 비밀글이 게시되었습니다.</span>";
								}
								else if(element.sub_TYPE == 3){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 공지글이 게시되었습니다.</span>";
								}
								else if(element.sub_TYPE == 4){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 비밀공지글이 게시되었습니다.</span>";
								}
							}
							else if(element.board_TYPE == 2){
								if(element.sub_TYPE == 1){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 앨범이 게시되었습니다.</span>";
								}
								else if(element.sub_TYPE == 2){
									format = format +	"<span class='message'>"+element.club_NAME+"에서 비밀앨범이 게시되었습니다.</span>";
								}
							}
							else if(element.board_TYPE == 3){
								if(element.sub_TYPE == 1){
									format = format +	"<span class='message'>"+element.user_NAME+"님이 "+element.club_NAME+"에서 문의 메세지를 보냈습니다.</span>";
								}
								else if(element.sub_TYPE == 2){
									format = format +	"<span class='message'>"+element.user_NAME+"님이 "+element.club_NAME+"에서 문의에 대한 답변 메세지를 보냈습니다.</span>";
								}
							}
							else if(element.board_TYPE == 6){
								if(element.sub_TYPE == 1){
									format = format +	"<span class='message'>"+element.user_NAME+"님이 "+element.club_NAME+"에서 문의 메세지를 보냈습니다.</span>";
								}
								else if(element.sub_TYPE == 2){
									format = format +	"<span class='message'>"+element.user_NAME+"님이 "+element.club_NAME+"에서 문의에 대한 답변 메세지를 보냈습니다.</span>";
								}
							}
							else if(element.board_TYPE == 7){
								if(element.sub_TYPE == 1){
									format = format +	"<span class='message'>"+element.user_NAME+"님이 "+element.club_NAME+"로 초대하였습니다.</span>";
								}
								else if(element.sub_TYPE == 2){
									format = format +	"<span class='message'>"+element.club_NAME+"에 가입했습니다.</span>";
								}
								else if(element.sub_TYPE == 3){
									format = format +	"<span class='message'>"+element.club_NAME+"으로의 초대를 거절했습니다.</span>";
								}
							}
							format = format +		"</div>"
									+				"<div class='datetime_container'>"
									+					"<span class='datetime'>"+element.formatted_WRITE_DATE+"&nbsp;"+element.formatted_WRITE_TIME+"</span>";
									if(element.board_TYPE == 7){
										if(element.sub_TYPE == 1){
											format = format + "<span class='reject_invite'>거절</span>"
															+ "<span class='accept_invite'>가입</span>";
										}
										else if(element.sub_TYPE == 2){
											format = format + "<span class='go_club'>동호회로 바로가기</span>";
										}
									}
									format = format +"</div>"
									+			"</div>"
									+			"<input class='alarm_id' type='hidden' value='"+element.alarm_ID+"' />"
									+			"<input class='board_type' type='hidden' value='"+element.board_TYPE+"' />"
									+			"<input class='board_id' type='hidden' value='"+element.board_ID+"' />"
									+			"<input class='sub_type' type='hidden' value='"+element.sub_TYPE+"' />"
									+			"<input class='club_code' type='hidden' value='"+element.club_CODE+"' />"
									+		"</div>"
									+	"<div class='line'></div>";
							$("#contents_container").append(format);
						});
						load_flag = 0;
						$(".content").off("click");
						$(".content").on("click", function() {
							clickContent($(this));
						});
						$(".reject_invite").off("click");
						$(".reject_invite").on("click", function() {
							clickReject($(this));
						});
						$(".accept_invite").off("click");
						$(".accept_invite").on("click", function() {
							clickAccept($(this));
						});
						$(".go_club").off("click");
						$(".go_club").on("click", function() {
							clickGoClub($(this));
						});
						$(".pictogram").css("height", $(".pictogram").width());
					});
				}
			}
			function clickContent(target){
				var alarm_id = target.find(".alarm_id").val();
				var board_type = target.find(".board_type").val();
				var sub_type = target.find(".sub_type").val();
				var club_code = target.find(".club_code").val();
				if(board_type == 7){
					return;
				}
				ajax_read_alarm(alarm_id, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					if(jsonObj.result != 1){
						alert("오류!");
						location.replace("#");
					}
				});
				if(target.attr("class").split(" ")[1] == "readflag0"){
					target.removeClass("readflag0");
					target.addClass("readflag1");
				}
				if(board_type == 1){
					location.replace("../club/club_detail.do?replace=alarm&mode=board&club_code="+club_code+"&#board");
				}
				else if(board_type == 2){
					location.replace("../club/club_detail.do?replace=alarm&mode=album&club_code="+club_code+"&#album");
				}
				else if(board_type == 3){
					if(sub_type == 1){
						location.replace("../club/club_admin_inquiry.do?replace=alarm&club_code="+club_code);
					}
					else if(sub_type == 2){
						var board_id = target.find(".board_id").val();
						location.replace("../club/club_inquiry_response_view.do?replace=alarm&INQUIRY_ID="+board_id);
					}
				}
				else if(board_type == 6){
					if(sub_type == 1){
						location.replace("../club/fed_admin_inquiry.do?replace=alarm&FED_CODE="+club_code);
					}
					else if(sub_type == 2){
						var board_id = target.find(".board_id").val();
						location.replace("../club/fed_inquiry_response_view.do?replace=alarm&INQUIRY_ID="+board_id);
					}
				}
			}
			function clickAccept(target){
				var target_parent = target.parent().parent().parent();
				var club_code = target_parent.find(".club_code").val();
				var club_name = target_parent.find(".club_name").val();
				var invite_id = target_parent.find(".board_id").val();
				var alarm_id = target_parent.find(".alarm_id").val();
				var ajax_result = 0;
				ajax_accept_club_invite(club_code, invite_id, alarm_id, function(json) {
					jsonObj = JSON.parse(JSON.stringify(json));
					ajax_result = jsonObj.result;
				});
				if(ajax_result != 1){
					alert("오류입니다. 다시 시도해주세요.");
					return;
				}
				if(target_parent.attr("class").split(" ")[1] == "readflag0"){
					target_parent.removeClass("readflag0");
					target_parent.addClass("readflag1");
				}
				target_parent.find(".accept_invite").remove();
				target_parent.find(".reject_invite").remove();
				target_parent.find(".datetime_container").append("<span class='go_club'>동호회로 바로가기</span>");
				$(".go_club").off("click");
				$(".go_club").on("click", function(){
					clickGoClub($(this));
				});
				target_parent.find(".message").html(club_name+"에 가입했습니다.");
				target_parent.find(".sub_type").val("2");
			}
			function clickReject(target){
				var target_parent = target.parent().parent().parent();
				var club_code = target_parent.find(".club_code").val();
				var club_name = target_parent.find(".club_name").val();
				var invite_id = target_parent.find(".board_id").val();
				var alarm_id = target_parent.find(".alarm_id").val();
				var ajax_result = 0;
				ajax_reject_club_invite(club_code, invite_id, alarm_id, function(json) {
					jsonObj = JSON.parse(JSON.stringify(json));
					ajax_result = jsonObj.result;
				});
				if(ajax_result != 1){
					alert("오류입니다. 다시 시도해주세요.");
					return;
				}
				if(target_parent.attr("class").split(" ")[1] == "readflag0"){
					target_parent.removeClass("readflag0");
					target_parent.addClass("readflag1");
				}
				target_parent.find(".accept_invite").remove();
				target_parent.find(".reject_invite").remove();
				target_parent.find(".message").html(club_name+"으로의 초대를 거절했습니다.");
				target_parent.find(".sub_type").val("3");
			}
			function clickGoClub(target){
				var target_parent = target.parent().parent().parent();
				var club_code = target_parent.find(".club_code").val();
				location.replace("../club/club_detail.do?replace=alarm&club_code="+club_code);
			}
		</script>