<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_list.css?ver=7'/>" rel="stylesheet">

<body>
<div class="header">
	<div class="left_btn">
		<span class="top_button_span" style="font-size: 13px; padding-top: 6px" onclick="location.replace('create_club.do?replace=clublist')">동호회 만들기</span>
	</div>
	<div class="title">
		동호회
	</div>
	<div class="right_btn">
		<img src="../resources/images/icon_검색.png" onclick="location.replace('./club_list_search.do')">
	</div>
</div>
<div id="club_list">
	<img src="../resources/images/main_top_banner.png" class="main_top_banner">

	<div class="drop_down">
		<div class="block over" id="si">
			<div class="block_title">${sortingSi}<div class="img"></div></div>
			<div class="block_content">
				<c:forEach items="${LocationSI}" var="list">
					<div category="si" class="out_border"><div class="in_border <c:if test="${list.SI eq sortingSi}">select</c:if>">${list.SI}</div></div>
				</c:forEach>
			</div>
		</div>
		<div class="block <c:if test="${LocationGU.size() >= 6}">over</c:if>" id="gu">
			<div class="block_title">${sortingGu}<div class="img"></div></div>
			<div class="block_content ">
				<c:forEach items="${LocationGU}" var="list">
					<div class="out_border">
						<div class="in_border <c:if test="${list.GU eq sortingGu}">select</c:if>">
						<a href="javascript:void(0);" onclick="location.replace('sorted_club_list.do?replace=clubindex&si=${sortingSi}&gu=${list.GU}&category=${sortingCategory}&sportsName=${sortingeSportsName}');">
						${list.GU}
						</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="block" id="cate">
			<div class="block_title">${sortingCategory}<div class="img"></div></div>
			<div  class="block_content">
				<c:forEach items="${category}" var="list">
					<div class="out_border">
					<div class="in_border <c:if test="${list.CATEGORY eq sortingCategory}">select</c:if>">
					<a href="javascript:void(0);" onclick="location.replace('sorted_club_list.do?replace=clubindex&si=${sortingSi}&gu=${sortingGu}&category=${list.CATEGORY}&sportsName=${all}');">
					${list.CATEGORY}
					</a>
					</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="block" id="sport">
			<div class="block_title">${sortingeSportsName}<div class="img"></div></div>
			<div class="block_content">
				<c:forEach items="${sports_name}" var="list">
					<div class="out_border">
					<div class="in_border <c:if test="${list.NAME eq sortingeSportsName}">select</c:if>">
					<a href="javascript:void(0);" onclick="location.replace('sorted_club_list.do?replace=clubindex&si=${sortingSi}&gu=${sortingGu}&category=${sortingCategory}&sportsName=${list.NAME}');">
					${list.NAME}
					</a>
					</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div id="space1">
	</div>
	<div class="federation" style="background-color: #55c4cb">
		<div class="fed_title">우리 지역구 <b>종목별 연합회</b></div>
		<div id="fed_list_container" class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:forEach items="${FedList}" var="list">
	            	<div class="fed_unit_wrapper swiper-slide">
            			<div class="fed_image_container">
            				<img class="fed_image" src="${list.MAIN_PIC}" onerror="this.src='<c:url value="/resources/images/club/fed/${list.SPORTS_NAME}3.png" />'" />
            			</div>
            			<div class="fed_name_container"><span class="fed_name">${list.FED_NAME}</span></div>
            			<script>
 	           				resize_font($(".fed_name"), 1, 32, 30, 17, 11);
            			</script>
	            		<input class="fed_code" type="hidden" value="${list.FED_CODE}" />
	            	</div>
	            </c:forEach>
	        </div>
	    </div>
	</div>
	
	<div class="lookingforclub"><p>동호회 리스트</p></div>
	
	<div class="club">
		<div class="main_contents">
			<c:forEach items="${ClubList}" var="list">
				<div class=content>
					<img class="content_img" src='../resources/upload/club/main/${list.MAIN_PIC}' onError="this.src='<c:url value="/resources/images/club/${list.SPORTS_NAME}2.jpg" />';">
					<div class="content_left">
						<div class="club_name">${list.CLUB_NAME}</div>
						<div class="club_detail">
						<img src="../resources/images/icon_운동장소_small.png">${list.SI} > ${list.GU}&nbsp;&nbsp;&nbsp;
						<img src="../resources/images/icon_종류선택_small.png">${list.CLUB_TYPE_NAME}&nbsp;&nbsp;&nbsp;
						<img src="../resources/images/icon_포인트_small.png">${list.ACTIVE_POINTS}</div>
					</div>
					<input type="hidden" class="club_code" name="club_code" value="${list.CLUB_CODE}">
					<div class="medal_wrapper">
						<c:choose>
							<c:when test="${list.RANKING eq 1}">
								<img class="medal" src="<c:url value="/resources/images/no_1.png" />" />
							</c:when>
							<c:when test="${list.RANKING eq 2}">
								<img class="medal" src="<c:url value="/resources/images/no_2.png" />" />
							</c:when>
							<c:when test="${list.RANKING eq 3}">
								<img class="medal" src="<c:url value="/resources/images/no_3.png" />" />
							</c:when>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div id="list_tail"></div>

