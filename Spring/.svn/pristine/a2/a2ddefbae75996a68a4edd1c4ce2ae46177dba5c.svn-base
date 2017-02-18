<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<div class="header">
	<div class="title_img"><img src="<c:url value="/resources/images/홈로고.png" />" /></div>
	<div class="left_btn">
		<img class="btn_image" src="<c:url value="/resources/images/icon_alarm.png" />" />
		<c:if test="${alarm_count gt 0}">
			<div id="alarm_count_container">
				<c:choose>
					<c:when test="${alarm_count lt 10}">
						<div id="alarm_count">${alarm_count}</div>
					</c:when>
					<c:otherwise>
						<div id="alarm_count">9+</div>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
	</div>
<%-- 	<div class="right_btn"><img class="btn_image" src="<c:url value="/resources/images/icon_검색.png" />" onclick="location.href='./search.do'"/></div> --%>
</div>
<script>
	$(".left_btn").click(function() {
		location.replace("alarm.do?replace=home");
	});
</script>
<div id="ad_container">
	<img src="../resources/images/03_홈-배너1.png">
</div>
<div class="club_info_wrapper" id="recommended_club_info_wrapper">
	<c:choose>
		<c:when test="${USER_INFO.LOCATION_SI ne '서울특별시'}">
        	<div class="club_info_image_container"><img class="club_info_image" src="<c:url value="/resources/images/img_noise.jpg" />" /></div>
			<div class="club_info_blind black_blind"></div>
			<div class="club_info_icon_container"><span class="club_info_icon">동호회</span></div>
			<div class="club_info_location_container"></div>
			<div class="club_info_phrase_container"><span class="club_info_phrase"></br>죄송합니다</br>서울 외 다른 지역은</br>현재 서비스 준비중입니다.</span></div>
        </c:when>
		<c:when test="${recommended_club_flag eq 0}">
			<div class="club_info_image_container"><img class="club_info_image" src="${recommended_club.MAIN_PIC}" onError="this.src='<c:url value="/resources/images/club/${recommended_club.SPORTS_NAME}2.jpg" />'" /></div>
			<div class="club_info_blind black_blind"></div>
			<div class="club_info_icon_container"><span class="club_info_icon">동호회</span></div>
			<div class="club_info_location_container"><span class="club_info_location">${recommended_club.SI} > ${recommended_club.GU}</span></div>
			<div class="club_info_phrase_container"><span class="club_info_phrase">이 동호회에서 함께</br>운동해보는 건 어때요?</span></div>
			<div class="club_info_title_container"><span class="club_info_title">${recommended_club.CLUB_NAME}</span></div>
			<input id="recommended_club_code" type="hidden" value="${recommended_club.CLUB_CODE}">
		</c:when>
		<c:when test="${recommended_club_flag eq 1}">
			<div>관심 종목을 선택하지 않았습니다.</div>
		</c:when>
		<c:when test="${recommended_club_flag eq 2}">
			<div class="club_info_image_container"><img class="club_info_image" src="<c:url value="/resources/images/img_noise.jpg" />" /></div>
			<div class="club_info_blind black_blind"></div>
			<div class="club_info_icon_container"><span class="club_info_icon">동호회</span></div>
			<div class="club_info_location_container"></div>
			<div class="club_info_phrase_container"><span class="club_info_phrase">회원님의 주변에 관심종목에</br>해당하는 동호회가 없습니다.</span></div>
			<div class="club_info_title_container"><span class="club_info_title">동호회를 개설해보는 건 어떨까요?</span></div>
		</c:when>
	</c:choose>
