<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
${fn:length(toDay)}
<c:choose>
	<c:when test="${fn:length(pickDay) > 0 }">
		<c:forEach items="${pickDay}" var="toDay">
			<p>${toDay.START_DATETIME} ${toDay.EVENT_SUBJECT}</p>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<span>등록된 일정이 없습니다.</span>
	</c:otherwise>
</c:choose>