<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<link href="<c:url value='/resources/css/info_news_viewer.css?ver=11'/>" rel="stylesheet">
		<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/ajax.js'/>"></script>
	</head>
	<body>
		<div id="picture_wrapper">
			<img id="picture_top" src="<c:url value="/resources/images/Info/news/${NEWS.MAIN_PIC}" />" onerror="this.src='<c:url value="/resources/images/Info/news/default/${NEWS.NAME}.jpg" />'" />
			<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back_white.png" />" />
			<c:choose>
				<c:when test="${NEWS.IS_ZZIMED eq 0}">
					<img class="top_button" id="zzim" src="<c:url value="/resources/images/icon_좋아요 뚤린 하트(회색).png" />" style="right: 5%;" />
				</c:when>
				<c:otherwise>
					<img class="top_button" id="zzim" src="<c:url value="/resources/images/icon_좋아요하트(채운)_회색.png" />" style="right: 5%;" />
				</c:otherwise>
			</c:choose>
			<!-- <img class="top_button" id="share" src="<c:url value="/resources/images/icon_share.png" />" /> -->
		</div>
		<div id="title_container">
			<span id="title">${NEWS.NEWS_NAME}</span>
		</div>
		<div class="subtitle_container">
			<span class="subtitle">대회 정보</span>
		</div>
		<div id="info_wrapper">
			<table id="info_table">
				<tr id="info_tr">
					<td class="td_title">대회 일정
					<td class="info_second_td"><span class="info_text">${NEWS.PLAN_DATETIME_STR}</span></td>
				</tr>
				<tr>
					<td class="td_title">대회 장소
					<td class="info_second_td"><span class="info_text">${NEWS.ADDRESS}</span></td>
				</tr>
				<tr>
					<td class="td_title">참가대상
					<td class="info_second_td"><span class="info_text">${NEWS.TARGET}</span></td>
				</tr>
				<tr>
					<td class="td_title">주최
					<td class="info_second_td"><span class="info_text">${NEWS.HOST}</span></td>
				</tr>
				<tr>
					<td class="td_title">주관
					<td class="info_second_td"><span class="info_text">${NEWS.MNGHOST}</span></td>
				</tr>
			</table>
		</div>
		<div class="subtitle_container">
			<span class="subtitle">대회 소개</span>
		</div>
		<div id="intro_container">
			<span id="intro_text">${NEWS.CONTENTS}</span>
		</div>
		<div class="subtitle_container">
			<span class="subtitle">대회 사진</span>
		</div>
		<div id="album_container">
			<c:forEach items="${album_list}" var="album">
				<div class="photo_container">
					<a href="./news_wide_viewer.do?picture=${album.PICTURE}">
					<img class="photo" src="<c:url value="/resources/images/Info/news/${album.PICTURE}" />" onError="this.src='<c:url value="/resources/images/icon_blank_pic.png" />'" />
					</a>
				</div>
			</c:forEach>
		</div>
		<div id="tail"></div>
		<div id="view_detail_button_container">상세요강 보러가기</div>
		<script>
			$(function() {
				$("#zzim").click(function() {
					ajax_zzim_info_news("${param.NEWS_CODE}", function(json) {
						var jsonObj = JSON.parse(JSON.stringify(json));
						if(jsonObj.is_ZZIMED == 0){
							$("#zzim").attr("src", "<c:url value='/resources/images/icon_좋아요 뚤린 하트(회색).png' />");
						}
						else{
							$("#zzim").attr("src", "<c:url value='/resources/images/icon_좋아요하트(채운)_회색.png' />");
						}
					});
				});
				$("#back").click(function() {
					history.back();
				});
				if("${NEWS.LINK}" != ""){
					$("#view_detail_button_container").css("background-color","#008ae8");
					$("#view_detail_button_container").css("color","#ffffff");
					$("#view_detail_button_container").css("border","0");
					$("#view_detail_button_container").on("click", function(){
						location.href="${NEWS.LINK}";
					});
				}
			});
		</script>
	</body>
</html>

<%@ include file="../common/backeventjs.jsp" %>