</div>
<!--<div class="club_info_wrapper" id="best_club_info_wrapper">
	<c:choose>
		<c:when test="${best_club_flag eq 0}">
			<div class="club_info_image_container"><img class="club_info_image" src="<c:url value="${best_club.MAIN_PIC}" />" /></div>
			<div class="club_info_blind blue_blind"></div>
			<div class="club_info_icon_container"><span class="club_info_icon">동호회</span></div>
			<div class="club_info_location_container"><span class="club_info_location">${best_club.SI} > ${best_club.GU}</span></div>
			<div class="club_info_phrase_container"><span class="club_info_phrase">우리동네 최강 동호회는</br>어디일까요?</span></div>
			<div class="club_info_title_container"><span class="club_info_title">${best_club.CLUB_NAME}</span></div>
			<input id="best_club_code" type="hidden" value="${best_club.CLUB_CODE}">
		</c:when>
		<c:when test="${best_club_flag eq 1}">
			<div class="club_info_image_container"><img class="club_info_image" src="" /></div>
			<div class="club_info_blind blue_blind"></div>
			<div class="club_info_icon_container"></div>
			<div class="club_info_location_container"></div>
			<div class="club_info_phrase_container"><span class="club_info_phrase">회원님의 주변에 관심종목에</br>해당하는 동호회가 없습니다.</span></div>
			<div class="club_info_title_container"><span class="club_info_title">동호회를 개설해보는 건 어떨까요?</span></div>
		</c:when>
	</c:choose>
</div>-->
<div id="news_list_wrapper">
	<div id="news_header_wrapper">
		<div id="news_header_title_container"><span id="news_header_title">대회 소식</span></div>
		<div id="news_header_phrase_container"><span id="news_header_phrase"><b>${USER_NAME}</b>님이 관심있어하는 종목 소식입니다!</span></div>
	</div>
	<c:choose>
		<c:when test="${empty news_list}">
			<div id="text_empty_news_container"><span id="text_empty_news">관심종목과 관련된</br>대회소식이 등록되어있지 않습니다.</span></div>
		</c:when>
		<c:otherwise>
			<div id="news_list_container">
				<c:forEach items="${news_list}" var="news_list">
					<div class="news_unit_wrapper">
						<span class="news_title">${news_list.NEWS_NAME}</span>
						<img class="right_arrow_btn" src="<c:url value="/resources/images/icon_detail.png" />"/>
						<input class="news_code" type="hidden" value="${news_list.NEWS_CODE}">
					</div>
					<div class="line"></div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<div id="facility_wrapper">
	<c:choose>
		<c:when test="${USER_INFO.LOCATION_SI ne '서울특별시'}">
        	<div class="facility_image_container"><img class="facility_image" src="<c:url value="/resources/images/img_noise.jpg" />" /></div>
			<div class="facility_blind black_blind"></div>
			<div class="facility_icon_container"><span class="facility_icon">시설</span></div>
			<div class="facility_phrase_container"><span class="facility_phrase"></br>죄송합니다</br>서울 외 다른 지역은</br>현재 서비스 준비중입니다.</span></div>
        </c:when>
		<c:otherwise>
			<div id="swiper_wrapper">
				<div class="swiper-container">
			        <div class="swiper-wrapper">
	        			<c:forEach items="${facility_list}" var="facility_list">
	        				<div class="swiper-slide facility_swiper">
							<div class="facility_image_container"><img class="facility_image" src="${facility_list.FACILITY_IMG}" onError="this.src='<c:url value="/resources/images/Info/facility/${facility_list.NAME}.jpg" />'" /></div>
							<div class="facility_blind black_blind"></div>
							<div class="facility_icon_container"><span class="facility_icon">시설</span></div>
							<div class="facility_location_container"><span class="facility_location">${facility_list.SI} > ${facility_list.GU}</span></div>
							<div class="facility_phrase_container"><span class="facility_phrase">${facility_list.PHRASE}</span></div>
							<div class="facility_title_container"><span class="facility_title">${facility_list.FACILITY_NAME}</span></div>
							<input class="facility_code" type="hidden" value="${facility_list.FACILITY_CODE}">
	        				</div>
	           			</c:forEach>
			        </div>
			        <!-- Add Pagination -->
			        <div class="swiper-pagination"></div>
			        <!-- Add Arrows -->
			        <div class="swiper-button-next swiper-button-white"></div>
			        <div class="swiper-button-prev swiper-button-white"></div>
		        </div>
			</div>
       	</c:otherwise>
	</c:choose>
