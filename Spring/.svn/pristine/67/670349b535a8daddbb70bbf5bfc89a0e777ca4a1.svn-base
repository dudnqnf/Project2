<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/footer.css?v=2'/>" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/resources/js/jquery.js'/>"></script>
<div class="footer">
	<div class="tab" id="tab_home"><img src="../resources/images/tab_home.png"></div>
	<div class="tab" id="tab_club"><img src="../resources/images/tab_club.png"></div>
	<div class="tab" id="tab_info"><img src="../resources/images/tab_info.png"></div>
	<div class="tab" id="tab_myprofile"><img src="../resources/images/tab_myprofile.png"></div>
</div>
<script>
	var path = window.location.pathname;
	if(path.indexOf("home")!=-1){
		$("#tab_home").addClass("on");
		$("#tab_home img").attr("src", "../resources/images/tab_home_blue.png");
	}else if(path.indexOf("club")!=-1){
		$("#tab_club").addClass("on");
		$("#tab_club img").attr("src", "../resources/images/tab_club_blue.png");
	}else if(path.indexOf("info")!=-1){
		$("#tab_info").addClass("on");
		$("#tab_info img").attr("src", "../resources/images/tab_info_blue.png");
	}else if(path.indexOf("myprofile")!=-1){
		$("#tab_myprofile").addClass("on");
		$("#tab_myprofile img").attr("src", "../resources/images/tab_myprofile_blue.png");
	}
	$(".tab#tab_home").click(function() {
		location.replace("../home/index.do?branchhome=branchhome");
	});
	$(".tab#tab_club").click(function() {
		location.replace("../club/index.do?branchhome=branchhome");
	});
	$(".tab#tab_info").click(function() {
		location.replace("../info/index.do?branchhome=branchhome");
	});
	$(".tab#tab_myprofile").click(function() {
		location.replace("../myprofile/index.do?branchhome=branchhome");
	});
</script>

</body>
</html>