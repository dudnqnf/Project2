<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="modify_location">
	<div class="header" style="background-color: #008ae8">
		<div class="left_btn"><img src="../resources/images/icon_back_white.png" onclick="history.back(-1);"></div>
		<div class="title" style="color: #ffffff; background-color: #008ae8;">지역선택</div>
		<div class="right_btn"></div>
	</div>
	<c:forEach items="${LocationSI}" var="list">
	<div class="line_div" onclick="getGU('${list.SI}')">
		<div class="loc_name_div">${list.SI}</div>
		<div class="loc_next_div" align="right">
			<img src="../resources/images/icon_detail.png" style="height: 20px; width: 20px;"></div>
	</div>
	</c:forEach>
</div>

<script>
function getGU(si){
	/*if(si != "서울특별시"){
		alert("경기도 서비스 준비중입니다.");
		return;
	}*/
	ajax_getGU(si, function callback(json){
		var jsonObj = JSON.parse(JSON.stringify(json));
		var result = jsonObj.result;
		var value = jsonObj.value;
		
		if(result){
			$("#gu_container").html("");
			value.forEach(function(element){
				var obj = element;
				var ori = $("#gu_container").html();
				$("#gu_container").html(ori
					+	"<div class='gu_div' onclick='modify_location(\""+ si +"\",\""+ obj.gu +"\",\""+ obj.location_CODE +"\");'>"
					+	obj.gu
					+	"</div>"
				);
			});
			
			$("#modify_location_detail").css("display", "block");
			$("#modify_location").css("display", "none");
		} else {
			window.alert("실패");
		}
	});
}

function modify_location(si, gu, code){
	$("#input_location").val(si+" "+gu);
	$("#input_location").removeClass();
	$("#input_location").addClass(code);
	$("#modify_location_detail").css("display", "none");
	$("#profile_modify").css("display", "block");
}
</script>