</div>
<!--<div id="event_info_wrapper">
	<div id="event_header_wrapper">
		<span id="event_header_icon">체육시설</span>
		<span id="event_header_text">${USER_NAME}님 주위에 있는 체육시설 정보입니다.</span>
	</div>
	<div id="event_list_container" class="swiper-container">
        <div class="swiper-wrapper">
        	<c:forEach items="${facility_list}" var="facility_list">
            	<div class="event_unit_container swiper-slide">
            		<div class="event_unit_wrapper">
            			<div class="event_unit_image_container">
            				<img class="event_unit_image" src="<c:url value="/resources/upload/home/facility/${facility_list.FACILITY_IMG}" />">
            			</div>
            		</div>
            		<input class="facility_code" type="hidden" value="${facility_list.FACILITY_CODE}" />
            	</div>
            </c:forEach>
        </div>
    </div>
</div>-->
<div id="recommended_facility_info_wrapper">
	<div id="recommended_facility_info_image_container">
		<img id="recommended_facility_info_image" src="<c:url value="/resources/images/home/event/${recommended_event.HOME_PIC}" />" />
	</div>
	<div class="recommended_facility_info_blind black_blind"></div>
	<div id="recommended_facility_info_top_icon_container">
		<span id="recommended_facility_info_top_icon">컨텐츠</span>
	</div>
	<div id="recommended_facility_info_phrase_container">
		<span id="recommended_facility_info_phrase">${recommended_event.EVENT_NAME}</span>
	</div>
	<div id="recommended_facility_info_bottom_icon_container">
		<span id="recommended_facility_info_bottom_icon">컨텐츠 보러가기</span>
	</div>
	<input class="event_code" type="hidden" value="${recommended_event.EVENT_CODE}" />
