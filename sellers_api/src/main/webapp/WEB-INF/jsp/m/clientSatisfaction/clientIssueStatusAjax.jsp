<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectClientIssueStatus) > 0}">
		<c:forEach items="${selectClientIssueStatus}" var="row">
			<tr>
				<th scope="row">${row.TARGET_NAME}</th>
				<td>${row.TOTAL_COUNT}</td>
				<td class="fc_blue">${row.ISSUE_STATUS_1}</td>
				<td class="fc_red">${row.ISSUE_STATUS_2}</td>
				<td>${row.ISSUE_STATUS_3}</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<th colspan="5">현재 등록된 데이터가 없습니다.</th>
		</tr>
	</c:otherwise>
</c:choose>