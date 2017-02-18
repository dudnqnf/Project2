<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<link href="<c:url value='/resources/css/bootstrap.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/footer.css?v=2'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/header.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club.css?v=1'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club_album_reply_edit.css?ver=3'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club_dialog.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/jquery.mobile.css'/>" rel="stylesheet">
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/ajax.js?v=1'/>"></script>
</head>
<body>

<div class="header">
	<div class="left_btn"></div>
	<div class="title">수정</div>
	<div class="right_btn"></div>
</div>

<div id="album_reply_edit">
	<input class="input_reply" type=text value="${reply_info.REPLY}">
	<button class="update" onclick="update_reply()">업데이트</button>
	<button class="cancel" onclick="history.back()">취소</button>
</div>

<script>
	function update_reply(){
		var reply_code = ${param.REPLY_CODE};
		var reply = $(".input_reply").val();
		ajax_album_reply_edit(reply_code, reply, function callback(json){
			var jsonObj = JSON.parse(JSON.stringify(json));
			var result = jsonObj.result;
			var value = jsonObj.value;
			
			if(result){
				location.href="./album.do?club_code=${param.club_code}&album_code=${param.album_code}";
			} else {
				window.alert("제목변경에 실패하였습니다.");
			}
		});
	}
</script>