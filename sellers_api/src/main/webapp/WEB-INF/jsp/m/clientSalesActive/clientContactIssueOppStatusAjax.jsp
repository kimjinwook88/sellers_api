<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
		<c:choose>
			<c:when test="${issueOppStatusCnt.TOTAL_CNT > 0}">
				<tr>
					<th scope="row">${issueOppStatusCnt.TARGET_NAME}</th>
					<td>${issueOppStatusCnt.TOTAL_CNT}</td>
					<td>${issueOppStatusCnt.ISSUE_CNT}</td>
					<td>${issueOppStatusCnt.HIDDENOPP_CNT}</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th colspan="4">현재 등록된 데이터가 없습니다.</th>
				</tr>
			</c:otherwise>
		</c:choose>

	</c:when>
	<c:otherwise>
		<%-- <c:forEach items="${issueOppStatusCnt}" var="cnt">
			<c:set var="totalSum" value="0" />
			<c:set var="totalSum" value="${totalSum + cnt.TOTAL_CNT}" />
		</c:forEach> --%>

		<c:choose>
			<c:when test="${fn:length(issueOppStatusCnt) > 0}">
				<c:forEach items="${issueOppStatusCnt}" var="cnt">
					<tr>
						<th scope="row" class="ta_l">${cnt.TARGET_NAME}</th>
						<td>${cnt.TOTAL_CNT}</td>
						<td>${cnt.ISSUE_CNT}</td>
						<td>${cnt.HIDDENOPP_CNT}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<th colspan="4">현재 등록된 데이터가 없습니다.</th>
				</tr>
			</c:otherwise>
		</c:choose>

	</c:otherwise>
</c:choose>