<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="<c:url value='/resources/css/club_list_create_club.css'/>" rel="stylesheet">

<body>
<%@ include file="../common/backeventjs.jsp" %>
<script>
	var selected_si = "";
	var selected_gu = "";
	var selected_gu_str = "지역을 선택해주세요";
	var selected_field = "";
	var selected_field_str = "종목을 선택해주세요";
</script>

<div id="location_select">
	<div class="header">
		<div class="left_btn bluecap-first-child"><span style="color: white;">취소</span></div>
		<div class="title bluecap-second-child" style="background-color:#008ae8; color: white">지역선택</div>
		<div class="right_btn bluecap-third-child" style="color: white;"></div>
	</div>
	<script>
		$("#location_select .bluecap-first-child").click(function() {
			$("#location_select").css("display","none");
		});
	</script>
	
	<c:forEach items="${LocationSI}" var="list_loc">
	
		<div class="SI_btn_wrapper" id="${list_loc.SI}">
			<div class="SI_btn">${list_loc.SI}</div>
			<div class="next_btn"><img class="arrow" src="<c:url value="/resources/images/icon_detail.png"/>"></div>
		</div>
		<div class="line"></div>
	</c:forEach>
	<script>
		$(".SI_btn_wrapper").click(function() {
			if($(this).attr("id") != "서울특별시"){
				alert("현재 서비스 준비중입니다.");
				return;
			}
			selected_si = $(this).attr("id");
			$("#location_select").css("display","none");
			$("#location_detail_select").css("display","block").css("height",$("html").height());
			$("#location_detail_select .GU_btn_wrapper div").css("display","none");
			$("#location_detail_select .GU_btn_wrapper ."+selected_si).css("display","block");
			if(selected_gu == "" && $("#create_club .selected_gu").attr("id") != ""){
				selected_gu = $("#create_club .selected_gu").attr("id");
				selected_gu_str = $("#create_club .selected_gu").val();
				$("#location_detail_select div.GU_btn#"+selected_gu+" img").attr("src","<c:url value='/resources/images/icon_admin_checkbox_click.png'/>");
			}
		});
	</script>
	
</div>

<div id="location_detail_select">
	<div class="header">
		<div class="left_btn bluecap-first-child"><span style="color: white">취소</span></div>
		<div class="title bluecap-second-child" style="background-color:#008ae8; color: white">지역선택</div>
		<div class="right_btn bluecap-third-child"><span style="color: white">완료</span></div>
	</div>
	<script>
		$("#location_detail_select .bluecap-first-child").click(function() {
			$("#location_select").css("display","block").css("height",$("html").height());
			$("#location_detail_select").css("display","none");
			if(selected_gu != ""){
				$("#location_detail_select div#"+selected_gu+" img").attr("src","<c:url value='/resources/images/icon_admin_checkbox.png'/>");
				selected_gu = "";
				selected_gu_str = "지역을 선택해주세요";
			}
		});
		$("#location_detail_select .bluecap-third-child").click(function() {
			$("#create_club .location_btn").html(selected_gu_str);
			$("#create_club .selected_gu").attr("id",selected_gu);
			$("#create_club .selected_gu").val(selected_gu_str);
			$("#location_detail_select").css("display","none");
			if(selected_gu == ""){
				$(".location_btn").css("color","#797979");
			}
			else{
				$(".location_btn").css("color","#000000");
			}
		});
	</script>
	<div class="GU_info"><span class="GU_info_span">같은 지역의 회원들과 운동할 수 있습니다.</span></div>
	<div class="GU_btn_wrapper">
		<c:forEach items="${LocationAllGU}" var="list_dloc">
			<div class="GU_btn ${list_dloc.SI}" id="${list_dloc.LOCATION_CODE}"><img class="checkbox" id="${list_dloc.LOCATION_CODE}" src="<c:url value="/resources/images/icon_admin_checkbox.png"/>"><span class="GU_btn_span">${list_dloc.GU}</span></div>
		</c:forEach>
		<script>
			$("#location_detail_select .GU_btn").click(function() {
				if($(this).attr("id") == selected_gu){
					$(this).children("img").attr("src","<c:url value='/resources/images/icon_admin_checkbox.png'/>");
					selected_gu = "";
					selected_gu_str = "지역을 선택해주세요";
				}
				else{
					if(selected_gu != ""){
						$("#location_detail_select div.GU_btn#"+selected_gu+" img").attr("src","<c:url value='/resources/images/icon_admin_checkbox.png'/>");
					}
					$(this).children("img").attr("src","<c:url value='/resources/images/icon_admin_checkbox_click.png'/>");
					selected_gu = $(this).attr("id");
					selected_gu_str = $(this).children("span").html();
				}
			});
		</script>
	</div>
