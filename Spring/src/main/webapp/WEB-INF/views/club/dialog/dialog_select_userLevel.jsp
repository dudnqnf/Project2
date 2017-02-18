<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<c:url value='/resources/css/club_dialog.css?ver=3'/>" rel="stylesheet">
<script type="text/javascript" src="<c:url value='/resources/js/dialog.js'/>"></script>

<body>
<div id="select_level_dialog" class="dialog" style="height">
	<div class="content">
		<%
			// 실력레벨(1~10까지) 수정하기 별출력
			for (int j = 11; j >= 1; j--) {
				// 시작하는 디브 출력
				out.println("<div class='level_select_button level_select1_button' id='"+j+"s' style='position:inline-block'>");
				// 실력이 짝수일때 꽉찬별 (실력/2)개 출력 & 라디오버튼이미지 출력
				if (j == 11) {
					out.println("<span>선수출신</span>");
					out.println("<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>");
					out.println("<img class='btnImage_on' src='../resources/images/radio_checked.png'>");
				} else if((j % 2) == 0) {
					for (int k = 0; k < j/2; k++){
						out.println("<img class='img_levelStar' src='../resources/images/icon_star.png'>");
					}
					out.println("<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>");
					out.println("<img class='btnImage_on' src='../resources/images/radio_checked.png'>");
					//out.println("<input type='hidden' value='"+j+"' class='level'>");
				// 실력이 홀수일때 꽉찬별 (실력/2)개 출력 후 반쪽별 한개 출력 & 라디오버튼이미지 출력
				} else {
					for (int k = 0; k < j/2; k++){
						out.println("<img class='img_levelStar' src='../resources/images/icon_star.png'>");
					}
					out.println("<img class='img_levelStar' src='../resources/images/icon_half_star.png'>");
					out.println("<img class='btnImage_off' src='../resources/images/radio_unchecked.png'>");
					out.println("<img class='btnImage_on' src='../resources/images/radio_checked.png'>");
					//out.println("<input type='hidden' value='"+j+"' class='level'>");
				}
				// 끝나는 디브 출력
				out.println("</div>");
			}
		%>
	</div>
	<input type="hidden" name="isOpened" id="isOpened" value="0">
	<input type="hidden" class="input_value">
</div>

<script>
	var category;
	
	$(".level_select1_button").click(function() {
		var resultLevel = $(this).attr("id").split("s")[0];
		$(".level_select1_button").removeClass("selected");
		$(this).toggleClass("selected");
		$("#select_level_dialog .input_value").val(resultLevel);
		console.log("누른값 : "+$("#select_level_dialog .input_value").val());
		$(".level_select1_button .btnImage_on").css("display","none");
		$(".level_select1_button .btnImage_off").css("display","inline-block");
		$(".level_select1_button.selected .btnImage_off").css("display","none");
		$(".level_select1_button.selected .btnImage_on").css("display","inline-block");
		$("#select_level_dialog").css("display","none");
		$("#blurAll").css("display","none");
		$("#"+category+" .level").val(resultLevel);
		$("#"+category+" .level_value").empty();
		draw_star($("#"+category+" .level_value"), resultLevel);
		//$("#tedit_select1_input_wrapper .input_value").val($(this).find("input").val());
	});
	
	//초기화
	function open_select_level_dialog(flag){
		category = flag;
		$("#blurAll").css("display","block");
		$("#select_level_dialog").css("display","block");
		
		$("#select_level_dialog").css("width", $(window).width()*21/25);
		$("#select_level_dialog").css("height", "337px");
		$("#select_level_dialog").css("padding", "5px");
		$("#select_level_dialog").css("left", $(window).width()*2/25);
		$("#select_level_dialog").css("top", $(window).scrollTop() + $(window).height()*3/20);
		
		$("#blurAll").css("top", "0px");
		$("#blurAll").css("width", $(document).width());
		$("#blurAll").css("height", $(document).height());

		$(".level_select_button").not("#"+$(".category_tr#"+category+" .level").val()+"s").removeClass("selected");
		//$(".level_select_button").not("#3").removeClass("selected");
		$(".level_select_button#"+$(".category_tr#"+category+" .level").val()+"s").addClass("selected");
		//$(".level_select_button#3").addClass("selected");
		$(".level_select1_button .btnImage_on").css("display","none");
		$(".level_select1_button .btnImage_off").css("display","inline-block");
		$(".level_select1_button.selected .btnImage_off").css("display","none");
		$(".level_select1_button.selected .btnImage_on").css("display","inline-block");
	}
	
	function draw_star(target, level){
		var format = "";
		if(level == 11) {
			format = format + "<span>선수출신</span>";
		}else{
			for(var i = 0; i < (level-1)/2; i++){
				format = format + "<img class='img_levelStar' src='../resources/images/icon_star.png'>";
			}
			if(level%2 == 1){
				format = format + "<img class='img_levelStar' src='../resources/images/icon_half_star.png'>";
			}
		}
		target.append(format);
	}
</script>