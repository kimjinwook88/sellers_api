<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top_shareCalendar.jsp"%>

<div class="mem-calendar-title">
	<c:choose>
		<c:when test="${fn:length(calendarList) > 0}">
			<c:forEach items="${calendarList}" var="calendarList">
				<c:choose>
					<%-- <c:when test="${calendarList.SHARE_YN eq 'Y'}"> --%>
					<c:when
						test="${calendarList.MEMBER_ID_NUM ne userInfo.MEMBER_ID_NUM}">
						<span>${calendarList.HAN_NAME}
							${calendarList.POSITION_STATUS} 캘린더</span>
						<a href="javascript:window.close();" class="btn-close"><i
							class="fa fa-times"></i></a>
						<input type="hidden" id="hiddenMemberIdNum"
							value="${calendarList.MEMBER_ID_NUM}" />
						<input type="hidden" id="hiddenCalendarId"
							value="${calendarList.CALENDAR_ID}" />
					</c:when>
				</c:choose>
			</c:forEach>
		</c:when>
	</c:choose>
	<!-- <h2>캘린더</h2> -->
	<!-- <ol class="breadcrumb">
         <li>
             <a href="/main/index.do">Home</a>
         </li>
         <li class="active">
             <strong>캘린더</strong>
         </li>
     </ol> -->
</div>

<div class="wrapper wrapper-content">
	<div class="row animated fadeInDown calendar-grid"
		style="padding-right: 0px;">
		<div class="calendar-grid-l">
			<div class="ibox">
				<div class="ibox-content border_n">
					<!-- <input type="checkbox" name="checkboxCalendarSchedule" id="checkboxCalendarSchedule" /> -->
					<div id="calendar" class="fc fc-ltr fc-unthemed"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/jsp/pc/calendar/calendarOfColleagueModal.jsp" />
<%-- <jsp:include page="/WEB-INF/jsp/pc/calendar/calendarOfOfficeModal.jsp" /> --%>

</body>
<script>
/*
 *  전역변수
 */
var gridWidth;
var searchSerialize;
var modalFlag = "ins/upd"; //추가 수정 변수
var listRow = 10;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;

var date = new Date();
//$("#buttonModalSubmit").trigger("click");
$(document).ready(function() { 
	calendar.draw();
});	