</div>

<div id="field_select">
	<div class="header">
		<div class="left_btn bluecap-first-child"><span style="color: white">취소</span></div>
		<div class="title bluecap-second-child" style="background-color:#008ae8; color: white">종목 선택</div>
		<div class="right_btn bluecap-third-child"><span style="color: white">저장</span></div>
	</div>
	<script>
		$("#field_select .bluecap-first-child").click(function() {
			$("#field_select").css("display","none");
			if($("#create_club .selected_field").val() != selected_field){
				$("#field_select div.field_unit").children("span").css("color","#008ae8");
				$("#field_select div.field_unit").children("span").css("background-color","#ffffff");
				if($("#create_club .selected_field").attr("id") != ""){
					$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("color","#ffffff");
					$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("background-color","#008ae8");
					selected_field = $("#create_club .selected_field").attr("id");
					selected_field_str = $("#create_club .selected_field").val();
				}
				else{
					selected_field = "";
					selected_field_str = "종목을 선택해주세요";
				}
			}
		});
		$("#field_select .bluecap-third-child").click(function() {
			$("#create_club .field_btn").html(selected_field_str);
			$("#create_club .selected_field").attr("id",selected_field);
			$("#create_club .selected_field").val(selected_field_str);
			$("#field_select").css("display","none");
			if(selected_field == ""){
				$(".field_btn").css("color","#797979");
			}
			else{
				$(".field_btn").css("color","#000000");
			}
		});
	</script>
	<div class="field_group_wrapper">
		<c:forEach items="${events}" var="outer_list">
				<div class="field_group" id="${outer_list.EVENTS_TAG}">
					<div class="field_group_icon">
						<c:if test="${outer_list.EVENTS_CODE ne 10}">
							<img class="field_group_icon_img" src="<c:url value="/resources/images/icon_${outer_list.EVENTS_NAME}_78px.png"/>">
						</c:if>
						<span class="field_group_name">${outer_list.EVENTS_NAME}</span>
					</div>
					<div class="field_group_list">
						<c:forEach items="${sports}" var="inner_list">
							<c:if test="${inner_list.PARENT_CODE eq outer_list.EVENTS_CODE}">
								<div class="field_unit" id="${inner_list.CATEGORY_CODE}"><span class="field_unit_span">${inner_list.NAME}</span></div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="line"></div>
		</c:forEach>
		<script>
			$(".field_unit").click(function() {
				if($(this).attr("id") == selected_field){
					$(this).children("span").css("color","#008ae8");
					$(this).children("span").css("background-color","#ffffff");
					selected_field = "";
					selected_field_str = "종목을 선택해주세요";
				}
				else{
					if(selected_field != ""){
						$("#field_select div.field_unit#"+selected_field).children("span").css("color","#008ae8");
						$("#field_select div.field_unit#"+selected_field).children("span").css("background-color","#ffffff");
					}
					$(this).children("span").css("color","#ffffff");
					$(this).children("span").css("background-color","#008ae8");
					selected_field = $(this).attr("id");
					selected_field_str = $(this).children("span").html();
				}
			});
		</script>
	</div>
</div>

