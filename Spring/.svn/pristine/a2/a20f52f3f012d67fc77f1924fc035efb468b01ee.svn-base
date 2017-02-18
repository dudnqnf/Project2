<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="eventResultContentsWrapper">
	<!--<c:forEach items="${result_event}" var="list_result_event">
		<div class="eventResultContent">
			<div class="eventResultImageContainer"><img class="eventResultImage" src='<c:url value="/resources/images/Info/event/thumbnail/${list_result_event.FRONT_PIC}" />'></div>
			<div class="eventResultTitleContainer"><span class="eventResultTitle">${list_result_event.EVENT_NAME}</span></div>
			<input type="hidden" class="id" value="${list_result_event.EVENT_CODE}">
		</div>
	</c:forEach>-->
</div>
<div id="tail"></div>
<script>
	var page_event;
	var load_flag_event;
	var event_page = ".contentContainer#event ";
	$(function() {
		page_event = -1;
		load_flag_event = 0;
		$(window).click(function() {
		});
		$(event_page+".eventResultContent").click(function () {
			clickResultContentEvent($(this));
		});
		event_scroll_loading();
		event_resize();
	});
	function clickResultContentEvent(target){
		var page_tag = "event";
		location.href = "info_contentviewer.do?replace=infolistevent&EVENT_CODE="+target.children("input").val()+"&PAGE_TAG="+page_tag;
	}
	function event_scroll_loading(){
		if((load_flag_event == 0 && $(event_page+"#tail").offset().top-200 < $(window).scrollTop() + $(window).height()) || page_event == -1){
			load_flag_event = 1;
			page_event += 1;
			ajax_info_get_event(page_event, "event", "", function(json) {
				var jsonObj = JSON.parse(JSON.stringify(json));
				var format = "";
				console.log(jsonObj);
				jsonObj.forEach(function(element) {
					format =	"<div class='eventResultContent'>"
							+		"<div class='eventResultImageContainer'><img class='eventResultImage' src=\"<c:url value='/resources/images/Info/event/thumbnail/"+element.front_PIC+"' />\" /></div>"
							+		"<div class='eventResultTitleContainer'>"
							+			"<span class='eventResultTitle'>"+removeBR(element.event_NAME)+"</span>"
							+		"</div>"
							+		"<input type='hidden' class='id' value='"+element.event_CODE+"'>"
							+	"</div>";
					$(event_page+"#eventResultContentsWrapper").append(format);
				});
				load_flag_event = 0;
				$(event_page+".eventResultContent").off("click");
				$(event_page+".eventResultContent").on("click", function() {
					clickResultContentEvent($(this));
				});
			});
			event_resize();
		}
	}
	function event_resize(){
		$(".eventResultImageContainer").height($(window).width()*33/100);
		$(".eventResultTitleContainer").height($(window).width()*11/100);
		$(".eventResultTitleContainer").css("font-size",$(window).width()*3.6/100+"px");
	}
</script>