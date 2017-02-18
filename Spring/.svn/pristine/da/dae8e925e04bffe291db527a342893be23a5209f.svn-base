<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<link href="<c:url value='/resources/css/info_map_viewer.css?ver=9'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/swiper.min.css'/>" rel="stylesheet">
		<link href="<c:url value="/resources/css/info_rect_drawer.css?ver=2" />" rel="stylesheet">
		<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/ajax.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/swiper.jquery.min.js'/>"></script>
	</head>
	<body>
		<div id="headerContainer" class="toptracer">
			<div id="titleContainer"><span id="titleText">스포츠 컨텐츠</span></div>
			<div class="topButtonContainer" id="buttonBackContainer"><img class="topButtonImage" src="<c:url value="/resources/images/icon_back.png" />"></div>
			<div class="topButtonContainer" id="buttonLikeContainer" style="right:5%;">
				<c:choose>
					<c:when test="${EVENT.IS_ZZIMED eq 0}">
						<img class="topButtonImage" src="<c:url value="/resources/images/icon_좋아요 뚤린 하트(회색).png" />">
					</c:when>
					<c:otherwise>
						<img class="topButtonImage" src="<c:url value="/resources/images/icon_좋아요하트(채운)_회색.png" />">
					</c:otherwise>
				</c:choose>
			</div>
			<!-- <div class="topButtonContainer" id="buttonShareContainer"><img class="topButtonImage" src="<c:url value="/resources/images/icon_share.png" />"></div> -->
		</div>
		<div id="contentContainer">
			<img id="content" usemap="#dynamic" src="<c:url value="/resources/images/Info/event/content/${EVENT.MAIN_PIC}" />" />
			<map id="content_map" name="dynamic">
			</map>
		</div>
		<div id="linkButtonContainer">
			<span id="linkButton">자세한 정보 보러가기</span>
			<script>
				<c:choose>
					<c:when test="${LINK.HREF ne null}">
						$("#linkButtonContainer").click(function() {
							location.href = "${LINK.HREF}";
						});
					</c:when>
					<c:otherwise>
						$("#linkButtonContainer").css("background","#979797");
					</c:otherwise>
				</c:choose>
			</script>
		</div>
		<script>
			$(function() {
				$("#buttonBackContainer").click(function() {
					history.back();
				});
				$("#buttonLikeContainer").click(function() {
					ajax_zzim_info_event("${param.EVENT_CODE}", function(json) {
						var jsonObj = JSON.parse(JSON.stringify(json));
						if(jsonObj.is_ZZIMED == 0){
							$("#buttonLikeContainer .topButtonImage").attr("src", "<c:url value='/resources/images/icon_좋아요 뚤린 하트(회색).png' />");
						}
						else{
							$("#buttonLikeContainer .topButtonImage").attr("src", "<c:url value='/resources/images/icon_좋아요하트(채운)_회색.png' />");
						}
					});
				});
			});
		</script>
		<c:choose>
			<c:when test="${IS_EDIT eq 1}">
				<div id="btn_make_location"><span>위치 만들기</span></div>
				<div id="paper" style="display:none; background-color:#797979; opacity:0.2;"></div>
				<script>
					var flag_draw = 0;
					var count = 0;
					var startX = 0, startY = 0, endX = 0, endY = 0, tmp = 0;
					var link = "";
					var cf = 0;
					var windowWidth = $(window).width();
					var trans_left = 0, trans_top = 0, trans_width = 0, trans_height = 0;
					$("#btn_make_location").click(function(){
						if($("#paper").css("display") == "none"){
							$("#paper").css("display","");
							$("#paper").css("height",$("#content").height());
						}
						else{
							$("#paper").css("display","none");
						}
					});
					$("#paper").mousemove(function(e){
						if(flag_draw == 1){
							var element = $(".selected_layer#sl"+count);
							//console.log(Math.abs(e.pageX-startX));
							element.css("width",Math.abs(e.pageX-startX));
							element.css("height",Math.abs(e.pageY-startY));
							element.css("left",(e.pageX-startX < 0) ? e.pageX : startX);
							element.css("top",(e.pageY-startY < 0) ? e.pageY : startY);
						}
					});
					$("#paper").click(function(e){
						if(flag_draw == 0) {
							console.log("start");
							startX = e.pageX;
							startY = e.pageY;
							$("body").append("<div class='selected_layer' id='sl"+count+"' style='position:absolute; z-index:1000; left:"+startX+"px; top:"+startY+"px; text-align:center; background-color:#797979; color:#ffffff; opacity:0.89;'>");
							$("#paper").css("cursor","crosshair");
							flag_draw = 1;
						}
						else {
							console.log("end");
							cf = confirm("잘그렷니");
							$("#paper").css("cursor","default");
							flag_draw = 0;
							if(cf == 1){
								link = prompt("링크주소 입력");
								$("#paper").css("display","none");
								$(".selected_layer#sl"+count).html(link);
								trans_left = $(".selected_layer#sl"+count).offset().left/windowWidth;
								trans_top = ($(".selected_layer#sl"+count).offset().top-54)/windowWidth;
								trans_width = $(".selected_layer#sl"+count).width()/windowWidth;
								trans_height = $(".selected_layer#sl"+count).height()/windowWidth;
								count++;
								ajax_insert_info_content_link("${param.EVENT_CODE}", link, trans_top, trans_left, trans_width, trans_height, function(json){});
							}
							else{
								$(".selected_layer#sl"+count).remove();
							}
						}
					});
				</script>
			</c:when>
		</c:choose>
		<c:forEach items="${EventLink}" var="link_list">
			<div class="selected_layer" id="sl${link_list.EL_CODE}"
				style="left:${link_list.LEFT_P}px; top:${link_list.TOP_P}px; width:${link_list.WIDTH_S}px; height:${link_list.HEIGHT_S}px; position:absolute; z-index:1000; text-align:center; background-color:#797979; color:#ffffff; opacity:0.89;">
				${link_list.HREF}
			</div>
			<script>
				$(".selected_layer#sl${link_list.EL_CODE}").css("left", ${link_list.LEFT_P}*windowWidth);
				$(".selected_layer#sl${link_list.EL_CODE}").css("top", ${link_list.TOP_P}*windowWidth+54);
				$(".selected_layer#sl${link_list.EL_CODE}").css("width", ${link_list.WIDTH_S}*windowWidth);
				$(".selected_layer#sl${link_list.EL_CODE}").css("height", ${link_list.HEIGHT_S}*windowWidth);
			</script>
		</c:forEach>
	</body>
</html>

<%@ include file="../common/backeventjs.jsp" %>