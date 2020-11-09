<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list">
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO') || fn:contains(auth, 'ROLE_CFO') || fn:contains(auth, 'ROLE_DIVISION')}">
					<tr class="tr_list depth2" id="team_${list.MEMBER_TEAM}" data-division="${list.MEMBER_DIVISION}" name="sub_tr_${list.MEMBER_DIVISION}">	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<tr class="tr_list" id="team_${list.MEMBER_TEAM}" data-division="${list.MEMBER_DIVISION}" name="sub_tr_${list.MEMBER_DIVISION}">	
				</c:when>
				<c:otherwise>
					<tr class="tr_list depth2" id="team_${list.MEMBER_TEAM}" data-division="${list.MEMBER_DIVISION}" name="sub_tr_${list.MEMBER_DIVISION}">
				</c:otherwise>
			</c:choose>
				<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.memberGet('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',this)"/><a href="javascript:void(0);" onClick="dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null);"> ${list.TEAM_NAME}</a></th>
				<td class="ag_c"><fmt:formatNumber value="${list.TOTAL_COUNT}" /></td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,'방문');">
						<fmt:formatNumber value="${list.EVENT_CATEGORY_1}" />
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,'마케팅');">
						<fmt:formatNumber value="${list.EVENT_CATEGORY_2}" />
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,'SNS');">
						<fmt:formatNumber value="${list.EVENT_CATEGORY_3}" />
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,'E-mail');">
						<fmt:formatNumber value="${list.EVENT_CATEGORY_4}" />
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,'전화');">
						<fmt:formatNumber value="${list.EVENT_CATEGORY_5}" />
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,null,'고객이슈');">
						<fmt:formatNumber value="${list.ISSUE_COUNT}" />
					</a>
				</td>
				<td class="ag_c end">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}',null,null,'잠재영업기회');">
						<fmt:formatNumber value="${list.OPP_COUNT}" />
					</a>
				</td>
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
