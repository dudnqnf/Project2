<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
		<style>
			html{
				width:100%;
				background:#979797;
			}
			body{
				margin:0px;
				padding:0px;
				width:100%;
			}
		</style>
	</head>
	<body>
	<img class="photo" src="<c:url value="/resources/images/Info/news/${param.picture}" />" onError="this.src='<c:url value="/resources/images/icon_blank_pic.png" />'" />
	<script>
		$(".photo").css("width", $(window).width()+"px");
	</script>
	</body>
</html>

<%@ include file="../common/backeventjs.jsp" %>