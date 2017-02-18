<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<body>
<script>
	var uploadImageName = "";
	if('${ClubInfo.IS_DELETED}' == '1'){
		alert("폐쇄된 동아리입니다.");
		history.back();
	}
</script>
<div id="club_detail">
	<div id="blurAll"></div>
	<%@ include file="./dialog/dialog_is_closed.jsp" %>
	<%@ include file="./dialog/dialog_album_title.jsp" %>
	<div class="top">
		<img class="img_club_background" src="../resources/upload/club/main/${ClubInfo.MAIN_PIC}" onError="this.src='<c:url value="/resources/images/club/${ClubInfo.SPORTS_NAME}2.jpg" />';">
		<div class="blind_club_background"></div>
		<div class="club_name_wrapper">
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					<span id="span_club_name">${ClubInfo.CLUB_NAME}</span>
				</c:when>
				<c:when test="${IS_FED eq 1}">
					<span id="span_club_name">${ClubInfo.FED_NAME}</span>
				</c:when>
			</c:choose>
		</div>
		<c:if test="${IS_FED eq 0}">
			<div class="div_club_type">
				<p>${ClubInfo.CLUB_TYPE_NAME}</p>
			</div>
			<div class="div_club_location_str">
				<span>${ClubInfo.SI} > ${ClubInfo.GU}</span>
			</div>
		</c:if>
		<div class="div_club_back">
			<img class="btn_size img_club_back" src="<c:url value="/resources/images/icon_back_white.png"/>">
		</div>
		<c:if test="${user_level eq 2}">
			<div class="div_club_edit">
				<img class="btn_size img_club_edit" src="<c:url value="/resources/images/ic_동호회이름수정.png"/>">
			</div>
		</c:if>
		<div class="div_club_like">
			<c:choose>
				<c:when test="${IS_ZZIMED eq 0}">
					<img class="btn_size img_club_like" src="<c:url value="/resources/images/icon_좋아요 뚤린2 하트(흰색).png" />">
				</c:when>
				<c:when test="${IS_ZZIMED eq 1}">
					<img class="btn_size img_club_like" src="<c:url value="/resources/images/icon_좋아요 하트2(채운)_흰색.png" />">
				</c:when>
			</c:choose>
		</div>
		<script>
			$(".img_club_back").click(function() {
				/*if("${param.replace}" == "clublist"){
			    	if("${param.si}" == ""){
						location.replace("../club/club_list.do?category=${param.category}&replace=clubindex");
			    	}
			    	else{
						location.replace("../club/sorted_club_list.do?si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}&replace=clubindex");
			    	}
				}
				else if("${param.replace}" == "home"){
					location.replace("../home/index.do?branchhome=branchhome");
				}
				else if("${param.replace}" == "alarm"){
					location.replace("../home/alarm.do?replace=home");
				}*/
				history.back();
			});
			$(".img_club_edit").click(function() {
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
				location.href="club_detail_modify.do?club_code=${param.club_code}&replace=modifydetail"+parameterString;
			});
			$(".img_club_like").click(function() {
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						ajax_zzim_club("${param.club_code}", function(json){
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.is_ZZIMED == 0){
								$(".img_club_like").attr("src","<c:url value='/resources/images/icon_좋아요 뚤린2 하트(흰색).png' />");
							}
							else{
								$(".img_club_like").attr("src","<c:url value='/resources/images/icon_좋아요 하트2(채운)_흰색.png' />");
							}
						});
					</c:when>
					<c:when test="${IS_FED eq 1}">
						ajax_zzim_fed("${param.FED_CODE}", function(json){
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.is_ZZIMED == 0){
								$(".img_club_like").attr("src","<c:url value='/resources/images/icon_좋아요 뚤린2 하트(흰색).png' />");
							}
							else{
								$(".img_club_like").attr("src","<c:url value='/resources/images/icon_좋아요 하트2(채운)_흰색.png' />");
							}
						});
					</c:when>
				</c:choose>
			});
		</script>
	</div>
	
    <!-- Slider main container -->
	<div class="swiper-container">
	    <!-- Additional required wrapper -->
	    <div class="swiper-pagination"></div>
	    <div class="swiper-wrapper">
	        <!-- Slides -->
	        <div class="swiper-slide" id="club_info_tab"><%@ include file="./club_detail_info.jsp" %></div>
	        <div class="swiper-slide" id="club_board_tab"><%@ include file="./club_detail_board.jsp" %></div>
	        <div class="swiper-slide" id="club_album_tab"><%@ include file="./club_detail_album.jsp" %></div>
	        <div class="swiper-slide" id="club_detail_tab" style="height: 100%"><%@ include file="./club_detail_admin.jsp" %></div>
	    </div>
	</div>

	<script>
	    //initialize swiper when document ready
	    var index = 0;
	    var mode = "${param.mode}";
	    switch (mode){
	    	case 'info' :
	    		index = 0;
	    		break;
	    	case 'board' :
	    		index = 1;
	    		$(".board .search_input").val("${param.keyword}");
				$(".board #InitialKeyword").val("${param.keyword}");
	    		break;
	    	case 'album' :
	    		index = 2;
	    		break;
	    	case 'admin' :
	    		index = 3;
	    		break;
	    	default :
	    		index = 0;
	    		break;
	    }
	    
	    var mySwiper = new Swiper ('.swiper-container', {
	      // Optional parameters
	      initialSlide:index,
	      autoHeight: true,
	      direction: 'horizontal',
	      pagination: '.swiper-pagination',
       	  paginationClickable: true,
	      loop: true,
	      paginationBulletRender: function (swiper, index, className) {
	    	  var title;
	    	  switch(index){
	    	  	case 0:
	    	  		title = "정보"
	    	  		break;
	    	  	case 1:
	    	  		title = "게시판"
	    	  		break;
	    	  	case 2:
	    	  		title = "사진첩"
	    	  		break;
	    	  	case 3:
	    	  		title = "운영진"
	    	  		break;
	    	  }
	    	  <c:choose>
	    		  <c:when test="${IS_FED eq 0}">
	 				  return '<div class="'+ className +'">'+ title +'<div class="pagi_bar"></div></div>';
				  </c:when>
	    		  <c:when test="${IS_FED eq 1}">
	 				  return '<div class="'+ className +' fed">'+ title +'<div class="pagi_bar"></div></div>';
				  </c:when>
	      	  </c:choose>
	      }
	    });
	    mySwiper.on('onSlideChangeStart', function() {
			$(".swiper-container").css("height","auto");
			$("#club_board_tab").css("height","auto");
	    });
	    mySwiper.on('onSlideChangeEnd', function() {
	    	console.log("current page: "+$(".swiper-slide.swiper-slide-active").attr("data-swiper-slide-index"));
	    	if($(".swiper-slide.swiper-slide-active").attr("data-swiper-slide-index") == 1){
		    	resize_board();
	    	}
	    });
	    
