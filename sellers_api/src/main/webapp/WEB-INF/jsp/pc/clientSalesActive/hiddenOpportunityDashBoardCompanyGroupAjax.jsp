<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectHiddenOpportunityDashBoardCompanyGroup) > 0}">
		<c:forEach items="${selectHiddenOpportunityDashBoardCompanyGroup}" var="company">
		
			<tr class="tr_list" name="sub_tr_${company.SEGMENT_CODE}">
			    <th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.companyGet('${company.SEGMENT_CODE}',this)"/><a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.SEGMENT_CODE}','',null);"> ${company.SEGMENT_HAN_NAME}</a></th>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('${company.SEGMENT_CODE}','',null);"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.TOTAL_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('${company.SEGMENT_CODE}','','op');"><fmt:formatNumber value="${company.CHANGE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.CHANGE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('${company.SEGMENT_CODE}','','od');"><fmt:formatNumber value="${company.OVERDUE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${company.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('${company.SEGMENT_CODE}','','mn');"><fmt:formatNumber value="${company.MONTH_NEW_COUNT}" groupingUsed="true"/></a></td>
			    <td class="end"><fmt:formatNumber value="${company.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
			</tr>
			
			<c:set var="sumTOTAL_COUNT" 	value="${sumTOTAL_COUNT + company.TOTAL_COUNT}" />
			<c:set var="sumTOTAL_AMOUNT"	value="${sumTOTAL_AMOUNT + company.TOTAL_AMOUNT}" />
			<c:set var="sumCHANGE_COUNT" 	value="${sumCHANGE_COUNT + company.CHANGE_COUNT}" />
			<c:set var="sumCHANGE_AMOUNT"	value="${sumCHANGE_AMOUNT + company.CHANGE_AMOUNT}" />
			<c:set var="sumOVERDUE_COUNT" 	value="${sumOVERDUE_COUNT + company.OVERDUE_COUNT}" />
			<c:set var="sumOVERDUE_AMOUNT"	value="${sumOVERDUE_AMOUNT + company.OVERDUE_AMOUNT}" />
			<c:set var="sumMONTH_NEW_COUNT" 	value="${sumMONTH_NEW_COUNT + company.MONTH_NEW_COUNT}" />
			<c:set var="sumMONTH_NEW_AMOUNT"	value="${sumMONTH_NEW_AMOUNT + company.MONTH_NEW_AMOUNT}" />
			
		</c:forEach>
		
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>

<tr class="total">
	<th style="text-align: center;">총계</th>
    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','','','');"><c:out value="${sumTOTAL_COUNT}"/></a></td>
    <td><fmt:formatNumber type="currency" currencySymbol=""><c:out value="${sumTOTAL_AMOUNT}" /></fmt:formatNumber></td>
    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','','','op');"><c:out value="${sumCHANGE_COUNT}"/></a></td>
    <td><fmt:formatNumber type="currency" currencySymbol=""><c:out value="${sumCHANGE_AMOUNT}"/></fmt:formatNumber></td>
    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','','','od');"><c:out value="${sumOVERDUE_COUNT}"/></a></td>
    <td><fmt:formatNumber type="currency" currencySymbol=""><c:out value="${sumOVERDUE_AMOUNT}"/></fmt:formatNumber></td>
    <td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goListCompany('','','','mn');"><c:out value="${sumMONTH_NEW_COUNT}"/></a></td>
    <td class="end"><fmt:formatNumber type="currency" currencySymbol=""><c:out value="${sumMONTH_NEW_AMOUNT}"/></fmt:formatNumber></td>
</tr>