<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
	<div id="floating" style="position:absolute; width:400px; z-index:2000; background-color:gray;"></div>
	<div id="cover" style="width:100%; height:700px; overflow:auto;">
		<div id="header" style="width:80%; background-color:red; margin:10%; padding:10%; border:2px solid black; color:white;">
			사진235677788
		    <div class="image-editor">
		      <input type="file" class="cropit-image-input">
		      <div class="cropit-preview"></div>
		      <div class="image-size-label">
		        Resize image
		      </div>
		      <input type="range" class="cropit-image-zoom-input">
		      <button class="rotate-ccw">Rotate counterclockwise</button>
		      <button class="rotate-cw">Rotate clockwise</button>
		
		      <button class="export">Export</button>
		    </div>
		    <script>
		      $(function() {
		        $('.image-editor').cropit({
		          imageState: {
		            src: 'http://lorempixel.com/500/400/',
		          },
		        });
		
		        $('.rotate-cw').click(function() {
		          $('.image-editor').cropit('rotateCW');
		        });
		        $('.rotate-ccw').click(function() {
		          $('.image-editor').cropit('rotateCCW');
		        });
		
		        $('.export').click(function() {
		          var imageData = $('.image-editor').cropit('export');
		          window.open(imageData);
		        });
		      });
		    </script>
		</div>
		<div id="footer" style="width:100%; height:1000px; background-color:blue; text-align:center;">
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" id="real-target" style="width:100%; height:200px; background-color:white; text-align:center;">real-target</div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:yellow; text-align:center;"></div>
			<div class="target" style="width:100%; height:200px; background-color:orange; text-align:center;"></div>
		</div>
	</div>
	<script>
		var scrollFlag;
		$(function() {
			printout();
			reposition();
			scrollFlag = 0;
		});
		$(window).resize(function() {
			printout();
			reposition();
		});
		$("#cover").scroll(function() {
			printout();
			reposition();
			var coverScrollTop = $("#cover").scrollTop();
			var coverHeight = $("#cover").height();
			var realTargetTop = $("#real-target").offset().top;
			if(coverHeight > realTargetTop && scrollFlag == 0){
				scrollFlag = 1;
				alert("find!");
			}
			if(coverHeight <= realTargetTop && scrollFlag == 1){
				scrollFlag = 0;
				alert("leashed!");
			}
		});
		function printout() {
			var text = "";
			text = text + "window-width:"+$(window).width()+" / window-height:"+$(window).height()+"<br/>";
			text = text + "html-width:"+$("html").width()+" / html-height:"+$("html").height()+"<br/>";
			text = text + "header-width:"+$("#header").width()+" / header-height:"+$("#header").height()+"<br/>";
			text = text + "footer-width:"+$("#footer").width()+" / footer-height:"+$("#footer").height()+"<br/>";
			text = text + "cover-scrollTop:"+$("#cover").scrollTop()+"<br/>";
			text = text + "cover-height:"+$("#cover").height()+"<br/>";
			text = text + "realTarget-top:"+$("#real-target").offset().top+"<br/>";
			if(scrollFlag == 1){
				text = text + "already found target.";
			}
			else{
				text = text + "have to find target.";
			}
			$("#floating").html(text);
		}
		function reposition() {
			$("#floating").height($(window).height()/4);
			$("#floating").css("top",($("#cover").height()*3)/4);
			$("#floating").css("right","10px");
		}
	</script>
</body>
</html>