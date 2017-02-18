<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<body>
<link href="<c:url value='/resources/css/club_detail_admin_inquiry.css?ver=2'/>" rel="stylesheet">
<div id="spaceBlank"></div>
<div id="club_inquiry">
	<div class="header">
		<div class="title">
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					<span id="page_name" style="color: #008ae8">답변하기</span>
				</c:when>
				<c:when test="${IS_FED eq 1}">
					<span id="page_name" class="fed" style="color: #4f2ca5">답변하기</span>
				</c:when>
			</c:choose>
		</div>
		<div class="left_btn" style="color: #4f2ca5">
			<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />">
		</div>
		<div class="right_btn">
			<span class="top_button_span" id="complete">보내기</span>
		</div>
		<script>
			$(".top_button#back").click(function() {
				//location.href="./club_admin_inquiry_view.do?club_code=${param.club_code}&inquiry_id=${param.inquiry_id}&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top=${param.scroll_top}";
				history.back();
			});
			$(".top_button_span#complete").click(function() {
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						ajax_insert_inquiry("0", "", "${param.club_code}", refineContent($("#titleTextarea").val()), refineContent($("#mainTextarea").val()), null, "1", "${param.inquiry_id}", function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1) {
								location.href = "./club_admin_inquiry.do?club_code=${param.club_code}&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top=${param.scroll_top}";
							}
						});
					</c:when>
					<c:when test="${IS_FED eq 1}">
						ajax_insert_fed_inquiry("0", 0, "${param.FED_CODE}", refineContent($("#titleTextarea").val()), refineContent($("#mainTextarea").val()), 0, "1", "${param.INQUIRY_ID}", function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1) {
								location.href = "./fed_admin_inquiry.do?FED_CODE=${param.FED_CODE}&INQUIRY_ID=-1&INQUIRY_TYPE=-1";
							}
						});
					</c:when>
				</c:choose>
			});
		</script>
	</div>
	<div class="line"></div>
	<div class="header_content">
	<form name="insertFrm2">
		<textarea id="titleTextarea" name="titleTextarea" placeholder="제목을 입력하세요." rows="1" onchange="len_chk2()" onKeyup="len_chk2()"></textarea>
		<input type="hidden" id="titleTextarea-mirror-value" name="titleTextarea-mirror-value" value="">
	</form>
	</div>
	<div class="line"></div>
	<div class="main_content">
		<form name="insertFrm">
			<textarea id="mainTextarea" name="mainTextarea" placeholder="내용을 입력하세요" rows="1" onchange="len_chk()" onKeyup="len_chk()"></textarea>
			<input type="hidden" id="mainTextarea-mirror-value" name="mainTextarea-mirror-value" value="">
		</form>
	</div>
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
	function len_chk2(){  
		var frm = document.insertFrm2.titleTextarea; 
		var length = parseInt($("#titleTextarea").val().length);
		if(length > 22){  
			alert("22자 이내로 작성해주세요.");  
			frm.value = frm.value.substring(0,22);  
			frm.focus();  
		}
	}
	$(function() {
		$("#titleTextarea").trackRows();
		$("#mainTextarea").trackRows();
	});
	$('textarea').on( 'keyup', function(e){
		$(this).css('height', 'auto' );
		$(this).height( this.scrollHeight );
		$("body").animate({scrollTop:$(this).offset().top+parseInt($(this).siblings("input").val())-$(window).height()/2},0);
	});
	$('textarea').change(function() {
		$(this).css('height', 'auto' );
		$(this).height( this.scrollHeight );
		$("body").animate({scrollTop:$(this).offset().top+parseInt($(this).siblings("input").val())-$(window).height()/2},0);
	});
	$("#spaceBlank").click(function() {
		$("#mainTextarea").focus();
	});
	</script>
</div>