<script>
	var swiper = new Swiper('.swiper-container', {
	    slidesPerView: 3.5,
	    centeredSlides: false,
	    spaceBetween: 10
	});
	var load_flag = 0;
	var page = 0;
	$(function() {
		$(window).scroll(function() {
			load_more();
		});
		$(".fed_unit_wrapper").click(function() {
			parameterString = "";
			if("${param.si}" != ""){
				parameterString += "&si=${param.si}";
			}
			if("${param.gu}" != ""){
				parameterString += "&gu=${param.gu}";
			}
			if("${param.category}" != ""){
				parameterString += "&category=${param.category}";
			}
			if("${param.sportsName}" != ""){
				parameterString += "&sportsName=${param.sportsName}";
			}
			location.replace("./fed_detail.do?replace=clublist&FED_CODE="+$(this).find("input").val()+parameterString);
		});
		$(".content").click(function() {
			var club_code = $(this).children(".club_code").val();
			select_club(club_code);
		});
		resize_club_list();
	});
	function select_club(club_code) {
		parameterString = "";
		if("${param.si}" != ""){
			parameterString += "&si=${param.si}";
		}
		if("${param.gu}" != ""){
			parameterString += "&gu=${param.gu}";
		}
		if("${param.category}" != ""){
			parameterString += "&category=${param.category}";
		}
		if("${param.sportsName}" != ""){
			parameterString += "&sportsName=${param.sportsName}";
		}
		history.replaceState(null, null, location.href);
		location.replace("club_detail.do?club_code="+club_code+parameterString);
	}
	function load_more(){
		if(load_flag == 0 && $("#list_tail").offset().top-240 < $(window).scrollTop() + $(window).height()){
			load_flag = 1;
			page += 1;
			console.log("load_flag : "+load_flag+"\npage : "+page);
			ajax_club_list_more(page, "${param.si}", "${param.gu}", "${param.category}", "${param.sportsName}", function(json) {
				var jsonObj = JSON.parse(JSON.stringify(json));
				var foramt = "";
				jsonObj.forEach(function(element) {
					console.log(element);
					format =			"<div class=content>"
							+				"<img class='content_img' src='"+element.main_PIC+"' onError='this.src=\"<c:url value='/resources/images/club/"+element.sports_NAME+"2.jpg' />\";'>"
							+				"<div class='content_left'>"
							+					"<div class='club_name'>"+element.club_NAME+"</div>"
							+					"<div class='club_detail'>"
							+						"<img src='../resources/images/icon_운동장소_small.png'>"+element.si+" > "+element.gu+"&nbsp;&nbsp;&nbsp;"
							+						"<img src='../resources/images/icon_종류선택_small.png'>"+element.club_TYPE_NAME+"&nbsp;&nbsp;&nbsp;"
							+						"<img src='../resources/images/icon_포인트_small.png'>"+element.active_POINTS
							+					"</div>"
							+				"</div>"
							+				"<input type='hidden' class='club_code' name='club_code' value='"+element.club_CODE+"'>"
							+				"<div class='medal_wrapper'>";
						if(element.ranking == "1"){
							format = format +	"<img class='medal' src='<c:url value="/resources/images/no_1.png" />'/>";
						}
						else if(element.ranking == "2"){
							format = format +	"<img class='medal' src='<c:url value="/resources/images/no_2.png" />'/>";
						}
						else if(element.ranking == "3"){
							format = format +	"<img class='medal' src='<c:url value="/resources/images/no_3.png" />'/>";
						}
					format = format +		"</div>"
							+			"</div>";
					$(".main_contents").append(format);
				});
				load_flag = 0;
				$(".content").on("click", function() {
					var club_code = $(this).children(".club_code").val();
					select_club(club_code);
				});
			});
		}
	}
	function resize_font(target, multiple, length, padding, limit){
		var fontPixel = parseInt(($(window).width() - padding)*(1.17)*(multiple)/length, 10);
		if(fontPixel > limit){
			fontPixel = limit;
		}
		target.css("font-size", fontPixel+"px");
		target.css("line-height", fontPixel+"px");
	}
	
	
	
