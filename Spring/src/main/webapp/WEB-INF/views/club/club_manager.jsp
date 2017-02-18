<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="date" value="<%=new java.util.Date()%>" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<link href="<c:url value='/resources/css/bootstrap.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/footer.css?v=2'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/header.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/club_manager.css?v=1'/>" rel="stylesheet">
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/bootstrap.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/ajax.js'/>"></script>
</head>
<body>
<div class="header">
	<div class="left_btn">
		<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />" onclick="go_list()">
	</div>
	<div class="title"><span id="page_name">회비관리</span></div>
	<div class="right_btn">
		<img src="../resources/images/icon_setting.png" id="setting_btn" onclick="location.href='../club/club_user_add.do?club_code=${param.club_code}'">
	</div>
</div>

<div id="club_manager">
	<div class="date">
		<div class="back" onclick="month_back()"></div>
		<div class="date_fmt"><fmt:formatDate value="${date}" pattern="yyyy년 MM월" /></div>
		<div class="next" onclick="month_next()"></div>
	</div>
	<div class="cost">
		<div class="total_cost">
			<div class="cost_title">총금액</div>
			<div class="cost_value total_cost_value">0</div>
		</div>
		<div class="unpaid_cost">
			<div class="cost_title">미납금액</div>
			<div class="cost_value short_cost_value">0</div>
		</div>
	</div>
	<div class="members">
	</div>
	
</div>

<script>
	var club_code = ${param.club_code};
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var fee_list;
	
	function go_list(){
		history.back();
		//location.href="./club_detail.do?club_code="+club_code+"&mode=admin"
	}
	
	//리스트 불러오기
	$(document).ready(function(){
		get_paid_list();
	});
	
	$("#setting_btn").click(function(){
		location.href="./club_fee.do?club_code="+club_code;
	});
	
	//나머지 숫자 0 채워주는 알고리즘
	function pad(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
	
	//뒤로가기 효과
	function month_back(){
		var cur_date = $(".date_fmt").html();
		var cur_year = parseInt(cur_date.substring(0, 4));
		var cur_month = parseInt(cur_date.substring(6, 8));
		
		if(cur_month==1){
			year = cur_year - 1;
			month = 12;
		} else {
			year = cur_year;
			month = cur_month - 1;
		}
		
		$(".date_fmt").html(year+"년 "+ pad(month, 2) + "월");
		get_paid_list();
	}
	
	//다음달 넘기기 효과
	function month_next(){
		var cur_date = $(".date_fmt").html();
		var cur_year = parseInt(cur_date.substring(0, 4));
		var cur_month = parseInt(cur_date.substring(6, 8));
		
		if(cur_month==12){
			year = cur_year + 1;
			month = 1;
		} else {
			year = cur_year;
			month = cur_month + 1;
		}
		
		$(".date_fmt").html(year+"년 "+ pad(month, 2) + "월");
		get_paid_list();
	}
	
	function get_paid_list(){
		ajax_get_paid_list(club_code, year, month, function callback(json){
			var jsonObj = JSON.parse(JSON.stringify(json));
			var result = jsonObj.result;
			var value = jsonObj.value;
			var cnt = 0;
			
			if(result){
				var total_cost = 0;
				var short_cost = 0;
				fee_list = value[2];
				fee_list.forEach(function(element){
					total_cost = total_cost + element;
				});
				
				$(".members").html("");
				var real_user = value[0];
				real_user.forEach(function(element){
					
					
					var obj = element;
					var ori = $(".members").html();
					$(".members").html(
							ori
							+ '<div class="member">'
							+ 	'<div class="member_image">' 
							+		'<img src="../resources/upload/user/profile/'+ obj.profile + '" class="user_profile" onerror="this.src=\'../resources/images/icon_프로필사진(공백).png\'">'
							+ 	'</div>' 
							+ 	'<div class="mamber_name">' 
							+ 		obj.user_NAME
							+ 	'</div>' 
							+ 	'<div class="member_checkbox" id="'+cnt+'"align="right" onclick="checkbox_click(event, '+obj.user_ID+', 0)">'
							+ 	'</div>'
							+ '</div>'
					);
					if(obj.user_PAID_CODE != 0){
						$("#"+cnt).addClass("checked");
					} else {
						short_cost = short_cost + fee_list[cnt];
					}
					
					cnt++;
				});
				
				var address_user = value[1];
				address_user.forEach(function(element){
					var obj = element;
					var ori = $(".members").html();
					$(".members").html(
							ori
							+ '<div class="member">'
							+ 	'<div class="member_image">' 
							+		'<img src="" class="user_profile" onerror="this.src=\'../resources/images/icon_프로필사진(공백).png\'">'
							+ 	'</div>' 
							+ 	'<div class="mamber_name">' 
							+ 		obj.user_NAME
							+ 	'</div>' 
							+ 	'<div class="member_checkbox" id="'+cnt+'"align="right" onclick="checkbox_click(event, '+obj.user_ADDRESS_CODE+', 1)">'
							+ 	'</div>'
							+ '</div>'
					);
					if(obj.user_PAID_ADDRESS_CODE != 0){
						$("#"+cnt).addClass("checked");
					} else {
						short_cost = short_cost + fee_list[cnt];
					}
					
					cnt++;
					
				});
				
				$(".total_cost_value").html(total_cost);
				$(".short_cost_value").html(short_cost);
				
			} else {
				window.alert("실패");
			}
		});
	}


	function checkbox_click(event, code, user_flag){
		var target = $("#"+event.target.id);
		var short_cost = parseInt($(".short_cost_value").html());
		if(user_flag == 0){		//일반회원가입 유저일떄
			if(target.hasClass("checked")){
				ajax_user_paid_cancel(code, club_code, year, month, function callback(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					var value = jsonObj.value;
					
					if(result){
						target.removeClass("checked");
						short_cost = short_cost + fee_list[event.target.id];
						$(".short_cost_value").html(short_cost);
					} else {
						window.alert("실패");
					}
				});
			} else {
				ajax_user_paid(code, club_code, year, month, function callback(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					var value = jsonObj.value;
					
					if(result){
						target.addClass("checked");
						short_cost = short_cost - fee_list[event.target.id];
						$(".short_cost_value").html(short_cost);
					} else {
						window.alert("실패");
					}
				});
			}
		} else {		//주소록에서 추가된 회원일경우
			var date = ""+ year + "-" + pad(month, 2) + "-" + "01 00:00:00";
			if(target.hasClass("checked")){
				ajax_user_paid_cancel_address(code, club_code, date, function callback(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					var value = jsonObj.value;
					
					if(result){
						target.removeClass("checked");
						short_cost = short_cost + fee_list[event.target.id];
						$(".short_cost_value").html(short_cost);
					} else {
						window.alert("실패");
					}
				});
			} else {
				ajax_user_paid_address(code, club_code, date, function callback(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					var value = jsonObj.value;
					
					if(result){
						target.addClass("checked");
						short_cost = short_cost - fee_list[event.target.id];
						$(".short_cost_value").html(short_cost);
					} else {
						window.alert("실패");
					}
				});
			}
		}
		
	}
	
</script>
<%@ include file="../common/backeventjs.jsp" %>