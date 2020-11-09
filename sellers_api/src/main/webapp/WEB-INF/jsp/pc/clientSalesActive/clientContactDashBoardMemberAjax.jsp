<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list">
				
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO') || fn:contains(auth, 'ROLE_CFO') || fn:contains(auth, 'ROLE_DIVISION') || fn:contains(auth, 'ROLE_TEAM')}">
						<tr class="tr_list depth3" data-division="${list.MEMBER_DIVISION}" data-team="${list.MEMBER_TEAM}" name="sub_tr_${list.MEMBER_DIVISION}">	
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<tr class="tr_list" data-division="${list.MEMBER_DIVISION}" data-team="${list.MEMBER_TEAM}" name="sub_tr_${list.MEMBER_DIVISION}">	
					</c:when>
					<c:otherwise>
						<tr class="tr_list depth3" data-division="${list.MEMBER_DIVISION}" data-team="${list.MEMBER_TEAM}" name="sub_tr_${list.MEMBER_DIVISION}">
					</c:otherwise>
				</c:choose>
				
					<th><a href="javascript:void(0);" onClick="dashboard.goList('${list.MEMBER_DIVISION}','${list.MEMBER_TEAM}','${list.MEMBER_ID_NUM}');">${list.HAN_NAME}</a></th>
					<td class="ag_c"><fmt:formatNumber value="${list.TOTAL_COUNT}" groupingUsed="true"/></td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,'방문');">
							<fmt:formatNumber value="${list.EVENT_CATEGORY_1}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,'마케팅');">
							<fmt:formatNumber value="${list.EVENT_CATEGORY_2}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,'SNS');">
							<fmt:formatNumber value="${list.EVENT_CATEGORY_3}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,'E-mail');">
							<fmt:formatNumber value="${list.EVENT_CATEGORY_4}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,'전화');">
							<fmt:formatNumber value="${list.EVENT_CATEGORY_5}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,null,'고객이슈');">
							<fmt:formatNumber value="${list.ISSUE_COUNT}" groupingUsed="true"/>
						</a>
					</td>
					<td class="ag_c end">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${list.MEMBER_DIVISION}',null,null,null,'잠재영업기회');">
							<fmt:formatNumber value="${list.OPP_COUNT}" groupingUsed="true"/>
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