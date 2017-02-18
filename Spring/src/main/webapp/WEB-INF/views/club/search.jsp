<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<div class="header" id="search_header">
	<table>
		<tr>
			<td class="left_btn">
				<!-- <img src="../resources/images/icon_back.png"  
					onclick="location.href='../club/club_list.do'"> -->
				<img src="../resources/images/icon_back.png"  
					onclick="history.back();">
			</td>
			<td class="input_title">
				<img class="search_icon" src="../resources/images/icon_club_search.png" style="height:20px">
				<input type="text" class="search_frame" name="search_frame" placeholder="찾고싶은 동호회 이름을 찾아보세요." value="${param.CLUB_NAME}">
				<c:if test="${param.CLUB_NAME ne null && param.CLUB_NAME ne ''}">
					<img class="remover" src="<c:url value="/resources/images/icon_X.png" />" style="height:20px">
				</c:if>
			<td class="right_btn">
				<c:choose>
					<c:when test="${param.CLUB_NAME ne null && param.CLUB_NAME ne '' && search_club_list ne null && search_club_list ne ''}">
						<img class="example_switch" src="<c:url value="/resources/images/icon_down.png" />">
					</c:when>
					<c:otherwise>
						<img class="example_switch" src="<c:url value="/resources/images/icon_up.png" />">
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</div>
<div id="search" <c:if test="${param.CLUB_NAME ne null && param.CLUB_NAME ne '' && search_club_list ne null && search_club_list ne ''}">style="display:none;"</c:if>>
	<div class="search_log_tab">
		<div class="search_log_tab_btn" id="popular">
			<div class="search_log_tab_span_wrapper" id="popular"><span class="search_log_tab_span" id="popular">인기 검색어</span></div>
			<div class="search_log_tab_underline" id="popular"></div>
		</div>
		<div class="search_log_tab_btn" id="recent">
			<div class="search_log_tab_span_wrapper" id="recent"><span class="search_log_tab_span" id="recent">최근 검색어</span></div>
			<div class="search_log_tab_underline" id="recent"></div>
		</div>
	</div>
	<div class="search_div" id="popular">
		<table class="search_tb">
			<c:forEach items="${search_log_popular}" var="list_p" varStatus="status_p">
				<tr class="search_tr" style="border-bottom: 1px solid #E5E5E5">
					<td class="search_td" align="right">
						<div class="search_number">${status_p.count}</div>
					</td>
					<td class="field_td" align="left">${list_p.KEYWORD}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="search_div" id="recent">
		<table class="search_tb">
			<c:forEach items="${search_log_recent}" var="list_r" varStatus="status_r">
				<tr class="search_tr" style="border-bottom: 1px solid #E5E5E5">
					<td class="search_td" align="right">
						<div class="search_number">${status_r.count}</div>
					</td>
					<td class="field_td" align="left">${list_r.KEYWORD}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<div id="club_list_search_result">
	<c:forEach items="${search_club_list}" var="list">
		<div class="content" id="${list.CLUB_CODE}">
			<img class="content_img" src="${list.MAIN_PIC}" onerror="this.src='<c:url value="/resources/images/club/${list.SPORTS_NAME}2.jpg" />'">
			<div class="content_left">
				<div class="club_name">${list.CLUB_NAME}</div>
				<div class="club_detail">
				<img src="../resources/images/icon_운동장소_small.png">${list.SI} &gt; ${list.GU} &nbsp; 
				<img src="../resources/images/icon_종류선택_small.png">${list.CLUB_TYPE_NAME} &nbsp; 
				<img src="../resources/images/icon_포인트_small.png">${list.ACTIVE_POINTS}</div>
			</div>
		</div>
	</c:forEach>
</div>
<div id="list_tail"></div>

<script>
	var load_flag = 0;
	var page = 0;
	$(function() {
		resize_club_search();
		change_tab("popular", "recent");
		$(window).resize(function() {
			resize_club_search();
		});
		$(window).scroll(function() {
			load_more();
		});
		$("#search .search_log_tab_btn").click(function() {
			var id_activate = $(this).attr("id");
			var id_deactivate = $(this).siblings().attr("id");
			change_tab(id_activate,id_deactivate);
		});
		$(".header#search_header .remover").click(function() {
			location.href="./club_list_search.do";
		});
		$(".header#search_header .search_frame").keydown(function(e) {
			if(e.keyCode == 13){
				var input_value = $(this).val();
				if(input_value == null || input_value == ""){
					alert("검색어를 입력해주세요.");
					return;
				}
				ajax_add_log_search(input_value, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var result = jsonObj.result;
					if(result == 1){
						location.href="./club_list_search.do?CLUB_NAME="+input_value;
					}
					else{
						alert("오류!");
					}
				});
			}
		});
		$("#search .search_tr").click(function() {
			location.href="./club_list_search.do?CLUB_NAME="+$(this).children(".field_td").html();
		});
		$(".header#search_header .example_switch").click(function() {
			if($("#search").css("display") == "none"){
				$("#search").css("display","block");
				$(".header#search_header .example_switch").attr("src","<c:url value='/resources/images/icon_up.png'/>");
			}
			else{
				$("#search").css("display","none");
				$(".header#search_header .example_switch").attr("src","<c:url value='/resources/images/icon_down.png'/>");
			}
		});
		$("#club_list_search_result .content").click(function() {
			var club_code = $(this).attr("id");
			select_club(club_code);
		});
	});
	function resize_club_search() {
		//console.log("!");
		//$(".header#search_header .input_title").width($(window).width() - $(".header#search_header .left_btn").width() - $(".header#search_header .right_btn").width());
		$(".header#search_header .search_frame").width($(window).width()*3/5-40);
	}
	function change_tab(activate, deactivate){
		$("#search .search_log_tab_span#"+activate).css({
			"color":"#008ae8",
			"opacity":"1"
		});
		$("#search .search_log_tab_underline#"+activate).css("background-color","#008ae8");
		$("#search .search_div#"+activate).css("display","block");
		
		$("#search .search_log_tab_span#"+deactivate).css({
			"color":"#000000",
			"opacity":"0.54"
		});
		$("#search .search_log_tab_underline#"+deactivate).css("background-color","#ffffff");
		$("#search .search_div#"+deactivate).css("display","none");
	}
	function select_club(club_code) {
		location.href = "club_detail.do?club_code="+club_code;
	}
	function load_more(){
		if(load_flag == 0 && $("#list_tail").offset().top-240 < $(window).scrollTop() + $(window).height()){
			load_flag = 1;
			page += 1;
			console.log("load_flag : "+load_flag+"\npage : "+page);
			ajax_club_list_search_more(page, "${param.CLUB_NAME}", function(json) {
				var jsonObj = JSON.parse(JSON.stringify(json));
				var foramt = "";
				jsonObj.forEach(function(element) {
					console.log(element);
					format = 	"<div class='content' id='"+element.club_CODE+"'>"
							+		"<img class='content_img' src='"+element.main_PIC+"' onerror='this.src=\"<c:url value='/resources/images/default-thumbnail.jpg' />\"'>"
							+		"<div class='content_left'>"
							+			"<div class='club_name'>"+element.club_NAME+"</div>"
							+			"<div class='club_detail'>"+element.si+" &gt; "+element.gu+" &nbsp; "+element.active_POINTS+"</div>"
							+		"</div>"
							+	"</div>";
					$("#club_list_search_result").append(format);
				});
				load_flag = 0;
				$(".content").on("click", function() {
					var club_code = $(this).attr("id");
					select_club(club_code);
				});
			});
		}
	}
</script>
<%@ include file="../common/footer.jsp" %>