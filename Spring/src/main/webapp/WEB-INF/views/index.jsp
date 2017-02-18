<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link href="<c:url value='/resources/css/account.css?v=2'/>" rel="stylesheet">
	<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/ajax.js?v=1'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/sha256.js'/>"></script>
</head>
<body>
<%@ include file="./common/backeventjs.jsp" %>
<div id="login">
	<div class="login_logo_container">
		<img src="./resources/images/login_logo.png">
	</div>
	<div class="login_body">
		<form id="login_form">
		<table class="login_tb" border="0">
			<tr class="login_tr">
				<td class="login_td" valign="bottom">
					<span style="line-height: 30px;">
						<input class="login_input" type="email" placeholder="이메일 입력" id="email" size="25px">
					</span>
			<tr class="login_tr">
				<td class="login_td" valign="bottom">
					<span style="line-height: 30px">
						<input class="login_input" type="password" placeholder="비밀번호 입력" id="password" size="25px">
					</span>
			<tr class="login_tr">
				<td class="auto_td">
					<div class="checkbox_wrapper">
						<div class="auto_login_container">
							<input type="checkbox" id="auto_login_check" checked>
							<label for="auto_login_check"></label>
						</div>
						<div class="auto_login_comment">자동로그인</span>
					</div>
		</table>
		<input class="login_bt" type=submit value="로그인">
		</form>
		<table class="login_tb_tab" border="0">	
			<tr valign="bottom">
				<td class="find_id">아이디 찾기
				<td class="find_password" align="center" style="width:40%;border-right: 1px solid white">비밀번호 찾기
				<td class="join_btn" align="right" width="32%">
					<font color="white">회원가입 하기</font>
		</table>
	</div>
</div>

<script>
	$("#login_form").submit(function(event){
		event.preventDefault();
		
		var email = $("#email").val();
		var password = $("#password").val();
		var auto_login = $("#auto_login_check").is(":checked");
		
		var sha256_password = Sha256.hash(password);
		
		ajax_login(email, sha256_password, auto_login, function callback(json){
			var jsonObj = JSON.parse(JSON.stringify(json));
			var result = jsonObj.result;
			
			if(result){
				location.replace("./home/index.do?branchhome=branchhome");
			} else {
				window.alert("아이디 또는 비밀번호가 틀렸습니다");
			}
		});
	});
	$(".find_id").click(function() {
		location.replace("./account/find_account.do?replace=main#id");
	});
	$(".find_password").click(function() {
		location.replace("./account/find_account.do?replace=main#password");
	});
	$(".join_btn").click(function() {
		location.replace("./account/join_basic.do?replace=main");
	});
</script>
</body>
</html>