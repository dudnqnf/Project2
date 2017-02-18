<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_board_write.css'/>" rel="stylesheet">

<body>
<%@ include file="../common/backeventjs.jsp" %>
<%
	String is_modify = request.getParameter("is_modify");
	if(is_modify == null)
		is_modify = "";
	String club_code = request.getParameter("club_code");
	if(club_code == null)
		club_code = "";
	String board_id = request.getParameter("board_id");
	if(board_id == null)
		board_id = "";
	String isNotice = request.getParameter("isNotice");
	String isOpened = request.getParameter("isOpened");
	String mode = request.getParameter("mode");
	if(mode == null)
		mode = "";
	String scrollTop = request.getParameter("scrollTop");
	if(scrollTop == null)
		scrollTop = "";
	String keyword = request.getParameter("keyword");
	if(keyword == null)
		keyword = "";
%>
<div id="spaceBlank"></div>
<div class="board_write">

<div class="header" style="border:0px;">
	<div class="left_btn">
		<span class="top_button_span" id="back">취소</span>
	</div>
	<c:choose>
		<c:when test="${IS_FED eq 0}">
			<div class="title"><span id="page_name">
				<c:choose>
					<c:when test="${param.is_modify ne 1}">글쓰기</c:when>
					<c:when test="${param.is_modify eq 1}">수정하기</c:when>
				</c:choose>
			</span></div>
		</c:when>
		<c:when test="${IS_FED eq 1}">
			<div class="title"><span id="page_name" class="fed">
				<c:choose>
					<c:when test="${param.IS_MODIFY ne 1}">글쓰기</c:when>
					<c:when test="${param.IS_MODIFY eq 1}">수정하기</c:when>
				</c:choose>
			</span></div>
		</c:when>
	</c:choose>
	<div class="right_btn">
		<span class="top_button_span" id="complete">완료</span>
	</div>
