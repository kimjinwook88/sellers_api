<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list">
		 <div class="timeline-item">
		     <div class="date">
		         <span class="v-m">${list.START_DATETIME}</span> <!-- 일정 시작시간 기준 -->
		     </div>
		     <div class="content no-top-border" style="cursor:pointer;" onClick="main.goTimeLine(${list.EVENT_ID});">
			     <c:choose>
			     	<c:when test="${list.EVENT_CODE == '1'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon1.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     	<c:when test="${list.EVENT_CODE == '2'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon2.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     	<c:when test="${list.EVENT_CODE == '3'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon3.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     	<c:when test="${list.EVENT_CODE == '4'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon4.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     	<c:when test="${list.EVENT_CODE == '6'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon6.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     	<c:when test="${list.EVENT_CODE == '7'}">
			     		<p class="m-b-xs"><img src="<%=request.getContextPath()%>/images/pc/calendar_icon7.png" class="v-m"/> <strong>${list.EVENT_SUBJECT}</strong></p>
			     	</c:when>
			     </c:choose>
		         <p>${list.EVENT_DETAIL}</p>
		     </div>
		 </div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;">
		    <strong>일정이 없습니다.</strong>
		 </div>
	</c:otherwise>
 </c:choose>
 
	
