<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectClientIssueDashBoardTeam) > 0}">
		<c:forEach items="${selectClientIssueDashBoardTeam}" var="team" varStatus="status">
		
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				<tr class="tr_list" data-division="${team.MEMBER_DIVISION}" name="sub_tr_${team.MEMBER_DIVISION}">	
			</c:when>
			<c:otherwise>
				<tr class="tr_list depth2" data-division="${team.MEMBER_DIVISION}" name="sub_tr_${team.MEMBER_DIVISION}">
			</c:otherwise>
		</c:choose>
			    <th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.employeeGet('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',this)"/>
			    <a href="javascript:void(0);" onClick="dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null);"> ${team.TEAM_NAME}</a></th>
			    <td class="ag_c"><fmt:formatNumber value="${team.TOTAL_COUNT}" groupingUsed="true"/></td>
			    <td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'고쳐주세요');">
								<fmt:formatNumber value="${team.CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'도와주세요');">
								<fmt:formatNumber value="${team.CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'이런건어때요');">
								<fmt:formatNumber value="${team.CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<%-- 
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,'기타');">
								<fmt:formatNumber value="${team.CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						 --%>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,null,'진행중');">
								<fmt:formatNumber value="${team.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${team.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,null,'지연');">
								<fmt:formatNumber value="${team.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${team.MEMBER_DIVISION}','${team.MEMBER_TEAM}',null,null,'완료');">
								<fmt:formatNumber value="${team.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="8" style="text-align:center;">No Data</td>
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
