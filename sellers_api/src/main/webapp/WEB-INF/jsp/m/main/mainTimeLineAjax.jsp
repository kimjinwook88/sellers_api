<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
<c:set var="sysMonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set>  
<c:set var="sysDay"><fmt:formatDate value="${now}" pattern="dd" /></c:set>

<h2 class="title">일정</h2>
<div class="todayList">
	<div class="top">
		<!-- <h3 id="timeLineDate"> 시간 데이터 불러오는 것-->
		<h3 id=""><span id="mainYear">${sysYear}</span>년 <span id="mainMonth">${sysMonth}</span>월 <span id="mainDay">${sysDay}</span>일</h3> 
		<a href="/calendar/modalCalendarForm.do?mode=I&curDate=&pos=viewCalendar" class="btn_more_landing">+</a>
	</div>
	<!-- <button class="btn btn-white btn-sm" id="timeLinePrev" onclick="fncSelectCalendar(null, 'prev'); return false;">왼쪽</button>
	<button class="btn btn-white btn-sm" id="timeLineNext" onclick="fncSelectCalendar(null, 'next'); return false;">오른쪽</button> -->
	<ul class="today_schedule_list" id="result_timeLine">
		<c:choose>
			<c:when test="${fn:length(toDay) > 0}">
				<c:forEach items="${toDay}" var="day">
					<li>
						<a href="#">
							<span class="time">[${day.START_DATETIME}]</span>
							<span class="subject">${day.EVENT_SUBJECT}</span>
						</a>
					</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<li id="no_calList">
					<p class="pd_t20 pd_b20 ta_c">등록된 일정이 없습니다.</p>
				</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>

<%-- 
<c:choose>
	<c:when test="${fn:length(data.toDay) > 0}">
		<c:forEach items="${toDay}" var="list">
			<li class=""> 
				<a href="#">
					<span class="time">
<%-- 						<span class="va_m">${list.START_DATETIME} ~ ${list.END_DATETIME}</span>
					</span>
					<span class="icon lg icon_sch_${list.EVENT_CODE}"></span> <!-- icon_sch_1~7 : 고객대면, 대면준비, 내부회의, 교육, 기타, 휴가, 이동시간 -->
					<span class="subject">${list.EVENT_SUBJECT}</span>					
				</a>					
			</li>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<li>
			<strong>일정이 없습니다.</strong>
		</li>
	</c:otherwise>
 </c:choose>
 
	
 --%>