// 	$(".block").click(function(e){
// 		var target = $(e.target).parent().children(".block_content");
// 		target.css("display", "block");
// 	});

	var prev_target;
	var prev_id;
	$(".block .block_title").click(function(e){
		var target = $(e.target);
		var content = target.parent().children(".block_content");
		var title = target.parent().children(".block_title");
		var id = target.parent().attr("id");
		
		if(content.css("display")=="none"){
			content.css("display", "block");
			title.addClass("hover");
			$(".block_title").addClass("none_hover");
		}else if(content.css("display")=="block"){
			content.css("display", "none");
			title.removeClass("hover");
			$(".block_title").removeClass("none_hover");
		}
			
		prev_target = target;
		prev_id = id;
	});
	
	$(".block").mouseleave(function(e){
		var prev_content = prev_target.parent().children(".block_content");
		var prev_title = prev_target.parent().children(".block_title");
		
		prev_content.css("display", "none");
		prev_title.removeClass("hover");
		$(".block_title").removeClass("none_hover");
	});
	
	$(".block div[category=si]").click(function(e){
		var si = $(e.target).html();
		if(si != "서울특별시" && si != "세종특별시"){
			window.alert("현재 서비스 준비중입니다.");
		}else
			location.replace("./sorted_club_list.do?replace=clubindex&si="+si+"&gu=강남구&category=${sortingCategory}&sportsName=${sortingeSportsName}");
		
	});
	
	function resize_club_list(){
		$("#fed_list_container").height($(".fed_unit_wrapper").width());
		$(".content_img").css("height", $(window).width()*2/3);
	}
	
	
	$(document).ready(function(){
		var si_cnt = "${LocationSI.size()}";
		var gu_cnt = "${LocationGU.size()}";
		var cate_cnt = "${category.size()}";
		var sport_cnt = "${sports_name.size()}";
		console.log(Math.ceil((parseInt(si_cnt)/4)));
		$("#si .block_content").css("height", Math.ceil((parseInt(si_cnt)/4))*35+30+"px");
		$("#gu .block_content").css("height", Math.ceil((parseInt(gu_cnt)/4))*35+30+"px");
		$("#cate .block_content").css("height", Math.ceil((parseInt(cate_cnt)/4))*35+30+"px");
		$("#sport .block_content").css("height", Math.ceil((parseInt(sport_cnt)/4))*35+30+"px");
	});
	
</script>

<%@ include file="../common/backeventjs.jsp" %>

<%@ include file="../common/footer.jsp" %>
