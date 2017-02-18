<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<link href="<c:url value='/resources/css/club_detail_admin_inquiry.css?ver=2'/>" rel="stylesheet">
<body>
<c:if test="${ClubInquiryView.IS_DELETED eq 1}">
	<script>
		alert("삭제된 게시글입니다.");
		location.href = "./club_admin_inquiry.do?club_code=${param.club_code}&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top=${param.scroll_top}";
	</script>
</c:if>
<div id="club_admin_inquiry">
	<div class="header">
		<div class="title">
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					<span id="page_name">문의글</span>
				</c:when>
				<c:when test="${IS_FED eq 1}">
					<span id="page_name" class="fed">문의글</span>
				</c:when>
			</c:choose>
		</div>
		<div class="left_btn">
			<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png"/>">
		</div>
		<script>
			$(".top_button#back").click(function() {
				//location.href = "./club_admin_inquiry.do?club_code=${param.club_code}&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top=${param.scroll_top}";
				history.back();
			});
		</script>
	</div>
	<div class="line"></div>
	<div class="header_content">
		<div class="header_inquiry_type">
			<c:choose>
				<c:when test="${ClubInquiryView.INQUIRY_TYPE eq 0}"><span class="header_inquiry_type_span" id="join">가입문의</span></c:when>
				<c:when test="${ClubInquiryView.INQUIRY_TYPE eq 1}"><span class="header_inquiry_type_span" id="match">매칭문의</span></c:when>
				<c:when test="${ClubInquiryView.INQUIRY_TYPE eq 2}"><span class="header_inquiry_type_span" id="etc">기타문의</span></c:when>
			</c:choose>
		</div>
		<div class="header_title">
			<span id="header_title_span">${ClubInquiryView.TITLE}</span>
		</div>
		<div class="header_writer_info" onclick="location.href='../myprofile/user_info.do?user_id=${ClubInquiryView.WRITE_USER}';">
			<div class="header_writer_pic">
				<img id="header_writer_pic_img" src="${ClubInquiryView.PROFILE}" onerror="this.src='../resources/images/icon_프로필사진(공백).png'">
			</div>
			<div class="header_writer_rest">
				<div class="header_writer_name">
					<span id="header_writer_name_span">${ClubInquiryView.USER_NAME}</span>
				</div>
				<div class="header_writer_datetime">
					<span id="header_writer_date_span">${ClubInquiryView.FORMATED_WRITE_DATE}</span>
					<span id="header_writer_time_span">${ClubInquiryView.FORMATED_WRITE_TIME}</span>
				</div>
			</div>
		</div>
	</div>
	<div class="lineSmall"></div>
	<div class="main_content" style="min-height: 300px;">
		<span id="main_content_span">${ClubInquiryView.CONTENT}</span>
	</div>
	<div class="response_button_wrapper">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<div class="response_button">답변하기</div>
				<script>
					$(".response_button").click(function() {
						location.href="./club_admin_inquiry_write.do?club_code=${param.club_code}&inquiry_id=${param.inquiry_id}&mode=${param.mode}&inquiry_type=${param.inquiry_type}&scroll_top=${param.scroll_top}";
					});
				</script>
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<div class="response_button fed">답변하기</div>
				<script>
					$(".response_button").click(function() {
						location.href="./fed_admin_inquiry_write.do?FED_CODE=${param.FED_CODE}&INQUIRY_ID=${param.INQUIRY_ID}";
					});
				</script>
			</c:when>
		</c:choose>
	</div>
	<script>
		$(function() {
			resize();
		});
		$(window).resize(function() {
			resize();
		});
		function resize() {
			$("#club_admin_inquiry .rest_container").css("width",parseFloat($("#club_admin_inquiry .inquiry_unit").css("width"))-83);
		}
	</script>
</div>