<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link href="<c:url value='/resources/css/footer.css?v=2'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/header.css?v=1'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/profile_modify.css?ver=2'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/jquery-ui.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club_dialog.css'/>" rel="stylesheet">
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/ajax.js?v=1'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/jquery-ui.min.js'/>"></script>
</head>
<body>

<div id="profile_modify" style="background-color: white">
	<div class="header">
		<div class="left_btn"><img src="../resources/images/icon_back.png" onclick="location.href='../myprofile/index.do'"></div>
		<div class="title">프로필 관리</div>
		<div class="right_btn" onclick="save()"><span style="color: #008ae8">저장</span></div>
	</div>
	<div id="blurAll"></div>
	<div class="div1">
		<div class="background_editor">
			<div class="preview background_preview">
				<img class="background_img picture" src='../resources/upload/user/background/${user_info.PROFILE_BACKGROUND}' onerror="this.src='../resources/images/bg_img.jpg'" onclick="background_change()">
				<div class="background_img color" style="display:none;"></div>
			</div>
			<div class="image_container"><img class="photo_img" src="../resources/images/icon_photo.png" onclick="background_change()"></div>
		 	<c:if test="${user_info.SEX eq 0 && empty user_info.PROFILE_BACKGROUND}">
			<script>
				$(".background_img.picture").css("display","none");
				$(".background_img.color").css("display","").css("background-color","#85a7d1");
			</script>
			</c:if>
			<c:if test="${user_info.SEX eq 1 && empty user_info.PROFILE_BACKGROUND}">
				<script>
					$(".background_img.picture").css("display","none");
					$(".background_img.color").css("display","").css("background-color","#fab4b4");
				</script>
			</c:if>
		 </div>
		<div class="profile_editor">
			<div class="preview profile_preview"><img class="profile_img" src='../resources/upload/user/profile/${user_info.PROFILE}' onerror="this.src='../resources/images/icon_프로필사진(공백).png'" onclick="profile_change()"></div>
			<div class="image_container"><img class="photo_img" src="../resources/images/icon_photo.png" onclick="profile_change()"></div>
		 </div>
	
	    <script>
	    var image_flag = 0;	// 0 : background, 1 : profile
	    var background_image = new Image();
	    var profile_image = new Image();
	    
	    function background_change(){
	    	image_flag = 0;
	    	window.Android.selectOneImage();
	    }
	    
	    function profile_change(){
	    	image_flag = 1;
	    	window.Android.selectOneImage();
	    }
	    
	    function selectedImage(mimeType, encodedImage){
	    	if(image_flag==0){
	    		background_image.src = 'data:'+mimeType+";base64,"+encodedImage;
				$(".background_preview").html(background_image);
				$(".background_preview img").addClass("background_img");
	    	} else if(image_flag==1){
				profile_image.src = 'data:'+mimeType+";base64,"+encodedImage;
				$(".profile_preview").html(profile_image);
				$(".profile_preview img").addClass("profile_img");
	    	}
		}
		
	    </script>
	    <div style="text-align: center;">
	    <input id="user_name" type="text" value="${user_info.USER_NAME}" maxlength="5" style="font-size: 20px;text-align: center; width:100px;" readonly="readonly">
		<image id="profile_name_modify" src="../resources/images/icon_edit.png" style="width:18px; height:18px;" onclick="fee_edit()">
		</image>
		</div>
	</div>
	<div class="div2" style="height:110px">
		<div id="input_info1" style="height:50px; background-color: white">
			<div id="birthday_edit" style="border-bottom: 1px solid #9B9B9B;">
				<span class="title_span">생년월일 : </span>
				<div class="birthday_div" align="center">
						<select id="selYear" name="bsnsYear" class="birth_sel" style="width: 50px;">
				          <option value="">년도</option>
				          <c:set var="now" value="<%=new java.util.Date()%>" />
				          <fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
				          <c:forEach begin="0" end="80" var="result" step="1">
				           <option value="<c:out value="${yearStart - result}" />" <c:if test="${(yearStart - result) == fn:substring(user_info.BIRTHDAY, 0, 4)}"> selected="selected"</c:if>><c:out value="${yearStart - result}" /></option>
				          </c:forEach>                      
				         </select>년
			         <div class="vertical_line"></div>

			         <select id="selMonth" name="bsnsMonth" class="birth_sel">
			          <option value="">월</option>
			          <c:forEach begin="1" end="12" var="result" step="1">
			           <option value="<c:out value="${monthStart + result}" />" <c:if test="${(monthStart + result) == fn:substring(user_info.BIRTHDAY, 5, 7)}"> selected="selected"</c:if>><c:out value="${monthStart + result}" /></option>
			          </c:forEach>                      
			         </select>월
			        <div class="vertical_line"></div>
			        
			         <select id="selDay" name="bsnsDay" class="birth_sel">
			          <option value="">일</option>
			          <c:forEach begin="1" end="31" var="result" step="1">
			           <option value="<c:out value="${dayStart + result}" />" <c:if test="${(dayStart + result) == fn:substring(user_info.BIRTHDAY, 8, 10)}"> selected="selected"</c:if>><c:out value="${dayStart + result}" /></option>
			          </c:forEach>
			         </select>일&nbsp;&nbsp;&nbsp;
				</div>
			</div>
		</div>
		<div id="input_info2" style="height:60px; background-color: white; text-align: top">
			<center><input id="input_location" class="${user_info.LOCATION_CODE}" type="text" value="${user_info.LOCATION_SI} ${user_info.LOCATION_GU}" readonly
						onfocus="if(this.value == '지역을 선택하세요.'){this.value=''};" onblur="if(this.value =='')this.value='지역을 선택하세요.';"
						style="font-size:13px; border:1px solid; color:#9B9B9B; height: 40px; width:80%; border-color:white; border-bottom-color: #9B9B9B;"></center>
		</div>
	</div>
	
	<div class="div4">
		<div id="space3">
			<font size="2px">내가 가입한 동호회</font></div>
		<div id="joined_clubs">
			<table style="width: 100%; background-color: white;">
				<c:forEach items="${user_club}" var="list">
						<tr height="45px" club_code="${list.CLUB_CODE}">
							<td style="width:15%; border-radius: 10px;">
								<image class="swimming_img" src="../resources/images/pictogram/${list.NAME}.png" onerror="this.src='../resources/images/pictogram/picto_default.png'"  style="height: 30px; width: 30px; float: right;">
							</td>
							<td style="width:65%; text-align: left">
								<font size="2.5px">&nbsp;&nbsp;&nbsp;${list.CLUB_NAME}</font>
							</td>
							<td style="padding-right:5%;width:20%;">
								<div class="getout_btn" onclick="getout_from_club(${list.CLUB_CODE})">탈퇴하기</div>
							</td>
						</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div class="div3">
		<div id="space3">나의 관심종목에서 경력/실력 추가하기</div>
		<div id="interested_field_modify" style="width:100%; background-color: white;">
			<table style="width: 100%; background-color: white" class="interest_table">
				<c:forEach items="${user_interest}" var="list">
				<tr height="45px" class="category_tr" id="${list.CATEGORY_CODE}">
					<td id="picto_td" style="width:14%; border-radius: 10px">
						<image class="swimming_img" src="../resources/images/pictogram/${list.NAME}.png" onerror="this.src='../resources/images/pictogram/picto_default.png'" style="height: 30px; width: 30px; float: right;">
					</td>
					<td id="category_td" style="width:25%; text-align: left">
						<font size="2.5px">&nbsp;&nbsp;&nbsp;${list.NAME}</font>
					</td>
					<td id="career_td">
						<div class="demo">
							<form action="#">
							 	 <fieldset>
								    <select name="spec" id="spec_carrer" class="career">
								      <option <c:if test="${list.CAREER eq 0}">selected="selected"</c:if> value="0">경력 없음</option>
								      <option <c:if test="${list.CAREER eq 1}">selected="selected"</c:if> value="1">1년 미만</option>
								      <option <c:if test="${list.CAREER eq 1}">selected="selected"</c:if> value="3">1년 ~ 3년</option>
								      <option <c:if test="${list.CAREER eq 3}">selected="selected"</c:if> value="5">3년 ~ 5년</option>
								      <option <c:if test="${list.CAREER eq 5}">selected="selected"</c:if> value="10">5년 ~ 10년</option>
								      <option <c:if test="${list.CAREER eq 10}">selected="selected"</c:if> value="11">10년 이상</option>
								    </select>
							    </fieldset>
						    </form>
					    </div>
					</td>
					<td id="level_td">
						<c:if test='${list.NAME != "배드민턴"}'>
							<div class="level_div" onclick="open_select_level_dialog('${list.CATEGORY_CODE}')">
								<span class="level_value">
									<c:choose>
										<c:when test="${list.LEVEL eq 11}">선수 출신</c:when>
										<c:when test="${(list.LEVEL % 2 == 1) && (list.LEVEL != 11)}">
											<c:forEach var="i" begin="1" end="${list.LEVEL / 2}" step="1">
												<img class="img_levelStar" src="../resources/images/icon_star.png">
											</c:forEach>
											<img class="img_levelStar" src="../resources/images/icon_half_star.png">
										</c:when>
										<c:otherwise>
											<c:forEach var="i" begin="1" end="${list.LEVEL / 2}" step="1">
												<img class="img_levelStar" src="../resources/images/icon_star.png">
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</span>
								<img class="img_select_arrow" src="../resources/images/icon_selectbox_arrow.png">
								<input type="hidden" class="level" value="${list.LEVEL}" />
							</div>
						</c:if>
						<c:if test='${list.NAME == "배드민턴"}'>
							<div class="demo">
								<form action="#">
								  	<fieldset>
									    <select name="spec" id="spec_carrer" class="level">
												<option <c:if test="${list.LEVEL eq 6}">selected="selected"</c:if> value="6">선수 출신</option>
												<option <c:if test="${list.LEVEL eq 5}">selected="selected"</c:if> value="5">A조</option>
												<option <c:if test="${list.LEVEL eq 4}">selected="selected"</c:if> value="4">B조</option>
												<option <c:if test="${list.LEVEL eq 3}">selected="selected"</c:if> value="3">C조</option>
												<option <c:if test="${list.LEVEL eq 2}">selected="selected"</c:if> value="2">D조</option>
												<option <c:if test="${list.LEVEL eq 1}">selected="selected"</c:if> value="1">초심</option>
									    </select>
								    </fieldset>
							    </form>
						    </div>
					    </c:if>
					</td>
				</tr>
				</c:forEach>
				<script>
					/*if($("#category_td").val == "배드민턴") {
						$(".level_td").attr("colspan","2");
						$(".level_td").html("<input type='text' placeholder='종목을 설명해주세요.'>");
					}*/
				
				</script>
			</table>
		</div>
		<div class="modify_interest_btn">관심종목 변경하기</div>
	</div>
	
	<form id="Form" method="post" enctype="multipart/form-data" action="update_profile.do">
	</form>
	
