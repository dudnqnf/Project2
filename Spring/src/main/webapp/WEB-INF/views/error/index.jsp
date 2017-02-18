<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>Page Error</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
	<style>
		@font-face{font-family:'NanumSquareR'; src:url('/SportForAll/resources/fonts/NanumSquareR.ttf')}
		@font-face{font-family:'NanumSquareB'; src:url('/SportForAll/resources/fonts/NanumSquareB.ttf')}
		@charset utf-8;
		
		.error{
			font-family:'NanumSquareR';
		}
		
		.error .error_img{
			width:100%;
			height:150px;
			text-align:center;
		}
		
		.error .error_img img{
			width:100px;
			height:150px;
		}
		
		.error .error_msg{
			font-family:'NanumSquareB';
			margin-top:10px;
			font-size:18px;
			color:#00a4e1;
			font-weight:bold;
		}
		
		.error .error_msg_detail{
			font-family:'NanumSquareR';
			margin-top:20px;
			font-size:12px;
			color:#979797;
		}
		
		.error .go_back{
			width:80%;
			margin-left:10%;
			margin-top:35px;
			color:#fff;
			background:#008ae8;
			padding-top:15px;
			padding-bottom:15px;
		}
		
		.error .go_home{
			width:80%;
			margin-left:10%;
			margin-top:25px;
			color:#fff;
			background:#008ae8;
			padding-top:15px;
			padding-bottom:15px;
		}
	</style>
</head>
<body>
<div class="error" style="width:100%;height:100%;text-align:center;padding-top:100px;">
	<div class="error_img"><img src="/SportForAll/resources/images/icon_error.png"></div>
	<div class="error_msg">죄송합니다<br>${msg}</div>
	<div class="error_msg_detail">존재하지 않는 주소를 입력하셨거나,<br>요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br>서비스 이용에 불편을 드려서 대단히 죄송합니다.</div>
	<div class="go_back" onclick="history.back(-1)">이전페이지로 이동</div>
	<div class="go_home" onclick="go_home()">운동생활 홈으로 이동</div>
</div>
<script>
	function go_home(){
		location.replace("<c:url value='/'/>");
	}
	if("${request_uri}" == "/SportForAll/myprofile/index.do"){
		go_home();
	}
</script>
</body>
</html>