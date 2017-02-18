<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_admin_inquiry.css?ver=1'/>" rel="stylesheet">
<body>
<%@ include file="../common/backeventjs.jsp" %>
<div id="club_admin_inquiry">
<div class="header">
	<div class="left_btn">
		<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />">
	</div>
	<div class="title">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<span id="page_name">문의하기</span>
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<span id="page_name" class="fed" style="color: #4f2ca5">문의하기</span>
			</c:when>
		</c:choose>
	</div>
	<div class="right_btn">
	</div>
	<script>
		$(".top_button#back").click(function() {
			//location.href="./club_detail.do?club_code=${param.club_code}&mode=${param.mode}";
			history.back();
		});
	</script>
</div>
	
	<div class="line"></div>
	<div class="dropdown_container">
		<div class="dropdown_button" id=""><span class="dropdown_inquiry_type"></span> 문의 보기 ▼</div>
		<div class="dropdown_list">
			<div class="dropdown_unit" id="all">전체</div>
			<div class="dropdown_unit" id="join">가입</div>
			<div class="dropdown_unit" id="match">매칭</div>
			<div class="dropdown_unit" id="etc">기타</div>
		</div>
		<script>
			$(function(){
				if("${param.inquiry_type}" == ""){
					$(".dropdown_button").attr("id","all");
					$(".dropdown_inquiry_type").html("전체");
				}
				else if("${param.inquiry_type}" == "0"){
					$(".dropdown_button").attr("id","join");
					$(".dropdown_inquiry_type").html("가입");
				}
				else if("${param.inquiry_type}" == "1"){
					$(".dropdown_button").attr("id","match");
					$(".dropdown_inquiry_type").html("매칭");
				}
				else if("${param.inquiry_type}" == "2"){
					$(".dropdown_button").attr("id","etc");
					$(".dropdown_inquiry_type").html("기타");
				}
				
				if("${param.scroll_top}" != ""){
					$(window).scrollTop("${param.scroll_top}");
				}
			});
			$(".dropdown_button").click(function() {
				if($(".dropdown_list").css("display") == "none"){
					$(".dropdown_list").css("display","block");
				}
				else{
					$(".dropdown_list").css("display","none");
				}
			});
			$(".dropdown_unit").click(function() {
				var url = "";
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						url = "./club_admin_inquiry.do?club_code=${param.club_code}&mode=${param.mode}&inquiry_type=";
					</c:when>
					<c:when test="${IS_FED eq 1}">
						url = "./fed_admin_inquiry.do?FED_CODE=${param.FED_CODE}&INQUIRY_ID=-1&INQUIRY_TYPE=";
					</c:when>
				</c:choose>
				switch($(this).attr("id")){
					case "all":
						location.href=url+"-1";
						break;
					case "join":
						location.href=url+"0";
						break;
					case "match":
						location.href=url+"1";
						break;
					case "etc":
						location.href=url+"2";
						break;
				}
			});
		</script>
	</div>
	<div class="line"></div>
	<div class="inquiry_list">
		<c:forEach items="${ClubAdminInquiry}" var="list">
			<div class="inquiry_unit">
				<div class="checkicon_container">
					<c:choose>
						<c:when test="${list.IS_RESPONSED eq 0}">
							<img class="checkicon" id="not_responsed" src="<c:url value="/resources/images/icon_운영진_미답변.png" />">
						</c:when>
						<c:when test="${list.IS_RESPONSED ne 0}">
							<c:choose>
								<c:when test="${IS_FED eq 0}">
									<img class="checkicon" id="responsed" src="<c:url value="/resources/images/icon_운영진_답변완료.png" />">
								</c:when>
								<c:when test="${IS_FED eq 1}">
									<img class="checkicon" id="responsed" src="<c:url value="/resources/images/icon_운영진_답변완료_연합회.png" />">
								</c:when>
							</c:choose>
						</c:when>
					</c:choose>
				</div>
				<div class="rest_container">
					<div class="content_head">
						<div class="name_container">
							<span class="name_span">${list.USER_NAME}</span>
						</div>
						<div class="type_container">
							<c:choose>
								<c:when test="${list.INQUIRY_TYPE eq 0}">
									<span class="inquiry_type" id="join">가입문의</span>
								</c:when>
								<c:when test="${list.INQUIRY_TYPE eq 1}">
									<span class="inquiry_type" id="match">매칭문의</span>
								</c:when>
								<c:when test="${list.INQUIRY_TYPE eq 2}">
									<span class="inquiry_type" id="etc">기타문의</span>
								</c:when>
							</c:choose>
						</div>
						<div class="date_container">
							<span class="date_span">${list.FORMATED_WRITE_DATE}</span>
						</div>
					</div>
					<div class="content_container">
						<span class="content_span">${list.TITLE}</span>
					</div>
				</div>
				<input type="hidden" name="inquiry_id" class="inquiry_id" id="${list.INQUIRY_ID}" value="${list.INQUIRY_ID}">
			</div>
			<div class="line"></div>
		</c:forEach>
	</div>
	<div id="tail"></div>
	<script>
		var load_flag = 0;
		$(function() {
			load_flag = 0;
			$(window).scroll(function() {
				scroll_loading();
			});
			resize();
		});
		$(window).resize(function() {
			resize();
		});
		$("#club_admin_inquiry .inquiry_unit").click(function() {
			click_inquiry_unit($(this));
		});
		function resize() {
			$("#club_admin_inquiry .rest_container").css("width",parseFloat($("#club_admin_inquiry .inquiry_unit").css("width"))-83);
		}
		function click_inquiry_unit(target){
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					location.href="./club_admin_inquiry_view.do?club_code=${param.club_code}&inquiry_id="+target.children(".inquiry_id").val()+"&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top="+$(window).scrollTop();
				</c:when>
				<c:when test="${IS_FED eq 1}">
					location.href="./fed_admin_inquiry_view.do?FED_CODE=${param.FED_CODE}&INQUIRY_ID="+target.children(".inquiry_id").val();
				</c:when>
			</c:choose>
		}
		function scroll_loading(){
			if(load_flag == 0 && $(window).scrollTop()+$(window).height() > $("#tail").offset().top - 110){
				load_flag = 1;
				var is_fed = "${IS_FED}";
				<c:choose>
					<c:when test="${IS_FED eq 0}">
						var club_code = "${param.club_code}";
						var last_iid = $(".inquiry_list .inquiry_unit:last").find(".inquiry_id").val();
						var inquiry_type = "${param.inquiry_type}";
						ajax_get_club_inquiry_more(club_code, last_iid, 5, inquiry_type, function(json) {
					</c:when>
					<c:when test="${IS_FED eq 1}">
						var fed_code = "${param.FED_CODE}";
						var last_iid = $(".inquiry_list .inquiry_unit:last").find(".inquiry_id").val();
						var inquiry_type = "${param.INQUIRY_TYPE}";
						ajax_get_fed_inquiry_more(fed_code, last_iid, 5, inquiry_type, function(json) {
					</c:when>
				</c:choose>
					var jsonObj = JSON.parse(JSON.stringify(json));
					var format = "";
					console.log(jsonObj);
					jsonObj.forEach(function(element) {
						format =	"<div class='inquiry_unit'>"
							+			"<div class='checkicon_container'>";
						if(element.is_RESPONSED == 0){
							format += 		"<img class='checkicon' id='not_responsed' src=\"<c:url value='/resources/images/icon_운영진_미답변.png' />\">";
						}
						else if(element.is_RESPONSED != 0){
							if(is_fed == 0){
								format +=	"<img class='checkicon' id='responsed' src=\"<c:url value='/resources/images/icon_운영진_답변완료.png' />\">";
							}
							else if(is_fed == 1){
								format +=	"<img class='checkicon' id='responsed' src=\"<c:url value='/resources/images/icon_운영진_답변완료_연합회.png' />\">";
							}
						}
						format +=		"</div>"
							+			"<div class='rest_container'>"
							+				"<div class='content_head'>"
							+					"<div class='name_container'>"
							+						"<span class='name_span'>"+element.user_NAME+"</span>"
							+					"</div>"
							+					"<div class='type_container'>";
						if(element.inquiry_TYPE == 0){
							format +=				"<span class='inquiry_type' id='join'>가입문의</span>";
						}
						else if(element.inquiry_TYPE == 1){
							format +=				"<span class='inquiry_type' id='match'>매칭문의</span>";
						}
						else if(element.inquiry_TYPE == 2){
							format +=				"<span class='inquiry_type' id='etc'>기타문의</span>";
						}
						format +=				"</div>"
							+					"<div class='date_container'>"
							+						"<span class='date_span'>"+element.formated_WRITE_DATE+"</span>"
							+					"</div>"
							+				"</div>"
							+				"<div class='content_container'>"
							+					"<span class='content_span'>"+element.title+"</span>"
							+				"</div>"
							+			"</div>"
							+			"<input type='hidden' name='inquiry_id' class='inquiry_id' id='"+element.inquiry_ID+"' value='"+element.inquiry_ID+"'>"
							+		"</div>"
							+	"<div class='line'></div>";
						$(".inquiry_list").append(format);
					});
					load_flag = 0;
					$(".inquiry_unit").off("click");
					$(".inquiry_unit").on("click", function() {
						click_inquiry_unit($(this));
					});
					resize();
				});
			}
		}
	</script>
</div>
<%@ include file="../common/backeventjs.jsp" %>