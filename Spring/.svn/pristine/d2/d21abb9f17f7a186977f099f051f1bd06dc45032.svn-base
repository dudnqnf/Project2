<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<div class="header" style="background-color: #008ae8">
	<div class="left_btn"><img src="../resources/images/icon_back_white.png" onclick="history.back(-1);"></div>
	<div class="title" style="color: #ffffff; background-color: #008ae8;">지역선택</div>
	<div class="right_btn"></div>
</div>

<div id="join_location_detail">
	<table class="check_location">
		<tr class="line">
			<td colspan="3" align="center" style="height:50px; color: #008ae8; font-size: 13px">
			<c:if test="${param.SI eq '서울특별시'}">같은 지역의 회원들과 운동할 수 있습니다.</c:if>
			<c:if test="${param.SI ne '서울특별시'}">가입은 가능하지만, 동호회서비스는 서울시에만 제한되어있습니다.</c:if>
		<tr class="line" height="50px">
			<c:forEach items="${LocationGU}" var="list" varStatus="loop">
				<td width="33%" align="center" style="border-right-color: #979797" onclick="update_location(${list.LOCATION_CODE})">
						${list.GU}
					<c:choose>
					<c:when test="${loop.count%3==0}"></tr><tr class="line" height="50px"></c:when>
					</c:choose>
			</c:forEach>
		</tr>
	</table>
</div>
<script>
	function update_location(code){
		location.href="./update_user_loc.do?LOCATION_CODE="+code;
	}
</script>
<%@ include file="./footer.jsp" %>