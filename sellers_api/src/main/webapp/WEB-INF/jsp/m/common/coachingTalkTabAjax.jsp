<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectCoachingTalk) > 0}">
		<c:forEach items="${selectCoachingTalk}" var="list" varStatus="varStatus">
			<c:if test="${varStatus.first || list.CREATED_DATE ne selectCoachingTalk[varStatus.index - 1].CREATED_DATE}">
				<div class="ag_c mg-b5"><span class="day-term">---${list.CREATED_DATE}---</span></div>
			</c:if>
			<c:choose>
				<c:when test="${list.MEMBER_ID_NUM eq userInfo.MEMBER_ID_NUM}">
					<div class="comment_along right" name="${list.CREATED_TIME}">
						<span class="msg">${list.RE_COACHING_TALK_DETAIL}</span>
					<c:if test="${varStatus.last || list.CREATED_TIME ne selectCoachingTalk[varStatus.index + 1].CREATED_TIME || list.MEMBER_ID_NUM ne selectCoachingTalk[varStatus.index + 1].MEMBER_ID_NUM}">
						<span class="date">${list.CREATED_TIME}</span>
					</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<div class="comment_along" name="${list.CREATED_TIME}">
					<c:choose>
						<c:when test="${varStatus.first || list.MEMBER_ID_NUM ne selectCoachingTalk[varStatus.index - 1].MEMBER_ID_NUM}">
						<span class="writer">${list.HAN_NAME} ${list.POSITION_STATUS} <%-- ${list.DIVISION_NAME} ${list.TEAM_NAME} --%></span>
						</c:when>
						<c:when test="${list.MEMBER_ID_NUM eq selectCoachingTalk[varStatus.index - 1].MEMBER_ID_NUM && list.CREATED_TIME eq selectCoachingTalk[varStatus.index - 1].CREATED_TIME}">
						</c:when>
						<c:otherwise>
						<span class="writer">${list.HAN_NAME} ${list.POSITION_STATUS} <%-- ${list.DIVISION_NAME} ${list.TEAM_NAME} --%></span>
						</c:otherwise>
					</c:choose>
						<span class="msg">${list.RE_COACHING_TALK_DETAIL}</span>
					<c:if test="${varStatus.last || list.CREATED_TIME ne selectCoachingTalk[varStatus.index + 1].CREATED_TIME || list.MEMBER_ID_NUM ne selectCoachingTalk[varStatus.index + 1].MEMBER_ID_NUM}">
						<span class="date">${list.CREATED_TIME}</span>
					</c:if>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
</c:choose>