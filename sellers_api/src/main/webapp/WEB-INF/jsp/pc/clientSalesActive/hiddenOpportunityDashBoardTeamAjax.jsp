<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectHiddenOpportunityDashBoardTeam) > 0}">
		<c:forEach items="${selectHiddenOpportunityDashBoardTeam}" var="team" varStatus="status">
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				<tr class="tr_list" data-division="${team.MEMBER_DIVISION}" id="team_${team.MEMBER_TEAM}" name="sub_tr_${team.MEMBER_DIVISION}">	
			</c:when>
			<c:otherwise>
				<tr class="tr_list depth2" data-division="${team.MEMBER_DIVISION}" id="team_${team.MEMBER_TEAM}" name="sub_tr_${team.MEMBER_DIVISION}">
			</c:otherwise>
		</c:choose>
			    <th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.memberGet('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',this)"/>
			    <a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null);"> ${team.TEAM_NAME}</a></th>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null);"><fmt:formatNumber value="${team.TOTAL_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${team.TOTAL_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'op');"><fmt:formatNumber value="${team.CHANGE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${team.CHANGE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'od');"><fmt:formatNumber value="${team.OVERDUE_COUNT}" groupingUsed="true"/></a></td>
			    <td><fmt:formatNumber value="${team.OVERDUE_AMOUNT}" groupingUsed="true"/></td>
			    <td class="ag_c"><a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'mn');"><fmt:formatNumber value="${team.MONTH_NEW_COUNT}" groupingUsed="true"/></a></td>
			    <td class="end"><fmt:formatNumber value="${team.MONTH_NEW_AMOUNT}" groupingUsed="true"/></td>
			</tr>
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
