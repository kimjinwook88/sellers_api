<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="alert-bg">
	<div class="alert-pop">
		<div class="image-success"></div>
		<div class="image-error"></div>
		<div class="image-warning"></div>
		<div class="image-info"></div>
		<div class="image-question"></div>
		
		<div class="text">success!</div>
		<div class="button">
			<button type="button" class="confrim" onclick="$('div.alert-bg').hide();">확인</button>
		</div>
	</div>
	
	<div class="confirm-pop">
		<div class="image-success"></div>
		<div class="image-error"></div>
		<div class="image-warning"></div>
		<div class="image-info"></div>
		<div class="image-question"></div>
		
		<div class="text"></div>
		<div class="button">
			<button type="button" class="confrim">확인</button>
			<button type="button" class="cancle">취소</button>
		</div>
	</div>
	
</div>

<script type="text/javascript">
$(document).ready(function(){
	/* popup.xyIndex();
	$(".alert-bg .alert-pop").fadeIn();
	$(".alert-bg .alert-pop").css({"display": "inline-block"}); */
	$(window).resize(function(){ // 창 크기 감지
		popup.xyIndex();
	});
	
});

var popup = {
		xyIndex : function(){
			var windowWidth = $(window).width()+"px";
			var windowHeight = $(window).height()+"px";
			$(".alert-bg").css({"width": windowWidth, "height": windowHeight, "line-height": windowHeight});
			$(".alert-bg").show();
		},
		
		show : function(val){
			popup.xyIndex();
			switch (val) {
			case "alert":
				$(".alert-bg .alert-pop").fadeIn();
				$(".alert-bg .alert-pop").css({"display": "inline-block"});
				break;
			case "alertSuccess":
				
				break;
			case "alertError":
				
				break;
			case "alertWarning":
				$("div.alert-pop > div.image-warning").show();
				$(".alert-bg .alert-pop").fadeIn();
				$(".alert-bg .alert-pop").css({"display": "inline-block"});
				break;
			case "alertInfo":
				
				break;
			case "alertQuestion":
				
				break;
			/* case "":
				
				break;
			case "":
				
				break;
			case "":
				
				break; */
			}
		},
		
		wait : function(ms){
			var start = new Date().getTime();
			var end = start;
			while(end < start + ms){
			}
		},
		
		alert : function(val){
			$("div.alert-pop > div.text").html(val);
			popup.show("alert");
			console.log($('#divModalCoachingTalk').css('display') == 'table-cell');
			/* if($("div.alert-bg")){
				
			} */
		},
		
		alertSuccess : function(val){
			
		},
		
		alertError : function(val){
			
		},
		
		alertWarning : function(val){
			$("div.alert-pop > div.text").html(val);
			popup.show("alertWarning");
			
			alert("g2");
			popup.wait(5000);
			if($('.alert-bg').css('display') == 'block'){
				
			}
		},
		
		alertInfo : function(val){
			
		},
		
		alertQuestion : function(val){
			
		},
}
</script>