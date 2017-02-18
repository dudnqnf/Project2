 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<div class="header" style="background-color: #008ae8">
	<div class="left_btn"><img src="../resources/images/icon_back_white.png" onclick="history.back(-1);"></div>
	<div class="title" style="color: #ffffff; background-color: #008ae8;">관심종목 선택</div>
	<div class="right_btn" id="next_btn" style="top:15px;"><span style="color: #ffffff">다음</span></div>
</div>

<div id="join_interest">
	<div class="space1" >
		<table style="font-size: 11.5px; background-color: #eeeeee;">
			<tr height="70px" valign="middle">
				<td align="left">
					<div style="width: 92%; margin: 0 auto">
					관심이 있는 스포츠 종목을 선택해 주세요. (최대 5개까지 선택 가능)</br>
					관심종목은 언제든지 내정보>관심종목 변경하기에서 변경할 수 있습니다.
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="check_interest_div">
		<table class="ball_check">
			<tr class="line">
				<td width="55px" style="padding-left: 15px;"><img src="../resources/images/category_ball.png" style="height: 30px; width: 30px">
				<td align="left" style="font-size: 15px">구기
			<tr class="line_ball">
				<td>
				<td>
					<c:forEach items="${type_ball}" var="list">
						<a><div class="checkbox" id="${list.CATEGORY_CODE}">${list.NAME}</div></a>
					</c:forEach>
		</table>
		<table class="racket_check">
			<tr class="line">
				<td width="55px" style="padding-left: 15px;"><img src="../resources/images/category_racket.png" style="height: 30px; width: 30px">
				<td align="left" style="font-size: 15px">라켓
			<tr class="line_racket">
				<td>
				<td>
					<c:forEach items="${type_racket}" var="list">
						<a><div class="checkbox" id="${list.CATEGORY_CODE}">${list.NAME}</div></a>
					</c:forEach>
		</table>
		<table class="martial_check">
			<tr class="line">
				<td width="55px" style="padding-left: 15px;"><img src="../resources/images/category_martial.png" style="height: 30px; width: 30px">
				<td align="left" style="font-size: 15px">무술
			<tr class="line_martial">
				<td>
				<td>
					<c:forEach items="${type_martial}" var="list">
						<a><div class="checkbox" id="${list.CATEGORY_CODE}">${list.NAME}</div></a>
					</c:forEach>
		</table>
		<table class="fitness_check">
			<tr class="line">
				<td width="55px" style="padding-left: 15px;"><img src="../resources/images/category_fitness.png" style="height: 30px; width: 30px">
				<td align="left" style="font-size: 15px">피트니스
			<tr class="line_fitness">
				<td>
				<td>
					<c:forEach items="${type_fitness}" var="list">
						<a><div class="checkbox" id="${list.CATEGORY_CODE}">${list.NAME}</div></a>
					</c:forEach>
		</table>
		<table class="etc_check">
			<tr class="line">
				<td width="55px" style="padding-left: 15px;"><img src="../resources/images/category_etc.png" style="height: 30px; width: 30px">
				<td align="left" style="font-size: 15px">기타
			<tr class="line_etc">
				<td>
				<td>
					<c:forEach items="${type_etc}" var="list">
						<a><div class="checkbox" id="${list.CATEGORY_CODE}">${list.NAME}</div></a>
					</c:forEach>
		</table>
		<div class="space" style="height: 60px;"></div>
	</div>
	
	<script>
		var arr = new Array();
		$(".checkbox").click(function(){
			var div = $(".checkbox").eq($(".checkbox").index($(this)));
			var id = div.attr('id');
				
			if(div.hasClass('on')){
				arr = arr.filter(function(x){
					if(x!=id)
						return x;
				})
				div.removeClass("on");
			}
			else{
				if(arr.length>=5){
					window.alert("최대 5개까지만 선택하여 주세요");
					return;
				}
				arr.push(id);
				div.addClass("on");
			}
		});
		
		$("#next_btn").click(function(){
			ajax_interest_update(arr, function callback(json){
				var jsonObj = JSON.parse(JSON.stringify(json));
				var result = jsonObj.result;
				
				if(result){
					location.href="../home/index.do"
				} else {
				}
			});
		});
		
	</script>

</div>
<%@ include file="./footer.jsp" %>