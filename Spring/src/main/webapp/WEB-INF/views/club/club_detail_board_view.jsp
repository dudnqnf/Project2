<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_board_view.css?ver=1'/>" rel="stylesheet">

<body>
<%
	String club_code = request.getParameter("club_code");
	if(club_code == null)
		club_code = "";
	String board_id = request.getParameter("board_id");
	if(board_id == null)
		board_id = "";
	String mode = request.getParameter("mode");
	if(mode == null)
		mode = "";
	String scrollTop = request.getParameter("scrollTop");
	if(scrollTop == null)
		scrollTop = "";
	String keyword = request.getParameter("keyword");
	if(keyword == null)
		keyword = "";
	String user_id = "";
	Cookie[] cookies = request.getCookies();
	for(int i = 0; i < cookies.length; i++){
		if(cookies[i].getName().equals("user_id")){
			user_id = cookies[i].getValue();
		}
	}
%>

<div class="board_view">
	<c:if test="${user_level eq -1 && BoardView.IS_OPEN eq 0}">
		<script>
			alert("이용권한이 없는 게시글입니다.");
			//location.href = "./club_detail.do?club_code=<%=club_code%>&mode=<%=mode%>&keyword=<%=keyword%>&scrollTop=<%=scrollTop%>";
			history.back();
		</script>
	</c:if>
	<c:if test="${BoardView.IS_DELETED eq 1}">
		<script>
			alert("삭제된 게시글입니다.");
			//location.href = "./club_detail.do?club_code=<%=club_code%>&mode=<%=mode%>&keyword=<%=keyword%>&scrollTop=<%=scrollTop%>";
			history.back();
		</script>
	</c:if>
	
	

	<div class="header">
		<div class="left_btn">
			<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />">
		</div>
		
		<div class="title">
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					<span id="page_name">게시글</span>
				</c:when>
				<c:when test="${IS_FED eq 1}">
					<span id="page_name" class="fed">게시글</span>
				</c:when>
			</c:choose>
		</div>
		
		<div class="right_sub_btn">
			<img class="top_button zzim" id="heart" src="<c:url value="/resources/images/icon_좋아요 뚤린 하트(회색).png" />">
			<img class="top_button zzim" id="heartFull" src="<c:url value="/resources/images/icon_좋아요하트(채운)_회색.png"/>">
			<input type="hidden" name="isZzim" class="isZzim" id="${IsZzim}" value="${IsZzim}">
			<c:if test="${IsZzim ne 0}">
				<script>
					$(".board_view #heartFull").css("display","block");
					$(".board_view #heart").css("display","none");
				</script>
			</c:if>
			<c:if test="${IsZzim eq 0}">
				<script>
					$(".board_view #heart").css("display","block");
					$(".board_view #heartFull").css("display","none");
				</script>
			</c:if>
			<script>
				$(".board_view .zzim").click(function() {
					<c:choose>
						<c:when test="${IS_FED eq 0}">
							ajax_zzim_board($(".board_view #board_id").val(), function(json) {
						</c:when>
						<c:when test="${IS_FED eq 1}">
							ajax_zzim_fed_board($(".board_view #board_id").val(), function(json) {
						</c:when>
					</c:choose>
						var jsonObj = JSON.parse(JSON.stringify(json));
						var isZzim = jsonObj.is_ZZIM;
						if(isZzim == 0){
							$(".board_view #heart").css("display","block");
							$(".board_view #heartFull").css("display","none");
							$(".board_view .isZzim").val(0);
						}
						else{
							$(".board_view #heart").css("display","none");
							$(".board_view #heartFull").css("display","block");
							$(".board_view .isZzim").val(1);
						}
					});
				});
			</script>
		</div>
		
		<div class="right_btn">
			<img class="top_button" id="dropdown" src="<c:url value="/resources/images/icon_공유 수정 삭제.png" />">
		</div>
		
		<div class="dropdownList">
			<c:if test="${is_writer eq 1}">
				<div class="dropdownButton" id="modify">수정하기</div>
				<div class="line"></div>
				<div class="dropdownButton" id="delete">삭제하기</div>
				<script>
					$(".board_view .dropdownList #modify").click(function() {
						<c:choose>
							<c:when test="${IS_FED eq 0}">
								var club_code = "<%=club_code%>";
								var board_id = "<%=board_id%>";
								var mode = "<%=mode%>";
								var scrollTop = "<%=scrollTop%>";
								var keyword = "<%=keyword%>";
								location.href="./club_detail_board_write.do?is_modify=1&club_code="+club_code+"&board_id="+board_id+"&keyword="+keyword+"&scrollTop="+scrollTop+"&keyword="+keyword;
							</c:when>
							<c:when test="${IS_FED eq 1}">
								var fed_code = "${param.FED_CODE}";
								var board_id = "${param.BOARD_ID}";
								location.href="./fed_detail_board_write.do?IS_MODIFY=1&FED_CODE="+fed_code+"&BOARD_ID="+board_id;
							</c:when>
						</c:choose>
					});
					$(".board_view .dropdownList #delete").click(function() {
						var check = confirm("게시물을 삭제하시겠습니까?");
						if(check == false){
							return;
						}
						<c:choose>
							<c:when test="${IS_FED eq 0}">
								//var club_code = "<%=club_code%>";
								var board_id = "<%=board_id%>";
								/*var mode = "<%=mode%>";
								var scrollTop = "<%=scrollTop%>";
								var keyword = "<%=keyword%>";
								location.href="./club_board_delete.do?club_code="+club_code+"&board_id="+board_id+"&keyword="+keyword+"&scrollTop="+scrollTop+"&keyword="+keyword;
								*/
								ajax_delete_club_board(board_id, function(json) {
							</c:when>
							<c:when test="${IS_FED eq 1}">
								var board_id = "${param.BOARD_ID}";
								ajax_delete_fed_board(board_id, function(json) {
							</c:when>
						</c:choose>
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1){
								alert("게시글을 삭제하였습니다.");
								history.back();
							}
						});
					});
				</script>
			</c:if>
			<c:if test="${is_writer eq 0}">
				<div class="dropdownButton disabled" id="modify">수정하기</div>
				<div class="line"></div>
				<div class="dropdownButton disabled" id="delete">삭제하기</div>
			</c:if>
			<!-- <div class="line"></div>
			<div class="dropdownButton" id="share">공유하기</div> -->
		</div>
		<script>
			$(function() {
				$(".board_view .dropdownList").css("display","none");
			});
			$(".board_view #dropdown").click(function() {
				if($(".board_view .dropdownList").css("display") == "none"){
					$(".board_view .dropdownList").css("display","block");
				}
				else{
					$(".board_view .dropdownList").css("display","none");
				}
			});
		</script>
	</div>
	
	
	<div class="line"></div>
	<div class="header_content">
		<div class="docOptions">
			<span id="optNotice">
				<c:if test="${BoardView.NOTICE_TYPE eq 0}">일반글</c:if>
				<c:if test="${BoardView.NOTICE_TYPE eq 1}">공지</c:if>
			</span>
			<span id="optOpened">
				<c:if test="${BoardView.IS_OPEN eq 1}">공개글</c:if>
				<c:if test="${BoardView.IS_OPEN eq 0}">비밀글</c:if>
			</span>
		</div>
		<div class="docTitle">
			<span id="titleText"></span>
		</div>
		<script>
			var title = "${BoardView.TITLE}";
			title = refineContentView(title);
			$(".board_view #titleText").html(title);
		</script>
		<div>
			<div class="writerProPicContainer">
				<img id="writerProPic" src="<c:url value="/resources/upload/user/profile/${BoardView.PROFILE}"/>" 
				onError="this.src='<c:url value="/resources/images/icon_프로필사진(공백).png"/>'"
				onclick="location.href='../myprofile/user_info.do?user_id=${BoardView.WRITE_USER}';">
			</div>
			<div class="rightside_pic">
				<div class="writerNameContainer">
					<span id="writerName">${BoardView.USER_NAME}</span>
				</div>
				<div class="writerDatetimeContainer">
					<span id="writeDatetime">${BoardView.FORMATED_WRITE_DATE} ${BoardView.FORMATED_WRITE_TIME}</span>
				</div>
			</div>
		</div>
		<input type="hidden" name="board_id" id="board_id" value="${BoardView.BOARD_ID}">
		<input type="hidden" name="write_user" id="write_user" value="${BoardView.WRITE_USER}">
	</div>
	<div class="lineSmall"></div>
	<div class="main_content"><span class="autoNewLine" id="mainContentText"></span></div>
	<script>
		var content = "${BoardView.CONTENT}";
		content = refineContentView(content);
		$(".board_view #mainContentText").html(content);
	</script>
	<div class="line"></div>
	<div class="button_footer">
		<div class="likeAndCommentButton">
			<div id="likeButton">
				<img class="imageInnerButton" id="grayFilter" src="<c:url value="/resources/images/icon_like_blue.png" />">
				<span class="spanInnerButton">좋아요</span>
				<c:if test="${IsLike ne 0}">
					<script>
						$(".board_view #likeButton .imageInnerButton").attr("src", "../resources/images/icon_like_blue.png");
						$(".board_view #likeButton .spanInnerButton").css("opacity","1");
						$(".board_view #likeButton .spanInnerButton").css("color","#008ae8");
					</script>
				</c:if>
				<c:if test="${IsLike eq 0}">
					<script>
						$(".board_view #likeButton .imageInnerButton").attr("src","../resources/images/icon_like_gray.png");
						$(".board_view #likeButton .spanInnerButton").css("opacity","0.34");
						$(".board_view #likeButton .spanInnerButton").css("color","#000000");
					</script>
				</c:if>
			</div>
			<script>
				$(".board_view #likeButton").click(function(){
					<c:choose>
						<c:when test="${IS_FED eq 0}">
							ajax_like_board($(".board_view #board_id").val(), function(json) {
						</c:when>
						<c:when test="${IS_FED eq 1}">
							ajax_like_fed_board($(".board_view #board_id").val(), function(json) {
						</c:when>
					</c:choose>
						var jsonObj = JSON.parse(JSON.stringify(json));
						var isLike = jsonObj.isLike;
						var countLike = jsonObj.countLike;
						if(isLike == 0){
							$(".board_view #likeButton .imageInnerButton").attr("src", "../resources/images/icon_like_gray.png");
							$(".board_view #likeButton .spanInnerButton").css("opacity","0.34");
							$(".board_view #likeButton .spanInnerButton").css("color","#000000");
							if(countLike == 0){
								$(".board_view .spanInnerBriefLike").html("첫번째 좋아요를 눌러주세요!");
							}
							else{
								$(".board_view .spanInnerBriefLike").html(countLike+" 명이 좋아합니다.");
							}
						}
						else{
							$(".board_view #likeButton .imageInnerButton").attr("src", "../resources/images/icon_like_blue.png");
							$(".board_view #likeButton .spanInnerButton").css("opacity","1");
							$(".board_view #likeButton .spanInnerButton").css("color","#008ae8");
							$(".board_view .spanInnerBriefLike").html(countLike+" 명이 좋아합니다.");
						}
					});
				});
			</script>
			<div class="vertical-line"></div>
			<div id="commentButton">
				<img class="imageInnerButton" id="grayFilter" src="<c:url value="/resources/images/icon_댓글_gray.png" />">
				<span class="spanInnerButton">댓글쓰기</span>
			</div>
			<!-- <script>
				$("#commentButton").click(function() {
					$("body").animate({scrollTop:$("body").prop("scrollHeight")},400);
					$(".comment_input_textarea").focus();
				});
			</script> -->
			<script>
			$("#commentButton").click(function() {
				var cnt;
				$("body").animate({scrollTop:$("body").prop("scrollHeight")},400);
				cnt = 1;
				if (cnt == 1){
					$(".comment_input_footer").css("display","block");
					$(".comment_input_textarea").focus();
					cnt = 0;
				}else{
					$(".comment_input_footer").css("display","none");
					cnt = 1;
				}
			});
			</script>
			
		</div>
		<div class="line"></div>
		<div class="briefLikes">
			<img class="imageInnerBriefLike" id="grayFilter" src="<c:url value="/resources/images/icon_like_gray.png" />">
			<c:if test="${CountLike ne 0}">
				<span class="spanInnerBriefLike">${CountLike} 명이 좋아합니다.</span>
			</c:if>
			<c:if test="${CountLike eq 0}">
				<span class="spanInnerBriefLike">첫번째 좋아요를 눌러주세요!</span>
			</c:if>
		</div>
	</div>
	<div class="line"></div>
	<div class="comment_list_footer">
		<c:forEach items="${BoardComment}" var="list">
			<div class="comment_wrapper is_replyEq${list.IS_REPLY}">
				<div class="commentProPic">
					<img class="commentWriterProPic" src="<c:url value="/resources/upload/user/profile/${list.PROFILE}"/>" 
					onError="this.src='<c:url value="/resources/images/icon_프로필사진(공백).png"/>'"
					onclick="location.href='../myprofile/user_info.do?user_id=${list.WRITE_USER}';">
				</div>
				<div class="commentNotPic rightside_pic">
					<div class="commentWriterNameContainer">
						<span class="commentWriterName">${list.USER_NAME}</span>
						<!-- <span class="commentFunction replyButton">댓글달기</span> -->
						<c:if test="${list.IS_WRITER eq 1}">
							<span class="commentFunction modifyButton">수정</span>
							<span class="commentFunction deleteButton">삭제</span>
						</c:if>
						<span class="commentWriteDatetime">${list.FORMATED_WRITE_DATE} ${list.FORMATED_WRITE_TIME}</span>
					</div>
					<div class="commentContentTextContainer">
						<span class="commentContentText autoNewLine" id="commentContentText">${list.CONTENT}</span>
					</div>
				</div>
				<input type="hidden" name="write_user" class="write_user" id="${list.WRITE_USER}" value="${list.WRITE_USER}">
				<input type="hidden" name="comment_id" class="comment_id" id="${list.COMMENT_ID}" value="${list.COMMENT_ID}">
				<c:if test="${list.IS_REPLY eq -1}">
					<input type="hidden" name="parent_id" class="parent_id" id="${list.COMMENT_ID}" value="${list.COMMENT_ID}">
				</c:if>
				<c:if test="${list.IS_REPLY ne -1}">
					<input type="hidden" name="parent_id" class="parent_id" id="${list.PARENT_ID}" value="${list.PARENT_ID}">
				</c:if>
			</div>
		</c:forEach>
	</div>
	<script>
		$(function() {
			$(".board_view #likeButton").css("width",$(window).width()/2-0.6);
			$(".board_view #commentButton").css("width",$(window).width()/2-0.6);
			$(".is_replyEq1").css("width",$(window).width()-50);
			$(".is_replyEq0 .commentNotPic").css("width",$(window).width()-60);
			$(".is_replyEq1 .commentNotPic").css("width",$(window).width()-110);
		});
	    // input이랑 textarea를 제외한 곳에서는 backspace가 안먹히게 하고
	    // 이전페이지로 돌아갈때 돌아갈 곳 제어
	    document.body.onkeydown = function(e) {
	        var elm = e.target.nodeName.toLowerCase();
	        if ( (e.which === 8 || e.which === 27) && (elm !== 'input' && elm  !== 'textarea')) {
	            e.preventDefault();
		    	backProcess();
	        }
	        e.stopPropagation();
	    };
	    $(".top_button#back").click(function() {
	    	backProcess();
	    });
		$(window).resize(function() {
			adjustResize();
		});
		function adjustResize() {
			$(".board_view #likeButton").css("width",$(window).width()/2-0.6);
			$(".board_view #commentButton").css("width",$(window).width()/2-0.6);
			$(".is_replyEq1").css("width",$(window).width()-50);
			$(".is_replyEq0 .commentNotPic").css("width",$(window).width()-60);
			$(".is_replyEq1 .commentNotPic").css("width",$(window).width()-110);
		}
	    $(".board_view .replyButton").click(function() {
	    	appendReplyButton($(this));
	    });
	    $(".board_view .modifyButton").click(function() {
	    	appendModifyButton($(this));
	    });
	    $(".board_view .deleteButton").click(function() {
	    	appendDeleteButton($(this));
	    });
	    function appendReplyButton(anchor){
	    	var target = anchor.parent().parent().parent();
	    	var comment_id = target.children("input").val();
	    	// 이미 열려있을 때
	    	if($(".replyContainer").length && comment_id == $(".replyContainer").attr('id')) {
				$(".replyContainer").remove();
		    	target.find(".replyButton").html("댓글달기");
	    	}
	    	else {
		    	$(".replyButton").html("댓글달기");
		    	$(".replyContainer").remove();
		    	target.find(".replyButton").html("접기");
		    	var format = "<div class='replyContainer' id='"+comment_id+"'>"
		    					+"<textarea class='reply_input_textarea' name='comment_input' placeholder='대댓글을 달아주세요^^' rows='1'></textarea>"
			    				+"<img class='reply_input_button' src='<c:url value='/resources/images/icon_올리기.png'/>'>"
		    				+"</div>";
		    	target.after(format);
		    	attach_event_textarea();
		    	attach_event_replySubmit();
	    	}
	    }
	    function appendModifyButton(anchor){
	    	var target = anchor.parent().parent().parent();
	    	var comment_id = target.children(".comment_id").val();
	    	// 이미 열려있을 때
	    	console.log(anchor);
	    	if($(".modifyContainer").length == 1 && comment_id == $(".modifyContainer").attr('id')) {
	    		console.log("?");
		    	$(".modifyButton").html("수정");
		    	$(".modifyContainer").before("<span class='commentContentText autoNewLine' id='commentContentText'>"+$(".board_view").find(".temporary").val()+"</span>");
		    	$(".board_view").find(".temporary").remove();
				$(".modifyContainer").remove();
	    	}
	    	else {
		    	console.log("@");
		    	$(".modifyButton").html("수정");
		    	$(".modifyContainer").before("<span class='commentContentText autoNewLine' id='commentContentText'>"+$(".board_view").find(".temporary").val()+"</span>");
		    	$(".board_view").find(".temporary").remove();
		    	$(".modifyContainer").remove();
		    	
		    	target.find(".modifyButton").html("접기");
		    	var format = "<div class='modifyContainer' id='"+comment_id+"'>"
		    					+"<textarea class='modify_input_textarea' name='comment_input' placeholder='댓글을 작성해주세요^^' rows='1'></textarea>"
			    				+"<img class='modify_input_button' src='<c:url value='/resources/images/icon_올리기.png'/>'>"
		    				+"</div>";
		    	target.find(".commentContentText").after(format);
		    	target.find(".modify_input_textarea").val(refineContentRev(target.find(".commentContentText").html()));
		    	$(".board_view").append("<textarea style='display:none;' class='temporary' value=''>");
		    	$(".temporary").val(target.find(".commentContentText").html());
		    	target.find(".commentContentText").remove();
		    	//attach_event_textarea();
		    	//attach_event_replySubmit();
		    	$(".modify_input_button").off("click");
		    	$(".modify_input_button").on("click", function() {
		    		appendModifySubmitButton($(this));
		    	});
		    }
	    }
	    function appendModifySubmitButton(anchor){
	    	var target = anchor.parent().parent().parent().parent();
	    	var comment_id = anchor.parent().attr("id");
	    	var content = anchor.parent().find(".modify_input_textarea").val();

			<c:choose>
				<c:when test="${IS_FED eq 0}">
		    		ajax_modify_comment(comment_id, content, function(json) {
				</c:when>
				<c:when test="${IS_FED eq 1}">
		    		ajax_modify_fed_comment(comment_id, content, function(json) {
				</c:when>
			</c:choose>
				var jsonObj = JSON.parse(JSON.stringify(json));
				if(jsonObj.result == 1){
			    	$(".modifyButton").html("수정");
			    	$(".modifyContainer").before("<span class='commentContentText autoNewLine' id='commentContentText'>"+content+"</span>");
			    	$(".board_view").find(".temporary").remove();
			    	$(".modifyContainer").remove();
					alert("댓글을 수정했습니다.");
				}
	    	});
	    }
	    function appendDeleteButton(anchor){
	    	var target = anchor.parent().parent().parent();
	    	var comment_id = target.children(".comment_id").val();
	    	var check = confirm("정말 삭제하시겠습니까?");
	    	if(check == true){
				<c:choose>
					<c:when test="${IS_FED eq 0}">
			    		ajax_delete_comment(comment_id, function(json) {
					</c:when>
					<c:when test="${IS_FED eq 1}">
			    		ajax_delete_fed_comment(comment_id, function(json) {
					</c:when>
				</c:choose>
					var jsonObj = JSON.parse(JSON.stringify(json));
					if(jsonObj.result == 1){
						target.remove();
						alert("댓글을 삭제했습니다.");
					}
		    	});
	    	}
	    }
		function attach_event_replySubmit(){
			$('.board_view .reply_input_button').on('click', function(){
				var board_id = $(".board_view #board_id").val();
				var content = $(this).siblings("textarea").val();
				content = refineContent(content);
				var parent_id = $(this).parent().attr("id");
				ajax_insert_comment(board_id, content, 1, parent_id, function callback(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					$(".board_view .comment_list_footer").empty();
					appendComment(jsonObj);
				});
				$("body").animate({scrollTop:$(this).offset().top-$(window).height()/2},400);
			});
		}
		function backProcess(){
			//location.href = "./club_detail.do?club_code=<%=club_code%>&mode=<%=mode%>&keyword=<%=keyword%>&scrollTop=<%=scrollTop%>";
			history.back();
		}
	</script>
	<div class="line"></div>
	<div class="comment_input_footer">
		<textarea class="comment_input_textarea" name="comment_input" placeholder="댓글을 달아주세요^^" rows="1"></textarea>
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<img class="comment_input_button" src="<c:url value="/resources/images/icon_올리기.png"/>">
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<img class="comment_input_button" src="<c:url value="/resources/images/bt_올리기_연합회.png"/>">
			</c:when>
		</c:choose>
		<script>
			$(".comment_input_button").click(function(){
				
				if($(".comment_input_textarea").val() == ""){
		    		window.alert("댓글 내용을 입력하세요.");
		    	}else{
					var content = $(".comment_input_textarea").val();
					content = refineContent(content);
					<c:choose>
						<c:when test="${IS_FED eq 0}">
							ajax_insert_comment($(".board_view #board_id").val(), content, 0, -1, function callback(json) {
						</c:when>
						<c:when test="${IS_FED eq 1}">
							ajax_insert_fed_comment($(".board_view #board_id").val(), content, 0, -1, function callback(json) {
						</c:when>
					</c:choose>
						var jsonObj = JSON.parse(JSON.stringify(json));
						$(".board_view .comment_list_footer").empty();
						appendComment(jsonObj);
					});
					$(".comment_input_textarea").val("");
					$(".comment_input_textarea").css('height', 'auto' );
					$(".comment_input_textarea").height( this.scrollHeight );
					$("body").animate({scrollTop:$("body").prop("scrollHeight")},400);
				}
			});
			$(".comment_input_textarea").focus(function() {
		    	$(".replyContainer").remove();
		    	$(".replyButton").html("댓글달기");
			});
			function appendComment(array){
				var format = "";
				for(var i = 0, item; item=array[i]; i++) {
					item = JSON.parse(JSON.stringify(item));
					format="<div class='comment_wrapper is_replyEq"+item.is_REPLY+"'>"
								+"<div class='commentProPic'>"
									+"<img class='commentWriterProPic' onclick='go_user_info("+item.write_USER+")' src='<c:url value='/resources/upload/user/profile/"+item.profile+"' />' onError=\"this.src='<c:url value='/resources/images/icon_프로필사진(공백).png' />'\">"
								+"</div>"
								+"<div class='commentNotPic rightside_pic'>"
									+"<div class='commentWriterNameContainer'>"
										+"<span class='commentWriterName'>"+item.user_NAME+"</span>";
					if(item.is_WRITER == 1){
						format = format +"<span class='commentFunction modifyButton'>수정</span>"
										+"<span class='commentFunction deleteButton'>삭제</span>";
					}
					/*if(item.is_REPLY == 0) {
						format = format + "<span class='replyButton'>댓글달기</span>";
					}*/
					format = format + "<span class='commentWriteDatetime'>"+item.formated_WRITE_DATE+" "+item.formated_WRITE_TIME+"</span>"
									+"</div>"
									+"<div class='commentContentTextContainer'>"
										+"<span class='commentContentText autoNewLine' id='commentContentText'>"+item.content+"</span>"
									+"</div>"
								+"</div>"
								+"<input type='hidden' name='write_user' id='write_user' value='"+item.write_ID+"'>"
								+"<input type='hidden' name='comment_id' id='comment_id' value='"+item.comment_ID+"'>"
								+"<input type='hidden' name='parent_id' id='parent_id' value='"+item.parent_ID+"'>"
							+"</div>";
					$(".comment_list_footer").append(format);
				}
				adjustResize();
				$(".board_view .modifyButton").off("click");
				$(".board_view .modifyButton").click(function(){
					appendModifyButton($(this));
					console.log($(this));
				});
				$(".board_view .deleteButton").off("click");
			    $(".board_view .deleteButton").click(function(){
			    	appendDeleteButton($(this));
			    });
				// 대댓글 달기 버튼 다시 활성화
				/*$('.board_view .replyButton').on('click', function(){
			    	appendReplyButton($(this));
				});*/
			}
			
			function go_user_info(user_id){
				location.href='../myprofile/user_info.do?user_id='+user_id;
			}
		</script>
	</div>
	<div class="line"></div>
	<script>
		$(function(){
			attach_event_textarea();
			$(".is_replyEq1 .replyButton").remove();
		});
		function attach_event_textarea() {
			$('.board_view textarea').on( 'keyup', function(e){
				$(this).css('height', 'auto' );
				$(this).height( this.scrollHeight );
				$("body").animate({scrollTop:$(this).offset().top+$(this).height()-$(window).height()/2},0);
			});
			$('.board_view textarea').find( 'textarea' ).keyup();
		}
		function delete_replyButton_forReply() {
			$(".is_replyEq1 .reply_button").remove();
		}
	</script>
	<input type="hidden" name="user_id" class="user_id" id="<%=user_id%>" value="<%=user_id%>">
</div>

<%@ include file="../common/backeventjs.jsp" %>

</body>
</html>