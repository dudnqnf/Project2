<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_dialog.css'/>" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/resources/js/dialog.js'/>"></script>

<style>
	.title{
		width:100%;
		height:50px;
		background:#008ae8;
		text-align:center;
		padding-top:15px;
		color:#fff;
	}
	
	.content div{
		width:100%;
		height:45px;
		padding-top:10px;
		text-align:center;
		border-bottom-style:solid;
		border-width:1px;
		border-color:#979797;
	}
</style>
<body>
<div id="club_picture_dialog" class="dialog" style="height">
	<div class="title">사진수정</div>
	<div class="content">
		<div onclick="photo_change()">앨범에서 선택</div>
		<div onclick="default_change()">기본이미지로 변경</div>
	</div>
	<input type="hidden" name="isOpened" id="isOpened" value="0">
</div>

<script>
	//초기화
	function open_club_picture_dialog(){	
		$("#blurAll").css("display","block");
		$("#club_picture_dialog").css("display","block");
		
		$("#club_picture_dialog").css("width", $(window).width()*19/25);
		$("#club_picture_dialog").css("height", "140px");
		$("#club_picture_dialog").css("left", $(window).width()*3/25);
		$("#club_picture_dialog").css("top", $(window).scrollTop() + $(window).height()*3/20);
		
		$("#blurAll").css("width", $(document).width());
		$("#blurAll").css("height", $(document).height());
		
		$(".input_basic_cost").focus();
	}
	
</script>
