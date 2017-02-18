<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_detail_admin_inquiry.css'/>" rel="stylesheet">

<body>
<table class="admin_tb">
	<tr>
		<td class="td_title" valign="bottom">관리하기
	<c:choose>
		<c:when test="${IS_FED eq 0}">
			<tr>
				<td onclick="location.href='./club_user.do?club_code=${param.club_code}&replace=clubdetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">회원관리</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
			<tr>
				<td onclick="location.href='./club_admin_inquiry.do?club_code=${param.club_code}&replace=clubdetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">문의관리</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
				
			<tr>
				<td onclick="location.href='./club_manager.do?club_code=${param.club_code}&replace=clubdetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">회비관리</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
			
			<tr>
				<td class="td_title" valign="bottom">부가정보	
			<tr>
				<td onclick="location.href='./club_point.do?club_code=${param.club_code}&CLUB_CODE=${param.club_code}&replace=clubdetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">동호회 포인트</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
			<tr>
				<td onclick="location.href='./club_close.do?club_code=${param.club_code}&replace=clubdetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">동호회 폐쇄</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
		</c:when>
		<c:when test="${IS_FED eq 1}">
			<tr>
				<td onclick="location.href='./fed_member.do?FED_CODE=${param.FED_CODE}&replace=feddetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">동호회 관리</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
			<tr>
				<td onclick="location.href='./fed_admin_inquiry.do?FED_CODE=${param.FED_CODE}&INQUIRY_TYPE=-1&INQUIRY_ID=-1&replace=feddetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">문의하기</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
			<tr>
				<td onclick="location.href='./fed_manager.do?FED_CODE=${param.FED_CODE}&replace=feddetailadmin&si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}'">
					<div class="admin_name_div">운영진 변경</div>
					<div class="admin_next_div" align="right">
						<img src="../resources/images/icon_detail.png">
					</div>
		</c:when>
	</c:choose>
</table>
<c:choose>
	<c:when test="${IS_FED eq 0 && user_level ne 2}">
		<div id="admin_blind">
			<span id="admin_blind_text">운영진만 이용할 수 있습니다.</span>
		</div>
		<script>
			$(".admin_tb td").prop("onclick", null).off("click");
		</script>
	</c:when>
	<c:when test="${IS_FED eq 1 && user_level ne 2}">
		<div id="admin_blind">
			<span id="admin_blind_text">운영진만 이용할 수 있습니다.</span>
		</div>
		<script>
			$(".admin_tb td").prop("onclick", null).off("click");
		</script>
	</c:when>
</c:choose>