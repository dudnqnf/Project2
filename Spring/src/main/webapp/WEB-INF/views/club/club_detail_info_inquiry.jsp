<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_info_inquiry.css?ver=1'/>" rel="stylesheet">

<body>
<div id="spaceBlank"></div>
<div id="club_inquiry">
<div class="header">
	<div class="left_btn">
		<span class="top_button_span" id="back">취소</span>
	</div>
	<div class="title">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<span id="page_name">
					<c:if test="${is_modify eq 0}">문의하기</c:if>
					<c:if test="${is_modify eq 1}">문의수정하기</c:if>
				</span>
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<span id="page_name" class="fed">
					<c:if test="${is_modify eq 0}">문의하기</c:if>
					<c:if test="${is_modify eq 1}">문의수정하기</c:if>
				</span>
			</c:when>
		</c:choose>
	</div>
	<div class="right_btn">
		<span class="top_button_span" id="complete">보내기</span>
	</div>

		<script>
			$(".top_button_span#back").click(function() {
				//location.href="./club_detail.do?club_code=${ClubCode}&mode=${mode}"
				history.back();
			});
			$(".top_button_span#complete").click(function() {
				var type = 0;
				if($(".inquiry_type_selected").attr("id") == "join"){
					type = 0;
				}
				else if($(".inquiry_type_selected").attr("id") == "match"){
					type = 1;
				}
				else if($(".inquiry_type_selected").attr("id") == "etc"){
					type = 2;
				}
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						ajax_insert_inquiry("0", "", "${ClubCode}", refineContent($("#titleTextarea").val()), refineContent($("#mainTextarea").val()), type, "0", null, function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1) {
								history.back();
								//location.href = "./club_detail.do?club_code=${ClubCode}&mode=${mode}";
							}
						});
					</c:when>
					<c:when test="${IS_FED eq 1}">
						ajax_insert_fed_inquiry("0", 0, "${param.FED_CODE}", refineContent($("#titleTextarea").val()), refineContent($("#mainTextarea").val()), type, 0, 0, function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1) {
								history.back();
								//location.href = "./fed_detail.do?FED_CODE=${param.FED_CODE}";
							}
						});
					</c:when>
				</c:choose>
			});
		</script>
	</div>
	
	
	
	<div class="header_content">
		<div class="docTitle">
			<input type="text" id="titleTextarea" name="titleTextarea" placeholder="제목을 입력하세요." maxlength="500">
			<input type="hidden" id="titleTextarea-mirror-value" name="titleTextarea-mirror-value" value="">
		</div>
		<div class="inquiry_type_container">
			<div class="inquiry_type_selected join" id="join">가입문의 ▼</div>
			<div class="inquiry_type_dropdown_list">
				<div class="inquiry_type_dropdown_unit join" id="join">가입문의</div>
				<div class="line"></div>
				<div class="inquiry_type_dropdown_unit match" id="match">매칭문의</div>
				<div class="line"></div>
				<div class="inquiry_type_dropdown_unit etc" id="etc">기타문의</div>
			</div>
		</div>
		<script>
			$(".inquiry_type_container").click(function() {
				if($(".inquiry_type_dropdown_list").css("display") == "none"){
					$(".inquiry_type_dropdown_list").css("display","block");
				}
				else{
					$(".inquiry_type_dropdown_list").css("display","none");
				}
			});
			$(".inquiry_type_dropdown_unit").click(function() {
				$(".inquiry_type_selected").attr("class","inquiry_type_selected");
				$(".inquiry_type_selected").toggleClass($(this).attr("id"));
				$(".inquiry_type_selected").attr("id", $(this).attr("id"));
				$(".inquiry_type_selected").html($(this).html()+" ▼");
			});
		</script>
	</div>
	<div class="line"></div>
	<div class="main_content">
		<form name="insertFrm">
			<textarea id="mainTextarea" name="mainTextarea" placeholder="내용을 입력하세요" rows="1" onkeyup="len_chk()" onchange="len_chk()"></textarea>
			<input type="hidden" id="mainTextarea-mirror-value" name="mainTextarea-mirror-value" value="">
		</form>
	</div>
	<script>
		//글자수 제한 체크 
		function len_chk(){  
			var frm = document.insertFrm.mainTextarea; 
			var length = parseInt($("#mainTextarea").val().length);
			console.log(length);
			if(length > 500){
				alert("500자 이내로 작성해주세요.");  
				frm.value = frm.value.substring(0,500);  
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
<%@ include file="../common/backeventjs.jsp" %>