</div>
<!-- dialog -->
<%@ include file="../club/dialog/dialog_select_userLevel.jsp" %>
<!-- 지역, 관심종목 변경하기 창 -->
<%@ include file="./modify_location.jsp" %>
<%@ include file="./modify_location_detail.jsp" %>
<%@ include file="./modify_interest.jsp" %>
</body>
<script>
	//$(function() {
	//  $( "#input_birthday" ).datepicker({
	//    dateFormat: 'yy년 mm월 dd일'
	//  });
	//});
	
	$("#input_location").click(function(){
		$("#profile_modify").css("display", "none");
		$("#modify_location").css("display", "block");
	});
	
	$(".modify_interest_btn").click(function(){
		$("#profile_modify").css("display", "none");
		$("#modify_interest").css("display", "block");
	});
	
	function fee_edit(){
		var id = $("#user_name");
		id.attr("readonly", false);
		id.css("autofocus", "autofocus");
		$("#user_name").focus();
	}
	
	
	function save(){
		var newName = $("#user_name").val();
		var year = $("#selYear option:selected").val();
		var month = $("#selMonth option:selected").val();
		var day = $("#selDay option:selected").val();
		var birthday = year+"-"+month+"-"+day;
		//var birthday = birthday.substring(0,4)+"-"+birthday.substring(6,8)+"-"+birthday.substring(10,12);
		var location_code = $('#input_location').attr("class");
		
		var category_tr = $('.category_tr');
		var code_arr = new Array();
		var career_arr = new Array();
		var level_arr = new Array();
		for(var i=0;i<category_tr.length;i++){
			var id = category_tr[i].id;
			code_arr.push(id);
			career_arr.push($("#"+id+" .career").val());
			level_arr.push($("#"+id+" .level").val());
		}
		
		var background = background_image.src;
		var profile = profile_image.src;
		
		var form = $('#Form');
		var formData = new FormData(form);
		formData.append("PROFILE_BACKGROUND", background);
		formData.append("PROFILE", profile);
		formData.append("USER_NAME", newName);
		formData.append("BIRTHDAY", birthday);
		formData.append("LOCATION_CODE", location_code);
		formData.append("code_arr", code_arr);
		formData.append("career_arr", career_arr);
		formData.append("level_arr", level_arr);
        
		$.ajax({
			url: './update_profile.do',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			success: function(result){
				window.alert("저장되었습니다.");
				history.back();
			}
		});
			
	}
	
	function getout_from_club(club_code){
		var club_tr = $("tr[club_code="+club_code+"]");
		if(confirm("정말로 탈퇴하시겠습니까?")){
			ajax_getout_from_club(club_code, function(json){
				var jsonObj = JSON.parse(JSON.stringify(json));
				if(jsonObj.result == 1){
					club_tr.html("");
					club_tr.css("height", "0px");
				}
				else{
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	
</script>
<%@ include file="../common/backeventjs.jsp" %>