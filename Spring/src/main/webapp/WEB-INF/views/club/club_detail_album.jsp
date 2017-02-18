<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_detail_album.css?v=4'/>" rel="stylesheet">

<body>
<div id="album">
	<c:if test="${user_level ne -1 && FedManagers.size() ne 0}">
		<c:choose>
			<c:when test="${IS_FED eq 0 && user_level ne -1}">
				<div class="btn_photo_upload" onclick="is_closed()"></div>
			</c:when>
			<c:when test="${IS_FED ne 0 && IsMemberFlag eq 1}">
				<div class="btn_photo_upload fed" onclick="is_closed()"></div>
			</c:when>
		</c:choose>
	</c:if>
	<div class="search_board <c:if test='${IS_FED eq 1}'>fed</c:if>">
		<div class="search_input_round">
			<img src="
			<c:if test='${IS_FED ne 1}'>../resources/images/icon_board_search.png</c:if>
			<c:if test='${IS_FED eq 1}'>../resources/images/icon_board_search_fed.png</c:if>
			">
			<input class="search_input" id="album_search" type="text" placeholder="다시보고 싶은 사진을 찾아보세요."></input>
		</div>
	</div>
	<div class="club_album">
		<c:forEach items="${ClubAlbum}" var="list">
			<div class="album_container" onclick="go_album(${list.ALBUM_CODE}, ${list.IS_CLOSED})">
				<div class="preview_num_container">
					<div class="preview_num">
						<c:if test="${list.LIKE_NUM ne 0}"><img src="../resources/images/icon_white_like.png"> ${list.LIKE_NUM}</c:if>
						<c:if test="${list.REPLY_NUM ne 0}"><img src="../resources/images/icon_white_reply.png"> ${list.REPLY_NUM}</c:if>
					</div>
				</div>
				<c:if test="${list.IS_CLOSED eq 1}">
				<div class="lock_container">
					<img class="lock" src="../resources/images/icon_album_lock.png">
				</div>
				</c:if>
				<img class="album_img" src="../resources/upload/club/thumbnail/${list.FILE_NAME}">
				<div class="title">${list.TITLE}</div>
			</div>
		</c:forEach>
	</div>
	<c:if test="${FedManagers.size() eq 0}">
	<div style="width:100%;height:100%;background:#797979;z-index:5;text-align:center;padding-top:50px;">
		<span style="color:#fff;">현재 임원진이 존재하지 않습니다.</span>
	</div>
	</c:if>
</div>
	
<script>
	$(document).ready(function(){
// 		$("#album").css("height", $(window).height()-$(".top").height()-$(".swiper-pagination").height()-$(".search_board").height()+"px");
		$("#album").css("height", $(window).height());
		$("#album .btn_photo_upload").css("top", $(window).scrollTop() + $(window).height()*4/5 - $(".swiper-pagination").offset().top - $(".swiper-pagination").height() + $(".search_board").height());
	});

		var album_code;
		var is_closed_flag;
		var page = 1;
		var search_flag = 0;	//search모드가 아님
		var search_page = 1;
		var word;
		var user_id = ${user_id};
		var is_fed = ${IS_FED};
		var club_code = ${club_code};
		
		//공개 비공개 여부 설정하기
		function is_closed(){
// 			window.Android.dialog();		//안드로이드 다이얼로그
			open_is_closed_dialog("album");		//결과는 android_album으로 돌아옴
		}
		
		//안드로이드 결과 받기
