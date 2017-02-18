<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>

<body>
<div class="header">
	<div class="left_btn">
		<!-- <img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />" onclick="location.href='../club/club_detail.do?club_code=${param.club_code}'"> -->
		<img class="top_button" id="back" src="<c:url value="/resources/images/icon_back.png" />" onclick="history.back()">
	</div>
	<div class="title">
	<c:choose>
		<c:when test="${IS_FED eq 0}">
			<span id="page_name">회원관리</span>
		</c:when>
		<c:when test="${IS_FED eq 1}">
			<span id="page_name" class="fed">
				<c:choose>
					<c:when test="${IS_MEMBER eq 1}">동호회 관리</c:when>
					<c:when test="${IS_MANAGER eq 1}">운영진 관리</c:when>
				</c:choose>
			</span>
		</c:when>
	</c:choose>
	</div>
	<div class="right_btn">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				<img src="../resources/images/icon_회원추가.png" onclick="location.href='../club/club_user_add.do?club_code=${param.club_code}'">
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<c:choose>
					<c:when test="${IS_MEMBER eq 1}">
						<img src="../resources/images/icon_회원추가_운영진_연합회.png" onclick="location.href='../club/fed_member_add.do?FED_CODE=${param.FED_CODE}'">
					</c:when>
					<c:when test="${IS_MANAGER eq 1}">
						<img src="../resources/images/icon_회원추가_운영진_연합회.png" onclick="location.href='../club/fed_manager_add.do?FED_CODE=${param.FED_CODE}'">
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
	</div>
</div>

<div id="club_user">
	<div class="space1" align="center">
		<div class="space1_input" align="left">
			<img src="../resources/images/icon_clubSearch.png">
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					<input class="search_frame" type="text" name="search_frame" size="32" placeholder="동호회 내 회원을 검색하세요." style="width:80%">
				</c:when>
				<c:when test="${IS_FED eq 1}">
					<c:choose>
						<c:when test="${IS_MEMBER eq 1}">
							<input class="search_frame" type="text" name="search_frame" size="31" placeholder="연합회에 소속된 동호회를 검색하세요">
						</c:when>
						<c:when test="${IS_MANAGER eq 1}">
							<input class="search_frame" type="text" name="search_frame" size="31" placeholder="연합회 내 운영진을 검색하세요">
						</c:when>
					</c:choose>
				</c:when>
			</c:choose>
			<c:if test="${search_keyword ne NULL}">
				<script>
					$(".search_frame").val("${search_keyword}");
				</script>
			</c:if>
		</div>
	</div>
	<div class="space2">
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				동호회에 가입된 회원 목록입니다.</br>
				회원 이름 옆에 있는 아이콘을 누르시면, 회원등급이 변경됩니다. 운영진은 최대 6명까지 가능합니다.
			</c:when>
			<c:when test="${IS_FED eq 1}">
				<c:choose>
					<c:when test="${IS_MEMBER eq 1}">
						동호회에 가입된 회원 목록입니다. 회원 이름 옆에 있는 아이콘을</br>
						누르시면, 연합회에서 해당 동호회를 제외할 수 있습니다. 운영진은 최대 6명까지 가능합니다.
					</c:when>
					<c:when test="${IS_MANAGER eq 1}">
						연합회 운영진 목록입니다.</br>
						회원 이름 옆에 있는 아이콘을 누르면 운영진 등급이 제외됩니다. 운영진은 최대 6명까지 가능합니다.
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
	</div>
	
	
	<div class="list_div">
		<table class="list_tb">
			<c:choose>
				<c:when test="${IS_FED eq 0 || (IS_FED eq 1 && IS_MANAGER eq 1)}">
					<c:forEach items="${ClubUserInfo}" var="list">
						<tr class="list_tr">
							<td class="user_icon" width="20%" align="right" style="padding-right: 7px" onclick="location.href='../myprofile/user_info.do?user_id=${list.USER_ID}';">
								<img src="<c:url value="/resources/upload/user/profile/${list.PROFILE}" />" onerror="this.src='../resources/images/icon_프로필사진(공백).png'">
							</td>
							<td class="user_name" width="40%" onclick="location.href='../myprofile/user_info.do?user_id=${list.USER_ID}';">
								<div>${list.USER_NAME}</div>
								<div class="user_manager">
								<c:choose>
									<c:when test="${list.USER_LEVEL eq 2}">운영진</c:when>
								</c:choose>
								</div>
							</td>
					 		<td class="user_grade" width="15%">
					 			<div class="manager">등급변경</div>
					 			<input class="user_id" type="hidden" value="${list.USER_ID}" />
					 			<input class="user_level" type="hidden" value="${list.USER_LEVEL}" />
					 		<td class="user_out" width="15%">
							<c:if test="${list.USER_ID ne user_id}">
					 			<div class="member_out">퇴출하기</div>
				 			</c:if>
