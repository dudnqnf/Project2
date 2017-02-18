<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_detail_board_view.css?ver=1'/>" rel="stylesheet">

<body>
<div id="club_detail_board">
	<div class="board">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<div class="search_board">
					<div class="search_input_round">
						<img src="../resources/images/icon_board_search.png">
						<input class="search_input" type="text" placeholder="게시글을 찾아보세요."></input>
					</div>
					<script>
						$(".search_input").keypress(function(e) {
						    if(e.which == 13) {
								location.href="./club_detail.do?mode=board&club_code=${param.club_code}&keyword="+$(this).val()+"&scrollTop="+getParameter("scrollTop");
						    }
						});
					</script>
				</div>
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<div class="search_board fed">
					<div class="search_input_round fed">
						<img src="../resources/images/icon_board_search_fed.png">
						<input class="search_input fed" type="text" placeholder="게시글을 찾아보세요."></input>
					</div>
					<script>
						$(".search_input").keypress(function(e) {
						    if(e.which == 13) {
						    	location.href="./fed_detail.do?FED_CODE=${param.FED_CODE}&KEYWORD="+$(this).val();
						    }
						});
					</script>
				</div>
			</c:when>
		</c:choose>
		<c:forEach items="${ClubNotice}" var="list_n">
			<div class="content notice">
				<div class="content_notice_title">
					<c:choose>
						<c:when test="${IS_FED eq 0}">
							<span class = "notice_icon">공지</span>
						</c:when>
						<c:when test="${IS_FED eq 1}">
							<span class = "notice_icon fed">공지</span>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${list_n.IS_OPEN == '1' || ((IS_FED eq 0 && user_level ne -1) || (IS_FED eq 1 && IsMemberFlag eq 1))}">
							<span class = "notice_title">${list_n.TITLE}</span>
						</c:when>
						<c:otherwise>
							<span class = "notice_title">비밀글 입니다.</span>
						</c:otherwise>
					</c:choose>
					<c:if test="${list_n.IS_OPEN == '0'}">
						<img class="icon_lock" src="<c:url value='/resources/images/icon_동호회_잠금화면.png' />">
					</c:if>
				</div>
				<div class="content_notice_info">
					<c:choose>
						<c:when test="${list_n.IS_OPEN == '1' || ((IS_FED eq 0 && user_level ne -1) || (IS_FED eq 1 && IsMemberFlag eq 1))}">
							<span class = "notice_subtitle">${list_n.REFINDEDCONTENT}</span>
						</c:when>
						<c:otherwise>
							<span class = "notice_subtitle">회원만 볼 수 있습니다.</span>
						</c:otherwise>
					</c:choose>
					<input class="board_id" type="hidden" name="board_id" value="${list_n.BOARD_ID}">
					<input class="is_open" type="hidden" name="is_open" value="${list_n.IS_OPEN}">
				</div>
			</div>
			<div class="line"></div>
		</c:forEach>
		<c:forEach items="${ClubBoard}" var="list">
			<div class="content normal">
				<div class="img_info_wrapper">
					<div class="image_container"><img src="${list.PROFILE}" onError="this.src='<c:url value="/resources/images/icon_프로필사진(공백).png"/>'"></div>
					<div class="inform_container">
						<div class="writer_container">
							<span class="content_writer">${list.USER_NAME}</span>
							<c:if test="${list.IS_OPEN == '0'}">
								<img class="icon_lock" src="<c:url value='/resources/images/icon_동호회_잠금화면.png' />">
							</c:if>
						</div>
						<div class="icon_like_comment_container">
							<c:choose>
								<c:when test="${list.COUNT_LIKE gt 0}">
									<img class="icon_like" src="<c:url value='/resources/images/icon_like_blue.png' />">
									<span class="count_like">${list.COUNT_LIKE}</span>
								</c:when>
								<c:otherwise>
									<img class="icon_like" src="" style="opacity:0;">
									<span class="count_like"></span>
								</c:otherwise>
							</c:choose>
							<c:if test="${list.COUNT_COMMENT gt 0}">
								<img class="icon_comment" src="<c:url value='/resources/images/icon_댓글(블루).png' />">
								<span class="count_comment">${list.COUNT_COMMENT}</span>
							</c:if>
						</div>
						<div class="time_container">
							<span class="content_time">${list.FORMATED_WRITE_DATE} ${list.FORMATED_WRITE_TIME}</span>
						</div>
					</div>
				</div>
				<div class="content_container">
					<div class="title_container">
						<c:choose>
							<c:when test="${list.IS_OPEN == '1' || ((IS_FED eq 0 && user_level ne -1) || (IS_FED eq 1 && IsMemberFlag eq 1))}">
								<span class="title">${list.TITLE}</span>
							</c:when>
							<c:otherwise>
								<span class="title">비밀글 입니다.</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="text_container">
						<c:choose>
							<c:when test="${list.IS_OPEN == '1' || ((IS_FED eq 0 && user_level ne -1) || (IS_FED eq 1 && IsMemberFlag eq 1))}">
								<span class="content_maintext">${list.REFINDEDCONTENT}</span>
							</c:when>
							<c:otherwise>
								<span class="content_maintext">회원만 볼 수 있습니다.</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<input class="board_id" type="hidden" class="board_id" name="board_id" value="${list.BOARD_ID}">
				<input class="is_open" type="hidden" name="is_open" value="${list.IS_OPEN}">
			</div>
			<div class="line"></div>
		</c:forEach>
		<div id="append_here"></div>
		<c:if test="${user_level ne -1 && FedManagers.size() ne 0}">
			<c:choose>
				<c:when test="${IS_FED eq 0 && user_level ne -1}">
					<div class="image_write"></div>
				</c:when>
				<c:when test="${IS_FED eq 1 && IsMemberFlag eq 1}">
					<div class="image_write fed"></div>
				</c:when>
			</c:choose>
		</c:if>
		<input type="hidden" name="ClubCode" id="ClubCode" value="${ClubCode}">
		<input type="hidden" name="InitialKeyword" id="InitialKeyword" value="">
		<!-- 	임원진 없을경우 어둡게 표시 -->
		<c:if test="${FedManagers.size() eq 0}">
		<div style="width:100%;height:100%;background:#797979;z-index:5;text-align:center;padding-top:50px;position:absolute;">
			<span style="color:#fff;">현재 임원진이 존재하지 않습니다.</span>
		</div>
		</c:if>
	</div>
	<div class="tail" id="board_tail"></div>
	
