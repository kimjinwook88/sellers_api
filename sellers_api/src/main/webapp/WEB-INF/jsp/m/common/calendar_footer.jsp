<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.springframework.web.util.UrlPathHelper"%>
<%
//String request_uri = request.getRequestURI();
UrlPathHelper urlPathHelper = new UrlPathHelper();
String originalURL = urlPathHelper.getOriginatingRequestUri(request);
//out.print("OriginalURL ==>" + originalURL  );

String[] active_class = {"","","",""};
Calendar c = Calendar.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
String todayDate = transFormat.format(c.getTime());
String pos = request.getParameter("pos")==null?"":request.getParameter("pos");

if(originalURL.indexOf("/viewCalendar.do") > -1 || pos.indexOf("viewCalendar") > -1) {
	active_class[1] = "active";
}
else if(originalURL.indexOf("/calendarEvent.do") > -1 || pos.indexOf("calendarEvent") > -1) {
	active_class[2] = "active";
}
else if(originalURL.indexOf("/calendar.do") > -1 || pos.indexOf("calendar") > -1) {
	//날짜 확인 (YYYYMMDD)
	todayDate = transFormat.format(c.getTime());

	String curDate = request.getParameter("curDate");
	
	if(todayDate.equals(curDate)) {
		active_class[3] = "active";
	}
	else {
		active_class[0] = "active";
	}
}
%>
	<article class="fix_func" style="display:none;">
		<ul>
			<li>
				<a href="/calendar/calendar.do?curDate=${param.curDate}" class="<%=active_class[0]%>">일</a>
			</li>
			<li>
				<a href="/calendar/viewCalendar.do" class="<%=active_class[1]%>">월</a>
			</li>
			<li>
				<a href="/calendar/calendarEvent.do" class="<%=active_class[2]%>">일정목록</a>
			</li>
			<li>
				<a href="/calendar/calendar.do?curDate=<%=todayDate%>" class="<%=active_class[3]%>">오늘</a>
			</li>
		</ul>
	</article>