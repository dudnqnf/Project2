<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	var flag = false;
	var replace = "${param.replace}";
	var branchhome = "${param.branchhome}";
	var mobileArr = new Array("iPhone", "iPod", "BlackBerry", "Android", "Windows CE", "LG", "MOT", "SAMSUNG", "SonyEricsson", "Chrome");
 	for(var txt in mobileArr){
 	    if(navigator.userAgent.match(mobileArr[txt]) != null){
 	    	flag = true;
 	        break;
 	    }
 	}
 	//alert(navigator.userAgent);
 	var android_ver = navigator.userAgent.substring(navigator.userAgent.indexOf("Android")+8, navigator.userAgent.indexOf("Android")+11);
	if(android_ver < "4.4"){
		flag = false;
	}
	var parameterString;

	//	안드로이드 뒤로가기 버튼 체크
	function is_back_btn(){
		flag = true;
	}
	
	//alert("replace == \"\" : "+(replace == ""));
	if(replace != "" && branchhome != "branchhome" && flag){
		//alert("pushState");
		//history.pushState({test: "test"}, null, null);
		history.pushState(null, null, location.href);
	}
	window.addEventListener('load', function() {
		setTimeout(function() {
			window.addEventListener('popstate', function() {
				//alert("popstate");
				if(flag){
					if(jQuery.type(".dialog") !== "undefined" && $(".dialog").css("display")=="block"){
						$(".dialog").css('display', 'none');
						$("#blurAll").css("display","none");
						history.pushState(null, null, location.href);
					}else if(jQuery.type(".dropdown_clubtype_list") !== "undefined" && $(".dropdown_clubtype_list").css("display") == "block"){
						$(".dropdown_clubtype_list").css("display","none");
						history.pushState(null, null, location.href);
					}else if(jQuery.type("#photo_viewer") !== "undefined" && $("#photo_viewer").css("display") == "block"){
						imagepopdown();
						history.pushState(null, null, location.href);
					}else if(jQuery.type(".dropdown_clubtarget_list") !== "undefined" && $(".dropdown_clubtarget_list").css("display") == "block"){
						$(".dropdown_clubtarget_list").css("display","none");
						history.pushState(null, null, location.href);
					}else if(jQuery.type("#location_select") !== "undefined" && $("#location_select").css("display") == "block"){
						$("#location_select").css("display","none");
						history.pushState(null, null, location.href);
					}else if(jQuery.type("#location_detail_select") !== "undefined" && $("#location_detail_select").css("display") == "block"){
						$("#location_select").css("display","block");
						$("#location_detail_select").css("display","none");
						if(selected_gu != ""){
							$("#location_detail_select div#"+selected_gu+" img").attr("src","<c:url value='/resources/images/icon_admin_checkbox.png'/>");
							selected_gu = "";
							selected_gu_str = "지역을 선택해주세요";
						}
						history.pushState(null, null, location.href);
					}else if(jQuery.type("#field_select") !== "undefined" && $("#field_select").css("display") == "block"){
						$("#field_select").css("display","none");
						if($("#create_club .selected_field").val() != selected_field){
							$("#field_select div.field_unit").children("span").css("color","#008ae8");
							$("#field_select div.field_unit").children("span").css("background-color","#ffffff");
							if($("#create_club .selected_field").val() != ""){
								$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("color","#ffffff");
								$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("background-color","#008ae8");
								selected_field = $("#create_club .selected_field").attr("id");
								selected_field_str = $("#create_club .selected_field").val();
							}
							else{
								selected_field = "";
								selected_field_str = "종목을 선택해주세요";
							}
						}
						history.pushState(null, null, location.href);
					}else if(jQuery.type(".text-editor") !== "undefined" && $(".text-editor").css("display") == "block"){
						$(".text-editor").css("display","none");
						$("body").css("overflow","");
						$(".tedit_input_wrapper").css("display","none");
						history.pushState(null, null, location.href);
				    }else if($("#modify_location").css("display")=="block"){
						$("#profile_modify").css("display", "block");
						$("#modify_location").css("display", "none");
						history.pushState(null, null, location.href);
				    } else if($("#modify_location_detail").css("display")=="block"){
				    	$("#modify_location").css("display", "block");
						$("#modify_location_detail").css("display", "none");
						history.pushState(null, null, location.href);
				    } else if($("#modify_interest").css("display")=="block"){
				    	$("#profile_modify").css("display", "block");
						$("#modify_interest").css("display", "none");
						history.pushState(null, null, location.href);
				    }else if(replace=="zzim"){
				    }else if(replace=="modifydetail"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/club_detail.do?club_code=${param.club_code}&replace=clublist"+parameterString);
				    }else if(replace=="myprofile"){
						location.replace("../myprofile/index.do?branchhome=branchhome");
					}else if(replace=="album"){
						var club_code = "${param.club_code}";
						location.replace("../club/club_detail.do?club_code="+club_code+"&mode=album");
				    }else if(replace=="alarm"){
						location.replace("../home/alarm.do?replace=home");
				    }else if(replace=="home"){
						location.replace("./index.do?branchhome=branchhome");
				    }else if(replace=="clublist"){
				    	if("${param.si}" == ""){
							location.replace("../club/club_list.do?category=${param.category}&replace=clubindex");
				    	}
				    	else{
							location.replace("../club/sorted_club_list.do?si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}&replace=clubindex");
				    	}
				    }else if(replace=="clubdetailboard"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=board"+parameterString+"#board");
				    }else if(replace=="feddetailboard"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=board"+parameterString+"#board");
				    }else if(replace=="clubdetailadmin"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=admin"+parameterString+"#admin");
				    }else if(replace=="feddetailadmin"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=admin"+parameterString+"#admin");
				    }else if(replace=="clubdetailinfo"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=info"+parameterString+"#info");
				    }else if(replace=="feddetailinfo"){
						parameterString = "";
						if("${param.si}" != ""){
							parameterString += "&si=${param.si}";
						}
						if("${param.gu}" != ""){
							parameterString += "&gu=${param.gu}";
						}
						if("${param.category}" != ""){
							parameterString += "&category=${param.category}";
						}
						if("${param.sportsName}" != ""){
							parameterString += "&sportsName=${param.sportsName}";
						}
						location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=info"+parameterString+"#info");
				    }else if(replace=="clubindex"){
						location.replace("../club/index.do?branchhome=branchhome");
				    }else if(replace=="infolistnews"){
				    	var si = "${param.SI}";
				    	var event = "${param.EVENT}";
						location.replace("./index.do?replace=branchhome&PAGE_TAG=news&SI="+si+"&EVENT="+event);
				    }else if(replace=="infolistfacility"){
						var si = "${param.SI}";
						var gu = "${param.GU}";
						var dong = "${param.DONG}";
						var event = "${param.EVENT}";
						location.replace("./index.do?replace=branchhome&PAGE_TAG=facility"+"&SI="+si+"&GU="+gu+"&DONG="+dong+"&EVENT="+event);
				    }else if(replace=="infolistevent"){
						location.replace("./index.do?replace=branchhome&PAGE_TAG=event");
				    }else if(replace=="main"){
						location.replace("../");
				    }else if(replace=="findaccountid"){
						location.replace("./find_account.do?replace=main#id");
				    }else if(replace=="findaccountpassword"){
						location.replace("./find_account.do?replace=main#password");
					}else{
						//alert("popstate > history.back();");
						history.back();
					}
				}
			});
		}, 0);
	});
	/*window.onpopstate = function(event){
		alert("popstate");
		if(flag){
			if(jQuery.type(".dialog") !== "undefined" && $(".dialog").css("display")=="block"){
				$(".dialog").css('display', 'none');
				$("#blurAll").css("display","none");
				history.pushState(null, null, location.href);
			}else if(jQuery.type(".dropdown_clubtype_list") !== "undefined" && $(".dropdown_clubtype_list").css("display") == "block"){
				$(".dropdown_clubtype_list").css("display","none");
				history.pushState(null, null, location.href);
			}else if(jQuery.type("#photo_viewer") !== "undefined" && $("#photo_viewer").css("display") == "block"){
				imagepopdown();
				history.pushState(null, null, location.href);
			}else if(jQuery.type(".dropdown_clubtarget_list") !== "undefined" && $(".dropdown_clubtarget_list").css("display") == "block"){
				$(".dropdown_clubtarget_list").css("display","none");
				history.pushState(null, null, location.href);
			}else if(jQuery.type("#location_select") !== "undefined" && $("#location_select").css("display") == "block"){
				$("#location_select").css("display","none");
				history.pushState(null, null, location.href);
			}else if(jQuery.type("#location_detail_select") !== "undefined" && $("#location_detail_select").css("display") == "block"){
				$("#location_select").css("display","block");
				$("#location_detail_select").css("display","none");
				if(selected_gu != ""){
					$("#location_detail_select div#"+selected_gu+" img").attr("src","<c:url value='/resources/images/icon_admin_checkbox.png'/>");
					selected_gu = "";
					selected_gu_str = "지역을 선택해주세요";
				}
				history.pushState(null, null, location.href);
			}else if(jQuery.type("#field_select") !== "undefined" && $("#field_select").css("display") == "block"){
				$("#field_select").css("display","none");
				if($("#create_club .selected_field").val() != selected_field){
					$("#field_select div.field_unit").children("span").css("color","#008ae8");
					$("#field_select div.field_unit").children("span").css("background-color","#ffffff");
					if($("#create_club .selected_field").val() != ""){
						$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("color","#ffffff");
						$("#field_select div.field_unit#"+$("#create_club .selected_field").attr("id")).children("span").css("background-color","#008ae8");
						selected_field = $("#create_club .selected_field").attr("id");
						selected_field_str = $("#create_club .selected_field").val();
					}
					else{
						selected_field = "";
						selected_field_str = "종목을 선택해주세요";
					}
				}
				history.pushState(null, null, location.href);
			}else if(jQuery.type(".text-editor") !== "undefined" && $(".text-editor").css("display") == "block"){
				$(".text-editor").css("display","none");
				$("body").css("overflow","");
				$(".tedit_input_wrapper").css("display","none");
				history.pushState(null, null, location.href);
		    }else if(replace=="zzim"){
		    }else if(replace=="modifydetail"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/club_detail.do?club_code=${param.club_code}&replace=clublist"+parameterString);
		    }else if(replace=="myprofile"){
				location.replace("../myprofile/index.do?branchhome=branchhome");
			}else if(replace=="album"){
				var club_code = "${param.club_code}";
				location.replace("../club/club_detail.do?club_code="+club_code+"&mode=album");
		    }else if(replace=="alarm"){
				location.replace("../home/alarm.do?replace=home");
		    }else if(replace=="home"){
				location.replace("./index.do?branchhome=branchhome");
		    }else if(replace=="clublist"){
		    	if("${param.si}" == ""){
					location.replace("../club/club_list.do?category=${param.category}&replace=clubindex");
		    	}
		    	else{
					location.replace("../club/sorted_club_list.do?si=${param.si}&gu=${param.gu}&category=${param.category}&sportsName=${param.sportsName}&replace=clubindex");
		    	}
		    }else if(replace=="clubdetailboard"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=board"+parameterString+"#board");
		    }else if(replace=="feddetailboard"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=board"+parameterString+"#board");
		    }else if(replace=="clubdetailadmin"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=admin"+parameterString+"#admin");
		    }else if(replace=="feddetailadmin"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=admin"+parameterString+"#admin");
		    }else if(replace=="clubdetailinfo"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/club_detail.do?replace=clublist&club_code=${param.club_code}&mode=info"+parameterString+"#info");
		    }else if(replace=="feddetailinfo"){
				parameterString = "";
				if("${param.si}" != ""){
					parameterString += "&si=${param.si}";
				}
				if("${param.gu}" != ""){
					parameterString += "&gu=${param.gu}";
				}
				if("${param.category}" != ""){
					parameterString += "&category=${param.category}";
				}
				if("${param.sportsName}" != ""){
					parameterString += "&sportsName=${param.sportsName}";
				}
				location.replace("../club/fed_detail.do?FED_CODE=${param.FED_CODE}&mode=info"+parameterString+"#info");
		    }else if(replace=="clubindex"){
				location.replace("../club/index.do?branchhome=branchhome");
		    }else if(replace=="infolistnews"){
				location.replace("./index.do?replace=branchhome&PAGE_TAG=news");
		    }else if(replace=="infolistfacility"){
				location.replace("./index.do?replace=branchhome&PAGE_TAG=facility");
		    }else if(replace=="infolistevent"){
				location.replace("./index.do?replace=branchhome&PAGE_TAG=event");
		    }else if(replace=="main"){
				location.replace("../");
		    }else if(replace=="findaccountid"){
				location.replace("./find_account.do?replace=main#id");
		    }else if(replace=="findaccountpassword"){
				location.replace("./find_account.do?replace=main#password");
			}else{
				//alert("popstate > history.back();");
				history.back();
			}
		}
	};*/
</script>
