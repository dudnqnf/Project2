//스크롤 됬을경우 따라다니는 효과
$(window).scroll(function() {
	$(".dialog").css("top", $(window).scrollTop() + $(window).height()*3/20);
});

$(window).resize(function() {
	$(".dialog").css("width", $(window).width()*21/25);
	$(".dialog").css("height", "250px");
	$(".dialog").css("left", $(window).width()*2/25);
	$(".dialog").css("top", $(window).scrollTop() + $(window).height()*3/20);
	
	$("#blurAll").css("width", $(document).width());
	$("#blurAll").css("height", $(document).height());
});


var cancelable = 1;
//팝업창바깥부분 클릭
$("#blurAll").click(function() {
	console.log(cancelable);
	if(cancelable != 0){
		$("#blurAll").css("display","none");
		$(".dialog").css("display","none");
		cancelable = 1;
	}
});
