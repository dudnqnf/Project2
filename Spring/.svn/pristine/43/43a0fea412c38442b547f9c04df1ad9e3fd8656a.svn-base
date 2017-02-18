<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
</head>
<body>
<c:choose>
	<c:when test="${param.page_tag eq 'news'}">
		<div class="header">
			<div class="left_btn"><img src="../resources/images/icon_back.png" onclick="history.back(-1);"></div>
			<div class="title">대회소식 검색</div>
			<div class="right_btn"></div>
		</div>
	</c:when>
	<c:when test="${param.page_tag eq 'facility'}">
		<div class="header">
			<div class="left_btn"><img src="../resources/images/icon_back.png" onclick="history.back(-1);"></div>
			<div class="title">체육시설 검색</div>
			<div class="right_btn"></div>
		</div>
	</c:when>
	<c:when test="${param.page_tag eq 'event'}">
		<div class="header">
			<div class="left_btn"><img src="../resources/images/icon_back.png" onclick="history.back(-1);"></div>
			<div class="title">컨텐츠 검색</div>
			<div class="right_btn"></div>
		</div>
	</c:when>
</c:choose>
<div id="search_bar">
	<img id="search_icon" src="<c:url value="/resources/images/icon_검색.png" />" >
	<input id="search_frame" type="text" name="search_frame" placeholder="검색어를 입력하세요" value="">
	<img id="remover" style="display:none;" src="<c:url value="/resources/images/icon_X.png" />" >
</div>
<c:choose>
	<c:when test="${param.page_tag eq 'news'}">
		<!-- 대회소식 검색의 VIEW -->
		<div id="resultContentsWrapper">
		</div>
	</c:when>
	
	<c:when test="${param.page_tag eq 'facility'}">
		<!-- 체육시설 검색의 VIEW -->
		<div id="facilityResultContentsWrapper">
		</div>
	</c:when>
	
	<c:when test="${param.page_tag eq 'event'}">
		<!-- 스포츠컨텐츠 검색의 VIEW -->
		<div id="eventResultContentsWrapper">
		</div>
	</c:when>
