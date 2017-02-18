<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="<c:url value='/resources/css/club_detail_album.css?ver=2'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/club_detail_album_view.css'/>" rel="stylesheet">

<body>

<%@ include file="../common/backeventjs.jsp" %>


<div class="header">
	<div class="left_btn">
		<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />" onclick="view_back()">
	</div>
	
	<div class="title">
		<span id="page_name">사진첩</span>
	</div>
	
	<div class="right_sub_btn <c:if test="${ZzimInfo ne null}">on</c:if>" id="zzim_btn" onclick="zzim()">
	</div>
	
	<div class="right_btn" id="dropdown">
		<img class="top_button" id="dropdown" src="<c:url value="/resources/images/icon_공유 수정 삭제.png" />">
	</div>



	<div class="dropdownList" style="display: none;">
		<c:if test="${UserId eq WriterInfo.USER_ID}">
			<div class="dropdownButton" id="update" onclick="album_update()">수정하기</div>
				<div class="line"></div>
			<div class="dropdownButton" id="delete" onclick="album_delete()">삭제하기</div>
		</c:if>
		
		<c:if test="${UserId ne WriterInfo.USER_ID}">
			<div class="dropdownButton disabled" style="background-color: #dddddd; color:white;">수정하기</div>
				<div class="line"></div>
			<div class="dropdownButton disabled" style="background-color: #dddddd; color:white;">삭제하기</div>
		</c:if>
			<!-- <div class="line"></div>
		<div class="dropdownButton" id="share" onclick="album_share()">공유하기</div> -->
	</div>

</div>

<div class="line"></div>
<div id="album_view">	
	<div class="is_closed">
		<c:choose>
		    <c:when test="${AlbumInfo.IS_CLOSED == 0}">
		        	공개글
		    </c:when>
		    <c:otherwise>
		        	비공개글
		    </c:otherwise>
		</c:choose>
	</div>
	<div class="docTitle">
		<span id="titleText">${AlbumInfo.TITLE}</span>
	</div>
	<div class="writer">
		<img class="user_img" 
		onclick="location.href='../myprofile/user_info.do?user_id=${WriterInfo.USER_ID}';"
		src="../resources/upload/user/profile/${WriterInfo.PROFILE}" onerror="this.src='../resources/images/icon_blank_pic.png'">
		<div class="user_info">
			<div>
				<span id="writerName">${WriterInfo.USER_NAME}</span>
			</div>
			<div>
				<span id="writeDatetime">
				<fmt:parseDate value="${AlbumInfo.CREATE_DATE}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss.s"/>
				<fmt:formatDate value="${dateFmt}" pattern="yyyy. MM. dd aa h시 m분"/>
				</span>
			</div>
		</div>
	</div>
	
	<!-- Slider main container -->
	<div class="swiper-container">
	    <!-- Additional required wrapper -->
	    <div class="swiper-pagination"></div>
	    <div class="swiper-wrapper">
	        <!-- Slides -->
	        <c:forEach items="${Pictures}" var="list">
				<div class="swiper-slide">
					<img src="../resources/upload/club/${list.FILE_NAME}">
				</div>
			</c:forEach>
	    </div>
	</div>

	<div class="like_reply_container">
	<div class="likeAndCommentButton">
		<div class="btn_like <c:if test="${LikeInfo.IS_LIKED eq 1}">on</c:if>" onclick="on_off()">
			<img class="imageInnerButton" id="icon_like_btn" src="<c:url value="/resources/images/icon_like_gray.png" />">
			<script>
				if(${LikeInfo.IS_LIKED} == 1){$("#icon_like_btn").attr("src", "../resources/images/icon_like_blue.png");}
			</script>
			<span class="spanInnerButton">좋아요</span>
		</div>
		<div class="btn_reply" onclick="moveFocus()">
			<img class="imageInnerButton" id="grayFilter" src="<c:url value="/resources/images/icon_댓글_gray.png" />">
			<span class="spanInnerButton">댓글쓰기</span>
		</div>
		<script>
			var cnt;
			$(".input_reply").css("display","none");
			$(".btn_reply").click(function() {
				
				//$("body").animate({scrollTop:$("body").prop("scrollHeight")},400);
				cnt = 1;
				if (cnt == 1){
					$(".input_reply").css("display","block");
					$(".input_reply .btn_reply_input").focus();
					cnt = 0;
				}else{
					$(".input_reply").css("display","none");
					cnt = 1;
				}
			});
			</script>
	</div>
	<div class="like_container">
		<img src="../resources/images/icon_like_gray.png">
		<div class="like">
	        <p class="like_count" style="float:left;">${LikeInfo.COUNT}</p>&nbsp;명이 좋아합니다
		</div>
	</div>
	<div class="reply">
		<c:forEach items="${ReplyInfo}" var="list">
			<div class="reply_container" id="${list.REPLY_CODE}" user_id="${list.USER_ID}">
				<div class="commentProPic">
					<img src="../resources/upload/user/profile/${list.PROFILE}" class="user_profile" 
					onError="this.src='<c:url value="/resources/images/icon_프로필사진(공백).png"/>'" 
					onclick="location.href='../myprofile/user_info.do?user_id=${list.USER_ID}';">
				</div>
				<div class="commentNotPic rightside_pic">
					<div class="commentWriterNameContainer">
						<span class="commentWriterName">${list.USER_NAME}</span>
						<c:if test="${list.USER_ID eq UserId}">
							<span class="reply_edit_btn" onclick="reply_edit(${list.REPLY_CODE})">수정</span>
							<span class="reply_delete_btn" onclick="reply_delete(${list.REPLY_CODE})">삭제</span>
						</c:if>
						<span class="commentWriteDatetime">${list.CREATED_DATE}</span>
					</div>
					<div class="commentContentText">
						<span>${list.REPLY}</span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
		<div class="input_reply" style="display: none;">
			<textarea class="btn_reply_input" name="comment_input" placeholder="댓글을 달아주세요^^" rows="1"></textarea>
			<img class="btn_reply_upload" src="../resources/images/icon_올리기.png">
		</div>
