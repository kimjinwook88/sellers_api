$.ajaxLoadingShow = function(){
   $("div.ajaxMask").show(); //ajax Loading
   $("div.ajax-loader_sellers").show(); //ajax Loading
}
 
 $.ajaxLoadingHide = function(){
   $("div.ajaxMask").hide(); //ajax Loading
   $("div.ajax-loader_sellers").hide(); //ajax Loading
}
 
var tmp_start_date = '';

//버튼 기능
function month_prev_btn(_date){
	//function fncMoveToDate(_date){
	//location.href="/calendar/calendarMonth.do?curDate="+_date;
	//window.location.href="/calendar/viewCalendar.do?curDate="+_date;
	$('#calendar').fullCalendar('prev');
	$('.current_date').html($('#ymd').html());
	
	tmp_start_date = '';
}

	
function month_next_btn(_date){
	//alert(_date);
	//window.location.href="/calendar/viewCalendar.do?curDate="+_date;
	$('#calendar').fullCalendar('next');
	$('.current_date').html($('#ymd').html());
	
	tmp_start_date = '';
}

//스케쥴 추가
function fncAddSchedule(_date) {
	location.href="/calendar/modalCalendarForm.do?mode=I&curDate="+_date+"&pos=viewCalendar";
}


function fncGetItemHtml(_item, start_date){
	var item_html = '';
	item_html += '<li><a href="/calendar/modalCalendarForm.do?mode=M&eventId='+_item.EVENT_ID+'&pos=viewCalendar&start_date='+start_date+'"><span class="time">'+_item.START_TIME+'</span>';
	item_html += '<span class="icon lg icon_sch_'+_item.EVENT_CODE+'"></span><span class="subject">'+_item.title+'</span></a></li>';
	return item_html;
}

/**
 * 캘린더 그림
 * @returns
 */