</div>
	<div class="line"></div>
	<div class="header_content">
		<div class="docTitle">
		<form name="insertFrm2">
			<textarea id="titleTextarea" name="titleTextarea" rows="1" placeholder="제목을 입력하세요." style="width: 100%;" onchange="len_chk2()" onKeyup="len_chk2()"></textarea>
			<input type="hidden" id="titleTextarea-mirror-value" name="titleTextarea-mirror-value" value="">
		</form>
		</div>
		<script>
			$("#titleTextarea").keydown(function(event){
				// 엔터키 방지
				if(event.keyCode == 13) {
					event.preventDefault();
					return false;
				}
			});
			function len_chk2(){  
				var frm = document.insertFrm2.titleTextarea; 
				var length = parseInt($("#titleTextarea").val().length);
				if(length > 22){  
					alert("22자 이내로 작성해주세요.");  
					frm.value = frm.value.substring(0,22);  
					frm.focus();  
				}
			}
		</script>
		<div class="docOptions" align="right">
			<div class="optUnitWrapper" id="optOpenedWrapper">
				<img class="optNotice" id="whenNotice" src="<c:url value='/resources/images/icon_공지on.png' />">
				<img class="optNotice" id="whenNormal" src="<c:url value='/resources/images/icon_공지off.png' />">
				<input type="hidden" id="isNotice" name="isNotice" value="">
			</div>
		</div>
	</div>
	<div class="line"></div>
	<div class="main_content">
		<form name="insertFrm">
			<textarea id="mainTextarea" name="mainTextarea" onKeyup="len_chk()" onchange="len_chk()" placeholder="내용을 입력하세요" style="min-height: 300px;"></textarea>
			<input type="hidden" id="mainTextarea-mirror-value" name="mainTextarea-mirror-value" value="">
		</form>
		<script> 
			//글자수 제한 체크 
			function len_chk(){  
				var frm = document.insertFrm.mainTextarea; 
				var length = parseInt($("#mainTextarea").val().length);
				if(length > 500){  
					alert("500자 이내로 작성해주세요.");  
					frm.value = frm.value.substring(0,500);  
					frm.focus();  
				}
			}
		</script>
	</div>
	<script>
		$(function(){
			$("#titleTextarea").val(refineContentRev("${original.TITLE}"));
			$("#titleTextarea").change();
			$("#mainTextarea").val(refineContentRev("${original.CONTENT}"));
			$("#mainTextarea").change();
			
			$("#titleTextarea").trackRows();
			$("#mainTextarea").trackRows();
			
			$('textarea').on( 'keyup', function(e){
				$(this).css('height', 'auto' );
				$(this).height( this.scrollHeight );
				$("body").animate({scrollTop:$(this).offset().top+parseInt($(this).siblings("input").val())-$(window).height()/2},0);
			});
			$('textarea').find( 'textarea' ).keyup();
			if("${is_modify}" == "1"){
				if("${original.NOTICE_TYPE}" == '1'){
					$(".optNotice#whenNormal").css("display","none");
					$("#isNotice").val("1");
				}
				else{
					$(".optNotice#whenNotice").css("display","none");
					$("#isNotice").val("0");
				}
				if("${original.IS_OPEN}" == '1'){
					$("#isOpened").val("1");
				}
				else{
					$("#isOpened").val("0");
				}
			}
			else{
				if('${param.isNotice}' == '1'){
					$(".optNotice#whenNormal").css("display","none");
					$("#isNotice").val("1");
				}
				else{
					$(".optNotice#whenNotice").css("display","none");
					$("#isNotice").val("0");
				}
				if('${param.isOpened}' == '1'){
					$("#isOpened").val("1");
				}
				else{
					$("#isOpened").val("0");
				}
			}
		});
		
		$("#mainTextarea").change(function() {
			$(this).css('height', 'auto' );
			$(this).height( this.scrollHeight );
			$("body").animate({scrollTop:$(this).offset().top+parseInt($(this).siblings("input").val())-$(window).height()/2},0);
		});
		
		$(".optNotice").click(function() {
			if($("#isNotice").val() == "1"){
				$(".optNotice#whenNotice").css("display","none");
				$(".optNotice#whenNormal").css("display","block");
				$("#isNotice").val("0");
			}
			else{
				$(".optNotice#whenNotice").css("display","block");
				$(".optNotice#whenNormal").css("display","none");
				$("#isNotice").val("1");
			}
		});
		
		$(".optOpened").click(function() {
			if($("#isOpened").val() == "1"){
				$(".optOpened#whenOpened").css("display","none");
				$(".optOpened#whenClosed").css("display","block");
				$("#isOpened").val("0");
			}
			else{
				$(".optOpened#whenOpened").css("display","block");
				$(".optOpened#whenClosed").css("display","none");
				$("#isOpened").val("1");
			}
		});
		
		$("#spaceBlank").click(function() {
			$("#mainTextarea").focus();
		});
		
	    // input이랑 textarea를 제외한 곳에서는 backspace가 안먹히게 하고
	    // 이전페이지로 돌아갈때 돌아갈 곳 제어
	    document.body.onkeydown = function(e) {
	        var elm = e.target.nodeName.toLowerCase();
	        if ( (e.which === 8 || e.which === 27) && (elm !== 'input' && elm  !== 'textarea')) {
	            e.preventDefault();
				//location.href = "./club_detail.do?club_code=${param.club_code}&mode=${param.mode}&keyword=${param.keyword}&scrollTop=${param.scrollTop}";
				history.back();
	        }
	        e.stopPropagation();
	    };
	    
	    $(".top_button_span#complete").click(function() { 
	    	if($("#titleTextarea").val() == ""){
	    		alert("제목을 입력하세요.");
	    		$("#titleTextarea").val().focus();
	    		return;
	    	}
	    	var title = refineContent($("#titleTextarea").val());
	    	var content = refineContent($("#mainTextarea").val());
	    	var notice_type = $("#isNotice").val();
	    	var result;
	    	<c:choose>
		   		<c:when test="${IS_FED eq 0}">
		    		var club_code = "${param.club_code}";
			    	var is_open = "${param.isOpened}";
			    	var is_modify = "${is_modify}";
			    	var board_id = "${param.board_id}";
			    	if(is_open == ""){
						is_open = "${original.IS_OPEN}";
			    	}
			    	if(is_modify == ""){
			    		is_modify = 0;
			    	}
			    	if(board_id == ""){
			    		board_id = 0;
			    	}
		    		ajax_insert_board(is_modify, board_id, club_code, title, content, is_open, notice_type, function(json) {
		   		</c:when>
		   		<c:when test="${IS_FED eq 1}">
		    		var fed_code = "${param.FED_CODE}";
			    	var is_open = "${param.IS_OPEN}";
			    	var is_modify = "${param.IS_MODIFY}";
			    	var board_id = "${param.BOARD_ID}";
			    	if(is_open == ""){
						is_open = "${original.IS_OPEN}";
			    	}
			    	if(is_modify == ""){
			    		is_modify = 0;
			    	}
			    	if(board_id == ""){
			    		board_id = 0;
			    	}
			    	ajax_insert_fed_board(is_modify, board_id, fed_code, title, content, is_open, notice_type, function(json) {
		   		</c:when>
	    	</c:choose>
				var jsonObj = JSON.parse(JSON.stringify(json));
				result = jsonObj.result;
				if(result == 1){
					if(is_modify == 0){
						alert("게시글이 작성되었습니다.");
					}
					else if(is_modify == 1){
						alert("게시글이 수정되었습니다.");
					}
			    	<c:choose>
				   		<c:when test="${IS_FED eq 0}">
							//location.href = "./club_detail.do?club_code="+club_code+"&mode=${param.mode}&keyword=${param.keyword}&scrollTop=${param.scrollTop}";
						</c:when>
				   		<c:when test="${IS_FED eq 1}">
							//location.href = "./fed_detail.do?FED_CODE="+fed_code;
						</c:when>
					</c:choose>
					history.back();
				}
	    	});
	    });
	    
	    $(".top_button_span#back").click(function() {
			//location.href = "./club_detail.do?club_code=${param.club_code}&mode=${param.mode}&keyword=${param.keyword}&scrollTop=${param.scrollTop}";
			history.back();
	    });
	</script>
</div>
</body>
</html>