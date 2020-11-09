<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectOpportunityDashBoardTeam) > 0}">
		<c:forEach items="${selectOpportunityDashBoardTeam}" var="items">
			
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO') || fn:contains(auth, 'ROLE_CFO') || fn:contains(auth, 'ROLE_DIVISION')}">
					<tr class="tr_list depth2" id="team_${items.MEMBER_TEAM}" data-division="${items.MEMBER_DIVISION}" name="sub_tr_${items.MEMBER_DIVISION}">	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<tr class="tr_list" id="team_${items.MEMBER_TEAM}" data-division="${items.MEMBER_DIVISION}" name="sub_tr_${items.MEMBER_DIVISION}">	
				</c:when>
				<c:otherwise>
					<tr class="tr_list depth2" id="team_${items.MEMBER_TEAM}" data-division="${items.MEMBER_DIVISION}" name="sub_tr_${items.MEMBER_DIVISION}">
				</c:otherwise>
			</c:choose>
			
				<th><img src="../images/pc/icon_folder_plus.png" class="btn_bottom_dep" onclick="dashboard.memberGet('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',this)"/><a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null);"> ${items.TEAM_NAME}</a></th>
				
				
				<fmt:parseNumber var="TARGET_REV" integerOnly="true" value="${items.TARGET_REV}"/>
				<fmt:parseNumber var="TARGET_GP" integerOnly="true" value="${items.TARGET_GP}"/>
				
				<fmt:parseNumber var="ACTUAL_TCV_AMOUNT" integerOnly="true" value="${items.REV_CLOSE_FC_IN + items.REV_CLOSE_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="ACTUAL_REV_AMOUNT" integerOnly="true" value="${items.REV_CLOSE_FC_IN + items.REV_CLOSE_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.GP_CLOSE_FC_IN + items.GP_CLOSE_SPLIT_FC_IN}"/>
					
				<fmt:parseNumber var="TCV_FC_IN" integerOnly="true" value="${items.REV_ING_FC_IN + items.REV_ING_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="TCV_FC_OUT" integerOnly="true" value="${items.REV_ING_FC_OUT + items.REV_ING_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="REV_FC_IN" integerOnly="true" value="${items.REV_ING_FC_IN + items.REV_ING_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="REV_FC_OUT" integerOnly="true" value="${items.REV_ING_FC_OUT + items.REV_ING_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="GP_FC_IN" integerOnly="true" value="${items.GP_ING_FC_IN + items.GP_ING_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="GP_FC_OUT" integerOnly="true" value="${items.GP_ING_FC_OUT + items.GP_ING_SPLIT_FC_OUT}"/>
				
				<fmt:parseNumber var="THIS_WEEK_TCV_FC_IN" integerOnly="true" value="${items.REV_THIS_FC_IN + REV_THIS_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="THIS_WEEK_TCV_FC_OUT" integerOnly="true" value="${items.REV_THIS_FC_OUT + REV_THIS_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="THIS_WEEK_REV_FC_IN" integerOnly="true" value="${items.REV_THIS_FC_IN + REV_THIS_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="THIS_WEEK_REV_FC_OUT" integerOnly="true" value="${items.REV_THIS_FC_OUT + REV_THIS_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="THIS_WEEK_GP_FC_IN" integerOnly="true" value="${items.GP_THIS_FC_IN + GP_THIS_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="THIS_WEEK_GP_FC_OUT" integerOnly="true" value="${items.GP_THIS_FC_OUT + GP_THIS_SPLIT_FC_OUT}"/>
				
				<fmt:parseNumber var="LAST_WEEK_TCV_FC_IN" 	integerOnly="true" value="${items.REV_LAST_FC_IN + REV_LAST_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="LAST_WEEK_TCV_FC_OUT" integerOnly="true" value="${items.REV_LAST_FC_OUT + REV_LAST_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="LAST_WEEK_REV_FC_IN" 	integerOnly="true" value="${items.REV_LAST_FC_IN + REV_LAST_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="LAST_WEEK_REV_FC_OUT" integerOnly="true" value="${items.REV_LAST_FC_OUT + REV_LAST_SPLIT_FC_OUT}"/>
				<fmt:parseNumber var="LAST_WEEK_GP_FC_IN" 	integerOnly="true" value="${items.GP_LAST_FC_IN + GP_LAST_SPLIT_FC_IN}"/>
				<fmt:parseNumber var="LAST_WEEK_GP_FC_OUT"  integerOnly="true" value="${items.GP_LAST_FC_OUT + GP_LAST_SPLIT_FC_IN}"/>
				
				<!-- TCV -->
				<td>
						<fmt:formatNumber value="${ACTUAL_TCV_AMOUNT / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'In');">
						<fmt:formatNumber value="${TCV_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				
				<c:choose>
					<c:when test="${TARGET_REV <= THIS_WEEK_TCV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_TCV_FC_IN - TARGET_REV) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_REV > THIS_WEEK_TCV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_REV - THIS_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${LAST_WEEK_TCV_FC_IN <= THIS_WEEK_TCV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_TCV_FC_IN - LAST_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_WEEK_TCV_FC_IN > THIS_WEEK_TCV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_WEEK_TCV_FC_IN - THIS_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				<%-- <td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_TCV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td> --%>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'Out');">
						<fmt:formatNumber value="${TCV_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				
				<!-- REV -->
				<td>
					<fmt:formatNumber value="${ACTUAL_REV_AMOUNT / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'In');">
						<fmt:formatNumber value="${REV_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<c:choose>
					<c:when test="${TARGET_REV <= THIS_WEEK_REV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_REV_FC_IN - TARGET_REV) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_REV > THIS_WEEK_REV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_REV - THIS_WEEK_REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${LAST_WEEK_REV_FC_IN <= THIS_WEEK_REV_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_REV_FC_IN - LAST_WEEK_REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_WEEK_REV_FC_IN > THIS_WEEK_REV_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_WEEK_REV_FC_IN - THIS_WEEK_REV_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				<%-- <td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_REV_FC_IN ) / 1000000}" type="currency" currencySymbol=""/></td> --%>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'Out');">
						<fmt:formatNumber value="${REV_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<!-- GP -->
				<td>
					<fmt:formatNumber value="${ACTUAL_GP_AMOUNT / 1000000}" type="currency" currencySymbol=""/>
				</td>
				
				<td>
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'In');">
						<fmt:formatNumber value="${GP_FC_IN / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
				<c:choose>
					<c:when test="${TARGET_GP <= THIS_WEEK_GP_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_GP_FC_IN - TARGET_GP) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${TARGET_GP > THIS_WEEK_GP_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(TARGET_GP - THIS_WEEK_GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${LAST_WEEK_GP_FC_IN <= THIS_WEEK_GP_FC_IN}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_WEEK_GP_FC_IN - LAST_WEEK_GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:when test="${LAST_WEEK_GP_FC_IN > THIS_WEEK_GP_FC_IN}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_WEEK_GP_FC_IN - THIS_WEEK_GP_FC_IN) / 1000000}" type="currency" currencySymbol=""/></td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol=""/></td>
					</c:otherwise>
				</c:choose>
				
				<td class="end">
					<a href="javascript:void(0);" onClick="dashboard.goList('${items.MEMBER_DIVISION}','${items.MEMBER_TEAM}',null,'Out');">
						<fmt:formatNumber value="${GP_FC_OUT / 1000000}" type="currency" currencySymbol=""/>
					</a>
				</td>
				
			</tr>
			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="16" style="text-align:center;" class="end" >No Data</td>
		</tr>
	</c:otherwise>
</c:choose>


