<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<!-- 혜영씨 고치면서 봐요 -->
<!-- 이걸 표준으로 하면 다른 페이지들 회일화 하는데 도움이 될듯해요 -->
<!-- class는 재사용되는 공통 요소들, id는 각 구별되는 요소들 -->
<!-- 겉에 있는 div들은(header,stem,여러 wrapper) display 속성을 inline-block으로 하면 -->
<!-- 내부에 있는 내용들에게 크기를 맞춰서 자동으로 조절되요 -->
<!-- 여기서 top_wrapper처럼 크기가 정해지고 내부에 있는 요소들이 위치를 잡아야되는 경우에는 그냥 block으로 해야지요 ^^감사합니당~-->
<link href="<c:url value='/resources/css/club_detail_admin_point.css?ver=7'/>" rel="stylesheet">

<body>
<div class="header">
	<div class="left_btn">
		<img src="<c:url value="/resources/images/icon_back.png" />" onclick="history.back()" style="position:relative; z-index: 9999;">
	</div>
	<div class="title"><span id="page_name">포인트 내역 조회</span></div>
	<div class="right_btn">
	</div>
</div>

<div id="spaceBlank"></div>
<div class="stem fullsizestem" id="point">
	<div id="top_wrapper">
		<div id="top_explain_container">
			<span id="top_explain">현재, 우리 동호회 총 포인트</span>
		</div>
		<div id="top_point_wrapper">
			<img id="top_point_icon" src="<c:url value="/resources/images/icon_포인트.png" />" />
			<span id="top_point_value">${point_total}</span>
			<script>
				//왜안먹지;
				//$(".top_point_value").html((parseInt($(".top_point_value").val())).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			</script>
		</div>
	</div>
	<div id="main_wrapper">
		<div id="select_tabs_wrapper">
			<div class="select_tab_button_wrapper" id="history">
				<span class="select_tab_button_title" id="history">포인트 상세내역</span>
				<div class="select_tab_button_underline" id="history"></div>
			</div>
			<div class="select_tab_button_wrapper" id="info">
				<span class="select_tab_button_title" id="info">포인트 쌓는 방법</span>
				<div class="select_tab_button_underline" id="info">
				</div>
			</div>
		</div>
		<div id="contents_wrapper">
			<div class="content" id="history">
				<c:forEach items="${point_list}" var="list">
					<div class="content_unit_wrapper">
						<span class="content_span point_category_name">
							<c:choose>
								<c:when test="${list.POINT_CATEGORY eq 0}">운동생활에 가입한 동호회 회원수</c:when>
								<c:when test="${list.POINT_CATEGORY eq 1}">동호회 게시글 등록</c:when>
								<c:when test="${list.POINT_CATEGORY eq 2}">동호회 사진글 등록</c:when>
								<c:when test="${list.POINT_CATEGORY eq 3}">문의하기 답변</c:when>
							</c:choose>
						</span>
						<span class="content_span point_amount">
							<c:choose>
								<c:when test="${list.POINT_CATEGORY eq 0}">${list.COUNT}명</c:when>
								<c:otherwise>${list.COUNT}글</c:otherwise>
							</c:choose>
						</span>
						<span class="content_span point_value">+${list.POINTS}P</span>
					</div>
				</c:forEach>
			</div>
			<div class="content" id="info">
				<img src="../resources/images/point_photo.jpg" style="height: 100%; width: 100%">
			</div>
		</div>
	</div>
</div>
<script>
	$(function() {
		change_tab("history", "info");
		$("#point .select_tab_button_wrapper").click(function() {
			var id_activate = $(this).attr("id");
			var id_deactivate = $(this).siblings().attr("id");
			change_tab(id_activate,id_deactivate);
		});
	});
	$(document).ready(function(){
		numberWithCommas();
		resize_font($(".content_unit_wrapper"), 1, 30, 30, 17, 11);
	});
	function change_tab(activate, deactivate) {
		$("#point .select_tab_button_title#"+activate).css({
			"color":"#008ae8",
			"opacity":"1"
		});
		$("#point .select_tab_button_underline#"+activate).css("background-color","#008ae8");
		$("#point .content#"+activate).css("display","block");
		
		$("#point .select_tab_button_title#"+deactivate).css({
			"color":"#000000",
			"opacity":"0.54"
		});
		$("#point .select_tab_button_underline#"+deactivate).css("background-color","#ffffff");
		$("#point .content#"+deactivate).css("display","none");
	}
	
	//cost에 3자리수마다 컴마붙이기
	function numberWithCommas(){
		var point = $("#top_point_value").html();
		var commaPoint = point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#top_point_value").html(commaPoint);
	}
</script>
<%@ include file="../common/backeventjs.jsp" %>
</body>