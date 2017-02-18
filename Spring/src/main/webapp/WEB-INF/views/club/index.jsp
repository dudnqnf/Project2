<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<div class="header">
	<div class="title">
		종목 카테고리
	</div>
</div>

<div id=category >
	<div class="category_ball"><img class="category_img" src="<c:url value="/resources/images/img_구기.jpg" />" /></div>
	<div class="category_racket"><img class="category_img" src="<c:url value="/resources/images/img_라켓.jpg" />" /></div>
	<div class="category_martial"><img class="category_img" src="<c:url value="/resources/images/img_무술.jpg" />" /></div>
	<div class="category_fitness"><img class="category_img" src="<c:url value="/resources/images/img_피트니스.jpg" />" /></div>
	<div class="category_etc"><img class="category_img" src="<c:url value="/resources/images/img_기타.jpg" />" /></div>
</div>
<script>
	function myFunction(msg){
		window.Android.categorySelect();
	}
	$(".category_ball").click(function() {
		location.replace("club_list.do?category=구기&replace=clubindex");
	});
	$(".category_racket").click(function() {
		location.replace("club_list.do?category=라켓&replace=clubindex");
	});
	$(".category_martial").click(function() {
		location.replace("club_list.do?category=무술&replace=clubindex");
	});
	$(".category_fitness").click(function() {
		location.replace("club_list.do?category=피트니스&replace=clubindex");
	});
	$(".category_etc").click(function() {
		location.replace("club_list.do?category=기타&replace=clubindex");
	});
</script>
<%@ include file="../common/backeventjs.jsp" %>
<%@ include file="../common/index_footer.jsp" %>