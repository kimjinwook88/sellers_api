<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear">
	<fmt:formatDate value="${now}" pattern="MM" />
</c:set>

<!doctype html>
<html lang="ko">

<body class="gray_bg">

	<div class="container">
		<article class="landing_quickmenu">
			<div class="ta_r pd_t10 mg_b10">
				<a href="#" class="btn_quickmenu_set" onclick="modal.set();">바로가기
					메뉴 설정</a>
			</div>

			<div class="ment">
				※ 셀러스 ‘바로가기’ 화면입니다. 원하는 메뉴를 등록해주세요.<br /> (6개까지 등록 가능합니다.)
			</div>
		</article>

		<!-- 바로가기 메뉴 설정 팝업 -->
		<jsp:include page="./mainLandingPageModal.jsp" flush="false" />
		<!-- <div class="modalpop_screen"></div> -->

		<article class="landing">
			<div class="">
				<div id="schedule_list"></div>
			</div>
			<div class="">
				<div id="div_clientIssue"></div>
			</div>
			<div class="">
				<div id="ResultGraph"></div>
				<div id="div_opportunity"></div>
			</div>
			<div class="">
				<div id="result_div"></div>
			</div>
		</article>

	</div>

	<div class="modal_screen"></div>

</body>

<!-- c3 chart -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
	$(document).ready(function(){
		
		/*
		var token = '${userInfo.SECRET_OUT_KEY}';
		setCookie("token", token, 7);
		alert(getCookie("token"));
		*/
		
		
		//alert(token);
		//console.log("@@@@@@@@@@@" + token);	
				
		
		/* $.ajax({
			url : "/main/selectSalesAct.do",
			async : false,
				datatype : 'html',
				method: 'POST',
				data : {
					searchMemberId : '${userInfo.MEMBER_ID_NUM}', 
					jsp : '/main/mainSalesActAjax',
					datatype : "html"
				},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				$('#div_result').html(data);
			},
			complete : function(){
			}
		}); */
		
		$('span[name="spanYear"]').html(moment().format('Y'));
		
		var todayDate = moment().format('YYYY-MM-DD');
		$('#curDate').html(todayDate);
		$('#timelineDate').html(moment().format('YYYY년 MM월 DD일'));

		fncGetSchedule(todayDate);
		//fncSelectResult(moment().quarter());
		//fncSelectCompanyResult(moment().quarter());
		//fncSelectNewUpdate();
		fncSelectOpportunity();
		fncSelectClientIssue();
		//fncSelectCalendar();
		//fncResultGraph();
		//fncResultGraph2();
		
		selectUserMobileLandingPage();
	});
	
	
	function selectUserMobileLandingPage(){ //사용자 메인랜딩페이지 설정 조회
		var params = $.param({
			datatype : 'html',
			jsp : '/main/mainLandingPageAjax'
		});
		
		$('article.landing_quickmenu').prevAll("ul.quickmenu_display").remove();
	
		//사용자 메뉴 리스트
		$.ajax({
			url : "/main/selectUserMobileLandingPage.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			//data : selectUserMobileLandingPage.getParams() + "&" + listParams,
 			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				$('article.landing_quickmenu').before(data);
			},
			complete : function(){
			}
		});
	}
	
	function fncGetItemHtml(_object, start_date){
		var obj_html = '';
		if (_object.PAST_YN == 'Y'){
			obj_html += '<li class="complete">';
		} else {
			obj_html += '<li>';
		}
		obj_html += '<a href="/calendar/modalCalendarForm.do?mode=M&eventId='+_object.EVENT_ID+'&pos=calendar&start_date='+start_date+'">';
		obj_html += '<span class="time">['+_object.START_DATETIME+' ~ '+_object.END_DATETIME+']</span>';
		obj_html += '<span class="subject">' + _object.EVENT_SUBJECT + '</span>';
		obj_html += '</a>';
		obj_html += '</li>';
		
		return obj_html;
	}
	
	function fncGetSchedule(_date, etc){
		//현재 
		var timeLineDate = moment().format('YYYY-MM-DD');
		var todayDate = moment().format('YYYY-MM-DD');
		var todayDate2 = moment().format('YYYYMMDD');
		var todayDateYear = moment().format('YYYY');
		var todayDateMonth = moment().format('MM');
		var todayDateDay = moment().format('DD');
		
		$.ajax({
			url : "/main/selectTimeLine.do",
			//url: "/calendar/calendarEventListMobile.do",
			async : false,
 			datatype : 'json',
 			method: 'POST',
 			data : {
 				searchDate : timeLineDate,
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				//jsp : '/main/mainTimeLineAjax',
 				datatype : "json"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				//var list = data.events;
				var list = data.list;
				
				var list_html = '';
				var start_date = '';
				var schedule_html = '';
				
				var jbAry = new Array();
				var jbAry2 = new Array();
				var longChedule = new Array();
				var stringDays = '';
				//$("#timeLineDate").html(timeLineDate);
				
				if(data != null && data != ''){
					
					for (var i = 0; i < list.length; i++){
						
						var l = list[i];
						
						if(l.START_DAY != null){
							stringDays = l.DAYS;
							if(stringDays != null){
								if(stringDays.length >= 11){
									var stringArray = stringDays.split(',');
									jbAry2.push(stringArray);
									longChedule.push(
										{
											"EVENT_ID" : l.EVENT_ID,
           								"CALENDAT_ID" : l.CALENDAT_ID,
           								"EVENT_CODE" : l.EVENT_CODE,
           								"EVENT_SUBJECT" : l.EVENT_SUBJECT,
           								"EVENT_DETAIL" : l.EVENT_DETAIL,
           								"allDay" : l.allDay,
           								"start" : l.start,
           								"end" : l.M_END_TIME,
           								"TIME_GAP" : l.TIME_GAP,
           								"BEFORE_MOVE_TIME" : l.BEFORE_MOVE_TIME,
           								"AFTER_MOVE_TIME" : l.AFTER_MOVE_TIME,
           								"textColor" : l.textColor,
           								"backgroundColor" : l.backgroundColor,
           								"REPEAT_YN" : l.REPEAT_YN,
           								"RECURRENCE_ID" : l.RECURRENCE_ID,
           								"RECURRENCE_FREQ" : l.RECURRENCE_FREQ,
           								"RECURRENCE_INTERVAL" : l.RECURRENCE_INTERVAL,
           								"RECURRENCE_END_DATE" : l.RECURRENCE_END_DATE,
           								"RECURRENCE_COUNT" : l.RECURRENCE_COUNT,
           								"RECURRENCE_BYWEEKDAY" : l.RECURRENCE_BYWEEKDAY,
           								"RECURRENCE_BYMONTHDAY" : l.RECURRENCE_BYMONTHDAY,
           								"RECURRENCE_RULE" : l.RECURRENCE_RULE,
           								"END_RULE" : l.END_RULE,
           								"EX_DATE" : l.EX_DATE,
           								"EX_DATE_YN" : l.EX_DATE_YN,
           								"LOCATION" : l.LOCATION,
           								"SHARE_YN" : l.SHARE_YN,
           								"ALARM_FLAG" : l.ALARM_FLAG,
           								"ALARM_TARGET" : l.ALARM_TARGET,
           								"RRULE_SYNC_ID" : l.RRULE_SYNC_ID,
           								"PAST_YN" : l.PAST_YN,
           								"START_DATETIME" : l.START_DATETIME,
           								"END_DATETIME" : l.END_DATETIME,
           								"START_DAY" : l.START_DAY,
           								"END_DAY" : l.END_DAY,
           								"COUNT" : l.DAYS_COUNT
										}
									);
								}
							}
						}
						
						if(l.START_DAY == todayDate) {
							start_date = moment(l.START_DAY).format("YYYY-MM-DD");
							list_html += fncGetItemHtml(l, start_date);
						}
					}
					
					for(var l = 0; l < jbAry2.length; l++){
						for(var k = 0; k < jbAry2[l].length; k++){
							var fn = parseInt(0+k);			//slice를 위한 구분자1(fn, ln)
							var ln = parseInt(0+(k+1));	//slice를 위한 구분자2(fn, ln)
							
							// 단기일정과 일정이 겹치지 않기 위한 조건 
							if(fn != 0 && ln != 0){
								// 선택된 일자와 jbAry2 값 일정중 맞을 경우에
								if(todayDate2 == String(jbAry2[l].slice(fn, ln))){
									// 날짜 포맷, 시작일은 고정으로 배열의 첫번째 값으로 활용
									start_date = moment(String(jbAry2[l].slice(fn, ln))).format("YYYY-MM-DD");
									// 장기적인 일,오늘(일정) HTML 생성
									list_html += fncGetItemHtml(longChedule[l], start_date);
									//
								}
							}
						}
					}
				}
				
				schedule_html += '<div class="title_head">';
				schedule_html += '<h2 class="title">나의 일정</h2>';
				schedule_html += '<a href="/calendar/modalCalendarForm.do?mode=I&curDate=&pos=viewCalendar" class="btn_more_landing">+</a>';
				schedule_html += '</div>';
				schedule_html += '<div class="todayList">';
				schedule_html += '<div class="top">';
				schedule_html += '<h3 id=""><span id="mainYear">' +todayDateYear + '</span>년 <span id="mainMonth">' + todayDateMonth + '</span>월 <span id="mainDay">' + todayDateDay + '</span>일</h3>';
				schedule_html += '</div>';
				schedule_html += '<ul class="today_schedule_list" id="result_timeLine">';
				
				if(list_html != null && list_html != ''){
					schedule_html += list_html;
				}else{
					schedule_html += '<li id="no_calList">';
					schedule_html += 	'<p class="pd_t20 pd_b20 ta_c">등록된 일정이 없습니다.</p>';
					schedule_html += '</li>';
				}
				
				schedule_html += '</ul>';
				schedule_html += '</div>';
				
				$('#schedule_list').html(schedule_html);
				/*
				
				*/
			},
			complete : function(){
			}
		});
	}
	/*
	function fncMoveDate(_vector){

		var curDate = moment($('#curDate').html());
		if(_vector == 'p'){//더하기
			var nextDate = curDate.add(1,'day');
			$('#curDate').html(nextDate.format('YYYY-MM-DD'));
			$('#timelineDate').html(nextDate.format('YYYY년 MM월 DD일'));
			fncGetSchedule(nextDate.format('YYYY-MM-DD'));
		}else{ //빼기
			var prevDate = curDate.add(-1,'day');
			$('#curDate').html(prevDate.format('YYYY-MM-DD'));
			$('#timelineDate').html(prevDate.format('YYYY년 MM월 DD일'));
			fncGetSchedule(prevDate.format('YYYY-MM-DD'));
		}
	}
	*/
	function fncSelectResult(_quarter){
		$('.result_tab').removeClass('active');
		$('#tab_result_'+_quarter).addClass('active');
		$.ajax({
			url : "/main/selectResult.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				searchQuarter : _quarter,
 				//datatype : "json"
                datatype : 'html',
                jsp : '/main/mainResult'
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
			    //console.log(data.list[0]);
				//$('.result_div').html(data);
				$('#result_div').html(data);
			},
			complete : function(){
			}
		});
	}
	
	function fncSelectCompanyResult(_quarter){
        $('.resultCompany_tab').removeClass('active');
		$('#tab_resultCompany_'+_quarter).addClass('active');
		$.ajax({
			url : "/main/selectCompanyResult.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchQuarter : _quarter,
                jsp : '/main/mainCompanyResult',
 				datatype : "html"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				$('.resultCompany_div').html(data);
			},
			complete : function(){
			}
		});
	}
