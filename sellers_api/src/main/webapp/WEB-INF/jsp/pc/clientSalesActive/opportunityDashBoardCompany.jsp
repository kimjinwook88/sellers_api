<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectOpportunityDashBoardCompnay) > 0}">
		<c:forEach items="${selectOpportunityDashBoardCompnay}" var="company">
			<%-- 
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
					<tr class="tr_list" data-division="${company.MEMBER_DIVISION}" data-team="${company.MEMBER_TEAM}" name="sub_tr_${company.MEMBER_DIVISION}">	
				</c:when>
				<c:otherwise>
					<tr class="tr_list depth3" data-division="${company.MEMBER_DIVISION}" data-team="${company.MEMBER_TEAM}" name="sub_tr_${company.MEMBER_DIVISION}">
				</c:otherwise>
			</c:choose>
				 --%>
				<tr class="tr_list depth3" data-category="${company.SEGMENT_CODE}">
				
				<th><a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_NAME}','','');"> ${company.COMPANY_NAME}</a></th>
				
				<fmt:parseNumber var="TARGET_REV" integerOnly="true" value="${company.TARGET_REV}"/>
				<fmt:parseNumber var="TARGET_GP" integerOnly="true" value="${company.TARGET_GP}"/>
				
				<fmt:parseNumber var="ACTUAL_REV_AMOUNT_QTD" integerOnly="true" value="${company.ACTUAL_REV_AMOUNT_QTD}"/>
				<fmt:parseNumber var="ACTUAL_GP_AMOUNT_QTD" integerOnly="true" value="${company.ACTUAL_GP_AMOUNT_QTD}"/>
				
				<%-- <fmt:parseNumber var="ACTUAL_TCV_AMOUNT" integerOnly="true" value="${company.ACTUAL_TCV_AMOUNT}"/> --%>
				<fmt:parseNumber var="ACTUAL_REV_AMOUNT" integerOnly="true" value="${company.ACTUAL_REV_AMOUNT}"/>
				<fmt:parseNumber var="ACTUAL_GP_AMOUNT" integerOnly="true" value="${company.ACTUAL_GP_AMOUNT}"/>
					
				<%-- <fmt:parseNumber var="TCV_FC_IN" integerOnly="true" value="${company.TCV_FC_IN}"/>
				<fmt:parseNumber var="TCV_FC_OUT" integerOnly="true" value="${company.TCV_FC_OUT}"/> --%>
				<fmt:parseNumber var="REV_FC_IN" integerOnly="true" value="${company.REV_FC_IN}"/>
				<fmt:parseNumber var="REV_FC_OUT" integerOnly="true" value="${company.REV_FC_OUT}"/>
				<fmt:parseNumber var="GP_FC_IN" integerOnly="true" value="${company.GP_FC_IN}"/>
				<fmt:parseNumber var="GP_FC_OUT" integerOnly="true" value="${company.GP_FC_OUT}"/>
				
				<%-- <fmt:parseNumber var="THIS_WEEK_TCV_FC_IN" integerOnly="true" value="${company.THIS_WEEK_TCV_FC_IN}"/>
				<fmt:parseNumber var="THIS_WEEK_TCV_FC_OUT" integerOnly="true" value="${company.THIS_WEEK_TCV_FC_OUT}"/> --%>
				<fmt:parseNumber var="LAST_REV_FC_IN" integerOnly="true" value="${company.LAST_REV_FC_IN}"/>
				<fmt:parseNumber var="LAST_REV_FC_OUT" integerOnly="true" value="${company.LAST_REV_FC_OUT}"/>
				<fmt:parseNumber var="LAST_GP_FC_IN" integerOnly="true" value="${company.LAST_GP_FC_IN}"/>
				<fmt:parseNumber var="LAST_GP_FC_OUT" integerOnly="true" value="${company.LAST_GP_FC_OUT}"/>
				
				<!-- TCV -->
				<%-- 
				<td>
					<fmt:formatNumber value="${ACTUAL_TCV_AMOUNT / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.MEMBER_DIVISION}','${company.MEMBER_TEAM}','${company.MEMBER_ID_NUM}','In');">
						<fmt:formatNumber value="${TCV_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<c:choose>
					<c:when test="${TARGET_REV < (TCV_FC_IN+ACTUAL_TCV_AMOUNT)}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${((TCV_FC_IN+ACTUAL_TCV_AMOUNT) - TARGET_REV) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_REV > (TCV_FC_IN+ACTUAL_TCV_AMOUNT)}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_REV - (TCV_FC_IN+ACTUAL_TCV_AMOUNT)) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${LAST_WEEK_TCV_FC_IN < THIS_WEEK_TCV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_TCV_FC_IN - LAST_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_WEEK_TCV_FC_IN > THIS_WEEK_TCV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_WEEK_TCV_FC_IN - THIS_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.MEMBER_DIVISION}','${company.MEMBER_TEAM}','${company.MEMBER_ID_NUM}','Out');">
						<fmt:formatNumber value="${TCV_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				 --%>
				
				<!-- REV -->
				<td>
					<fmt:formatNumber value="${ACTUAL_REV_AMOUNT_QTD / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_NAME}','In','');">
						<fmt:formatNumber value="${REV_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<%-- <c:choose>
					<c:when test="${TARGET_REV < REV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(REV_FC_IN - TARGET_REV) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_REV > REV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_REV - REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose> --%>
				
				<c:choose>
					<c:when test="${LAST_REV_FC_IN < REV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(REV_FC_IN - LAST_REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_REV_FC_IN > REV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_REV_FC_IN - REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_NAME}','Out','');">
						<fmt:formatNumber value="${REV_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<!-- GP -->
				<td>
					<fmt:formatNumber value="${ACTUAL_GP_AMOUNT_QTD / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_NAME}','In','');">
						<fmt:formatNumber value="${GP_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<%-- <c:choose>
					<c:when test="${TARGET_GP < GP_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(GP_FC_IN - TARGET_GP) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_GP > GP_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_GP - GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose> --%>
				
				<c:choose>
					<c:when test="${LAST_GP_FC_IN < GP_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(GP_FC_IN - LAST_GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_GP_FC_IN > GP_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_GP_FC_IN - GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<td class="end">
					<a href="javascript:void(0);" onClick="dashboard.goListCompany('${company.COMPANY_NAME}','Out','');">
						<fmt:formatNumber value="${GP_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
			</tr>
			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="13" style="text-align:center;" class="end" >No Data</td>
		</tr>
	</c:otherwise>
</c:choose>