<%-- 				 			<c:if test="${list.USER_ID eq user_id}"> --%>
<!-- 				 				<td width="12%"> -->
<%-- 				 			</c:if> --%>
					</c:forEach>
				</c:when>
				<c:when test="${IS_FED eq 1 && IS_MEMBER eq 1}">
					<c:forEach items="${FedMemberInfo}" var="list">
						<tr class="list_tr">
							<td class="user_icon" width="18%" align="center">
								<img src="" onerror="this.src='../resources/images/icon_프로필사진(공백).png'">
							</td>
							<td class="user_name" width="52%">
								${list.CLUB_NAME}
							</td>
							<td width="18%" align="center">
							</td>
							<c:if test="${list.USER_ID ne user_id}">
								<td class="user_grade" width="12%" align="left">
						 			<img class="manager_on" src="../resources/images/icon_운영진_on.png">
						 			<input class="club_code" type="hidden" value="${list.CLUB_CODE}" />
								</td>
							</c:if>
							<c:if test="${list.USER_ID eq user_id}">
				 				<td width="12%" align="left">
				 			</c:if>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>
</div>
<script>
	$(".user_grade").click(function() {
		var td_user_grade = $(this);
		var list_tr = $(this).parent(".list_tr");
		var user_manager = $(list_tr.get(0)).find(".user_manager");
		var confirm_value = false;
		<c:choose>
			<c:when test="${IS_FED eq 0}">
				var club_code = "${param.club_code}";
				var user_id = td_user_grade.find(".user_id").val();
				var user_level = td_user_grade.find(".user_level").val();
				if(user_id == "${user_id}" && user_level == "2"){
					confirm_value = confirm("운영진의 권한을 상실합니다. 진행할까요?");
					if(confirm_value == false){
						return;
					}
				}
				ajax_change_club_user_level(club_code, user_id, user_level, function(json){
					var jsonObj = JSON.parse(JSON.stringify(json));
					if(jsonObj.user_LEVEL == "1"){
						user_manager.html("");
						td_user_grade.find(".user_level").val("1");
					}
					else if(jsonObj.user_LEVEL == "2"){
						user_manager.html("운영진");
						td_user_grade.find(".user_level").val("2");
					}
					else if(jsonObj.user_LEVEL == "-1"){
						alert("6명 초과");
					}
				});
				if(user_id == "${user_id}" && user_level == "2"){
					history.back();
				}
			</c:when>
			<c:when test="${IS_FED eq 1}">
				var fed_code = "${param.FED_CODE}";
				<c:choose>
					<c:when test="${IS_MANAGER eq 1}">
						var user_id = td_user_grade.find(".user_id").val();
						ajax_drop_fed_manager(fed_code, user_id, function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1){
								td_user_grade.parent().remove();
							}
						});
					</c:when>
					<c:when test="${IS_MEMBER eq 1}">
						var club_code = td_user_grade.find(".club_code").val();
						ajax_drop_fed_member(fed_code, club_code, function(json) {
							var jsonObj = JSON.parse(JSON.stringify(json));
							if(jsonObj.result == 1){
								td_user_grade.parent().remove();
							}
						});
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
	});
	
	$(".member_out").click(function() {
		var list_tr = $(this).parent(".user_out").parent(".list_tr");
		var user_grade = $(list_tr.get(0)).find(".user_grade");
		
		var club_code = "${param.club_code}";
		var user_id = user_grade.find(".user_id").val();
		
		if(confirm("정말로 퇴출 하시겠습니까?")){
			ajax_drop_club_manager(club_code, user_id, function(json){
				var jsonObj = JSON.parse(JSON.stringify(json));
				var result = jsonObj.result;
				if(result){
					list_tr.html("");
					list_tr.css("height", "0px");
				} else {
					window.alert("오류");
				}
			});
		}
	});
	
	$(".search_frame").keydown(function(e) {
		if(e.keyCode == 13){
			var input_value = $(this).val();
			if(input_value == null || input_value == ""){
				alert("검색어를 입력해주세요.");
				return;
			}
			<c:choose>
				<c:when test="${IS_FED eq 0}">
					location.href="./club_user_search.do?club_code=${param.club_code}&CLUB_CODE=${param.club_code}&KEYWORD="+input_value;
				</c:when>
				<c:when test="${IS_FED eq 1}">
					location.href="./fed_member_search.do?FED_CODE=${param.FED_CODE}&KEYWORD="+input_value;
				</c:when>
			</c:choose>
		}
	});
	
	
</script>
<%@ include file="../common/backeventjs.jsp" %>
</body>