/*
	function fncSelectNewUpdate(){
		$.ajax({
			url : "/main/selectNewUpdate.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				jsp : "/main/mainNewUpdateAjax",
 				datatype : "html"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
			    console.log(data)
				$('#div_new_result').html(data);
			},
			complete : function(){
			}
		});
	}
*/
	// 영업기회
	function fncSelectOpportunity(){
		var params = $.param({
			searchMemberId : '${userInfo.MEMBER_ID_NUM}',
			searchQuarter : '3',
			jsp : '/main/mainOpportunityAjax',
			datatype : 'html'
		});
		
		$.ajax({
			url : "/main/selectSalesAct.do",
			//async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				$('#div_opportunity').html(data);
			},
			complete : function(){
			}
		});
	}

	// 고객이슈
	function fncSelectClientIssue(){
		
		var params = $.param({
			searchMemberId : '${userInfo.MEMBER_ID_NUM}',
			jsp : '/main/mainClientIssueAjax2',
			datatype : 'html'
		});
		
		$.ajax({
			url : "/main/selectClientIssue.do",
			//async : false,
			datatype : 'html',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				//console.log(data);
				$('#div_clientIssue').html(data);
			},
			complete : function(){
			}
		});
	}
	
	// 일정(CEO, 셀러 포함)
	function fncSelectCalendar(_date, etc){
		var cYear = '${cYear}';
		var cMonth = '${cMonth}';
		var cDay = '${cDay}';
		
		var todayDate = moment().format('YYYYMMDD');
		/*
		if(_date != null){
			todayDate = _date;
		}
		*/
		
		$("#mainYear").html(cYear);
		$("#mainMonth").html(cMonth);
		$("#mainDay").html(cDay);
		
		var params = $.param({
			searchMemberId : '${userInfo.MEMBER_ID_NUM}',
			curDate : todayDate,
			searchEtc : etc,
			jsp : '/main/mainCalendarAjax',
			datatype : 'json'
		});
		
		$.ajax({
			url : "/main/selectCalendar.do",
			//async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				
				
				//$('#div_calendar').html(data);
				/*
				$("#mainYear").html(data.cYear);
				$("#mainMonth").html(data.cMonth);
				$("#mainDay").html(data.cDay);
				*/
				
				//$("#timeLinePrev").attr("onclick","fncSelectCalendar('"+data.yesterdayDate+"','prev'); return false;");
				//$("#timeLineNext").attr("onclick","fncSelectCalendar('"+data.tomorrowDate+"','next'); return false;");
				
				var list = data.pickDay;
				var list_html = '';
				if(list.length > 0 ){
					for (var i = 0; i < list.length; i++){
						list_html += fncGetTimeLineHtml(list[i]);
					}
					
					$("#result_timeLine2").html(list_html);
				}else{
					$("#no_calList").show();
				}
				
			},
			complete : function(){
			}
		});
	}
	
	function fncGetTimeLineHtml(_object){
		var obj_html = '';
		obj_html += '<li><a href="#">';
		obj_html += '<span class="time">[' + _object.START_DATETIME + ']</span>';
		obj_html += '<span class="subject">' + _object.EVENT_SUBJECT + '</span>';
		obj_html += '</a></li>';
		
		return obj_html;
	}
	
	
	
	// 실적현황 그래프
	function fncResultGraph(quarter){
		var quarter;
		if(quarter != null){
			quarter = quarter;
		}else{
			
			var nowMonth = '${sysYear}';
			
			switch (nowMonth) {
			case '01':
			case '02':
			case '03': 
				quarter = '1';
				break;
			
			case '04':
			case '05':
			case '06':
				
				quarter = '2';
				break;
				
			case '07':
			case '08':
			case '09':
				
				quarter = '3';
				break;
				
			default:
				quarter = '4';
				break;
			}
		}
		
		$("#tab"+quarter).addClass('active');
		var params = $.param({
			datatype : 'html',
			jsp :"/main/mainSelectResultGraphMAjax",
			searchMemberId : "${userInfo.MEMBER_ID_NUM}",
			searchQuarter : quarter,
		});
		
		$.ajax({
			url : "/main/selectResultGraphM.do",
			async : false,
			datatype : 'html',
			//cache: false,
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				//console.log(data);
				/*
				for(var i=0; i<4; i++){
					$("#tab"+i).removeClass("active");
				}
				*/
				//$("#tab4"+quarter).addClass('active');
				
				$("#ResultGraph").html(data);
				
			},
			complete : function(){
				
			}
		});
	}
	
	// 실적현황 그래프
	function fncResultGraph2(quarter){
		var quarter;
		if(quarter != null){
			quarter = quarter;
			
		}else{
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
			var nowMonth = '${sysYear}';
			
			switch (nowMonth) {
			case '01':
			case '02':
			case '03': 
				quarter = '1';
				break;
			
			case '04':
			case '05':
			case '06':
				
				quarter = '2';
				break;
				
			case '07':
			case '08':
			case '09':
				
				quarter = '3';
				break;
				
			default:
				quarter = '4';
				break;
			}
		}
		//$("#tab"+quarter).addClass('active');
		var params = $.param({
			datatype : 'html',
			jsp : "/main/mainSelectResultGraphMAjax2",
			searchMemberId : "${userInfo.MEMBER_ID_NUM}",
			searchQuarter : quarter,
		});
		
		$.ajax({
			url : "/main/selectResultGraphM2.do",
			async : false,
			datatype : 'html',
			//cache: false,
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				//console.log(data);
				/*
				for(var i=0; i<4; i++){
					$("#tab"+i).removeClass("active");
				}
				*/
				
				
				$("#graph2").html(data);
				$("#tab"+quarter).addClass('active');
				
				  	tabmenuLiWidth();
				  	tabmenuLiWidth4();
				
			},
			complete : function(){
				
			}
		});
	}

	function tabmenuLiWidth(){
		// 상세, 수정페이지 상단 TAb
		var tabmenu_w = $('.tabmenu').width();
		var tabmenu_length = $('.tabmenu li').length;
		var tabmenuLi_w = tabmenu_w/tabmenu_length;
		$('.tabmenu li').width(tabmenuLi_w);

		// 하단 고정버튼 영역 TAb
		// var pg_bottom_func_w = $('.pg_bottom_func').width();
		// var pg_bottom_func_length = $('.pg_bottom_func li').length;
		// var pg_bottom_funcLi_w = pg_bottom_func_w/pg_bottom_func_length;
		// $('.pg_bottom_func li').width(pg_bottom_funcLi_w);
	};

	function tabmenuLiWidth4(){
		// 상세, 수정페이지 상단 TAb
		var tabmenu_w4 = $('.tabmenu_type4').width();
		var tabmenu_length4 = $('.tabmenu_type4 li').length;
		var tabmenuLi_w4 = tabmenu_w4/tabmenu_length4;
		$('.tabmenu_type4 li').width(tabmenuLi_w4);
		// alert(tabmenu_length4);
	};
</script>
</html>