</div>
<div id="tail"></div>
<script>
	/*var swiper = new Swiper('.swiper-container', {
        slidesPerView: 1.225,
        centeredSlides: true,
	    spaceBetween: 15
	});*/
	resize();
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 1,
        pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev'
    });
	$(function() {
		resize();
	});
	$("#recommended_club_info_wrapper").click(function(){
		<c:choose>
			<c:when test="${USER_INFO.LOCATION_SI ne '서울특별시'}">
		    </c:when>
			<c:when test="${recommended_club_flag eq 0}">
				location.href="../club/club_detail.do?replace=home&club_code="+$("#recommended_club_code").val();
			</c:when>
			<c:when test="${recommended_club_flag eq 2}">
				location.href="../club/create_club.do?replace=home";
			</c:when>
		</c:choose>
	});
	$("#best_club_info_wrapper").click(function(){
		<c:choose>
			<c:when test="${best_club_flag eq 0}">
				location.href="../club/club_detail.do?club_code="+$("#best_club_code").val();
			</c:when>
			<c:when test="${best_club_flag eq 1}">
				location.href="../club/create_club.do";
			</c:when>
		</c:choose>
	});
	$(".news_unit_wrapper").click(function() {
		location.href="../info/info_newsviewer.do?NEWS_CODE="+$(this).find("input").val();
	});
	$(".event_unit_container").click(function() {
		location.href="../info/info_mapviewer.do?FACILITY_CODE="+$(this).find("input").val();
	});
	$("#recommended_facility_info_wrapper").click(function(){
		location.href="../info/info_contentviewer.do?EVENT_CODE="+$(this).find("input").val();
	});
	$(".facility_swiper").click(function(){
		location.href="../info/info_mapviewer.do?FACILITY_CODE="+$(this).find("input").val();
	});
	function resize(){
		$(".club_info_wrapper").css("height",$(window).width()*60/100);
		$(".club_info_image_container").css("height",$(window).width()*60/100);
		$(".club_info_blind").css("height",$(window).width()*60/100);
		$(".line").css("height",$(window).width()/400);
		$(".club_info_icon_container").css("height",$(window).width()*6/100);
		$(".club_info_icon_container").css("padding-top",$(window).width()*5/100);
		$(".club_info_icon").css("font-size",$(window).width()*2/100+"pt");
		$(".club_info_icon").css("padding-top",$(window).width()*7/1000);
		$(".club_info_icon").css("padding-bottom",$(window).width()*7/1000);
		$(".club_info_icon").css("padding-left",$(window).width()*4/100);
		$(".club_info_icon").css("padding-right",$(window).width()*4/100);
		$(".club_info_location_container").css("padding-top",$(window).width()*1.39/100);
		$(".club_info_location").css("line-height",$(window).width()*2/100+"pt");
		$(".club_info_location").css("font-size",$(window).width()*2/100+"pt");
		$(".club_info_phrase").css("line-height",$(window).width()*5/100+"pt");
		$(".club_info_phrase").css("font-size",$(window).width()*4/100+"pt");
		$(".club_info_phrase").css("padding-top",$(window).width()*4.63/100);
		$(".club_info_title_container").css("padding-top",$(window).width()*1.39/100);
		$(".club_info_title").css("height",$(window).width()*9.7/100);
		$(".club_info_title").css("border-radius", $(window).width()*4.85/100);
		$(".club_info_title").css("line-height",$(window).width()*7/100+"pt");
		$(".club_info_title").css("font-size",$(window).width()*3/100+"pt");
		//$(".club_info_title").css("margin-left",$(window).width()*16.665/100);
		$(".club_info_title").css("margin-top",$(window).width()*4.63/100);
		
		$("#news_header_wrapper").css("height",$(window).width()*18.5/100);
		$("#news_header_wrapper").css("height",$(window).width()*18.5/100);
		$("#news_header_title_container").css("height",$(window).width()*7.41/100);
		$("#news_header_title_container").css("padding-top",$(window).width()*3/100);
		$("#news_header_title").css("font-size",$(window).width()*2/100+"pt");
		$("#news_header_title").css("line-height",$(window).width()*2/100+"pt");
		$("#news_header_title").css("padding-top",$(window).width()*0.83/100);
		$("#news_header_title").css("padding-bottom",$(window).width()*1.02/100);
		$("#news_header_title").css("padding-left",$(window).width()*1.3/100);
		$("#news_header_title").css("padding-right",$(window).width()*1.3/100);
		$("#news_header_phrase_container").css("height",$(window).width()*4.63/100);
		$("#news_header_phrase").css("font-size",$(window).width()*3.2/100+"pt");
		$("#news_header_phrase").css("line-height",$(window).width()*3.2/100+"pt");
		$("#news_list_container").css("height",$(window).width()*33.9/100);
		$(".news_unit_wrapper").css("height",$(window).width()*5/100);
		$(".news_unit_wrapper").css("padding-top",$(window).width()*3/100);
		$(".news_unit_wrapper").css("padding-bottom",$(window).width()*3/100);
		$(".news_unit_wrapper").css("padding-left","4%");
		$(".news_unit_wrapper").css("width","96%");
		$(".news_title").css("font-size",$(window).width()*2.7/100+"pt");
		$(".right_arrow_btn").css("right",$(window).width()*4.4/100);
		$(".right_arrow_btn").css("width",$(window).width()*4.4/100);
		$(".right_arrow_btn").css("height",$(window).width()*4.4/100);
		$(".right_arrow_btn").css("padding-top",$(window).width()*0.2/100);

		$("#swiper_wrapper").css("height",$(window).width()*60/100);
		$("#facility_wrapper").css("height",$(window).width()*60/100);
		$(".facility_image_container").css("height",$(window).width()*60/100);
		$(".facility_blind").css("height",$(window).width()*60/100);
		$(".facility_icon_container").css("height",$(window).width()*6/100);
		$(".facility_icon_container").css("padding-top",$(window).width()*5/100);
		$(".facility_icon").css("font-size",$(window).width()*2/100+"pt");
		$(".facility_icon").css("padding-top",$(window).width()*7/1000);
		$(".facility_icon").css("padding-bottom",$(window).width()*7/1000);
		$(".facility_icon").css("padding-left",$(window).width()*4/100);
		$(".facility_icon").css("padding-right",$(window).width()*4/100);
		$(".facility_location_container").css("padding-top",$(window).width()*1.39/100);
		$(".facility_location").css("line-height",$(window).width()*2/100+"pt");
		$(".facility_location").css("font-size",$(window).width()*2/100+"pt");
		$(".facility_phrase").css("line-height",$(window).width()*5/100+"pt");
		$(".facility_phrase").css("font-size",$(window).width()*3.6/100+"pt");
		$(".facility_phrase").css("padding-top",$(window).width()*4.63/100);
		$(".facility_title_container").css("padding-top",$(window).width()*1.39/100);
		$(".facility_title").css("height",$(window).width()*9.7/100);
		$(".facility_title").css("border-radius", $(window).width()*4.85/100);
		$(".facility_title").css("line-height",$(window).width()*7/100+"pt");
		$(".facility_title").css("font-size",$(window).width()*3/100+"pt");
		$(".facility_title").css("margin-top",$(window).width()*4.63/100);
		
		/*$("#event_info_wrapper").css("height",$(window).width()*43/100);
		$("#event_header_wrapper").css("height",$(window).width()*8.97/100);
		$("#event_header_wrapper").css("padding-top",$(window).width()*2.6/100);
		$("#event_header_wrapper").css("padding-left",$(window).width()*5/100);
		$("#event_header_icon").css("line-height",$(window).width()*1.5/100+"pt");
		$("#event_header_icon").css("font-size",$(window).width()*1.5/100+"pt");
		$("#event_header_icon").css("padding-top",$(window).width()*1.39/100);
		$("#event_header_icon").css("padding-bottom",$(window).width()*1.39/100);
		$("#event_header_icon").css("padding-left",$(window).width()*2.2/100);
		$("#event_header_icon").css("padding-right",$(window).width()*2.2/100);
		$("#event_header_text").css("font-size",$(window).width()*2.8/100+"pt");
		$("#event_header_text").css("line-height",$(window).width()*2.8/100+"pt");
		$(".swiper-container").css("height",$(window).width()*29.58/100);
		$(".swiper-container").css("padding-bottom",$(window).width()*1.85/100);
		$(".event_unit_wrapper").css("height",$(window).width()*29.63/100);*/
		
		$("#recommended_facility_info_wrapper").css("height",$(window).width()*66/100);
		$("#recommended_facility_info_image_container").css("height",$(window).width()*66/100);
		$(".recommended_facility_info_blind").css("height",$(window).width()*66/100);
		$("#recommended_facility_info_top_icon_container").css("height",$(window).width()*6/100);
		$("#recommended_facility_info_top_icon_container").css("padding-top",$(window).width()*5/100);
		$("#recommended_facility_info_top_icon").css("font-size",$(window).width()*2/100+"pt");
		$("#recommended_facility_info_top_icon").css("padding-top",$(window).width()*7/1000);
		$("#recommended_facility_info_top_icon").css("padding-bottom",$(window).width()*7/1000);
		$("#recommended_facility_info_top_icon").css("padding-left",$(window).width()*4/100);
		$("#recommended_facility_info_top_icon").css("padding-right",$(window).width()*4/100);
		$("#recommended_facility_info_phrase_container").css("height",$(window).width()*12.98/100);
		$("#recommended_facility_info_phrase_container").css("padding-top",$(window).width()*3.8/100);
		$("#recommended_facility_info_phrase").css("font-size",$(window).width()*4/100+"pt");
		$("#recommended_facility_info_phrase").css("line-height",$(window).width()*7/100+"pt");
		$("#recommended_facility_info_bottom_icon_container").css("height",$(window).width()*8.89/100);
		$("#recommended_facility_info_bottom_icon_container").css("padding-top",$(window).width()*23/100);
		$("#recommended_facility_info_bottom_icon").css("font-size",$(window).width()*3/100+"pt");
		$("#recommended_facility_info_bottom_icon").css("line-height",$(window).width()*3/100+"pt");
		$("#recommended_facility_info_bottom_icon").css("padding-top",$(window).width()*2.22/100);
		$("#recommended_facility_info_bottom_icon").css("padding-bottom",$(window).width()*2.22/100);
		$("#recommended_facility_info_bottom_icon").css("padding-left",$(window).width()*2.69/100);
		$("#recommended_facility_info_bottom_icon").css("padding-right",$(window).width()*2.69/100);
		$("#recommended_facility_info_bottom_icon").css("-moz-border-radius",$(window).width()*6.665/100);
		$("#recommended_facility_info_bottom_icon").css("-webkit-border-radius",$(window).width()*6.665/100);
		$("#recommended_facility_info_bottom_icon").css("-khtml-border-radius",$(window).width()*6.665/100);
		$("#recommended_facility_info_bottom_icon").css("border-radius",$(window).width()*6.665/100);
	}
</script>
<%@ include file="../common/backeventjs.jsp" %>
<%@ include file="../common/index_footer.jsp" %>
