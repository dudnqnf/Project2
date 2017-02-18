<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<link href="<c:url value='/resources/css/info_map_viewer.css?ver=3'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/swiper.min.css'/>" rel="stylesheet">
		<link href="<c:url value='/resources/css/header.css'/>" rel="stylesheet">
		<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/ajax.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/resources/js/swiper.jquery.min.js'/>"></script>
	    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=1HvVKMlWCScyt9Idxpn0"></script>
	</head>
	<body>
		<div class="header">
			<div class="left_btn" id="buttonBackContainer" onclick="history.back(-1)"><img class="topButtonImage" src="<c:url value="/resources/images/icon_back.png" />"></div>
			<div class="title"><span id="page_name">지도에서 위치보기</span></div>
			<div class="right_sub_btn" id="buttonLikeContainer"  style="right:5%;">
				<c:choose>
					<c:when test="${info.IS_ZZIMED eq 0}">
						<img class="topButtonImage" src="<c:url value="/resources/images/icon_좋아요 뚤린 하트(회색).png" />">
					</c:when>
					<c:otherwise>
						<img class="topButtonImage" src="<c:url value="/resources/images/icon_좋아요하트(채운)_회색.png" />">
					</c:otherwise>
				</c:choose>
			</div>
			<!-- <div class="right_btn" style="top:13px;" id="buttonShareContainer"><img class="topButtonImage" src="<c:url value="/resources/images/icon_share.png" />"></div> -->
		</div>
		
		<div id="mapContainer">
			<div id="map" style="position: absolute; top: 60px; bottom: 60px; left: 0px; right: 0px;"></div>
			<script>
				var mapOptions = {
				    center: new naver.maps.LatLng(${info.LATITUDE}, ${info.LONGITUDE}),
				    zoom: 10,
					minzoom: 1,
			        logoControl: false,
			        mapDataControl: false,
			        mapTypeControl: false,
					zoomControl: true,
			        zoomControlOptions: {
			            style: naver.maps.ZoomControlStyle.SMALL,
			            position: naver.maps.Position.RIGHT_TOP
			        },
			        scaleControl: true,
			        scaleControlOptions: {
			            position: naver.maps.Position.LEFT_BOTTOM
			        },
				};
				var map = new naver.maps.Map(document.getElementById('map'), mapOptions);
	
				var marker = new naver.maps.Marker({
				    position: new naver.maps.LatLng(${info.LATITUDE}, ${info.LONGITUDE}),
				    map: map
				});
			</script>
		</div>
		<div id="mapTitle">
			<div id="locationContainer"><span id="locationText">${info.SI} > ${info.GU}</span></div>
			<div id="nameContainer"><span id="nameText">${info.FACILITY_NAME}</span></div>
		</div>
		<!--<div id="albumButtonContainer"><img id="albumButtonImage" src="<c:url value="/resources/images/bt_시설 사진보기.png" />" /></div>-->
		<script>
			$(function() {
				$("#buttonBackContainer").click(function() {
					history.back();
				});
				$("#buttonLikeContainer").click(function() {
					ajax_zzim_info_facility("${param.FACILITY_CODE}", function(json) {
						var jsonObj = JSON.parse(JSON.stringify(json));
						if(jsonObj.is_ZZIMED == 0){
							$("#buttonLikeContainer .topButtonImage").attr("src", "<c:url value='/resources/images/icon_좋아요 뚤린 하트(회색).png' />");
						}
						else{
							$("#buttonLikeContainer .topButtonImage").attr("src", "<c:url value='/resources/images/icon_좋아요하트(채운)_회색.png' />");
						}
					});
				});
				$("#albumButtonImage").click(function() {
					$("#swiper_wrapper").css("display","block");
					$("#blackout").css("display","block");
			        setTimeout(function(){
			            swiper.onResize();
			        }, 10);
				});
				$("#close_button_container").click(function() {
					$("#swiper_wrapper").css("display","none");
					$("#blackout").css("display","none");
				});
			});
		</script>
		
		<!-- 이미지 swiper -->
		<div id="swiper_wrapper">
			<div class="swiper-container">
		        <div class="swiper-wrapper">
		        	<c:forEach items="${album_list}" var="album">
		            	<div class="swiper-slide"><img class="pictureUnit" src="<c:url value="/resources/images/Info/${album.PICTURE}" />" /></div>
		            </c:forEach>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
		        <!-- Add Arrows -->
		        <div class="swiper-button-next"></div>
		        <div class="swiper-button-prev"></div>
		    </div>
		    <div id="close_button_container"><img id="close_button" src="<c:url value="/resources/images/white_cancel.png" />" /></div>
	    </div>
	    <div id="blackout"></div>
	    <script>
		    var swiper = new Swiper('.swiper-container', {
		        pagination: '.swiper-pagination',
		        paginationClickable: true,
		        nextButton: '.swiper-button-next',
		        prevButton: '.swiper-button-prev',
		        spaceBetween: 30
		    });
		    $(function() {
		    	album_resize();
		    	$(window).resize(function() {
		    		album_resize();
		    	});
		    });
		    $(document).ready(function() {
		    });
		    function album_resize(){
		    	console.log(($(window).height()-$(".swiper-container").height())/2);
		    	$(".swiper-container").css("top",($(window).height()-$(".swiper-container").height())/2);
		    }
	    </script>
	</body>
</html>

<%@ include file="../common/backeventjs.jsp" %>