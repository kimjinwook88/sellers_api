<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>

	<article class="topControl primary_bg">
		<div class="func_left fl_l">
			<a href="#" class="btn_prev va_m" onclick="fncMoveToDate('${prevDate}'); return false;">이전</a>
			<span class="current_date va_m">${cYear}년 ${cMonth}월 ${cDay}일</span>
			<a href="#" class="btn_next va_m" onclick="fncMoveToDate('${nextDate}'); return false;">다음</a>
		</div>
		<div class="func_right fl_r">
			<a href="" onClick="fncAddSchedule(); return false;"><span class="va_t icon_add">일정추가</span></a>
		</div>
	</article>

	<article class="schedule_cont">

		<ul class="schedule_list" id="result_list">
		</ul>
		
        <p class="guide_blank pd_t50" id="empty_result" style="display:none;">
            오늘은 등록된 일정이 없습니다.<br/>
            일정을 등록해주세요.
        </p>

	</article>

<jsp:include page="/WEB-INF/jsp/m/common/calendar_footer.jsp"/>
<!-- 
	<article class="fix_func">
		<ul>
			<li>
				<a href="" class="active">일</a>
			</li>
			<li>
				<a href="/calendar/calendarMonth.do">월</a>
			</li>
			<li>
				<a href="/calendar/calendarEvent.do">일정목록</a>
			</li>
			<li>
				<a href="">오늘</a>
			</li>
		</ul>
	</article>
 -->
 
</div>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/moment/moment.js"></script>

<script type="text/javascript">
	function fncList(){
		window.history.back();
	}
	
	function fncShowDetail(_event_id){
		location.href="/calendar/modalCalendarForm.do?mode=M&eventId="+_event_id+"&pos=calendar";
	}
	
	function fncRegister(){
		$('#frmPartner').attr('action', '');
		$('#frmPartner').submit();
	}
	
	function fncMoveToDate(_date){
		location.href="/calendar/calendar.do?curDate="+_date;
	}

	function fncGetItemHtml(_object, start_date){
		var obj_html = '';
		if (_object.PAST_YN == 'Y'){
			obj_html += '<li class="complete">';
		} else {
			obj_html += '<li>';
		}
		obj_html += '<a href="/calendar/modalCalendarForm.do?mode=M&eventId='+_object.EVENT_ID+'&pos=calendar&start_date='+start_date+'"><span class="time">';
		obj_html += '<span class="va_m">'+_object.START_TIME+'~'+_object.END_TIME+'</span></span>';
		obj_html += '<span class="icon lg icon_sch_'+_object.EVENT_CODE+'"></span><span class="subject">'+_object.title+'</span>';
		obj_html += '</a>';
		obj_html += '</li>';
		return obj_html;
	}
	
	function fncAddSchedule() {
		location.href="/calendar/modalCalendarForm.do?mode=I&curDate=${curDate}&pos=calendar";
	}
	
	function fncShowCalendar() {
		
		var calendarCheck_id = [];
		<c:forEach items="${calendarList}" var="calendar">
			calendarCheck_id.push('${calendar.CALENDAR_ID}');
		</c:forEach>
		
		var member_id_num = "${userInfo.MEMBER_ID_NUM}";
		var c_year = "${cYear}";
		var c_month = "${cMonth}";
		var c_day = "${cDay}";
		
		//c_month = (c_month.length == 1)?"0"+c_month:c_month;
		//c_day = (c_day.length == 1)?"0"+c_day:c_day;
		//c_cur_date = c_year + '-' + c_month + '-' + c_day;
		
		$.ajax({
			type : "POST",
			data : {
				"hiddenModalCreatorId" : member_id_num,
				"startRange" : '${startRange}',
				"endRange" : '${endRange}',
				"startDate" : '${startRange}',
				"endDate" : '${endRange}',
				"calendarCheck_id" : calendarCheck_id.toString(),
				
				"datatype" : 'json',
				"hiddenUserId" : member_id_num,
				"selectYear" : c_year,
				"selectMonth" : c_month,
				"outlook" : 'N',
				"office365" : 'N',
				"google" : '',
				"thisMonthHoliday_id" : c_year+'%',
			},
			async: false,
			url: "/calendar/calendarEventListMobile.do",
			success:function(data){
				var list = data.events;
				var list_html = '';
				var start_date = '';
				for (var i = 0; i < list.length; i++){
					if(list[i].START_DAY == "${curDate}") {
						start_date = moment(list[i].START_DAY).format("YYYY-MM-DD");
						list_html += fncGetItemHtml(list[i], start_date);
					}
				} 
				
				$('#result_list').html(list_html);
				
				if(list_html == '') {
					$('#empty_result').show();
				}
				
				//if (list.length == 0) $('#empty_result').show();
				//else $('#empty_result').hide();
			}
		});
	}
	
	$(document).ready(function() {
		fncShowCalendar();
	});
	
</script>

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>