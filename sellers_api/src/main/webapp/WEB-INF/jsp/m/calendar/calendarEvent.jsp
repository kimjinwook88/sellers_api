<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>

	<!-- <article class="schedule_cont pd_t30 pd_b20" id="result_list"> -->
	<article class="schedule_cont pd_b20" id="result_list">
		<!-- 일정목록 /이전, 다음버튼 -->
		<nav class="schedule_all_list_navi pd_t20">
<!-- 
			<a href="#" class="mg_r5"><img src="../../../images/m/icon_arrow_up.svg" alt="이전"/></a>
			<a href="#"><img src="../../../images/m/icon_arrow_down.svg" alt="다음"/></a>
 -->
		</nav>
		<!-- 이전, 다음 일정은 1주일 단위로 나오도록 해주세요. -->
		<!--// 일정목록 /이전, 다음버튼 -->

	</article>

<jsp:include page="/WEB-INF/jsp/m/common/calendar_footer.jsp"/>
<!-- 
	<article class="fix_func">
		<ul>
			<li>
				<a href="/calendar/calendar.do">일</a>
			</li>
			<li>
				<a href="/calendar/calendarMonth.do">월</a>
			</li>
			<li>
				<a href="" class="active">일정목록</a>
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

	function fncShowCalendar() {
		var calendarCheck_id = [];
		<c:forEach items="${calendarList}" var="calendar">
			calendarCheck_id.push('${calendar.CALENDAR_ID}');
		</c:forEach>
		
		var member_id_num = "${userInfo.MEMBER_ID_NUM}";
		var c_year = "${cYear}";
		var c_month = "${cMonth}";
		var c_day = "${cDay}";
		var c_cur_date = '';
		var c_cur_year_month = '${curDate}';
		
		c_month = (c_month.length == 1)?"0"+c_month:c_month;
		c_day = (c_day.length == 1)?"0"+c_day:c_day;
		
		if(c_year != '' && c_month != '' && c_day != '') {
			c_cur_date = c_year + '-' + c_month + '-' + c_day;
		}
		
		$.ajax({
			type : "POST",
			data : {
				"hiddenModalCreatorId" : member_id_num,
				"calendarCheck_id" : calendarCheck_id.toString(),
				"thisMonthHoliday_id" : c_year+'%',
				"textSearchStartDate" : c_cur_date,
				"hiddenUserId" : member_id_num,
				"outlook" : 'N',
				"office365" : 'N',
				
				"order_by" : 'DESC'
			},
			async: false,
			url: "/calendar/calendarEventListMobile.do",
			success:function(data){
				var events = data.events;
				var dateIndex = '';
				var _html = '';
				var cnt = 0;
				
				for (var i = 0; i < events.length; i++){
					var this_day = events[i].START_DAY;
					var start_date = moment(this_day).format("YYYY-MM-DD");
					
					if(c_cur_year_month.substring(0,6) == this_day.substring(0,6)) {
					
						//alert($("#day_"+this_day).length);
						if ( $("#day_"+this_day).length > 0 ) {
							_html = '<li>';
							_html += '<a href="/calendar/modalCalendarForm.do?mode=M&eventId='+events[i].EVENT_ID+'&pos=calendarEvent&start_date='+start_date+'">';
							_html += '<span class="time">'+events[i].START_TIME+'</span>';
							_html += '<span class="icon lg icon_sch_'+events[i].EVENT_CODE+'"></span>';
							_html += '<span class="subject">'+events[i].title+'</span>';
							_html += '</a>';
							_html += '</li>';
							$("#day_"+this_day).append(_html);
						}
						else {
							// 신규일자 생성
							var extra_class='';
							if (this_day == '${curDate}'){
								extra_class=' current';
							}
							
							_html = '<div class="schedule_all_list">';
							_html += '<p class="day_title'+extra_class+'">';
							_html += this_day.substring(0,4)+'년 '+parseInt(this_day.substring(4,6))+'월 '+parseInt(this_day.substring(6,8))+'일';
							_html += '</p>'
							_html += '<ul id="day_'+this_day+'" name="day_'+this_day+'">';
							_html += '<li>';
							_html += '<a href="/calendar/modalCalendarForm.do?mode=M&eventId='+events[i].EVENT_ID+'&pos=calendarEvent&start_date='+start_date+'">';
							_html += '<span class="time">'+events[i].START_TIME+'</span>';
							_html += '<span class="icon lg icon_sch_'+events[i].EVENT_CODE+'"></span>';
							_html += '<span class="subject">'+events[i].title+'</span>';
							_html += '</a>';
							_html += '</li>';
							_html += '</ul>';
							_html += '</div>';
							
							$("#result_list").append(_html);
						}
	
						
						
						/*
						if (dateIndex == this_day){
							// 일자에 스케쥴 붙이기
							var _html = '<li><span class="time">'+events[i].START_TIME+'</span><span class="subject">'+events[i].title+'</span>';
							$('#day_'+this_day).append(_html);
						} else {
							// 신규일자 생성
							var extra_class='';
							if (this_day == '${curDate}'){
								extra_class=' current';
							}
							
							var _html = '<div class="schedule_all_list"><p class="day_title'+extra_class+'">';
							_html += this_day.substring(0,4)+'년 '+parseInt(this_day.substring(4,6))+'월 '+parseInt(this_day.substring(6,8))+'일</p><ul id="day_'+this_day+'" name="day_'+this_day+'">';
							_html += '<li><span class="time">'+events[i].START_TIME+'</span><span class="subject">'+events[i].title+'</span></ul></div>';
							$('#result_list').append(_html);
						}
						*/
						
					}
				}
				
				location.href="/calendar/calendarEvent.do#day_${curDate}";
			}
		});
	} 

	$(document).ready(function(){
		fncShowCalendar();
	});
</script>

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>