<div class="header">
	<div class="left_btn bluecap-first-child" onclick="history.back(-1)"><span style="color: white;">취소</span></div>
	<div class="title bluecap-second-child"  style="background-color:#008ae8; color: white">동호회만들기</div>
	<div class="right_btn bluecap-third-child"  style="color: white"></div>
</div>
<div id="create_club">
	<div class="wrap_location_div">
		<div class="location_div">
			<center><table class="location_tb">
				<tr height="50px">
					<td class="image_td"><img src="../resources/images/icon_지역.png"></td>
					<td>지역</td>
					<td class="location_btn" align="right" style="color:#797979;">지역을 선택해주세요</td>
				</tr>
			</table></center>
			<input type="hidden" class="selected_gu" name="selected_gu" id="" value="">
		</div>
		<script>
			$(".location_btn").click(function() {
				$("#location_select").css("display","block").css("height",$("html").height());
			});
		</script>
	</div>
	<div class="wrap_field_div">
		<div class="field_div">
			<center><table class="field_tb">
				<tr height="50px">
					<td class="image_td"><img src="../resources/images/icon_종목.png"></td>
					<td>종목</td>
					<td class="field_btn" align="right" style="color:#797979;">종목을 선택해주세요</td>
				</tr>
			</table></center>
			<input type="hidden" class="selected_field" name="selected_field" id="" value="">
		</div>
		<script>
			$(".field_btn").click(function() {
				$("#field_select").css("display","block").css("height",$("html").height());
			});
		</script>
	</div>
	<div class="wrap_write_div">
		<div class="write_div">
			<center><table class="write_tb">
				<tr height="50px">
					<td class="image_td"><img src="../resources/images/icon_동호회 이름적기.png"></td>
					<td>
						<form name="insertFrm2">
							<input type="text" name="club_name" id="club_name" placeholder="동호회 이름을 적어주세요" onchange="len_chk2()" onKeyup="len_chk2()"></td>
						</form>
				</tr>
				<tr height="100px" style="border-top: 0.5px solid #979797">
					<td colspan="2" valign="middle">
						<form name="insertFrm">
							<textarea name="club_introduce" id="club_introduce" placeholder="동호회 소개멘트를 작성해주세요." onchange="len_chk()" onKeyup="len_chk()"></textarea>
						</form>
						<script> 
							//글자수 제한 체크 
							function len_chk(){
							  var frm = document.insertFrm.club_introduce;
							  if(frm.value.length > 500){  
							       alert("500자 이내로 작성해주세요.");  
							       frm.value = frm.value.substring(0,500);  
							       frm.focus();  
							  }
							} 
							function len_chk2(){
								  var frm = document.insertFrm2.club_name;
								  if(frm.value.length > 20){  
								       alert("20자 이내로 작성해주세요.");  
								       frm.value = frm.value.substring(0,500);  
								       frm.focus();  
								  }
								} 
						</script>
					</td>
				</tr>
			</table></center>
		</div>
	</div>
	<div class="wrap_category_div">
		<div class="category_div">
			<center><table class="category_tb">
				<tr height="50px">
					<td class="image_td"><img src="../resources/images/icon_종류검색.png"></td>
					<td class="dropdown_clubtype_btn" align="right">
						<span class="current_club_type_str" style="color:#797979;">동호회 종류 선택</span>
						<input type="hidden" name="current_club_type" class="current_club_type" value="">
					</td>
				</tr>
			</table></center>
			<div class="dropdown_list dropdown_clubtype_list">
				<c:forEach items="${club_type}" var="type_list">
					<div class="dropdown_unit dropdown_clubtype_unit">
						<span class="type_name">${type_list.CLUB_TYPE_NAME}</span>
						<input type="hidden" name="type_code" class="type_code" id="${type_list.CLUB_TYPE_CODE}" value="${type_list.CLUB_TYPE_CODE}">
					</div>
					<div class="line"></div>
				</c:forEach>
				<script>
					$("#create_club .dropdown_clubtype_unit").click(function() {
						$("#create_club .current_club_type_str").html($(this).children("span").html());
						$("#create_club .current_club_type").val($(this).children("input").val());
						$("#create_club .dropdown_clubtype_list").css("display","none");
						$(".current_club_type_str").css("color","#000000");
					});
				</script>
			</div>
			<script>
				$("#create_club .dropdown_clubtype_btn").click(function() {
					if($("#create_club .dropdown_clubtype_list").css("display") == "none"){
						$("#create_club .dropdown_clubtype_list").css("display","block");
					}
					else{
						$("#create_club .dropdown_clubtype_list").css("display","none");
					}
				});
			</script>
		</div>
	</div>
	<div class="wrap_target_div">
		<div class="target_div">
			<center><table class="target_tb">
				<tr height="50px">
					<td class="image_td"><img src="../resources/images/icon_연령소개.png"></td>
					<td class="dropdown_clubtarget_btn" align="right">
						<span class="current_club_target_str" style="color:#797979;">주요 연령대 선택</span>
						<input type="hidden" name="current_club_target" class="current_club_target" value="">
					</td>
				</tr>
			</table></center>
			<div class="dropdown_list dropdown_clubtarget_list">
				<c:forEach items="${club_target}" var="target_list">
					<div class="dropdown_unit dropdown_clubtarget_unit">
						<span class="target_name">${target_list.CLUB_TARGET_NAME}</span>
						<input type="hidden" name="target_code" class="target_code" id="${target_list.CLUB_TARGET_CODE}" value="${target_list.CLUB_TARGET_CODE}">
					</div>
					<div class="line"></div>
				</c:forEach>
				<script>
					$("#create_club .dropdown_clubtarget_unit").click(function() {
						$("#create_club .current_club_target_str").html($(this).children("span").html());
						$("#create_club .current_club_target").val($(this).children("input").val());
						$("#create_club .dropdown_clubtarget_list").css("display","none");
						$(".current_club_target_str").css("color","#000000");
					});
				</script>
			</div>
			<script>
				$("#create_club .dropdown_clubtarget_btn").click(function() {
					if($("#create_club .dropdown_clubtarget_list").css("display") == "none"){
						$("#create_club .dropdown_clubtarget_list").css("display","block");
					}
					else{
						$("#create_club .dropdown_clubtarget_list").css("display","none");
					}
				});
			</script>
		</div>
	</div>
	<div class="etc_div">
		<table class="etc_tb">
			<tr class="etc_tr">
				<td class="etc_td" width="40%">전체 동호회 회원수</td>
				<td align="right" width="60%">
					<input type="number" name="member_num" class="member_num" min="1" max="999" maxlength="3" oninput="maxLengthCheck(this)">
						<script>
						  function maxLengthCheck(object){
						   if (object.value.length > object.maxLength){
						    object.value = object.value.slice(0, object.maxLength);
						   }    
						  }
						</script>
				</td>
			</tr>
			<tr class="etc_tr2">
				<td class="etc_td">동호회 창립 연도</td>
				<td align="right">
					<div class="foundationDate_div" style="padding-right: 3px;">
						<select id="selYear" name="bsnsYear" class="found_sel">
						  <c:set var="now" value="<%=new java.util.Date()%>" />
				          <fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/>
				          <option value="${yearStart}"><c:out value="${yearStart}" /></option>
				          <c:forEach begin="1" end="80" var="result" step="1">
				           <option value="<c:out value="${yearStart - result}" />" ><c:out value="${yearStart - result}" /></option>
				          </c:forEach>                      
				         </select>년
				         
				         <div class="vertical_line"></div>
				         
				         
				         <select id="selMonth" name="bsnsMonth" class="found_sel" style="width: 30px">
				          <fmt:formatDate value="${now}" pattern="MM" var="monthStart"/>
				           <c:forEach begin="1" end="12" var="result" step="1">
				           <option value="<c:if test="${result lt 10}">0</c:if><c:out value="${result}" />"><c:out value="${result}" /></option>
				          </c:forEach>                      
				         </select>월
				         
				        
				         
				         <div class="vertical_line"></div>
				         
					</div>
				</td>
			</tr>
			<tr style="height: 20px;">
				<td id="etc_notice" colspan="2">창립 연도는 한번 설정하면 바꿀 수 없습니다.</td>
			</tr>
		</table>
	</div>
	<center><div class="create_btn_div">
			<div class="create_btn">동호회 만들기</div>
	</div></center>
	<script>
	var today = new Date();
	var cur_year = today.getFullYear();
	var cur_month = today.getMonth() + 1;
	$(window).load(function() {
		console.log(today);
		console.log(cur_month);
		console.log(cur_year);
	});
	$(document).ready(function() {
		console.log(today.getMonth());
	});
		$(function() {
			resize();
		});
		$(window).resize(function() {
			resize();
		});
		function resize() {
			$(".SI_btn_wrapper").css("width",$(window).width());
		}
		$(".create_btn_div").click(function() {
			var location_code = $("#create_club .selected_gu").attr("id");
			if(location_code == ""){
				alert("지역을 선택해주세요.");
				return;
			}
			var sports_type_code = $("#create_club .selected_field").attr("id");
			if(sports_type_code == ""){
				alert("종목을 선택해주세요.");
				return;
			}
			var club_name = $("#create_club #club_name").val();
			if(club_name == ""){
				alert("동호회 이름을 입력해주세요.");
				return;
			}
			var introduction = $("#create_club #club_introduce").val();
			if(introduction == ""){
				alert("동호회 소개글을 입력해주세요.")
				return;
			}
			else{
				var count = 0;
				ajax_club_name_overlap_check(club_name, function(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					count = jsonObj.count;
				});
				if(count > 0){
					alert("이미 존재하는 동호회 이름입니다.");
					return;
				}
			}
			var club_type_code = $("#create_club .current_club_type").val();
			if(club_type_code == ""){
				alert("동호회 종류를 선택해주세요.");
				return;
			}
			var club_target_code = $("#create_club .current_club_target").val();
			if(club_target_code == ""){
				alert("주요 연령대를 선택해주세요.");
				return;
			}
			var member_num = $("#create_club .member_num").val();
			if(!$.isNumeric(member_num) || member_num < 1){
				alert("정확한 회원수를 입력해주세요.");
				return;
			}
			var year = $("#selYear option:selected").val();
			var month = $("#selMonth option:selected").val();
			var establishment_year = year+"-"+month+"-01";
			
			
			if(establishment_year.match(/^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/)){
				console.log("검증받음");
				if((year == cur_year)&&(cur_month<month)) {
					alert("창립년도에 미래의 날짜를 설정할 수 없습니다.");
					return;
				}
			}
			else{
				console.log(establishment_year);
				alert("정확한 날짜를 입력해주세요.");
				return;
			}
			club_name = refineContent(club_name);
			introduction = refineContent(introduction);
			ajax_create_club(club_name,member_num,introduction,location_code,sports_type_code,establishment_year,club_type_code,club_target_code,function(json) {
				var jsonObj = JSON.parse(JSON.stringify(json));
				club_code = jsonObj.result;
				location.href = "./club_detail.do?club_code="+club_code;
			});
		});
		$(window).click(function(event) {
			var isDropdownButton = hasClass(event.target, "dropdown_clubtype_btn") || hasClass(event.target, "current_club_type_str");
			if(!isDropdownButton){
				$("#create_club .dropdown_clubtype_list").css("display","none");
			}
			isDropdownButton = hasClass(event.target, "dropdown_clubtarget_btn") || hasClass(event.target, "current_club_target_str");
			if(!isDropdownButton){
				$("#create_club .dropdown_clubtarget_list").css("display","none");
			}
		});
		function hasClass(element, cls) {
		    return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
		}
	</script>
</div>