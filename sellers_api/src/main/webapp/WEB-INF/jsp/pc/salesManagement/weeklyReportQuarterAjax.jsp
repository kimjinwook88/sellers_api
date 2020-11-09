<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(weeklyReportQuarter) > 0}">
		<c:forEach items="${weeklyReportQuarter}" var="items" varStatus="status">
			<tr class="tr_list">
				<td style="text-align: center;">${items.OBTAIN_ORDER_TYPE}</td>
				<td style="text-align: center;">${items.HAN_NAME}</td>
				<td style="text-align: left;">${items.COMPANY_NAME}</td>
				<td style="text-align: left;">${items.PROJECT_NAME}</td>
				<td><fmt:formatNumber value="${items.TCV}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.ACCRUE_REV}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.ACCRUE_GP}" pattern="#,###" /></td>
				<td>${items.DT_SO}</td>
				<td class="end">${items.DT_IVL}</td>
				<!-- <td></td>
				<td></td> 
				<td class="end"></td> -->
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="10" style="text-align:center;" class="end" >No Data</td>
		</tr>
	</c:otherwise>
</c:choose>