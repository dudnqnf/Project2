<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_modify.css?ver=2'/>" rel="stylesheet">
<link href="<c:url value='/resources/css/datepicker.min.css'/>" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/resources/js/datepicker.min.js'/>"></script>

<body>
<%@ include file="../common/backeventjs.jsp" %>
<div class="white_screen">
	<div id="club_detail_modify">
	<div id="blurAll"></div>
	<%@ include file="./dialog/dialog_club_picture.jsp" %>
		<div class="top">
			<div class="header">
				<div class="left_btn"><img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />"></div>
				<div class="title">
					<span id="page_name">수정하기</span>
				</div>
				<script>
					$(".header #back").click(function() {
						history.back();
					});
				</script>
			</div>
			<div class="preview">
				<img src="<c:url value="/resources/upload/club/main/${ClubInfo.MAIN_PIC}" />" onerror="this.src='<c:url value="/resources/images/club/${ClubInfo.SPORTS_NAME}2.jpg" />';" />
				<div class="blind"></div>
			</div>
			<div class="club_name_wrapper">
				<span id="span_club_name">${ClubInfo.CLUB_NAME}</span>
				<img class="btn_size btn_change_club_name" src="<c:url value="/resources/images/ic_동호회이름수정.png"/>" />
			</div>
			<div class="div_club_type">
				<p>${ClubInfo.CLUB_TYPE_NAME}</p>
			</div>
			<img class="btn_size img_change_background" src="<c:url value="/resources/images/icon_photo.png"/>" onclick="dialog_club_picture()" />
		</div>
		
		<script>
			var image = new Image();
			
			function dialog_club_picture(){
				open_club_picture_dialog();
			}
			
			function photo_change(){
				$("#blurAll").css("display","none");
				$("#club_picture_dialog").css("display","none");
		    	window.Android.selectOneImage();
		    }
			
			function default_change(){
				$("#blurAll").css("display","none");
				$("#club_picture_dialog").css("display","none");
				var club_code = ${param.club_code};
				ajax_default_main_picture(club_code, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					if(result == 1){
						alert("수정완료");
						$(".preview img").attr("src", '<c:url value="/resources/images/club/${ClubInfo.SPORTS_NAME}2.jpg" />')
					}
				});
			}
		    
		    function selectedImage(mimeType, encodedImage){
		    	var image = new Image();
		    	image.src = 'data:'+mimeType+";base64,"+encodedImage;
				$(".preview").html(image);
				$(".preview img").addClass("preview");
				
				var formData = new FormData();
				formData.append("MAIN_PIC", image.src);
				formData.append("CLUB_CODE", "${param.club_code}");
		        
				$.ajax({
					url: './club_main_pic_upload.do',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					success: function(result){
						window.alert("수정완료");
					}
				});
			}
		</script>
		
		
		<!-- Edit popup container -->
		<div class="text-editor">
			<div class="tedit_header">
				<div class="tedit_title" id="tedit_title_wrapper"><span id="page_name"></span></div>
				<div class="tedit_left_btn" id="tedit_back_wrapper"><span id="tedit_back_span">돌아가기</span></div>
				<div class="tedit_right_btn" id="tedit_submit_wrapper"><span id="tedit_complete_span">완료</span></div>
			</div>
			<div class="tedit_main">
				<div class="tedit_input_wrapper" id="tedit_text_input_wrapper">
					<textarea class="input_value" id="tedit_input_textarea" placeholder="내용을 입력해주세요."></textarea>
				</div>
				<script>
					$("textarea.input_value").keydown(function(event){
						// CLUB_NAME 수정 시에 엔터키 방지
						if(event.keyCode == 13 && ($("#dbMapColumn").val() == "CLUB_NAME" || $("#dbMapColumn").val() == "MEMBER_NUM")) {
							event.preventDefault();
							return false;
						}
					});
				</script>
				<div class="tedit_input_wrapper" id="tedit_number_input_wrapper">
					<input type="number" class="input_value" id="tedit_input_number">
				</div>
				<div class="tedit_input_wrapper" id="tedit_date_input_wrapper">
					<input type="text" class="input_value" id="tedit_input_date" data-toggle="datepicker">
				</div>
				
				<script>
					$('[data-toggle="datepicker"]').datepicker({
						format:'yyyy-mm-dd',
						startDate:'today'
					});
				</script>
				
				<div class="tedit_input_wrapper" id="tedit_select1_input_wrapper">
					<%
						// 실력레벨(1~10까지) 수정하기 별출력
						for (int j = 1; j <= 10; j++) {
							// 시작하는 디브 출력
							out.println("<div class='tedit_input_select_button tedit_input_select1_button' id='"+j+"' style='display:block'>");
							// 실력이 짝수일때 꽉찬별 (실력/2)개 출력 & 라디오버튼이미지 출력
							if((j % 2) == 0) {
								for (int k = 0; k < j/2; k++){
									out.println("<img class='img_levelStar' src='../resources/images/icon_star.png'>");
								}
								out.println("<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>");
								out.println("<img class='btnImage_on' src='../resources/images/radio_checked.png'>");
								//out.println("<input type='hidden' value='"+j+"' class='level'>");
							// 실력이 홀수일때 꽉찬별 (실력/2)개 출력 후 반쪽별 한개 출력 & 라디오버튼이미지 출력
							} else {
								for (int k = 0; k < j/2; k++){
									out.println("<img class='img_levelStar' src='../resources/images/icon_star.png'>");
								}
								out.println("<img class='img_levelStar' src='../resources/images/icon_half_star.png'>");
								out.println("<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>");
								out.println("<img class='btnImage_on' src='../resources/images/radio_checked.png'>");
								//out.println("<input type='hidden' value='"+j+"' class='level'>");
							}
							// 끝나는 디브 출력
							out.println("</div>");
						}
					%>
					
					<!-- 
					<c:forEach var="i" begin="0" end="10" step="1">
						<div class="tedit_input_select_button tedit_input_select1_button" id="${i}">${i}</div>
						<div class="line"></div>
					</c:forEach>
					 -->
					 
					<input type="hidden" class="input_value">
					<script>
						
					
						$(".tedit_input_select1_button").click(function() {
							$(".tedit_input_select1_button").removeClass("selected");
							$(this).toggleClass("selected");
							$("#tedit_select1_input_wrapper .input_value").val($(this).attr("id"));
							$(".tedit_input_select1_button .btnImage_on").css("display","none");
							$(".tedit_input_select1_button .btnImage_off").css("display","inline-block");
							$(".tedit_input_select1_button.selected .btnImage_off").css("display","none");
							$(".tedit_input_select1_button.selected .btnImage_on").css("display","inline-block");
							//$("#tedit_select1_input_wrapper .input_value").val($(this).find("input").val());
						});
						
						
						
					</script>
				</div>
				<div class="tedit_input_wrapper" id="tedit_select2_input_wrapper">
					<c:forEach items="#{club_target}" var="list">
						<div class="tedit_input_select_button tedit_input_select2_button" id="${list.CLUB_TARGET_CODE}">${list.CLUB_TARGET_NAME}
							<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>
							<img class='btnImage_on' src='../resources/images/radio_checked.png'>
						</div>
						<div class="line"></div>
					</c:forEach>
					<input type="hidden" class="input_value">
					<script>
						$(".tedit_input_select2_button").click(function() {
							$(".tedit_input_select2_button").removeClass("selected");
							$(this).toggleClass("selected");
							$("#tedit_select2_input_wrapper .input_value").val($(this).attr("id"));
							$(".tedit_input_select2_button .btnImage_on").css("display","none");
							$(".tedit_input_select2_button .btnImage_off").css("display","inline-block");
							$(".tedit_input_select2_button.selected .btnImage_off").css("display","none");
							$(".tedit_input_select2_button.selected .btnImage_on").css("display","inline-block");
						});
					</script>
				</div>
			</div>
			<input type="hidden" id="dbMapColumn">
			<input type="hidden" id="dbMapType">
		</div>
		<script>
			$(".text-editor #tedit_back_wrapper").click(function() {
				$(".text-editor").css("display","none");
				$("body").css("overflow","");
				$(".tedit_input_wrapper").css("display","none");
			});
			$(".text-editor #tedit_submit_wrapper").click(function() {
				var dbMapColumn = $(".text-editor #dbMapColumn").val();
				var dbMapType = $(".text-editor #dbMapType").val();
				var value = refineContent($(".text-editor #tedit_"+dbMapType+"_input_wrapper .input_value").val());
				if(tedit_validate(dbMapColumn, value)){
					return;
				}
				ajax_edit_club_info(dbMapColumn, dbMapType, value, "${param.club_code}", function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					if(result == 1){
						alert("변경되었습니다.");
						location.reload();
					}
					else{
						$(".text-editor").css("display","none");
						$("body").css("overflow","");
						$(".tedit_input_wrapper").css("display","none");
						alert("오류!");
					}
				});
			});
		    function tedit_validate(target, value){
		    	console.log(target+value);
		    	if(target == "CLUB_NAME"){
					var count = 0;
					ajax_club_name_overlap_check(value, function(json){
						var jsonObj = JSON.parse(JSON.stringify(json));
						count = jsonObj.count;
					});
					if(count > 0){
						alert("이미 존재하는 동호회 이름입니다.");
						return true;
					}
		    	}
		    	else if(target == "INTRODUCTION" && value == ""){
		    		alert("동호회 소개글은 적어도 한 글자 입력해야 합니다.");
		    		return true;
		    	}
		    	else if(target == "MEMBER_NUM"){
		    		value = value.toString();
		    		var n1 = Math.abs(value);
		    		var n2 = parseInt(value, 10);
		    		if(!isNaN(n1) && n2 === n1 && n1.toString() === value && value != "0"){
		    			return false;
		    		}
		    		else{
		    			alert("회원 수를 숫자로만 정확히 입력해주세요.");
			    		return true;
		    		}
		    	}
		    }
		</script>
		
		<div class="info_container_modify">
			<div class="div1 border_container">
				<div class="level">
					<img src="../resources/images/icon_실력.png">
					<p class="img_name">실력</p>
					<p class="value">
					<c:choose>
						<c:when test="${ClubInfo.SKILL_POINT eq null || ClubInfo.SKILL_POINT eq 0}">미지정</c:when>
						<c:when test="${ClubInfo.SKILL_POINT % 2 == 1}">
							<c:forEach var="i" begin="1" end="${ClubInfo.SKILL_POINT / 2}" step="1">
								<img class="img_levelStar" src="../resources/images/icon_star.png">
							</c:forEach>
							<img class="img_levelStar" src="../resources/images/icon_half_star.png">
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="1" end="${ClubInfo.SKILL_POINT / 2}" step="1">
								<img class="img_levelStar" src="../resources/images/icon_star.png">
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</p>
				</div>
				<div class="matchingdate">
					<img src="../resources/images/icon_매칭희망일.png">
					<p class="img_name">매칭 희망일</p>
					<p class="value"><c:choose><c:when test="${ClubInfo.MATCH_DATE eq null || ClubInfo.MATCH_DATE eq ''}">미정</c:when><c:otherwise>${ClubInfo.MATCH_DATE}</c:otherwise></c:choose></p>
				</div>
			</div>
			<div class="div2 space">
				<span class="div2_space_span">동호회에 대한 상세정보를 적어주세요</span>
			</div>
			<div class="div2 border_container exercise_place">
				<span class="div2_title">운동장소</span>
				<span class="div2_value">${ClubInfo.EXERCISE_PLACE}</span>
			</div>
			<div class="div2 border_container exercise_time">
				<span class="div2_title">운동시간</span>
				<span class="div2_value">${ClubInfo.EXERCISE_TIME}</span>
			</div>
			<div class="div2 border_container ages">
				<span class="div2_title">주요 연령대</span>
				<span class="div2_value">${ClubInfo.CLUB_TARGET_NAME}</span>
			</div>
			<div class="div2 border_container member_num">
				<span class="div2_title">회원수</span>
				<span class="div2_value">${ClubInfo.MEMBER_NUM}</span>
			</div>
			<div class="div3 space">동호회 소개 글을 수정하세요</div>
			<div class="div3 border_container" id="div3_content">${ClubInfo.INTRODUCTION}</div>
		</div>
	</div>
	<script>
		$(function() {
			$(".text-editor .tedit_input_wrapper").css("display","none");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("position","absolute");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("width","100%");
			$(".text-editor .tedit_input_wrapper > textarea").css("height","100%");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("padding-left","5%");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("top","50px");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("padding-right","5%");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("padding-top","5%");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").css("padding-bottom","5%");
			$(".text-editor .tedit_input_wrapper > textarea, .text-editor .tedit_input_wrapper > input").focus();
		});
		$(window).load(function() {
			$(".blind").css("top", $(".header").height());
			$(".blind").height($(".preview img").height());
		});
		$(window).resize(function() {
			resize_detail();
		});
		$(window).scroll(function() {
			resize_detail();
		});
		function resize_detail(){
// 			$(".white_screen").height($(document).height());
// 			$('.image-editor').cropit('previewSize', { width: $(window).width(), height: $(window).width()/1.618 });
// 			$(".top").height($(window).width()/1.618);
// 			$("#club_detail_modify .top .btn_size").css("width",$(window).width()*7/100);
// 			$("#club_detail_modify .top .btn_size").css("height",$(window).width()*7/100);
// 			$(".img_change_background").css("top",$(".img_club_background").height()-$(".img_change_background").height()+30);
// 			$(".top .club_name_wrapper").css("top",$(".top").height()*9/10-$(".top .club_name_wrapper").height()+50);
// 			$(".top .div_club_type p").css("top",$(".top").height()*9/10-$(".top .club_name_wrapper").height()-$(".top .div_club_type p").height()+40);
// 			$(".info_container_modify").css("top",$(".img_club_background").height()+50);
		}
		
		$(".img_club_background").click(function() {
			change_background();
		});
		$(".img_change_background").click(function() {
			change_background();
		});
		function change_background() {
			$(".input_background").click();
			$(".image-editor").css("display","block");
			switchedit();
		}
		
		$(".btn_change_club_name").click(function() {
			toggle_tedit("CLUB_NAME","text","동호회 이름 수정하기",refineContentRev($(this).siblings("span").html()));
		});
		$(".info_container_modify .level").click(function() {
			$(".tedit_input_select1_button").removeClass("selected");
			$(".tedit_input_select1_button#${ClubInfo.SKILL_POINT}").toggleClass("selected");
			toggle_tedit("SKILL_POINT","select1","실력 수정하기","${ClubInfo.SKILL_POINT}");
			$(".tedit_input_select1_button .btnImage_on").css("display","none");
			$(".tedit_input_select1_button .btnImage_off").css("display","inline-block");
			$(".tedit_input_select1_button.selected .btnImage_off").css("display","none");
			$(".tedit_input_select1_button.selected .btnImage_on").css("display","inline-block");
		});
		$(".info_container_modify .matchingdate").click(function() {
			toggle_tedit("MATCH_DATE","date","매칭희망일 수정하기",$(this).children(".value").html());
		});
		$(".info_container_modify .exercise_place").click(function() {
			toggle_tedit("EXERCISE_PLACE","text","운동장소 수정하기",refineContentRev($(this).children(".div2_value").html()));
		});
		$(".info_container_modify .exercise_time").click(function() {
			toggle_tedit("EXERCISE_TIME","text","운동시간 수정하기",refineContentRev($(this).children(".div2_value").html()));
		});
		$(".info_container_modify .ages").click(function() {
			$(".tedit_input_select2_button").removeClass("selected");
			$("#${ClubInfo.CLUB_TARGET_CODE}.tedit_input_select2_button").toggleClass("selected");
			toggle_tedit("CLUB_TARGET_CODE","select2","주요 연령대 수정하기","${ClubInfo.CLUB_TARGET_CODE}");
			$(".tedit_input_select2_button .btnImage_on").css("display","none");
			$(".tedit_input_select2_button .btnImage_off").css("display","inline-block");
			$(".tedit_input_select2_button.selected .btnImage_off").css("display","none");
			$(".tedit_input_select2_button.selected .btnImage_on").css("display","inline-block");
		});
		$(".info_container_modify .member_num").click(function() {
			toggle_tedit("MEMBER_NUM","text","회원수 수정하기",refineContentRev($(this).children(".div2_value").html()));
		});
		$(".info_container_modify .div3").click(function() {
			toggle_tedit("INTRODUCTION","text","동호회 소개 수정하기", refineContentRev($(this).html()));
		});
		function toggle_tedit(target, type, title, original){
			$(window).scrollTop(0);
			$("body").css("overflow","hidden");
			$(".text-editor").css("display","block").css("height",$("html").height());
			$(".text-editor #page_name").html(title);
			$(".text-editor #tedit_"+type+"_input_wrapper").css("display","block");
			$(".text-editor #tedit_"+type+"_input_wrapper > input").val(original);
			$(".text-editor #tedit_"+type+"_input_wrapper > textarea").val(original);
			$(".text-editor #dbMapColumn").val(target);
			$(".text-editor #dbMapType").val(type);
		}
	</script>
</div>