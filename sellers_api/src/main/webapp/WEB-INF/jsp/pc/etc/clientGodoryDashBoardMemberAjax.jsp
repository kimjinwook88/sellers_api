<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectClientIssueDashBoardMember) > 0}">
		<c:forEach items="${selectClientIssueDashBoardMember}" var="member" varStatus="status">
		
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
				<tr class="tr_list depth3" data-division="${member.MEMBER_DIVISION}" data-team="${member.MEMBER_TEAM}" name="sub_tr_${member.MEMBER_DIVISION}">	
			</c:when>
			<c:otherwise>
				<tr class="tr_list depth3" data-division="${member.MEMBER_DIVISION}" data-team="${member.MEMBER_TEAM}" name="sub_tr_${member.MEMBER_DIVISION}">
			</c:otherwise>
		</c:choose>
		
			    <th><a href="javascript:void(0);" onClick="dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}', null, null);"> ${member.HAN_NAME} ${member.POSITION_STATUS}</a></th>
			    <td class="ag_c"><fmt:formatNumber value="${member.TOTAL_COUNT}" groupingUsed="true"/></td>
			    <td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','고쳐주세요', null);">
								<fmt:formatNumber value="${member.CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','도와주세요', null);">
								<fmt:formatNumber value="${member.CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','이런건어때요', null);">
								<fmt:formatNumber value="${member.CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<%-- 
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}','기타', null);">
								<fmt:formatNumber value="${member.CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						 --%>
						
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}',null,'진행중');">
								<fmt:formatNumber value="${member.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${member.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}',null,'지연');">
								<fmt:formatNumber value="${member.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${member.MEMBER_DIVISION}','${member.MEMBER_TEAM}','${member.MEMBER_ID_NUM}',null,'완료');">
								<fmt:formatNumber value="${member.ISSUE_STATUS_3}" groupingUsed="true"/>
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

