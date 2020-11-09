<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
        div.ajaxMask 
        { 
            position:fixed; 
            width:100%; 
            height:100%; 
            top:0; 
            left:0; 
            background-color:#777; 
            opacity:0.3;
            filter: alpha(opacity=50); 
            z-index:99999999;
            display:none;
        }
        div.ajax-loader_sellers{
       		position:fixed; 
            width:100%; 
            height:100%; 
            top:50%; 
            left:50%;
            display:none;
        }
</style>

<!-- 화면 전체 덮을 loading img -->
<div class="ajaxMask"></div>
<div class="ajax-loader_sellers" style="z-index:99999999;">
	<img src = "/img/pc/ajax-loader_sellers.gif" width="70px;"/>
</div>

<script src="<%=request.getContextPath()%>/js/pc/inspinia.js"></script> <!-- 메뉴 스크립트 때문에 bottom 으로 -->
<script src="<%=request.getContextPath()%>/js/pc/custom.js"></script>
<script type="text/javascript">
   var emptyMsgDiv = $("<div style='padding:100px 0;text-align: center;font-size: 13px;color:#666;'><span>등록된 정보가 없습니다. 신규 정보를 등록해주세요</span></div>");
   var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
   $(document).ready(function() { 
       // datapicker : 달력 노출 스크립트
		$(document).on('mouseover','div.data_1 .input-group.date', function(){
	    //$(document).on('focus','#data_1 .input-group.date', function(){
	    	$(this).datepicker({
	    		   todayBtn: "linked",
		           //keyboardNavigation: false,
		           forceParse: false,
		           calendarWeeks: true,
		           autoclose: true
		     }).on('hide.bs.modal', function(event) {
		   	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
		    	event.stopPropagation(); 
			}).on('changeDate', function(ev) {
				if($(this).children("input").attr("aria-required") == "true") $(this).children("input").valid();  
	        });
	    });
	    
	    $(document).on('click','div.data_1 .input-group.date', function(){
	    	//달력 노출시 인풋값 날짜에 active.
	    	var date = $(this).children("input").val();
    		if(date != ""){
    			//$(this).datepicker("setDate", new Date(moment(date).format("YYYY"),moment(date).format("MM")-1,moment(date).format("DD")));
    		}
	    });
   
	   	$("#formModalData input:text, #textCommonSearchMember2").keydown(function (key) {
	   		/* if(){
	   		} */
	   		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	   	  		/*  if($(this).attr("id") == "textCommonSearchCompany"){
	   	  			commonSearch.companyInfo();
	   	  			//
	   	  		}else{
	   	  			return false;
	   	  		}  */
	   	  		if($(this).parent().hasClass('input-group date') && !dayRegExp.test($(this).val())){ //(데이트피커) 날짜 입력란에 날짜입력 양식 안지킬 경우 빈값처리
	   	  			$(this).val("");
	   	  		}
	   	  		
	   	  		return false;
		     }
		 });
	   	
	   	/*  항목보기 설정 */
	   	$(".table-menu-wrapper2 input[name='toggle-cols']").click(function(){
	   		var url = (($(location).attr("href")).replaceAll("#","")).trim();
   			if($(this).is(":checked")){
	   			$('[name="'+$(this).val()+'"]').show();
	   		}else{
	   			$('[name="'+$(this).val()+'"]').hide();
	   		}
   			
   			//영업기회...
	   		if(url.indexOf("/clientSalesActive/viewOpportunityList.do") != -1){
	   			var totalCount = parseInt($('tr.total td.title').attr('colspan'));
	   			var colspanCount;
	   			if(isEmpty($('tr#trCellCount th[name="'+$(this).val()+'"]').attr("colspan"))){
	   				colspanCount = 1;
	   			}else{
	   				colspanCount = parseInt($('tr#trCellCount th[name="'+$(this).val()+'"]').attr("colspan"));
	   			}
	   			
	   			if($(this).val() != "cell_CONTRACT_AMOUNT" && $(this).val() != "cell_REV" && $(this).val() != "cell_GP"){
		   			if($(this).is(":checked")){
		   				totalCount = totalCount + colspanCount;
		   			}else{
		   				totalCount = totalCount - colspanCount;
		   			}
	   			}
	   			
	   			$('tr.total td.title').attr('colspan',totalCount);
	   			columnCount = totalCount;
	   		}
	   	});

	   	$("#table-menu-btn").click(function(){
	   		$("div.table-menu").toggle();
	   	});
	   	
	  	//Title 설정
	 	$("title").html($("ol.breadcrumb strong").html());
	  	
	 	//바탕 영역 클릭시 검색 div 숨기기 및 초기화
	 	$("div#wrapper").click(function(e){
	 		//바탕 영역 클릭시 검색 div 숨기기
			if (!$('div.search-common').has(e.target).length) {
	 			$("div.search-detail").hide();
	 			//filedReset($(this));
	        }
			//바탕 영역 클릭시 항복보기 div 숨기기
			if(!$('div.table-menu-wrapper2').has(e.target).length){
				$("div.table-menu").hide();
			}
			//바탕 영역 클릭시 템플릿 div 숨기기
			if(!$('div.template-doc').has(e.target).length){
				$("ul.template-list").hide();
			}
	 	});
	 	
	 	//date type readonly
	 	$("div.input-group.date input:text").not(".search").attr("autocomplete","off");
	 	$("div.input-group.date input:text").prop("placeholder","ex) 1988-11-18");
   
	 	$('div').on({
 			'blur.dateBlur' : function(e){
 				if(!dayRegExp.test($(this).val())){
 		 			//$(this).val("");
 		 		}
 			}
		},'div.input-group.date input:text');
	 	
	 	
	 	//milestones 마우스 오버
		var st = ""; 
		$('tbody#row').on('mouseenter','td.ms_status, td.fua_status',function(){
			var subVal = $(this).find('div.step').html();
			var popMs = $(this).find('div.pop_milestones_detail');
			st = setTimeout(function(){
				/* $.post("/clientSalesActive/selectOpportunityMilestonesList.do", { pkNo: pkNo} ).done(function( data ) {
				    console.log(data);
				}); */
				if((subVal).trim() != "-"){
					popMs.show();
				}
			},250);
		}).on('mouseleave','td.ms_status, td.fua_status',function(){
			clearTimeout(st);
			$('div.pop_milestones_detail').hide();
		});
		
   });   
   
   //backspace key 막기
   $(document).keydown(function(e) {
   	key = (e) ? e.keyCode : event.keyCode;
   	var t = document.activeElement;
           if (key == 8 && $("div#myModal1").css("display") != "none") {
               if (t.tagName != "INPUT" && t.tagName != "TEXTAREA") {
                   if (e) {
                       e.preventDefault();
                   } else {
                       event.keyCode = 0;
                       event.returnValue = false;
                   }
               }
           } 
   });
 
 	
 	function noDataFn(ts,grid){
        if (ts.p.reccount === 0) {
            $(this).hide();
            emptyMsgDiv.show();
            emptyMsgDiv.insertAfter($sellersGrid.parent());
        } else {
            $(this).show();
            emptyMsgDiv.hide();
        }
 	}
 	
//브라우저 리사이즈 체크
$(window).resize(function() {
	$('div.autocomplete-suggestions').html('');
});
 	
 //not event f5  event.clientY < 0
 //event.altKey When press Alt +F4 
 //event.ctrlKey When press Ctrl +F4 
 //event.clientY 107 or 129 is  Alt F4 postion on window screen it may change base on screen resolution 
 //브라우저 로그아웃 체크
/* $(window).bind('beforeunload', function() {
     if ((event.clientY < 0) ||(event.altKey) ||(event.ctrlKey)||((event.clientY < 129) && (event.clientY>107))) { 
    	$.ajax({
			url : "/logout",  //스프링시큐리티 에서 적용시켜놓은 custom logout url
			success : function(){
				alert("잘갔냐"); 
			}
	    }); 
     }
});  */
</script>
</html>
