<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<div class="header" style="background-color: #008ae8">
	<div class="left_btn"><img src="../resources/images/icon_back_white.png" onclick="history.back(-1);"></div>
	<div class="title" style="color: #ffffff; background-color: #008ae8;">지역선택</div>
	<div class="right_btn"></div>
</div>

<div id="join_location">
		<c:forEach items="${LocationSI}" var="list">
		<div class="line_div" onclick="">
			<div class="loc_name_div">${list.SI}</div>
			<div class="loc_next_div" align="right">
				<img src="../resources/images/icon_detail.png" style="height: 20px; width: 20px;"></div>
		</div>
		</c:forEach>
</div>
<script>
	$(".line_div").click(function() {
		/*if($(this).find(".loc_name_div").html() != "서울특별시"){
			alert("경기도 서비스 준비중입니다.");
			return;
		}*/
		location.href='./loc_detail.do?SI='+$(this).find(".loc_name_div").html();
	});
</script>
<%@ include file="./footer.jsp" %>