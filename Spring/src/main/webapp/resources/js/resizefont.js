	function resize_font(target, multiple, length, padding, limit, minsize){
		var fontPixel = parseInt(($(window).width() - padding)*(1.17)*(multiple)/length, 10);
		if(fontPixel > limit){
			fontPixel = limit;
		}
		if(fontPixel < minsize){
			fontPixel = minsize;
		}
		target.css("font-size", fontPixel+"px");
		target.css("line-height", fontPixel+"px");
	}
	/*
	 * target: jquery 선택자로 선택된 객체
	 * multiple: 단순 배수 일단 1을 넣어보고 너무 크거나 작다 싶으면 소수점 단위로 늘려나가면 됨
	 * length: padding을 감안해서 몇글자가 들어갈 정도 사이즈로 줄일 건지
	 * padding: 이 글자가 들어갈 좌우 패딩 값의 합
	 * limit: 폰트사이즈 커지는 한계치인데 17정도로 하면 적당한 듯
	 */