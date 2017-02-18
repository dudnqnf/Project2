<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<link href="<c:url value='/resources/css/zzim_locker.css?v=1'/>" rel="stylesheet">

<div class="header">
	<div class="title">보관함 보기</div>
	<div class="left_btn" onclick="history.back();"><img src="../resources/images/icon_back.png"></div>
	<div class="right_btn"></div>
</div>


<div id="zzim_locker" >
	<div class="top"><div class="t">전체 보관함 <span class="contents_num">${zzim.size()}</span></div></div>
	<div class=contents_container>
		<c:forEach items="${zzim}" var="list">
			<c:choose>
			<c:when test="${list.CATEGORY == 'ALBUMZZIM'}">
				<a onclick="goto_album('${list.CLUB_CODE}','${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_album.png"></div>
						<div class="title">
							<span style="color:#fbc04f">사진글</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			<c:when test="${list.CATEGORY == 'BOARDZZIM'}">
				<a onclick="goto_board('${list.CLUB_CODE}','${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_board.png"></div>
						<div class="title">
							<span style="color:#fbc04f">게시글</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			<c:when test="${list.CATEGORY == 'CLUBZZIM'}">
				<a onclick="goto_club('${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_club.png"></div>
						<div class="title">
							<span style="color:#008ae8">동호회</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			<c:when test="${list.CATEGORY == 'EVENTZZIM'}">
				<a onclick="goto_event('${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_event.png"></div>
						<div class="title">
							<span style="color:#55c4cb">스포츠 컨텐츠</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			<c:when test="${list.CATEGORY == 'FACILITYZZIM'}">
				<a onclick="goto_facility('${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_facility.png"></div>
						<div class="title">
							<span style="color:#ef65a3">체육시설</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			<c:when test="${list.CATEGORY == 'NEWSZZIM'}">
				<a onclick="goto_news('${list.CODE}')">
					<div class="content">
						<div class="image"><img src="../resources/images/zzim_news.png"></div>
						<div class="title">
							<span style="color:#55c4cb">대회소식</span>
							<div class="t">${list.TITLE}</div>
						</div>
					</div>
				</a>
			</c:when>
			</c:choose>
		</c:forEach>
	</div>
</div>

<script>
	function goto_album(club_code, code){
		location.replace("../club/album.do?club_code="+club_code+"&album_code="+code+"&replace=zzim");
	}
	function goto_board(club_code, code){
		location.replace("../club/club_detail_board_view.do?club_code="+club_code+"&mode=board&board_id="+code+"&replace=zzim");
	}
	function goto_club(code){
		location.replace("../club/club_detail.do?club_code="+code+"&replace=zzim");
	}
	function goto_event(code){
		location.replace("../info/info_contentviewer.do?EVENT_CODE="+code+"&replace=zzim");
	}
	function goto_facility(code){
		location.replace("../info/info_mapviewer.do?FACILITY_CODE="+code+"&replace=zzim");
	}
	function goto_news(code){
		location.replace("../info/info_newsviewer.do?NEWS_CODE="+code+"&replace=zzim");
	}
</script>

<%@ include file="../common/backeventjs.jsp" %>
