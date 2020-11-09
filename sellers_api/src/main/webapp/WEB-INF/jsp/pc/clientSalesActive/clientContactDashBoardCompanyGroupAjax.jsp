<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectClientContactDashBoardCompanyGroup) > 0}">
		<c:forEach items="${selectClientContactDashBoardCompanyGroup}" var="company">
			<c:choose>
				<c:when test="${company.SEGMENT_CODE eq null}">
					<tr class="total">
						<th style="text-align: center;">총계</th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'방문',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'마케팅');">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'SNS');">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'E-mail');">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,'전화');">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_5}" groupingUsed="true"/>
							</a>
						</td>
						<%-- <td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,null,'이슈');">
								<fmt:formatNumber value="${company.ISSUE_COUNT}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goList(null,null,null,null,'잠재영업기회');">
								<fmt:formatNumber value="${company.OPP_COUNT}" groupingUsed="true"/>
							</a>
						</td> --%>
					</tr>
				</c:when>
			
				<c:otherwise>
					<tr class="tr_list" name="sub_tr_${company.SEGMENT_CODE}">
						<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.companyGet('${company.SEGMENT_CODE}',this)"/><a href="javascript:void(0);" onClick="dashboard.goListCompany('','${company.SEGMENT_CODE}');"> ${company.SEGMENT_HAN_NAME}</a></th>
						<td class="ag_c"><fmt:formatNumber value="${company.TOTAL_COUNT}" groupingUsed="true"/></td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}','방문',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_1}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}','마케팅',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_2}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}','SNS',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_3}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}','E-mail',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_4}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}','전화',null);">
								<fmt:formatNumber value="${company.EVENT_CATEGORY_5}" groupingUsed="true"/>
							</a>
						</td>
						<%-- <td class="ag_c">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}',null,'이슈');">
								<fmt:formatNumber value="${company.ISSUE_COUNT}" groupingUsed="true"/>
							</a>
						</td>
						<td class="ag_c end">
							<a href="javascript:void(0);" onClick="if(dashboard.countCheck(this))dashboard.goListCompany(null,'${company.SEGMENT_CODE}',null,'잠재영업기회');">
								<fmt:formatNumber value="${company.OPP_COUNT}" groupingUsed="true"/>
							</a>
						</td> --%>
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

