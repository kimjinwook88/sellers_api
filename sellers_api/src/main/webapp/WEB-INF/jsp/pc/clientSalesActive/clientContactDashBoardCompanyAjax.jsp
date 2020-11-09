<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectClientContactDashBoardComapny) > 0}">
		<c:forEach items="${selectClientContactDashBoardComapny}" var="company">
					<tr class="tr_list depth3" data-category="${company.SEGMENT_CODE}">
						<th><a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}');"> ${company.COMPANY_NAME}</a></th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}','방문',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}','마케팅',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}','SNS',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}','E-mail',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}','전화',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_5}" groupingUsed="true"/>
							</a>
						</td>
						<%-- <td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}',null,'이슈');">
								<fmt:formatNumber value="${company.ISSUE_COUNT}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany('${company.COMPANY_ID}','${company.SEGMENT_CODE}',null,'잠재영업기회');">
								<fmt:formatNumber value="${company.OPP_COUNT}" groupingUsed="true"/>
							</a>
						</td> --%>
					</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>



