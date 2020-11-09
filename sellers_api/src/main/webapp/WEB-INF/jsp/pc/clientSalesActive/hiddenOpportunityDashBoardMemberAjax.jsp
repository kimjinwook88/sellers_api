<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectHiddenOpportunityDashBoardMember) > 0}">
		<c:forEach items="${selectHiddenOpportunityDashBoardMember}" var="member" varStatus="status">
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
				<tr class="tr_list" data-division="${member.MEMBER_DIVISION}" data-team="${member.MEMBER_TEAM}" name="sub_tr_${member.MEMBER_DIVISION}">	
			</c:when>
			<c:otherwise>
				<tr class="tr_list depth3" data-division="${member.MEMBER_DIVISION}" data-team="${member.MEMBER_TEAM}" name="sub_tr_${member.MEMBER_DIVISION}">
			</c:otherwise>
		</c:choose>
			    <th><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}');"> ${member.HAN_NAME}</a></th>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}');"><fmt:formatNumber value="${member.TOTAL_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${member.TOTAL_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','op');"><fmt:formatNumber value="${member.CHANGE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${member.CHANGE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','od');"><fmt:formatNumber value="${member.OVERDUE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${member.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','mn');"><fmt:formatNumber value="${member.MONTH_NEW_COUNT}" groupingUsed="true"/></a></td>
			    <td class="end"><fmt:formatNumber value="${member.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