// 	  	//뒤로가기 눌렀을시
// 		var flag = false;
// 		function is_back_btn(){
// 			flag = ture;
// 		}
// 		window.onpopstate = function(event){
// 			//다이얼로그 끄기
// 			if(flag){
// 				if($(".dialog").css("display")=="block"){
// 					$(".dialog").css('display', 'none');
// 					$("#blurAll").css("display","none");
// 			    } else {
// 			    	history.back(-1);
// 			    }
// 			}
// 		}
		
</script>
	
	
	<script>
		$(function() {
			resize_detail();
			$("body").animate({scrollTop:getParameter("scrollTop")});
		});
		
		$(window).resize(function() {
			resize_detail();
		});
		
		function resize_detail(){
// 			$("html").css("background-color","#ffffff");
			$(".top").height($(window).width()/1.618);
			$(".top .blind_club_background").height($(window).width()/1.618);
			$("#club_detail .top .btn_size").css("width",$(window).width()*7/100);
			$("#club_detail .top .btn_size").css("height",$(window).width()*7/100);
			$(".top .club_name_wrapper").css("top",$(".top").height()*9/10-$(".top .club_name_wrapper").height()).css("font-size", $(window).width()*5/100+"px");
			$(".top .div_club_type p").css("top",$(".top").height()*9/10-$(".top .club_name_wrapper").height()-$(".top .div_club_type p").height()-10).css("font-size", $(window).width()*3/100+"px");
			$(".top .div_club_location_str").css("top",$(".top").height()*9/10+$(".top .club_name_wrapper").height()-$(".top .div_club_location_str").height()).css("font-size", $(window).width()*2.7/100+"px");
		}
	</script>
</div>
<%@ include file="../common/backeventjs.jsp" %>