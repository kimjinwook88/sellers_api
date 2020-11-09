<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectClientIssueCompanyDashBoardDep1) > 0}">
		<c:forEach items="${selectClientIssueCompanyDashBoardDep1}" var="companyGroup">
		
			<c:choose>
				<c:when test="${companyGroup.SEGMENT_CODE eq null}">
					<tr class="total">
						<th style="text-align: center;">총계</th>
						<td class="ag_c"><fmt:formatNumber value="${companyGroup.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'제품',null);">
								<fmt:formatNumber value="${companyGroup.CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'서비스',null);">
								<fmt:formatNumber value="${companyGroup.CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'지원',null);">
								<fmt:formatNumber value="${companyGroup.CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'기타',null);">
								<fmt:formatNumber value="${companyGroup.CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'진행중',null,null);">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${companyGroup.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'지연',null,null);">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'완료',null,null);">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr class="tr_list">
						<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.companyGet('${companyGroup.SEGMENT_CODE}',this)"/><a href="javascript:void(0);" onClick="dashboard.goList(null,null,null,'${companyGroup.SEGMENT_CODE}');"> ${companyGroup.SEGMENT_HAN_NAME}</a></th>
						<td class="ag_c"><fmt:formatNumber value="${companyGroup.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'제품', '${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'서비스','${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'지원','${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,'기타','${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'진행중',null,'${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${companyGroup.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'지연',null,'${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'완료',null,'${companyGroup.SEGMENT_CODE}');">
								<fmt:formatNumber value="${companyGroup.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
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
