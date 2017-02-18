<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_dialog.css?v=1'/>" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/resources/js/dialog.js'/>"></script>

<body>
<div id="dialog_album_title" class="dialog">
	<div class="header" >제목을 입력하여 주세요</div>
	<div class="title_container"><input type="text" class="title_input" placeholder="제목을 입력하여 주세요" maxlength="22" style="border: 0px;" onchange="len_chk2()" onKeyup="len_chk2()"></div>
	<div id="footer">
		<span id="btnCancel">취소</span>
		<span id="btnSubmit">확인</span>
	</div>
</div>

<script>
	
	$(".title_input").keydown(function(event){
		// 엔터키 방지
		if(event.keyCode == 13) {
			event.preventDefault();
			return false;
		}
	});
	function len_chk2(){  
		var frm = document.insertFrm2.titleTextarea; 
		var length = parseInt($(".title_input").val().length);
		if(length > 22){  
			alert("22자 이내로 작성해주세요.");  
			frm.value = frm.value.substring(0,22);  
			frm.focus();  
		}
	}
	//취소버튼
	$("#dialog_album_title #btnCancel").click(function() {
		$("#blurAll").css("display","none");
		$("#dialog_album_title").css("display","none");
		cancelable = 1;
	});
	
	//확인버튼
	$("#dialog_album_title #btnSubmit").click(function() {
		$("#blurAll").css("display","none");
		$("#dialog_album_title").css("display","none");
		
		var title = $(".title_input").val();
		update_title(title);
		cancelable = 1;
	});
	
	//호출시 기본 부르기 효과
	function open_album_title_dialog(){
		cancelable = 0;
		
		$("#blurAll").css("display","block");
		$("#dialog_album_title").css("display","block");
		
// 		$("#dialog_album_title").css("width", $(window).width()*21/25);
// 		$("#dialog_album_title").css("height", "250px");
		$("#dialog_album_title").css("left", $(window).width()*2/25);
		$("#dialog_album_title").css("top", $(window).scrollTop() + $(window).height()*3/20);
		$("#dialog_album_title .title_input").focus();
		
		$("#dialog_album_title #blurAll").css("width", $(document).width());
		$("#dialog_album_title #blurAll").css("height", $(document).height());
	}
	
</script>
