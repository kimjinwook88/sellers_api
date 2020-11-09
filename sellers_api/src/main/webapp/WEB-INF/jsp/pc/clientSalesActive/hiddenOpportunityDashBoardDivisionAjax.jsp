<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectHiddenOpportunityDashBoardDivision) > 0}">
		<c:forEach items="${selectHiddenOpportunityDashBoardDivision}" var="division">
			
			<c:choose>
				<c:when test="${division.MEMBER_DIVISION eq null}">
					<tr class="total">
						<th style="text-align: center;">총계</th>
						<td class="ag_c"><fmt:formatNumber value="${division.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td><fmt:formatNumber value="${division.TOTAL_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><fmt:formatNumber value="${division.CHANGE_COUNT}" groupingUsed="true"/></td>
						<td><fmt:formatNumber value="${division.CHANGE_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><fmt:formatNumber value="${division.OVERDUE_COUNT}" groupingUsed="true"/></td>
						<td><fmt:formatNumber value="${division.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><fmt:formatNumber value="${division.MONTH_NEW_COUNT}" groupingUsed="true"/></td>
						<td class="end"><fmt:formatNumber value="${division.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr class="tr_list" id="division_${division.MEMBER_DIVISION}">
						<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.teamGet('${division.MEMBER_DIVISION}',this)"/><a href="javascript:void(0);" onClick="dashboard.goList('${division.MEMBER_DIVISION}',null,null);"> ${division.DIVISION_NAME}</a></th>
						<td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goList('${division.MEMBER_DIVISION}',null,null);"><fmt:formatNumber value="${division.TOTAL_COUNT}" groupingUsed="true"/></a></td>
						<td><fmt:formatNumber value="${division.TOTAL_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goList('${division.MEMBER_DIVISION}',null,null,'op');"><fmt:formatNumber value="${division.CHANGE_COUNT}" groupingUsed="true"/></a></td>
						<td><fmt:formatNumber value="${division.CHANGE_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goList('${division.MEMBER_DIVISION}',null,null,'od');"><fmt:formatNumber value="${division.OVERDUE_COUNT}" groupingUsed="true"/></a></td>
						<td><fmt:formatNumber value="${division.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
						<td class="ag_c"><a href="javascript:void(0);" onclick="dashboard.goList('${division.MEMBER_DIVISION}',null,null,'mn');"><fmt:formatNumber value="${division.MONTH_NEW_COUNT}" groupingUsed="true"/></a></td>
						<td class="end"><fmt:formatNumber value="${division.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
					</tr>
		    	</c:otherwise>
			</c:choose>
			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
	
<!-- 
<tr class="depth2">
    <th><img src="../images/icon_folder_minus.png" class="btn_bottom_dep" /> <a href="#">영업1팀</a></th>
    <td class="ag_c">2</td>
    <td>10,000,000</td>
    <td class="ag_c">5</td>
    <td>200,000,000</td>
    <td class="ag_c">3</td>
    <td>10,000,000</td>
    <td class="ag_c">3</td>
    <td class="end">120,000,000</td>
</tr>

<tr class="depth3">
    <th><a href="#">이상현</a></th>
    <td class="ag_c">2</td>
    <td>10,000,000</td>
    <td class="ag_c">5</td>
    <td>200,000,000</td>
    <td class="ag_c">3</td>
    <td>10,000,000</td>
    <td class="ag_c">3</td>
    <td class="end">120,000,000</td>
</tr>
<tr class="depth3">
    <th><a href="#">황정민</a></th>
    <td class="ag_c">2</td>
    <td>10,000,000</td>
    <td class="ag_c">5</td>
    <td>200,000,000</td>
    <td class="ag_c">3</td>
    <td>10,000,000</td>
    <td class="ag_c">3</td>
    <td class="end">120,000,000</td>
</tr>
 -->