// 		function android_result(flag){
// 			is_closed = flag;
// 			webview();
// 		}
		
		//웹 팝업에서 결과 받기(dialog_is_closed.jsp)
		//안드로이드 사진앨범 호출
		function android_album(is_opened){
			if(is_opened=="0")
				is_closed_flag=1;
			else
				is_closed_flag=0;
				
			window.Android.selectImage(club_code, user_id);
		}
		
		//안드로이드 사진앨범 선택 후 호출되는 함수
		//제목 설정하기
		function title_update(code){
			album_code = code;
			open_album_title_dialog();
		}
		//dialog에서 title값 받아서 update
		function update_title(title){
			ajax_update_title(title, album_code, is_closed_flag, function callback(json){
				var jsonObj = JSON.parse(JSON.stringify(json));
				var result = jsonObj.result;
				var value = jsonObj.value;
				
				if(result){
					album_view(value, "front");
				} else {
					window.alert("제목변경에 실패하였습니다.");
				}
			});
		}
		
		function go_album(album_code, is_closed_flag){
			var flag = ${IsMemberFlag};			
			if(is_closed_flag==1 && flag == false) {
				window.alert("권한이 없습니다");
			} else {
				location.href="./album.do?club_code=${club_code}&album_code="+album_code+"&replace=album";
			}
			
		}
		
		$("#album_search").keypress(function(e) {
			word = $("#album_search").val();
			
			search_flag = 1;	//찾기모드
		    if(e.which == 13) {
		    	ajax_album_search(word, club_code, function callback(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					var value = jsonObj.value;
					$(".club_album").html("");
					if(result){
						value.forEach(function(element){
							var obj = element;
							album_view(obj, "back");
						});
						mySwiper.onResize();
					} else {
						window.alert("실패");
					}
				});
		    }
		});
		
		$(window).scroll(function() {
			$("#album .btn_photo_upload").css("top", $(window).scrollTop() + $(window).height()*4/5 - $(".swiper-pagination").offset().top - $(".swiper-pagination").height() + $(".search_board").height());
			if($("#club_album_tab").hasClass("swiper-slide-active") && $(window).scrollTop() == $(document).height() - $(window).height()){
				if(!search_flag){		//search_mode가 아닐때
					ajax_album_more(club_code, page, function callback(json){
						var jsonObj = JSON.parse(JSON.stringify(json));
						var result = jsonObj.result;
						var value = jsonObj.value;
						
						if(result){
							page = page + 1;
							value.forEach(function(element){
								var obj = element;
								album_view(obj, "back");
							});
							mySwiper.onResize();
						} else {
//	 						window.alert("자료가 더이상 없습니다.");
						}
					});
				} else {		//찾기모드일때
					ajax_album_search_more(word, search_page, code, function callback(json){
						var jsonObj = JSON.parse(JSON.stringify(json));
						var result = jsonObj.result;
						var value = jsonObj.value;
						
						if(result){
							search_page = search_page + 1;
							value.forEach(function(element){
								var obj = element;
								album_view(obj, "back");
							});
							mySwiper.onResize();
						} else {
//	 						window.alert("자료가 더이상 없습니다.");
						}
					});
				}
				
		    }
		});
		
		function album_view(obj, location){
			var ori = $(".club_album").html();
			var ori_front = "";
			var ori_back = "";
			if(location=="front"){
				ori_back = ori;
			} else if(location=="back"){
				ori_front = ori;
			}
			
			var is_closed_flag = obj.is_CLOSED;
			var lock_html = "";
			if(is_closed_flag==1){
				lock_html = 
					'<div class="lock_container">'
					+		'<img class="lock" src="../resources/images/icon_album_lock.png">'
					+	'</div>'
			}
			
			var like_num = "";
			var reply_num = "";
			if(obj.like_NUM!=0)
				like_num = '<img src="../resources/images/icon_white_like.png"> '+obj.like_NUM;
			if(obj.reply_NUM!=0)
				reply_num = '<img src="../resources/images/icon_white_reply.png"> '+obj.reply_NUM;
				
			$(".club_album").html(
					ori_front
					+ '<div class="album_container" onclick="go_album('+ obj.album_CODE +', '+ obj.is_CLOSED +')">' 
					+ 	'<div class="preview_num_container">'
					+ 		'<div class="preview_num">'
					+ 			like_num
					+ 			reply_num
					+ 		'</div>'
					+ 	'</div>'
					+	lock_html
					+	'<img class="album_img" src="../resources/upload/club/thumbnail/'+ obj.file_NAME +'">' 
					+	'<div class="title">' + obj.title + '</div>'
					+ '</div>'
					+ ori_back
			);
			
		}
		
</script>
	