function draw(){
	$('#calendar').fullCalendar({
		height: 500,
		timezone: 'local',
		timeFormat: 'HH:mm', //주간,일간
		events: function(start, end, timexone, callback, events) {
			
			/*
			var calendarCheck_id = [];

			<c:choose>
				<c:when test="${fn:length(calendarList) > 0}">
					<c:forEach items="${calendarList}" var="calendar">
					calendarCheck_id.push('${calendar.CALENDAR_ID}');
					</c:forEach>
				</c:when>
				<c:otherwise>
					addCalendar();
				</c:otherwise>
			</c:choose>*/
			
			$.ajax({
				url: "/calendar/calendarEventList.do",
				type : "POST",
				data : {
					"hiddenModalCreatorId" : userId,
					"startRange" : startRange,
					"endRange" : endRange,
					"startDate" : start._d.toISOString().slice(0, 10),
					"endDate" : end._d.toISOString().slice(0, 10),
					"calendarCheck_id" : calendarCheck_id.toString(),
					"datatype" : 'json',
					"hiddenUserId" : userId,
					"selectYear" : selectYear,
					"selectMonth" : selectMonth,
					"outlook" : "N",
					"office365" : fncOffice365,
					"google" : '',
					"thisMonthHoliday_id" : selectYear+'%'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success:function(data){
					var event = data.events;
					var holidays = data.holidays;
					
					for(var i=0; i < holidays.length; i++) {
						data.events.push({
       						title: holidays[i].title,
							start: holidays[i].start,
				            allDay:holidays[i].allDay,
				            renderi: holidays[i].rendering,
				            HOLIDAY_TYPE: holidays[i].HOLIDAY_TYPE
       					});
       				}
				
					for(var i=0; i<data.events.length; i++) {
           				if(typeof(data.events[i].allDay)=="string"){
           					data.events[i].allDay = parseInt(data.events[i].allDay);
           				}
       				}
					
					//종일 수정
					for(var i=0; i<data.events.length; i++) {
           				if(data.events[i].allDay==1){
          					var endeventdate = new Date(data.events[i].end);
       	        			endeventdate.setDate(endeventdate.getDate()-1);
       	        			var starteventdate = new Date(data.events[i].start);
          					data.events[i].start = starteventdate;
          					data.events[i].end = endeventdate;
           				}
       				}
					
					if(data.office365Calendar != undefined) {
           				if(data.office365Calendar[0].errStatus == 0){
           					alert(data.office365Calendar[0].errMsg);
           					window.location.reload();
           				}else if(data.office365Calendar[0].errStatus == 1){
               				if(data.office365Calendar !=null){
               					 for(var i=0; i<data.office365Calendar.length; i++){
               						data.events.push({
               							start : data.office365Calendar[i].DTSTART,
               							end : data.office365Calendar[i].DTEND,
               							title: data.office365Calendar[i].SUMMARY,
               							EVENT_DETAIL: data.office365Calendar[i].DESCRIPTION,
               							CALENDAR_ID: data.office365Calendar[i].CALENDAR_ID,
               							LOCATION: data.office365Calendar[i].LOCATION,
               							EVENT_CODE: '8',
	               						textColor: 'black',
	               					 	backgroundColor: 'white'
               						});
               					}
               				} 
           				}else if(data.office365Calendar[0].errStatus == 9){
           					//alert(data.office365Calendar[0].errMsg);
           				}else{
           					alert(data.office365Calendar[0].errMsg);
           				}
       				}
					
					textColor: 'black'
					callback(data.events);
				},
				complete : function(){
					$.ajaxLoadingHide();
				},
				error : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		eventRender: function(event, element){
			if(event.renderi == 'background' && event.start != null) {
					start_date = moment(event.start);
					start_date = start_date.format("YYYY-MM-DD");
																
					if(start_date == tmp_start_date)
						v_title = ',' + event.title;
					else
						v_title = event.title;
					
					tmp_start_date = start_date;
					
				$('#holiday_'+start_date).append(v_title);
				//$('#holiday_'+start_date).append(event.title);
				$('#holiday_'+start_date).css("color","red");
				$('#holiday_'+start_date).css("display","block");
				$('#holiday_'+start_date).css("text-overflow","ellipsis");
				$('#holiday_'+start_date).css("white-space","nowrap");
				$('#holiday_'+start_date).css("word-wrap","normal");
				$('#holiday_'+start_date).css("overflow","hidden");
				element.css({display:"none"});
			}
			
			// 이동시간은 출력하지 않음
			if(event.EVENT_CODE == '5'){
				element.hide();
			}
		},
		eventClick: function(event) {
			if(event.EVENT_CODE == "8"){ //outlook
				var start_date = moment(event.start);
				start_date = start_date.format("HH:mm");
				var end_date = moment(event.end);
				end_date = end_date.format("HH:mm");
				
				$("div.daysch_list_pop").show();
				$("#modal_day_title").html(moment(event.start).format("YYYY-MM-DD"));
				$("ul#modal_result_list li:nth-child(1)").find("span").eq(0).html(start_date+" ~ " +end_date); //time
				$("ul#modal_result_list li:nth-child(1)").find("span").eq(1).html(event.title); //title
				$("ul#modal_result_list li:nth-child(2)").find("span").html(event.LOCATION);
				//$("ul#modal_result_list li").find("span").eq(3).html(event.EVENT_DETAIL); //detail
			}else{
				var start_date = moment(event.START_DAY).format("YYYY-MM-DD");				
				window.location.href= "/calendar/modalCalendarForm.do?mode=M&eventId="+event.EVENT_ID+"&pos=viewCalendar&start_date="+start_date;
			}
		} 
	});
}

$(document).ready(function() {
	if(noticeEventId != '' ){
		location.href = '/calendar/modalCalendarForm.do?mode=M&eventId='+noticeEventId;
	}
	
	draw();
	return;
	
	initThemeChooser({
		init: function(themeSystem) {
			/*var calendarCheck_id = [];
			<c:choose>
				<c:when test="${fn:length(calendarList) > 0}">
					<c:forEach items="${calendarList}" var="calendar">
					calendarCheck_id.push('${calendar.CALENDAR_ID}');
					</c:forEach>
				</c:when>
				<c:otherwise>
					addCalendar();
				</c:otherwise>
			</c:choose>*/
			
			$.ajax({
				type : "POST",
				data : {
					"hiddenModalCreatorId" : userId,
					"startRange" : startRange,
					"endRange" : endRange,
					"calendarCheck_id" : calendarCheck_id.toString(),
					
					"datatype" : 'json',
					"hiddenUserId" : userId,
					"selectYear" : selectYear,
					"selectMonth" : selectMonth,
					"outlook" : 'N',
					"office365" : 'N',
					"google" : '',
					"thisMonthHoliday_id" : selectYear+'%'
				},
				async: false,
				url: "/calendar/calendarEventList.do",
				success:function(data){
					var daily_event_cnt = 0;
					var current_day = '';
					var daily_time_date = null;
					var holidays = data.holidays;
					for (var i = 0; i < holidays.length; i++){
						var _html = '<span class="annual">'+holidays[i].title+'</span>';
						$('#a_'+holidays[i].start).append(_html);
					}
					var events2 = data.events;
					
					//alert("events2 길이" + events2.length);
					if(events2.length == 0){
						//alert("이벤트 할당 없음");
						$('#calendar').fullCalendar({
							events: function(start, end, timexone, callback, events) {
								$.ajax({
									url: "/calendar/calendarEventList.do",
									type : "POST",
									data : {
										"hiddenModalCreatorId" : userId,
										"startRange" : startRange,
										"endRange" : endRange,
										"calendarCheck_id" : calendarCheck_id.toString(),
										
										"datatype" : 'json',
										"hiddenUserId" : userId,
										"selectYear" : selectYear,
										"selectMonth" : selectMonth,
										"outlook" : 'N',
										"office365" : 'N',
										"google" : '',
										
										"thisMonthHoliday_id" : selectYear+'%'
									},
									success:function(data){
										var event = data.events;
										var holidays = data.holidays;
										
										for(var i=0; i < holidays.length; i++) {
											data.events.push({
			               						title: holidays[i].title,
			       								start: holidays[i].start,
			     					            allDay:holidays[i].allDay,
			     					            renderi: holidays[i].rendering,
			     					            HOLIDAY_TYPE: holidays[i].HOLIDAY_TYPE
			               					});
			               				}
										textColor: 'black'
										callback(data.events);
									}
								});
							},
							eventRender: function(event, element){
								if(event.renderi == 'background' && event.start != null) {
										start_date = moment(event.start);
										start_date = start_date.format("YYYY-MM-DD");
										
										if(start_date == tmp_start_date)
											v_title = ',' + event.title;
										else
											v_title = event.title;
										
										tmp_start_date = start_date;
										
									$('#holiday_'+start_date).append(v_title);
										//$('#holiday_'+start_date).append(event.title);
										$('#holiday_'+start_date).css("color","red");
										$('#holiday_'+start_date).css("display","block");
										$('#holiday_'+start_date).css("text-overflow","ellipsis");
										$('#holiday_'+start_date).css("white-space","nowrap");
										$('#holiday_'+start_date).css("word-wrap","normal");
										$('#holiday_'+start_date).css("overflow","hidden");
										element.css({display:"none"});
								}
							}
						});
					}else{
						//alert("이벤트 할당 영역");
						for (var i = 0; i < events2.length; i++){
							if (current_day != events2[i].START_DAY){
								if (current_day == '' || daily_event_cnt == 0){
									//비교할 날짜가 없거나 이벤트쌓인게 없으면 아무것도 안함
								} else if (daily_event_cnt > 4) {
									//전일 이벤트가 4개보다 많으면 얼마만큼 더 많다고 표시해주기
									var over_cnt = daily_event_cnt - 4;
									$('#a_'+current_day).append('<span class="over_count">+'+over_cnt+'</span>');
								}
								
								//날짜인덱스 변경
								current_day = events2[i].START_DAY;
								
								//일별 이벤트 카운터 리셋
								daily_event_cnt = 0;
							}
							
							daily_event_cnt ++;
							
								//if(events2[i].START_DAY != events2[i].END_DAY){
									var calHeight = 380;
									$('#calendar').fullCalendar({
										height:calHeight,
										contentHeight:calHeight,
										themeSystem: 'standard',
										header: {
											//left: 'prev,next today',
											//center: 'title',
											//right: 'month,agendaWeek,agendaDay,'
										},
										defaultDate: current_day,
										lang: "ko",
										weekNumbers: false,
										navLinks: false, // can click day/week names to navigate views
										editable: false,
										eventLimit: true, // allow "more" link when too many events
										// 날짜 정보 들어가는 곳
										events: function(start, end, timexone, callback, events) {
											$.ajax({
												url: "/calendar/calendarEventList.do",
												type : "POST",
												data : {
													"hiddenModalCreatorId" : userId,
													"startRange" : startRange,
													"endRange" : endRange,
													"calendarCheck_id" : calendarCheck_id.toString(),
													"datatype" : 'json',
													"hiddenUserId" : userId,
													"selectYear" : selectYear,
													"selectMonth" : selectMonth,
													"outlook" : 'N',
													"office365" : 'N',
													"google" : 'N',
													"thisMonthHoliday_id" : selectYear+'%'
												},
												success:function(data){
													var event = data.events;
													
													var holidays = data.holidays;
													var min_events = new Array();
													for(var i=0; i < holidays.length; i++) {
														min_events.push({
						               						title: holidays[i].title,
						       								start: holidays[i].start,
						     					            allDay:holidays[i].allDay,
						     					            renderi: holidays[i].rendering,
						     					            HOLIDAY_TYPE: holidays[i].HOLIDAY_TYPE
						               					});
						               				}
													
													textColor: 'black';
						               				
						               				var testArr = new Array();
						               				// 2019-02-19 
						               				// 모바일에서 이동시간이 나오는 오류로 event_id가 없는 이동시간은 걸러서 다시 배열로 정리
						               				
						               				for(var i=0; i<data.events.length; i++){
						               					
						               					// 이동시간 제외
						               					if(data.events[i].EVENT_ID != null){
						               						if(data.events[i].DAYS_COUNT > 1){
						               							min_events.push(
								               							{
								               								"EVENT_ID" : data.events[i].EVENT_ID,
								               								"CALENDAT_ID" : data.events[i].CALENDAT_ID,
								               								"EVENT_CODE" : data.events[i].EVENT_CODE,
								               								"title" : data.events[i].title,
								               								"EVENT_DETAIL" : data.events[i].EVENT_DETAIL,
								               								"allDay" : data.events[i].allDay,
								               								"start" : data.events[i].start,
								               								"end" : data.events[i].M_END_TIME,
								               								"TIME_GAP" : data.events[i].TIME_GAP,
								               								"BEFORE_MOVE_TIME" : data.events[i].BEFORE_MOVE_TIME,
								               								"AFTER_MOVE_TIME" : data.events[i].AFTER_MOVE_TIME,
								               								"textColor" : data.events[i].textColor,
								               								"backgroundColor" : data.events[i].backgroundColor,
								               								"REPEAT_YN" : data.events[i].REPEAT_YN,
								               								"RECURRENCE_ID" : data.events[i].RECURRENCE_ID,
								               								"RECURRENCE_FREQ" : data.events[i].RECURRENCE_FREQ,
								               								"RECURRENCE_INTERVAL" : data.events[i].RECURRENCE_INTERVAL,
								               								"RECURRENCE_END_DATE" : data.events[i].RECURRENCE_END_DATE,
								               								"RECURRENCE_COUNT" : data.events[i].RECURRENCE_COUNT,
								               								"RECURRENCE_BYWEEKDAY" : data.events[i].RECURRENCE_BYWEEKDAY,
								               								"RECURRENCE_BYMONTHDAY" : data.events[i].RECURRENCE_BYMONTHDAY,
								               								"RECURRENCE_RULE" : data.events[i].RECURRENCE_RULE,
								               								"END_RULE" : data.events[i].END_RULE,
								               								"EX_DATE" : data.events[i].EX_DATE,
								               								"EX_DATE_YN" : data.events[i].EX_DATE_YN,
								               								"LOCATION" : data.events[i].LOCATION,
								               								"SHARE_YN" : data.events[i].SHARE_YN,
								               								"ALARM_FLAG" : data.events[i].ALARM_FLAG,
								               								"ALARM_TARGET" : data.events[i].ALARM_TARGET,
								               								"RRULE_SYNC_ID" : data.events[i].RRULE_SYNC_ID,
								               								"PAST_YN" : data.events[i].PAST_YN,
								               								"START_TIME" : data.events[i].START_TIME,
								               								"END_TIME" : data.events[i].END_TIME,
								               								"START_DAY" : data.events[i].START_DAY,
								               								"END_DAY" : data.events[i].END_DAY,
								               								"COUNT" : data.events[i].DAYS_COUNT
								               							}
								               					);
						               						}else{
						               							min_events.push(
								               							{
								               								"EVENT_ID" : data.events[i].EVENT_ID,
								               								"CALENDAT_ID" : data.events[i].CALENDAT_ID,
								               								"EVENT_CODE" : data.events[i].EVENT_CODE,
								               								"title" : data.events[i].title,
								               								"EVENT_DETAIL" : data.events[i].EVENT_DETAIL,
								               								"allDay" : data.events[i].allDay,
								               								"start" : data.events[i].start,
								               								"end" : data.events[i].end,
								               								"TIME_GAP" : data.events[i].TIME_GAP,
								               								"BEFORE_MOVE_TIME" : data.events[i].BEFORE_MOVE_TIME,
								               								"AFTER_MOVE_TIME" : data.events[i].AFTER_MOVE_TIME,
								               								"textColor" : data.events[i].textColor,
								               								"backgroundColor" : data.events[i].backgroundColor,
								               								"REPEAT_YN" : data.events[i].REPEAT_YN,
								               								"RECURRENCE_ID" : data.events[i].RECURRENCE_ID,
								               								"RECURRENCE_FREQ" : data.events[i].RECURRENCE_FREQ,
								               								"RECURRENCE_INTERVAL" : data.events[i].RECURRENCE_INTERVAL,
								               								"RECURRENCE_END_DATE" : data.events[i].RECURRENCE_END_DATE,
								               								"RECURRENCE_COUNT" : data.events[i].RECURRENCE_COUNT,
								               								"RECURRENCE_BYWEEKDAY" : data.events[i].RECURRENCE_BYWEEKDAY,
								               								"RECURRENCE_BYMONTHDAY" : data.events[i].RECURRENCE_BYMONTHDAY,
								               								"RECURRENCE_RULE" : data.events[i].RECURRENCE_RULE,
								               								"END_RULE" : data.events[i].END_RULE,
								               								"EX_DATE" : data.events[i].EX_DATE,
								               								"EX_DATE_YN" : data.events[i].EX_DATE_YN,
								               								"LOCATION" : data.events[i].LOCATION,
								               								"SHARE_YN" : data.events[i].SHARE_YN,
								               								"ALARM_FLAG" : data.events[i].ALARM_FLAG,
								               								"ALARM_TARGET" : data.events[i].ALARM_TARGET,
								               								"RRULE_SYNC_ID" : data.events[i].RRULE_SYNC_ID,
								               								"PAST_YN" : data.events[i].PAST_YN,
								               								"START_TIME" : data.events[i].START_TIME,
								               								"END_TIME" : data.events[i].END_TIME,
								               								"START_DAY" : data.events[i].START_DAY,
								               								"END_DAY" : data.events[i].END_DAY,
								               								"COUNT" : data.events[i].DAYS_COUNT
								               							}
								               					);
						               						}
						               						/*
						               						if(data.events[i].START_DAY != data.events[i].END_DAY){
						               						}
						               						*/
						               					}
						               				}
													callback(min_events);
												}
											});
										},
										
										eventRender: function(event, element){
											if(event.renderi == 'background' && event.start != null) {
 												start_date = moment(event.start);
 												start_date = start_date.format("YYYY-MM-DD");
 												
 												if(start_date == tmp_start_date)
 													v_title = ',' + event.title;
												else
													v_title = event.title;
 												
 												tmp_start_date = start_date;
 												
												$('#holiday_'+start_date).append(v_title);
 												//$('#holiday_'+start_date).append(event.title);
  												$('#holiday_'+start_date).css("color","red");
  												element.css({display:"none"});
											}
 											
 											switch(event.EVENT_CODE){
 												case '1' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#d0edfc"});
 												break;
 												case '2' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#d4edef"});
 												break;
 												case '3' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdebf5"});
 												break;
 												case '4' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#e1e1f7"});
 												break;
 												case '5' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdf6da"});
 												break;
 												case '6' :
 													element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8f1c8"});
 												break;
 												case '7' :
  													element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8e9ea"});
 												break;	
 											}
										},
										eventClick: function(event) {
											// 해당 일 클릭하면 일정 리스트 업
											start_date = moment(event.start);
											start_date = start_date.format("YYYY-MM-DD");
											window.location.href= "/calendar/modalCalendarForm.do?mode=M&eventId="+event.EVENT_ID+"&pos=viewCalendar&start_date="+start_date;
										}//eventClick end
									});//fullcalendar end
								//}if end
							//}
						}
					}
				}
			});
			
			
		},

		change: function(themeSystem) {
			$('#calendar').fullCalendar('option', 'themeSystem', themeSystem);
		}

	}); 

});

function addCalendar(){
	var params = $.param({
		hiddenModalCreatorId : userId,
		textCalendarName : '나의 캘린더',
		datatype : 'json'
	});
	
	$.ajax({
		url : "/calendar/addCalendar.do",
		datatype : 'json',
		data :params,
		async : false,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			alert("나의 캘린더가 생성되었습니다.");
			window.location.reload();
		},
		complete : function(){
			//$.ajaxLoadingHide();
		}
	});
}