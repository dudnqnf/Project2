<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<body>
<div class="header">
	<div class="left_btn">
		<img src="../resources/images/icon_back.png" onclick="history.back()">
	</div>
	<div class="title"><span id="page_name">동호회 폐쇄</span></div>
	<div class="right_btn">
	</div>
</div>

<div id="close_club">
	<div class="space1" >
		<table style="font-size: 11px; background-color: #eeeeee;">
			<tr height="70px" valign="middle">
				<td align="left">
					<div style="width: 92%; margin: 0 auto; padding-top: 13px; padding-bottom: 13px;">
					동호회 폐쇄를 위해서는 운영진 전체의 승인이 필요합니다.<br>
					이름 옆에 있는 아이콘이 전체 승인되면 자동으로 폐쇄됩니다.
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="check_close_club_div">
		<table class="check_close_club_tb">
			<c:forEach items="${managers}" var="list">
				<tr class="line">
					<td width="20%" align="right" style="padding-right: 15px;">
						<img src="${list.PROFILE}" onError="this.src='<c:url value="/resources/images/icon_프로필사진(공백).png" />';" style="height: 40px; width: 40px">
					<td width="55%" align="left" style="font-size: 14px">${list.USER_NAME}
					<c:if test="${user_id == list.USER_ID}">
						<span class="icon_me" style="color: #12a36d; padding-left: 6px">나</span>
						<input type="hidden" name="is_mine" class="is_mine" id="${list.USER_ID}" value="1">
					</c:if>
					<td width="25%" align="center">
					<c:choose>
						<c:when test="${list.AGREE_DELETE eq 0}">
							<div class="agree" style="height:28px;border-radius:15px;padding-top:4px;border-style:solid;border-width:1px;border-color:#979797;color:#979797;margin-right:20px;">비승인</div>
<!-- 							<img src="../resources/images/bt_비승인.png" style="height: 23px; width: 58px"> -->
						</c:when>
						<c:otherwise>
							<div class="disagree" style="height:28px;background:#008ae8;color:#fff;border-radius:15px;padding-top:4px;margin-right:20px;">승인</div>
<!-- 							<img src="../resources/images/bt_승인.png" style="height: 23px; width: 58px"> -->
						</c:otherwise>
					</c:choose>
			</c:forEach>
		</table>
		<script>
			$("#close_club .check_close_club_tb tr.line").click(function() {
				if($(this).find("input").val() == 1){
					ajax_club_agree_delete("${param.club_code}", "${user_id}", function(json) {
						var jsonObj = JSON.parse(JSON.stringify(json));
						var result = jsonObj.result;
						var lastAgree = false;
						if(result == 1){
							location.reload();
						}
						else if(result == 2){
							lastAgree = confirm("모두 폐쇄를 동의하였습니다.\n정말 동호회를 폐쇄하시겠습니까?");
							if(lastAgree == true){
								ajax_confirm_delete_club("${param.club_code}", function(json2){
									var jsonObj2 = JSON.parse(JSON.stringify(json2));
									var result2 = jsonObj2.result;
									if(result2 == 1){
										alert("동호회가 폐쇄되었습니다.");
										location.href="./club_list.do";
									}
									else{
										alert("오류B");
									}
								});
							}
							else{
								ajax_club_agree_delete("${param.club_code}", "${user_id}", function(json2) {
									var jsonObj2 = JSON.parse(JSON.stringify(json2));
									var result2 = jsonObj2.result;
									if(result2 == 1){
										alert("동호회 폐쇄가 취소되었습니다.");
										location.reload();
									}
									else{
										alert("오류C");
									}
								});
							}
						}
						else{
							alert("오류A");
						}
					});
				}
			});
		</script>
	</div>
</div>
<%@ include file="../common/backeventjs.jsp" %>
</body>