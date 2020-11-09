<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectHiddenOpportunityDashBoardCompany) > 0}">
		<c:forEach items="${selectHiddenOpportunityDashBoardCompany}" var="company">
		
			<tr class="tr_list depth3" data-category="${company.SEGMENT_CODE}">
			    <th><a href="javascript:void(0);" onClick="dashboard.goListCompany('','${company.COMPANY_NAME}',null);"> ${company.COMPANY_NAME}</a></th>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','${company.COMPANY_NAME}',null);"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.TOTAL_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','${company.COMPANY_NAME}','op');"><fmt:formatNumber value="${company.CHANGE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.CHANGE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','${company.COMPANY_NAME}','od');"><fmt:formatNumber value="${company.OVERDUE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','${company.COMPANY_NAME}','mn');"><fmt:formatNumber value="${company.MONTH_NEW_COUNT}" groupingUsed="true"/></a></td>
			    <td class="end"><fmt:formatNumber value="${company.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
			</tr>
			
		</c:forEach>
		
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