</div>
<div class="jsp_referer" style="display:none;"><%=request.getHeader("REFERER")%></div>
</div>
</body>
</html>
<script>
	$(document).ready(function(){
		//initialize swiper when document ready  
	    var mySwiper = new Swiper ('.swiper-container', {
	      // Optional parameters
	      direction: 'horizontal',
	      autoHeight: true,
	      loop: true
	    })
	
		likeCheck();
	});
    
    $(".btn_reply_upload").click(function(){
    	
    	if($(".btn_reply_input").val() == ""){
    		window.alert("댓글 내용을 입력하세요.");
    	}else{
	    	var reply = $(".btn_reply_input").val();
	    	var album_code = ${param.album_code};
	    	
	    	ajax_insert_album_reply(album_code, reply, function callback(json){
	    		var jsonObj = JSON.parse(JSON.stringify(json));
	    		var result = jsonObj.result;
	    		var value = jsonObj.value;
	    		
	    		if(result){
	    			$(".btn_reply_input").val("");
	    			var ori = $(".reply").html();
					$(".reply").html(ori
							+ '<div class="reply_container" id="'+value.reply_CODE+'" user_id="'+value.user_ID+'">'
							+	 '<div class="commentProPic">'
							+ 		'<img class="user_profile" src="../resources/upload/user/profile/' + value.profile + '" onclick="go_user_info('+value.user_ID+')"'
							+		'onerror="this.src=\'<c:url value="/resources/images/icon_프로필사진(공백).png"/>\'" >'
							+	'</div>'
							+	'<div class="commentNotPic rightside_pic">'
							+ 		'<div class="commentWriterNameContainer">'
							+ 			'<span class="commentWriterName">' + value.user_NAME + '</span>'
							+			'<span class="reply_edit_btn" onclick="reply_edit('+value.reply_CODE+')">수정</span>'
							+			'<span class="reply_delete_btn" onclick="reply_delete('+value.reply_CODE+')">삭제</span>'
							+			'<span class="commentWriteDatetime">' + value.created_DATE+ '</span>'
							+ 		'</div>'
							+ 		'<div class="commentContentText">'
							+ 			'<span>'+ value.reply + '</span>'
							+ 		'</div>'
							+ 	'</div>'
							+ '</div>'
					);
	    		} else {
	    			window.alert("실패");
	    		}
	    	});
    	}
    });
    
    function go_user_info(user_id){
    	location.href='../myprofile/user_info.do?user_id='+user_id;
    }
    
    function moveFocus(){
    	$(".btn_reply_input").focus();
    }
    
    function on_off(){
		if($(".btn_like").hasClass("on")){
			dislike();
		} else {
			like();
		}
			

    }
    
    function like(){
    	var album_code = ${param.album_code};
    	ajax_album_like(album_code, function callback(json){
    		var jsonObj = JSON.parse(JSON.stringify(json));
    		var result = jsonObj.result;
    		var value = jsonObj.value;
    		
    		if(result){
    			$("#album_view .btn_like .imageInnerButton").attr("src","../resources/images/icon_like_blue.png");
    			$(".btn_like").addClass("on");
    			var like_count = $(".like_count").html();
    			if(like_count==undefined)
    				$(".like").html('<p class="like_count" style="float:left;">1</p>&nbsp;명이 좋아합니다');
    			else
    				$(".like_count").html(parseInt(like_count)+1);
    			
    		} else {
    			window.alert("실패");
    		}
    	});
    }
    
    
    function dislike(){
    	var album_code = ${param.album_code};
    	ajax_album_dislike(album_code, function callback(json){
    		var jsonObj = JSON.parse(JSON.stringify(json));
    		var result = jsonObj.result;
    		var value = jsonObj.value;
    		
    		if(result){
				$("#album_view .btn_like .imageInnerButton").attr("src","../resources/images/icon_like_gray.png");
    			$(".btn_like").removeClass("on");
    			var like_count = $(".like_count").html();
    			$(".like_count").html(like_count-1);
    			likeCheck();
    		} else {
    			window.alert("실패");
    		}
    	});
    }
    
    function likeCheck(){
    	var like_count = $(".like_count").html();
    	if(like_count == 0)
    		$(".like").html("첫번째 좋아요를 눌러주세요!");
    }
    
    $(document).mouseover(function(e){
   		var target_id = $(e.target).attr("id");
       	if(target_id=="update"){
       		album_update();
       	}
       	if(target_id=="delete"){
       		album_delete();
       	}
       	if(target_id=="share"){
       		album_share();
       	}
       	$(".dropdownList").css("display", "none");
    });
    
    $(function() {
		$(".dropdownList").css("display","none");
	});
	$(".right_btn").click(function() {
		if($(".dropdownList").css("display") == "none"){
			$(".dropdownList").css("display","block");
		}
		else{
			$(".dropdownList").css("display","none");
		}
	});
   /* 
    $(".right_btn").mouseover(function(){
   		$(".dropdownList").css("display", "block");
    });
    
    $(".right_btn").mouseleave(function(){
   		$(".dropdownList").css("display", "none");
    });
    */
    function album_delete(){
    	var del = window.confirm("정말로 삭제하시겠습니까?");
    	var flag = 0;
    	if(del){
    		$.ajax({
    			type:"POST",
    			url:"./album_del.do",
    			data : {club_code : "${param.club_code}", album_code : "${param.album_code}"},
    			dataType : "json",
    	        async: false,
    		    success: function(){
    		    	flag = 1;
    		    },
    		    error: function(xhr, status, error) {
    		    }
    		});
    		if(flag == 1){
        		alert("삭제되었습니다.");
        		history.go(-2);
    		}
    		else{
    			alert("오류가 발생하였습니다.");
    		}
    	}
    }
    
    var reload_flag = 0;
    function album_update(){
    	$(".dropdownList").css("display", "none");
		reload_flag = 1;    	
    	var title = window.prompt("제목을 다시 입력하여 주세요");
    	if(title!=undefined){
    		var album_code = ${param.album_code};
        	ajax_album_update(album_code, title, function callback(json){
        		var jsonObj = JSON.parse(JSON.stringify(json));
        		var result = jsonObj.result;
        		var value = jsonObj.value;
        		
        		if(result){
        			$(".docTitle").html(title);
        		} else {
        			window.alert("실패");
        		}
        	});
    	}
    }
    
    function zzim(){
    	var album_code = ${param.album_code};
    	if($("#zzim_btn").hasClass("on")){
    		//찜하기가 이미 눌려져 있을경우
    		ajax_album_zzim_cancel(album_code, function callback(json){
        		var jsonObj = JSON.parse(JSON.stringify(json));
        		var result = jsonObj.result;
        		var value = jsonObj.value;
        		
        		if(result){
        			$("#zzim_btn").removeClass("on");
        		} else {
        			window.alert("실패");
        		}
        	});
    	} else {
    		//찜하기 누르기
    		ajax_album_zzim(album_code, function callback(json){
        		var jsonObj = JSON.parse(JSON.stringify(json));
        		var result = jsonObj.result;
        		var value = jsonObj.value;
        		
        		if(result){
        			$("#zzim_btn").addClass("on");
        		} else {
        			window.alert("실패");
        		}
        	});
    	}
    	
    }
    
    function view_back(){
    	history.back();
    	//location.href="./club_detail.do?club_code=${param.club_code}&mode=album";
    }
    
	function reply_edit(reply_code){
		location.href="./club_album_reply_edit.do?club_code=${param.club_code}&album_code=${param.album_code}&REPLY_CODE=" + reply_code;
	}
    
	function reply_delete(reply_code){
		ajax_album_reply_delete(reply_code, function callback(json){
			var jsonObj = JSON.parse(JSON.stringify(json));
			var result = jsonObj.result;
			var value = jsonObj.value;
			
			if(result){
				$("#"+reply_code).css("display", "none");
			} else {
				window.alert("제목변경에 실패하였습니다.");
			}
		});
	}
	
</script>
</div>


