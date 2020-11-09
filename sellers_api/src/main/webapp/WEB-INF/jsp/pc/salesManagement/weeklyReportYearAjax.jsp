<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(weeklyReportYear) > 0}">
		<c:forEach items="${weeklyReportYear}" var="items" varStatus="status">
			<tr class="tr_list">
				<th style="text-align:center;">SI</th>
				<th>${status.count}분기 closing (SI)</th>
				<td><fmt:formatNumber value="${items.TCV_SI}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.REV_SI}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.GP_SI}" pattern="#,###" /></td>
				<td rowspan="3"><fmt:formatNumber value="${items.ACHIEVE_REV_Y}" pattern="0.##%"/></td>
				<td rowspan="3"><fmt:formatNumber value="${items.ACHIEVE_GP_Y}" pattern="0.##%"/></td>
				<td rowspan="3"><fmt:formatNumber value="${items.TARGET_REV_Q}" pattern="#,###" /></td>
				<td rowspan="3"><fmt:formatNumber value="${items.TARGET_GP_Q}" pattern="#,###" /></td>
				<td rowspan="3"><fmt:formatNumber value="${items.ACHIEVE_REV_Q}" pattern="0.##%"/></td>
				<td class="end" rowspan="3"><fmt:formatNumber value="${items.ACHIEVE_GP_Q}" pattern="0.##%"/></td>
			</tr>
			<tr class="tr_list">
				<th style="text-align:center;">MA</th>
				<th>${status.count}분기 closing (MA)</th>
				<td><fmt:formatNumber value="${items.TCV_MA}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.REV_MA}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.GP_MA}" pattern="#,###" /></td>
			</tr>
			<tr class="tr_list">
				<th style="text-align:center;">기타</th>
				<th>${status.count}분기 closing (기타)</th>
				<td><fmt:formatNumber value="${items.TCV_ETC}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.REV_ETC}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.GP_ETC}" pattern="#,###" /></td>
			</tr>
			<tr class="tr_list">
				<td colspan="2" style="font-weight:bold;text-align:center;">${status.count}Q Outlook</td>
				<td><fmt:formatNumber value="${items.SUM_TCV}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.SUM_REV}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.SUM_GP}" pattern="#,###" /></td>
				<td></td>
				<td></td>
				<td><fmt:formatNumber value="${items.TARGET_REV_Q}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${items.TARGET_GP_Q}" pattern="#,###" /></td>
				<td></td>
				<td class="end"></td>
			</tr>
				
				<<%-- th>SI</th>
				<th>${status.count}사분기 closing (SI)</th>
				<td>items.TCV</td>
				<td>
					<fmt:formatNumber value="${items.TCV}" type="currency" currencySymbol=""/>
				</td>
				<td>
					<fmt:formatNumber value="${items.REV}" type="currency" currencySymbol=""/>
				</td> --%>
				
		</c:forEach>
		<tr class="tr_list">
			<td colspan="2" style="font-weight:bold;text-align:center;">18Y 1Q + 2Q + 3Q + 4Q Outlook</td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_TCV}" pattern="#,###" /></td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_REV}" pattern="#,###" /></td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_GP}" pattern="#,###" /></td>
			<td></td>
			<td></td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_TARGET_REV_Q}" pattern="#,###" /></td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_TARGET_GP_Q}" pattern="#,###" /></td>
			<td><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_ACHIEVE_REV_Q}" pattern="0.##%"/></td>
			<td class="end"><fmt:formatNumber value="${weeklyReportTotalYear.TOTAL_ACHIEVE_GP_Q}" pattern="0.##%"/></td>
		</tr>
	</c:when>
	<c:otherwise>
		<!-- <tr>
			<td colspan="16" style="text-align:center;" class="end" >
			<c:out value="${fn:length(selectWeeklyReport[0])}"/>
			</td>
			
		</tr> -->
		<tr>
			<td colspan="11" style="text-align:center;" class="end" >No Data</td>
		</tr>
	</c:otherwise>
</c:choose>