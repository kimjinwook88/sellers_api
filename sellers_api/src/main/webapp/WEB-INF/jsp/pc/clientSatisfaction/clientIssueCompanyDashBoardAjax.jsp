<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${fn:length(selectClientIssueCompanyDashBoardDep2) > 0}">
		<c:forEach items="${selectClientIssueCompanyDashBoardDep2}" var="company">
		
			<c:choose>
				<c:when test="${company.COMPANY_NAME eq null}">
				<%-- 
					<tr class="total">
						<th style="text-align: center;">총계</th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>

						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'진행중');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${company.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'지연');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'완료');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
					</tr>
					 --%>
				</c:when> 
				<c:otherwise>
					<tr class="tr_list depth3" data-category="${company.SEGMENT_CODE}">
					
						<th><a href="javascript:void(0);" onClick="dashboard.goList('${company.COMPANY_ID}','','','');"> ${company.COMPANY_NAME}</a></th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>

						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.COMPANY_ID}',null,'제품',null);">
								<fmt:formatNumber value="${company.CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.COMPANY_ID}',null,'서비스',null);">
								<fmt:formatNumber value="${company.CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.COMPANY_ID}',null,'지원',null);">
								<fmt:formatNumber value="${company.CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.COMPANY_ID}',null,'기타',null);">
								<fmt:formatNumber value="${company.CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.COMPANY_ID}','진행중',null,null);">
								<fmt:formatNumber value="${company.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${company.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.MEMBER_DIVISION}','지연',null,null);">
								<fmt:formatNumber value="${company.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList('${company.MEMBER_DIVISION}','완료',null,null);">
								<fmt:formatNumber value="${company.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
					
					</tr>
				</c:otherwise>
			</c:choose>
			<%-- 
			<c:choose>
				<c:when test="${company.CLIENT_CATEGORY_NAME eq null}">
					<tr class="total">
						<th style="text-align: center;">총계</th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>

						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'진행중');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${company.ISSUE_STATUS_2 > 0}">
						<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'지연');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,'완료');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_3}" groupingUsed="true"/>
							</a>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr class="tr_list">
						<th><a href="javascript:void(0);" onClick="dashboard.goList('${company.COMPANY_ID}');"> ${company.COMPANY_NAME}</a></th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>

						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${company.COMPANY_ID}', '진행중');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_1}" groupingUsed="true"/>
							</a>
						</td>
						<c:choose>
						<c:when test="${company.ISSUE_STATUS_2 > 0}">
							<td class="ag_c cell-status fc_white">
						</c:when>
						<c:otherwise><td class="ag_c"></c:otherwise>
						</c:choose>
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${company.COMPANY_ID}', '지연');">
								<fmt:formatNumber value="${company.ISSUE_STATUS_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
						<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.countCheck(this);dashboard.goList('${company.COMPANY_ID}', '완료');">
							<fmt:formatNumber value="${company.ISSUE_STATUS_3}" groupingUsed="true"/>
						</a>
					</td>
					</tr>
		    	</c:otherwise>
			</c:choose>
 --%>

			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