</div>
<script>
	var scrollFlag, eventFlag, parameterString;
	$(function() {
		scrollFlag = 0;
		eventFlag = 0;
		$(".board .image_write").css("right", ($(".image_write").width()/2));
		resize_board();
	});
	$(window).scroll(function() {
		scrollControll();
		resize_board();
	});
	function scrollControll() {
		if($(".swiper-slide-active > div").prop("id") != "club_detail_board")
			return;
		/*
		// 진입
		if(scrollFlag == 0 && $(window).scrollTop()+$(window).height()-$("#board_tail").offset().top > 0){
			scrollFlag = 1;
			setTimeout(function() {
				scrollControll();
			}, 300);
		}
		// 탈출
		else if($(window).scrollTop()+$(window).height()-$("#board_tail").offset().top <= 0){
			scrollFlag = 0;
		}
		// 진입 후
		else if(scrollFlag == 1){
			$(window).scrollTop($(window).scrollTop()-1);
			if($(window).scrollTop()+$(window).height()-$("#board_tail").offset().top > 100){
				scrollFlag = 3;
			}
			setTimeout(function() {
				scrollControll();
			}, 300);
		}
		// 진입 후 재귀
		else if(scrollFlag == 3 && $(window).scrollTop()+$(window).height()-$("#board_tail").offset().top > 0){
			$(window).scrollTop($(window).scrollTop()-1);
			if(eventFlag == 0 && $(window).scrollTop()+$(window).height()-$("#board_tail").offset().top > 115){
				eventFlag = 1;
				var last_child = $(".board .content.normal:last");
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						ajax_select_board_more($("#ClubCode").val(), 5, last_child.children(".board_id").val(), $("#InitialKeyword").val(), function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							attachMore(jsonObj, $("#append_here"));
							$(window).scrollTop($(window).scrollTop()+30);
						});
					</c:when>
					<c:when test="${IS_FED eq 1}">
						ajax_select_fed_board_more("${param.FED_CODE}", 5, last_child.children(".board_id").val(), $("#InitialKeyword").val(), function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							attachMore(jsonObj, $("#append_here"));
							$(window).scrollTop($(window).scrollTop()+30);
						});
					</c:when>
				</c:choose>
			}
			setTimeout(function() {
				scrollControll();
			}, 300);
		}*/
		if(eventFlag == 0 && $(window).scrollTop()+$(window).height() > $(".tail").offset().top - 120){
			eventFlag = 1;
			var is_fed = "${IS_FED}";
			var last_bid = $(".board .content.normal:last").find(".board_id").val();
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					var club_code = "${param.club_code}";
					ajax_select_board_more(club_code, 5, last_bid, $("#InitialKeyword").val(), function(json) {
				</c:when>
				<c:when test="${IS_FED eq 1}">
					var fed_code = "${param.FED_CODE}";
					ajax_select_fed_board_more(fed_code, 5, last_bid, $("#InitialKeyword").val(), function(json) {
				</c:when>
			</c:choose>
				var jsonObj = JSON.parse(JSON.stringify(json));
				attachMore(jsonObj, $("#append_here"));
			});
		}
	}
	function resize_board(){
		if($(".swiper-slide.swiper-slide-active").attr("data-swiper-slide-index") == 1){
			console.log("board_scroll_flag: "+scrollFlag);
			console.log("window.height: "+$(window).height());
			console.log("board.height: "+$(".board").height());
			if($(".board").height() < $(window).height() + $("#board_tail").height()){
				$(".board").height($(window).height() + $("#board_tail").height());
			}
			$(".swiper-container").height($("#club_board_tab").height() + 49);
			if(($(window).scrollTop() + $(window).height()*4/5) < ($(".swiper-pagination").offset().top + $(".swiper-pagination").height() + 20)){
				$(".board .image_write").css("top", $(".search_board").height() + 20);
			}
			else{
				$(".board .image_write").css("top", $(window).scrollTop() + $(window).height()*4/5 - $(".swiper-pagination").offset().top - $(".swiper-pagination").height() + $(".search_board").height());
			}
		}
	}
	function attachMore(array, append_here){
		var format = "";
		for(var i = 0, item; item = array[i]; i++){
			item = JSON.parse(JSON.stringify(item));
			format = "<div class='content normal'>"
						+ "<div class='img_info_wrapper'>"
							+ "<div class='image_container'><img src='"+item.profile+"' onError=\"this.src='<c:url value='/resources/images/icon_프로필사진(공백).png' />'\"></div>"
							+ "<div class='inform_container'>"
								+ "<div class='writer_container'>"
									+ "<span class='content_writer'>"+item.user_NAME+"</span>";
			if(item.is_OPEN == 0){
				format = format 	+ "<img class='icon_lock' src='<c:url value='/resources/images/icon_동호회_잠금화면.png' />'>";
			}
			format = format		+ "</div>"
								+ "<div class='icon_like_comment_container'>";
			if(item.count_LIKE > 0){
				format = format 	+ "<img class='icon_like' src='<c:url value='/resources/images/icon_like_blue.png' />'>&nbsp;"
									+ "<span class='count_like'>"+item.count_LIKE+"</span>&nbsp;";
			}
			else{
				format = format 	+ "<img class='icon_like' src='' style='opacity:0;'>&nbsp;"
									+ "<span class='count_like'></span>&nbsp;";
			}
			if(item.count_COMMENT > 0){
				format = format 	+ "<img class='icon_comment' src='<c:url value='/resources/images/icon_댓글(블루).png' />'>&nbsp;"
									+ "<span class='count_comment'>"+item.count_COMMENT+"</span>";
			}
			format = format 	+ "</div>"
								+ "<div class='time_container'>"
									+ "<span class='content_time'>"+item.formated_WRITE_DATE+" "+item.formated_WRITE_TIME+"</span>"
								+ "</div>"
							+ "</div>"
						+ "</div>"
						+ "<div class='content_container'>"
							+ "<div class='title_container'>";
			if(item.is_OPEN == 1 || ("${IS_FED}" == "0" && "${user_level}" != "-1") || ("${IS_FED}" == "1" && "${IsMemberFlag}" == "1")){
				format = format	+ "<span class='title'>"+item.title+"</span>";
			}
			else{
				format = format	+ "<span class='title'>비밀글 입니다.</span>";
			}
			format = format + "</div>"
							+ "<div class='text_container'>";
			if(item.is_OPEN == 1 || ("${IS_FED}" == "0" && "${user_level}" != "-1") || ("${IS_FED}" == "1" && "${IsMemberFlag}" == "1")){
				format = format	+ "<span class='content_maintext'>"+item.refindedcontent+"</span>";
			}
			else{
				format = format	+ "<span class='content_maintext'>회원만 볼 수 있습니다.</span>";
			}
			format = format + "</div>"
						+ "</div>"
						+ "<input class='board_id' type='hidden' class='board_id' name='board_id' value='"+item.board_ID+"'>"
					+ "</div>"
					+ "<div class='line'></div>";
			append_here.before(format);
		}
		eventFlag = 0;
		resize_board();
		$('.content.normal').off('click');
		$('.content.normal').on('click', function(){
			contentOpen($(this));
		});
	}
	$(".board .content").click(function() {
		contentOpen($(this));
	});
	function contentOpen(obj){
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				if(obj.find(".is_open").val() == "0" && "${user_level}" == "-1"){
					alert("이용할 권한이 없습니다.");
					return;
				}
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
				location.href = "./club_detail_board_view.do?replace=clubdetailboard&club_code="+$("#ClubCode").val()+"&mode=board"+"&board_id="+obj.find(".board_id").val()+"&scrollTop="+$(window).scrollTop()+"&keyword="+$("#InitialKeyword").val()+parameterString;
			</c:when>
			<c:when test="${IS_FED eq 1}">
				if(obj.find(".is_open").val() == "0" && "${IsMemberFlag}" == "0"){
					alert("이용할 권한이 없습니다.");
					return;
				}
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
				location.href = "./fed_detail_board_view.do?replace=feddetailboard&FED_CODE=${param.FED_CODE}&BOARD_ID="+obj.find(".board_id").val()+parameterString;
			</c:when>
		</c:choose>
	}
	$(".board .image_write").click(function() {
		/*ajax_auth_check($("#ClubCode").val(), function(json) {
			var jsonObj = JSON.parse(JSON.stringify(json));
			var auth = jsonObj.user_LEVEL;
			if(auth == -1){
				alert("글을 작성할 권한이 없습니다.");
			}
			else{
				open_is_closed_dialog("board");
			}
		});*/
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				open_is_closed_dialog("board");
			</c:when>
			<c:when test="${IS_FED eq 1}">
				open_is_closed_dialog("board_fed");
			</c:when>
		</c:choose>
	});
</script>