</c:choose>
<div id="tail"></div>
<script>
	var page_tag = "${param.page_tag}";
	var resultWrapperId = "";
	var keyword = "";
	var page = 0;
	var load_flag = 0;
	// 공통 스크립트
	switch(page_tag){
	case "news":
		resultWrapperId = "#resultContentsWrapper";
		break;
	case "facility":
		resultWrapperId = "#facilityResultContentsWrapper";
		break;
	case "event":
		resultWrapperId = "#eventResultContentsWrapper";
		break;
	}
	$("#back").click(function() {
		history.back();
	});
	$("#remover").click(function() {
		$(resultWrapperId).empty();
		keyword = "";
		$("#search_frame").val("");
		$("#remover").css("display","none");
	});
	$("#search_frame").keydown(function(e) {
		if(e.keyCode == 13){
			$(resultWrapperId).empty();
			keyword = $(this).val();
			$("#search_frame").html(keyword);
			$("#remover").css("display","");
			page = 0;
			load_data();
		}
	});
	$(window).scroll(function() {
		if(load_flag == 0 && $("#tail").offset().top-200 < $(window).scrollTop() + $(window).height() ){
			load_data();
		}
	});
	
	<c:choose>
		<c:when test="${param.page_tag eq 'news'}">
			// 대회소식 검색의 스크립트
			$("#title").html("대회소식 검색");
			function load_data(){
				load_flag = 1;
				ajax_info_get_news("all", "", "", "", "", page, "news", keyword, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var format = "";
					jsonObj.forEach(function(element) {
						format =	"<div class='resultContent'>"
								+		"<div class='resultImageContainer'>"
								+			"<img class='resultImage'  src=\"<c:url value='/resources/images/Info/news/"+element.front_PIC+"' />\" onerror='this.src=\"<c:url value="/resources/images/Info/news/default/" />"+element.name+".jpg\";'/>"
								+		"</div>"
								+		"<div class='resultTextWrapper'>"
								+			"<div class='resultTitleContainer'>"
								+				"<span class='resultTitle'>"+element.news_NAME+"</span>"
								+			"</div>"
								+			"<div class='resultDatetimeContainer'>"
								+				"<span class='resultDatetime'>대회날짜 : "+element.formatted_PLAN_DATE+"</span>"
								+			"</div>"
								+			"<div class='resultAddressContainer'>"
								+				"<img src='../resources/images/icon_location_gray.png'>"
								+				"<span class='resultAddress'>"+element.address+"</span>"
								+			"</div>"
								+		"</div>"
								+		"<input type='hidden' class='id' value='"+element.news_CODE+"'>"
								+	"</div>";
						$(resultWrapperId).append(format);
					});
					page += 1;
					load_flag = 0;
					$(".resultContent").off("click");
					$(".resultContent").on("click", function() {
						clickResultContentNews($(this));
					});
				});
				resize();
			}
			function clickResultContentNews(target){
				location.href="./info_newsviewer.do?NEWS_CODE="+target.children("input").val();
			}
		</c:when>
		
		<c:when test="${param.page_tag eq 'facility'}">
			// 체육시설 검색의 스크립트
			$("#title").html("체육시설 검색");
			function load_data(){
				load_flag = 1;
				ajax_info_get_facility("all", "", "", "", "", page, "facility", keyword, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var format = "";
					jsonObj.forEach(function(element) {
						format =	"<div class='facilityResultContent'>"
								+		"<div class='facilityResultImageContainer'>"
								+			"<img class='resultImage'  src=\"<c:url value='/resources/images/Info/facility/"+element.name+".jpg' />\" />" 
								+		"</div>"
								+		"<div class='facilityResultTitleContainer' style='height:44px'>"
								+			"<span class='facilityResultTitle'>"+element.facility_NAME+"</span>"
								+		"</div>"
								+		"<input type='hidden' class='id' value='"+element.facility_CODE+"'>"
								+	"</div>";
						$(resultWrapperId).append(format);
					});
					page += 1;
					load_flag = 0;
					$(".facilityResultContent").off("click");
					$(".facilityResultContent").on("click", function() {
						clickResultContentFacility($(this));
					});
				});
				resize();
			}
			function clickResultContentFacility(target){
				location.href = "info_mapviewer.do?FACILITY_CODE="+target.children("input").val();
			}
		</c:when>
		
		<c:when test="${param.page_tag eq 'event'}">
			// 스포츠컨텐츠 검색의 스크립트
			$("#title").html("스포츠컨텐츠 검색");
			function load_data(){
				load_flag = 1;
				ajax_info_get_event(page, "event", keyword, function(json) {
					var jsonObj = JSON.parse(JSON.stringify(json));
					var format = "";
					console.log(jsonObj);
					jsonObj.forEach(function(element) {
						format =	"<div class='eventResultContent'>"
								+		"<div class='eventResultImageContainer'><img class='eventResultImage' src=\"<c:url value='/resources/images/Info/event/thumbnail/"+element.front_PIC+"' />\" /></div>"
								+		"<div class='eventResultTitleContainer' style='height:44px;'>"
								+			"<span class='eventResultTitle'>"+element.event_NAME+"</span>"
								+		"</div>"
								+		"<input type='hidden' class='id' value='"+element.event_CODE+"'>"
								+	"</div>";
						$(resultWrapperId).append(format);
					});
					page += 1;
					load_flag = 0;
					$(".eventResultContent").off("click");
					$(".eventResultContent").on("click", function() {
						clickResultContentEvent($(this));
					});
				});
				resize();
			}
			function clickResultContentEvent(target){
				var page_tag = "event";
				location.href = "info_contentviewer.do?EVENT_CODE="+target.children("input").val()+"&PAGE_TAG="+page_tag;
			}
		</c:when>
	</c:choose>
	function resize(){
		<c:choose>
			<c:when test="${param.page_tag eq 'news'}">
			</c:when>
			<c:when test="${param.page_tag eq 'facility'}">
				$(".facilityResultImageContainer").height($(window).width()*33/100);
				$(".facilityResultTitleContainer ").height($(window).width()*11/100);
			</c:when>
			<c:when test="${param.page_tag eq 'event'}">
				$(".eventResultImageContainer").height($(window).width()*33/100);
				$(".eventResultTitleContainer ").height($(window).width()*11/100);
			</c:when>
		</c:choose>
		/*if($("#tail").offset().top + $("#tail").height() < $(window).height() ){
			load_data();
		}*/
	}
</script>