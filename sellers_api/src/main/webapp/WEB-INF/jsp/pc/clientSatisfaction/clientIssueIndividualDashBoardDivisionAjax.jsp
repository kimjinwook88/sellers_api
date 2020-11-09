<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectClientIssueDashBoardDivision) > 0}">
		<c:forEach items="${selectClientIssueDashBoardDivision}" var="division" varStatus="status">
			<tr class="tr_list" id="division_${division.DIVISION_NO}">
				<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.teamGet('${division.DIVISION_NO}',this)"/><a href="javascript:void(0);" onClick="dashboard.goList('${division.DIVISION_NO}',null,null);"> ${division.DIVISION_NAME}</a></th>
				<td class="ag_c"><fmt:formatNumber value="${division.TOTAL_COUNT}" groupingUsed="true"/></td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,'제품');">
						<fmt:formatNumber value="${division.CATEGORY_1}" groupingUsed="true"/>
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,'서비스');">
						<fmt:formatNumber value="${division.CATEGORY_2}" groupingUsed="true"/>
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,'지원');">
						<fmt:formatNumber value="${division.CATEGORY_3}" groupingUsed="true"/>
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,'기타');">
						<fmt:formatNumber value="${division.CATEGORY_4}" groupingUsed="true"/>
					</a>
				</td>
				<td class="ag_c">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,null,'진행중');">
						<fmt:formatNumber value="${division.ISSUE_STATUS_1}" groupingUsed="true"/>
					</a>
				</td>
				<c:choose>
				<c:when test="${division.ISSUE_STATUS_2 > 0}">
				<td class="ag_c cell-status fc_white">
				</c:when>
				<c:otherwise><td class="ag_c"></c:otherwise>
				</c:choose>
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,null,'지연');">
						<fmt:formatNumber value="${division.ISSUE_STATUS_2}" groupingUsed="true"/>
					</a>
				</td>
				<td class="ag_c end">
					<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${division.DIVISION_NO}',null,null,null,'완료');">
						<fmt:formatNumber value="${division.ISSUE_STATUS_3}" groupingUsed="true"/>
					</a>
				</td>
			</tr>
			
			<c:set var="sumTotal"			value="${sumTotal + division.TOTAL_COUNT}" />
			<c:set var="sumIssueCategory1"	value="${sumIssueCategory1 + division.CATEGORY_1}" />
			<c:set var="sumIssueCategory2"	value="${sumIssueCategory2 + division.CATEGORY_2}" />
			<c:set var="sumIssueCategory3"	value="${sumIssueCategory3 + division.CATEGORY_3}" />
			<c:set var="sumIssueCategory4"	value="${sumIssueCategory4 + division.CATEGORY_4}" />
			<c:set var="sumIssueStatus1"	value="${sumIssueStatus1 + division.ISSUE_STATUS_1}" />
			<c:set var="sumIssueStatus2"	value="${sumIssueStatus2 + division.ISSUE_STATUS_2}" />
			<c:set var="sumIssueStatus3"	value="${sumIssueStatus3 + division.ISSUE_STATUS_3}" />
			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>

<c:if test="${fn:length(selectClientIssueDashBoardDivision) > 0}">
	<tr class="total">
		<th style="text-align: center;">총계</th>
		<td class="ag_c"><fmt:formatNumber value="${sumTotal}" groupingUsed="true"/></td>
		<td class="ag_c">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'제품');">
				<fmt:formatNumber value="${sumIssueCategory1}" groupingUsed="true"/>
			</a>
		</td>
		<td class="ag_c">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'서비스');">
				<fmt:formatNumber value="${sumIssueCategory2}" groupingUsed="true"/>
			</a>
		</td>
		<td class="ag_c">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'지원');">
				<fmt:formatNumber value="${sumIssueCategory3}" groupingUsed="true"/>
			</a>
		</td>
		<td class="ag_c">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'기타');">
				<fmt:formatNumber value="${sumIssueCategory4}" groupingUsed="true"/>
			</a>
		</td>
		<td class="ag_c">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,null,'진행중');">
				<fmt:formatNumber value="${sumIssueStatus1}" groupingUsed="true"/>
			</a>
		</td>
		<c:choose>
			<c:when test="${sumIssueStatus2 > 0}">
			<td class="ag_c cell-status fc_white">
			</c:when>
			<c:otherwise>
			<td class="ag_c">
			</c:otherwise>
		</c:choose>
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,null,'지연');">
				<fmt:formatNumber value="${sumIssueStatus2}" groupingUsed="true"/>
			</a>
		</td>
		<td class="ag_c end">
			<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,null,'완료');">
				<fmt:formatNumber value="${sumIssueStatus3}" groupingUsed="true"/>
			</a>
		</td>
	</tr>
</c:if>
