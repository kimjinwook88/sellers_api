<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>캘린더</title>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%
Calendar cal = Calendar.getInstance();
 
String strYear = request.getAttribute("cYear").toString();
String strMonth = request.getAttribute("cMonth").toString();
 
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);
 
if(strYear != null)
{
  year = Integer.parseInt(strYear);
  month = Integer.parseInt(strMonth) - 1;
 
}else{
 
}
//년도/월 셋팅
cal.set(year, month, 1);
 
int startDay = cal.getMinimum(java.util.Calendar.DATE);
int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;
 
//오늘 날짜 저장.
Calendar todayCal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
 
 
%>


<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>THE Seller's</title>
<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">
</head>

<body class="gray_bg">

<div class="container">
	<jsp:include page="../templates/header.jsp" flush="false"/>

	<jsp:include page="/WEB-INF/jsp/m/common/calendar_footer.jsp"/>
	
	<article class="topControl primary_bg">
		
		<div class="func_left fl_l">
			<a href="" id="month_prev_btn" class="btn_prev va_m" onclick="month_prev_btn('${prevMonth}');  return false;">이전</a> <%-- fncMoveToDate('${prevMonth}'); --%>
			<span class="current_date va_m">${cYear}년 ${cMonth}월</span>
			<a href="" id="month_next_btn" class="btn_next va_m" onclick="month_next_btn('${nextMonth}'); return false;">다음</a>
		</div>
		<div class="func_right fl_r">
			<a href="" onClick="fncAddSchedule('${curDate}'); return false;"><span class="va_t icon_add">일정추가</span></a>
		</div>
		
		
	</article>
	
	
	
	<article class="schedule_cont" >
		<div id="calendar"></div>
		<input type="hidden" id="textCalendarName" name="textCalendarName"></input>
	</article>





<div class="daysch_list_pop off">
    <div class="pop_header">
        <p class="day_title" id="modal_day_title"></p>
        <div class="func_area">
            <a href="javascript:$('div.daysch_list_pop').hide();" class="btn_modal_close" style="display: block;">닫기</a>
        </div>
    </div>
    <div class="pop_cont">
        <div class="schedule_all_list" style="border:1px black solid;">
            <ul id="modal_result_list">
            	<li>
            		<span class="time">00 : 00 ~ 00 : 00</span>
            		<span class="subject"></span>
            	</li>
            	<li>
            		<span class="subject"></span>
            	</li>
            </ul> 
        </div>
    </div>
</div>
</div>
<!-- <div class="modal_screen"></div> -->

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>


<link href="${pageContext.request.contextPath}/js/m/fullcalendar/fullcalendar.min.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/js/m/fullcalendar/fullcalendar.print.min.css" rel='stylesheet' media='print' />


<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/fullcalendar/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/fullcalendar/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/fullcalendar/theme-chooser.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/fullcalendar/ko.js"></script>

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

<script>
var startRange = '${startRange}';
var endRange = '${endRange}';
var userId = '${userInfo.MEMBER_ID_NUM}';
var selectYear = '${cYear}';
var selectMonth = '${cMonth}';
var noticeEventId = '${notice_event_id}';
var calendarList = '${calendarList}';

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
</c:choose>

var fncOffice365 = function(){
	var office365 = "N";
	<c:choose>
		<c:when test="${fn:length(calendarList) > 0}">
			<c:forEach items="${calendarList}" var="calendar">
				<c:if test="${calendar.CALENDAR_TYPE eq 2}"> office365 = "office365"; </c:if>
			</c:forEach>
		</c:when>
	</c:choose>
	return office365;
}


</script>

<script src="${pageContext.request.contextPath}/js/m/view/calendar/calendarView.js"></script>

</body>
</html>