var calendar = {
		otherCalendarPopup : function() {
				$('#divPopupOtherCalndar_Office365').hide();
				$('#divPopupOtherCalndar_Outlook').hide();
				$('#divPopupOtherCalndar_Google').hide();
				$('#divPopupOtherCalndar_General').show();
		},
		draw : function() {
			var d = date.getDate();
		    var m = date.getMonth();
		    var y = date.getFullYear();
		    var intiData = [];
		    var events;
		    
			$('#calendar').fullCalendar({
				events: function(start, end, timexone, callback, event) {
					var nowDate;
					nowDate = $('#calendar').fullCalendar('getDate');
	        		var selectYear = nowDate.format('YYYY');
	        		var selectMonth = nowDate.format('MM');
					
					$.ajax({
						url: '/calendar/calendarSharedUserEventList.do',
                  		datatype : 'json',
                  		beforeSend : function(xhr){
                  			$.ajaxLoadingShow();
							xhr.setRequestHeader("AJAX", true);
                  		},
              			data : {
              				datatype : 'json',
               				hiddenUserId : $("#userIdNum").val(),
               				hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
               				hiddenMemberIdNum : $("#hiddenMemberIdNum").val(),
               				selectYear : selectYear,
        	        		selectMonth : selectMonth,
               				CALENDAR_ID : $("#hiddenCalendarId").val(),
               				
               				thisMonthHoliday_id : function (view, element) {
               					var b = $('#calendar').fullCalendar('getDate');
    							return b._i[0]+'%';
               				}
               			},
               			success: function(data) {
               			
               				for(var i=0; i<data.holidays.length; i++) {
               					data.events.push({
               						title: data.holidays[i].title,
       								start: data.holidays[i].start,
     					            allDay: data.holidays[i].allDay,
     					            rendering: data.holidays[i].rendering,
     					            HOLIDAY_TYPE: data.holidays[i].HOLIDAY_TYPE
               					});
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
	               				}else if(data.office365Calendar[0].errStatus == 2){
	               					alert(data.office365Calendar[0].errMsg);
	               				}else{
	               				}
               				}
               				
               				textColor: 'black' // a non-ajax option
               				callback(data.events);
               				//callback(events);
               				
               				var calendarEvents = $('input[name="checkboxCalendarId"]');
               			},
               			complete: function() {
        					$.ajaxLoadingHide();
    					}
                  		
              });
					// any other sources...
			}, //event
			eventRender: function(event, element){
				if(event.rendering == 'background') {
   					element.append(event.title);
   					element.css({opacity: "inherit", float: "left", background: "none", color: "red"});
				}/* else if(event.CALENDAR_TYPE == 'google') {
					element.append('G');
				} */
				switch(event.EVENT_CODE) {
				case '1': //고객컨택
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#d0edfc"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon1.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon1.png\" class=\"v-m\">");
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '2': //컨택준비
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#d4edef"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon2.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon2.png\" class=\"v-m\">"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '3': //내부회의
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdebf5"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon3.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon3.png\" class=\"v-m\">"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '4': //교육
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#e1e1f7"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon4.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon4.png\" class=\"v-m\">"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '5': //이동시간
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdf6da"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon5.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon5.png\" class=\"v-m\">"); 
					$(element).find("a.fc-day-grid-event.fc-h-event.fc-event.fc-start.fc-end").hide();
					if(element[0].className=="fc-day-grid-event fc-h-event fc-event fc-start fc-end") {
						element.hide();
					}else if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						element.find("div .fc-time").html("");
						element.find("div .fc-title").html("");
					};
				break;
				case '6': //기타
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8f1c8"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon7.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon7.png\" class=\"v-m\">"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '7': //휴가
					element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8e9ea"});
					element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon6.png\" class=\"v-m\">"); 
					element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon6.png\" class=\"v-m\">"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				case '8': //오피스365
					element.css("border", "1px solid #fe8360");
					//element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_office\"></span></span>"); 
					//element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_office\"></span></span>"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				break;
				//--------------------------------------------------------------
				 default : //그 외
					element.css("border", "1px solid #b8aea2");
					//element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_comment\"></span></span>"); 
					//element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_comment\"></span></span>"); 
					if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
						//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
						element.find("div .fc-time").remove();
						element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
					};
				 break;
			}
					
			},//
			
			eventLimit: true,
			views: {
				month: {
					titleFormat: 'YYYY년 M월',
					columnFormat: 'ddd'
				},
				agendaWeek: {
					titleFormat: 'YYYY년 M월 D일',
					columnFormat: 'M/D [(]ddd[)]'
				},
				agendaDay: {
					titleFormat: 'YYYY년 M월 D일',
					columnFormat: 'dddd'
				},
				dayList: {
		            type: 'listYear',
		            duration: { days: 365 },
					titleFormat: '일정검색',
					listDayFormat: 'YYYY년 M월 D일 dddd',
					listDayAltFormat : '',
					allDayText: '종일'
			    }
		    },
			height: 850,
	        header: {
	            left: 'today prev,next checkSchedule', //좌측버튼
	            center: 'title', //가운데 타이틀
	            //right: 'insertSchedule month,agendaWeek,agendaDay,listYear' //우측버튼
	            right: 'insertSchedule month,agendaWeek,agendaDay' //우측버튼
	        },
	        timezone: 'local',
	        timeFormat: 'HH:mm', //주간,일간
	        allDayText: '시간', //주간,일간
	        axisFormat: 'Thh', //주간,일간
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        buttonText: {
	            prev: '이전',
	            next: '다음',
	            today: '오늘',
	            month: '월간',
	            week: '주간',
	            day: '일간',
	            //listYear: '리스트'
	        },
	        editable: false,
	        eventLimit: true, // allow "more" link when too many events
	        nowIndicator: true,
	        /*
	        
	            id : 아이디
	            title : 일정 제목
	            allDay : 시간 상관없이 시작일부터 끝일까지  true/false
	            start : 시작 일
	            end : 끝 일
	            url : 클릭시 해당 페이지로 이동
	            className : 특정 class의 css를 참조하는듯? String/배열
	            editable : 마우스 수정옵션 true/false, default false
	            startEditable : true/false, default true
	            durationEditable : true/false, default true
	            rendering : 특정일정을 배경에 표시함 'background'/'inverse-background'
	            overlap : eventOverlap선언되어있는  이벤트를 참고하는듯? true/false, default true
	                
	        */
	        googleCalendarApiKey: 'AIzaSyCKE8qrncJjPcV5T3uk2ZAi49l2yI7C1sg',
	        
	        eventClick: function(calEvent, jsEvent, view) {
	        	if(calEvent.EVENT_CODE == 8 || calEvent.EVENT_CODE == 9 || calEvent.EVENT_CODE == 10)
	        	{
		        	modalFlag = "upd";

		        	$("#textModalCountNum").val("");
		        	$("#textModalEndRuleDate").val("");
		        	$("#hiddenModalEndDate").val(moment(calEvent.end).format("YYYY-MM-DD"));
		        	
		        	var starteventdate = new Date(calEvent.start);
		        	var startyear = starteventdate.getFullYear();
		        	var startmonth = (starteventdate.getMonth() <= 8) ? "0"+(starteventdate.getMonth()+1).toString() : starteventdate.getMonth()+1;
		        	var startdate = (starteventdate.getDate() <= 9) ? "0"+(starteventdate.getDate()).toString() : starteventdate.getDate();
		        	var starthour = (starteventdate.getHours() <= 9) ? "0"+(starteventdate.getHours()).toString() : starteventdate.getHours();
		        	var startmin = (starteventdate.getMinutes() <= 9) ? "0"+(starteventdate.getMinutes()).toString() : starteventdate.getMinutes();
		        	
		        	var endeventdate;
		        	var endyear;
		        	var endmonth;
		        	var enddate;
		        	var endhour;
		        	var endmin;
		        	
		        	if(calEvent.end!=null) {
		        		if(calEvent.allDay==false) {
				        	endeventdate = new Date(calEvent.end);
				        	endyear = endeventdate.getFullYear();
				        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
				        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
				        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
				        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
		        		}else if(calEvent.allDay==true) {
		        			endeventdate = new Date(calEvent.end);
		        			endeventdate.setDate(endeventdate.getDate()-1);
				        	endyear = endeventdate.getFullYear();
				        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
				        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
				        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
				        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
		        		}
		        	}else {
		        		endeventdate = starteventdate;
			        	endyear = startyear;
			        	endmonth = startmonth;
			        	enddate = startdate;
			        	endhour = starthour;
			        	endmin = startmin;
		        	}
		        	
		        	$("h4.modal-title").html(calEvent.title);
		        	$("small.font-bold").html("일정 세부 정보입니다.");
		        	$("#textModalEventSubject2").val(calEvent.title);
		        	$("#selectModalEventCode2").val(calEvent.EVENT_CODE);
		        	$("#selectModalCalendarID2").val(calEvent.CALENDAR_ID);
		        	$("#textareaModalEventDetail2").val(calEvent.EVENT_DETAIL);
		        	$("#selectModalStartDateTime2").val(startyear+"-"+startmonth+"-"+startdate+"  "+starthour+":"+startmin);
		        	$("#selectModalEndDateTime2").val(endyear+"-"+endmonth+"-"+enddate+"  "+endhour+":"+endmin);
		        	
					$("#buttonModalDelete").css('display','');
		        	$("#myModalOutlook").modal();
		        	compare_before = $("#formModalData").serialize();
					//toggleDiv(modalFlag);
					
	        	}else{
	        		$.ajax({
						url : "/calendar/getInviteMemberList.do",
						datatype : 'json',
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
							$("#divInviteMemberList").html('');
				        	$("#divInviteMemberList").html('<div class="form-group"><label class="col-sm-2 control-label" style="text-align: center;">이름</label>'+
			               		   '<label class="col-sm-4 control-label" style="text-align: center;">메일</label>'+
			               		   '<label class="col-sm-2 control-label" style="text-align: center;">수락여부</label>'+
			               		   '<label class="col-sm-4 control-label" style="text-align: center;">수락시간</label></div>');
						},
						data :{
							datatype : 'json',
							hiddenModalEventId : calEvent.EVENT_ID
						},
						success : function(data){
							for(i=0; i<data.InviteMemberList.length; i++){
								$("#divInviteMemberList").append('<div class="form-group">');
								$("#divInviteMemberList").append('<div class=""><input type="hidden" class="form-control" value="'+ data.InviteMemberList[i].MEMBER_ID_NUM +'"/></div>');
								$("#divInviteMemberList").append('<div class="col-sm-2">'+data.InviteMemberList[i].HAN_NAME+'</div>');
								$("#divInviteMemberList").append('<div class=""><input type="hidden" class="form-control" value="'+data.InviteMemberList[i].BASIC_CALENDAR_ID+'"/></div>');
								$("#divInviteMemberList").append('<div class="col-sm-4">'+data.InviteMemberList[i].EMAIL+'</div>');
								$("#divInviteMemberList").append('<div class="col-sm-2">'+data.InviteMemberList[i].INVITE_YN+'</div>');
								$("#divInviteMemberList").append('<div class="col-sm-4">'+moment(data.InviteMemberList[i].SYS_UPDATE_DATE).format('YYYY[-]MM[-]DD HH:mm:ss')+'</div>');
								$("#divInviteMemberList").append('</div>');
							}
							
							if(data.InviteMemberList.length > 0){
								$("#checkboxModalInviteList").val("Y");
				        		$("#checkboxModalInviteList").prop("checked", true);
				        		$("#divModalConviteListOption").css("display", "");
							}else{
								$("#checkboxModalInviteList").val("N");
				        		$("#checkboxModalInviteList").prop("checked", false);
				        		$("#divModalConviteListOption").css("display", "none");
							}
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
		        	
		        	modalFlag = "upd";
		        	
		        	$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
	   					this.checked=false;
	   			    }); 
		        	$("#textModalCountNum").val("");
		        	$("#textModalEndRuleDate").val("");
		        	
		        	var starteventdate = new Date(calEvent.start);
		        	var startyear = starteventdate.getFullYear();
		        	var startmonth = (starteventdate.getMonth() <= 8) ? "0"+(starteventdate.getMonth()+1).toString() : starteventdate.getMonth()+1;
		        	var startdate = (starteventdate.getDate() <= 9) ? "0"+(starteventdate.getDate()).toString() : starteventdate.getDate();
		        	var starthour = (starteventdate.getHours() <= 9) ? "0"+(starteventdate.getHours()).toString() : starteventdate.getHours();
		        	var startmin = (starteventdate.getMinutes() <= 9) ? "0"+(starteventdate.getMinutes()).toString() : starteventdate.getMinutes();
		        	
		        	var endeventdate;
		        	var endyear;
		        	var endmonth;
		        	var enddate;
		        	var endhour;
		        	var endmin;
		        	
		        	if(calEvent.end!=null) {
			        	endeventdate = new Date(calEvent.end);
			        	endyear = endeventdate.getFullYear();
			        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
			        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
			        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
			        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
		        	}else {
		        		endeventdate = starteventdate;
			        	endyear = startyear;
			        	endmonth = startmonth;
			        	enddate = startdate;
			        	endhour = starthour;
			        	endmin = startmin;
		        	}
		        	
		        	$("h4.modal-title").html(calEvent.title);
		        	$("small.font-bold").html("일정 세부 정보입니다.");
		        	
		        	$("#textModalEventSubject").val(calEvent.title);
		        	$("#selectModalEventCode").val(calEvent.EVENT_CODE);
		        	$("#selectModalCalendarID").val(calEvent.CALENDAR_ID);
		        	$("#textareaModalEventDetail").val(calEvent.EVENT_DETAIL);
		        	/* 
		        	$("#textModalStartDate").val(startyear+"-"+startmonth+"-"+startdate);
		        	$("#selectModalStartDateTime").val(starthour+":"+startmin);
		        	$("#textModalEndDate").val(endyear+"-"+endmonth+"-"+enddate);
		        	$("#selectModalEndDateTime").val(endhour+":"+endmin);
		        	 */
		        	 
		        	$("#textModalStartDateTime").val(startyear+"-"+startmonth+"-"+startdate+"  "+starthour+":"+startmin);
		        	$("#textModalEndDateTime").val(endyear+"-"+endmonth+"-"+enddate +"  "+endhour+":"+endmin);
		        	$("#textModalEventLocation").val(calEvent.LOCATION);
		        	//alert(calEvent.allDay==false);
		        	if(calEvent.allDay==false) {
		        		$("#checkboxModalAllday").val("N");
		        		$("#hiddenModalAllday_YN").val("N");
		        		$("#checkboxModalAllday").prop("checked", false);
		        		$("#selectModalStartDateTime").attr("disabled", false); 
		        		$("#selectModalEndDateTime").attr("disabled", false);
		        	}else if(calEvent.allDay==true){
		        		$("#checkboxModalAllday").val("Y");
		        		$("#hiddenModalAllday_YN").val("Y");
		        		$("#checkboxModalAllday").prop("checked", true);
		        		$("#selectModalStartDateTime").val(""); $("#selectModalStartDateTime").attr("disabled", true); 
		        		$("#selectModalEndDateTime").val(""); $("#selectModalEndDateTime").attr("disabled", true);
		        	}
		        	if(calEvent.REPEAT_YN=="Y" || calEvent.REPEAT_Y=="Y") {
		        		//alert("");
		        		$("#checkboxModalRepeat").val("Y");
		        		$("#hiddenModalRepeat_YN").val("Y");
		        		$("#checkboxModalRepeat").prop("checked", true);
		        		$("#selectModalFreq").val(calEvent.RECURRENCE_FREQ);
		        		$("#divModalInterval").val(calEvent.RECURRENCE_INTERVAL);
		        		if(calEvent.RECURRENCE_BYWEEKDAY!=undefined) {
		        			var byWeekDay = calEvent.RECURRENCE_BYWEEKDAY.split(",");
		        			for(var i=0; i<byWeekDay.length; i++) {
		        				$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
		        					if($(this).val()==byWeekDay[i]) {
		        						this.checked=true;
		        					}
		        			    }); 
		        			}
		        		}
		        		if(calEvent.RECURRENCE_END_DATE!=undefined) {
		        			$("#checkboxModalEndRuleDate").prop("checked", true);
		        			$("#textModalEndRuleDate").val(calEvent.RECURRENCE_END_DATE);
		        			$("#textModalEndRuleDate").attr("disabled", false);
		        			$("#textModalCountNum").attr("disabled", true);
		        		}else if(calEvent.RECURRENCE_COUNT==500) {
		        			$("#radioModalCountNull").prop("checked", true);
		        			$("#textModalEndRuleDate").attr("disabled", true);
		        			$("#textModalCountNum").attr("disabled", true);
		        		}else if(calEvent.RECURRENCE_COUNT<500 || calEvent.RECURRENCE_COUNT>500) {
		        			$("#radioModalCountNum").prop("checked", true);
		        			$("#textModalCountNum").val(calEvent.RECURRENCE_COUNT);
		        			$("#textModalEndRuleDate").attr("disabled", true);
		        			$("#textModalCountNum").attr("disabled", false);
		        		}else {
		        			$("#radioModalCountNull").prop("checked", true);
		        			$("#textModalCountNum").val("");
		        			$("#textModalCountNum").attr("disabled", true);
		        			$("#textModalEndRuleDate").val("");
		        			$("#textModalEndRuleDate").attr("disabled", true);
		        		}
		        		//$("#").val();
		        		//$("#").val();
		        		//$("#").val();
		        		$("#hiddenModalRruleString").val(calEvent.RECURRENCE_RULE);
		        		$("#divModalRepeatOption").css("display", "");
		        	}else if(calEvent.REPEAT_YN=="N" || calEvent.REPEAT_YN==null) {
		        		$("#checkboxModalRepeat").val("N");
		        		$("#hiddenModalRepeat_YN").val("N");
		        		$("#checkboxModalRepeat").prop("checked", false);
		        		$("#divModalRepeatOption").css("display", "none");
		        	}
		        	/* 
		        	if(calEvent.MOVE_TIME_MIN=="" || calEvent.MOVE_TIME_MIN==null) {
		        		$("#checkboxModalMove").val("N");
		        		$("#checkboxModalMove").prop("checked", false);
		        		$("#divModalMoveOption").css("display", "none");
		        	}else {
		        		$("#checkboxModalMove").val("Y");
		        		$("#checkboxModalMove").prop("checked", true);
		        		$("#divModalMoveOption").css("display", "");
		        		$("#selectModalBeforeMoveTimeMin").val(calEvent.BEFORE_MOVE_TIME);
		        		$("#selectModalAfterMoveTimeMin").val(calEvent.AFTER_MOVE_TIME);
		        	}
		        	 */
		        	if(calEvent.BEFORE_MOVE_TIME =="" || calEvent.BEFORE_MOVE_TIME==null){
		        		$("#divModalEventCode").css("display", "none");
		        	}else{
		        		$("#divModalEventCode").css("display", "");
		        		$("#selectModalBeforeMoveTimeMin").val(calEvent.BEFORE_MOVE_TIME);
		        	}
		        	if(calEvent.AFTER_MOVE_TIME =="" || calEvent.AFTER_MOVE_TIME==null){
		        		$("#divModalEventCode2").css("display", "none");
		        	}else{
		        		$("#divModalEventCode2").css("display", "");
		        		$("#selectModalAfterMoveTimeMin").val(calEvent.AFTER_MOVE_TIME);
		        	}
		        	
		        	//일단 무조건 체크 해제
		        	$("#checkboxModalInvite").val("N");
	        		$("#checkboxModalInvite").prop("checked", false);
	        		$("#divModalConviteOption").css("display", "none");
		        	
		        	
		        	
		        	$("#textModalInviteName").val(calEvent.INVITE_NAME);
		        	$("#textModalInviteId").val(calEvent.INVITE_MEMBER_ID);
		        	$("#textModalInviteMail").val(calEvent.INVITE_EMAIL);
		        	$("#textModalInviteCalendarId").val(calEvent.INVITE_CALENDAR_ID);
		        	$("#hiddenModalEventId").val(calEvent.EVENT_ID);
		        	
					/* $("#buttonModalSubmit").html("저장하기"); */
					$("#buttonModalDelete").css('display','');
		        	
		        	$("#myModal3").modal();
		        	compare_before = $("#formModalData").serialize();
					//toggleDiv(modalFlag);
	        	}
	        }
	        
	    });
	} //draw
}
</script>
<%-- <%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%> --%>