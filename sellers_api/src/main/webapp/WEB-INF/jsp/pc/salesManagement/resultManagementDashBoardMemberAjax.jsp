<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(selectResultDashBoardMember) > 0}">
		<c:forEach items="${selectResultDashBoardMember}" var="items">
			
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO') || fn:contains(auth, 'ROLE_CFO') || fn:contains(auth, 'ROLE_DIVISION') || fn:contains(auth, 'ROLE_TEAM')}">
						<tr class="tr_list depth3" data-division="${items.MEMBER_DIVISION}" data-team="${items.MEMBER_TEAM}" name="sub_tr_${items.MEMBER_DIVISION}">	
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<tr class="tr_list" data-division="${items.MEMBER_DIVISION}" data-team="${items.MEMBER_TEAM}" name="sub_tr_${items.MEMBER_DIVISION}">	
					</c:when>
					<c:otherwise>
						<tr class="tr_list" data-division="${items.MEMBER_DIVISION}" data-team="${items.MEMBER_TEAM}" name="sub_tr_${items.MEMBER_DIVISION}">
					</c:otherwise>
				</c:choose>
				
				<th>${items.HAN_NAME}</th>

				<fmt:parseNumber var="FY_TARGET_REV" integerOnly="true" value="${items.FY_TARGET_REV}" />
				<fmt:parseNumber var="FY_TARGET_GP" integerOnly="true" value="${items.FY_TARGET_GP}" />
				<fmt:parseNumber var="Q_TARGET_REV" integerOnly="true" value="${items.Q_TARGET_REV}" />
				<fmt:parseNumber var="Q_TARGET_GP" integerOnly="true" value="${items.Q_TARGET_GP}" />

				<fmt:parseNumber var="TCV_AMOUNT" integerOnly="true" value="${items.TCV_AMOUNT}" />
				<fmt:parseNumber var="REV_AMOUNT" integerOnly="true" value="${items.REV_AMOUNT}" />
				<fmt:parseNumber var="PLAN_GP_AMOUNT" integerOnly="true" value="${items.PLAN_GP_AMOUNT}" />
				<fmt:parseNumber var="ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.ACTUAL_GP_AMOUNT}" />

				<fmt:parseNumber var="THIS_YEAR_TCV_AMOUNT" integerOnly="true" value="${items.THIS_YEAR_TCV_AMOUNT}" />
				<fmt:parseNumber var="THIS_YEAR_REV_AMOUNT" integerOnly="true" value="${items.THIS_YEAR_REV_AMOUNT}" />
				<fmt:parseNumber var="THIS_YEAR_PLAN_GP_AMOUNT" integerOnly="true" value="${items.THIS_YEAR_PLAN_GP_AMOUNT}" />
				<fmt:parseNumber var="THIS_YEAR_ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.THIS_YEAR_ACTUAL_GP_AMOUNT}" />

				<fmt:parseNumber var="LAST_YEAR_TCV_AMOUNT" integerOnly="true" value="${items.LAST_YEAR_TCV_AMOUNT}" />
				<fmt:parseNumber var="LAST_YEAR_REV_AMOUNT" integerOnly="true" value="${items.LAST_YEAR_REV_AMOUNT}" />
				<fmt:parseNumber var="LAST_YEAR_PLAN_GP_AMOUNT" integerOnly="true" value="${items.LAST_YEAR_PLAN_GP_AMOUNT}" />
				<fmt:parseNumber var="LAST_YEAR_ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.LAST_YEAR_ACTUAL_GP_AMOUNT}" />

			<%-- 	<fmt:parseNumber var="LAST_WEEK_TCV_AMOUNT" integerOnly="true" value="${items.LAST_WEEK_TCV_AMOUNT}" />
				<fmt:parseNumber var="LAST_WEEK_REV_AMOUNT" integerOnly="true" value="${items.LAST_WEEK_REV_AMOUNT}" />
				<fmt:parseNumber var="LAST_WEEK_PLAN_GP_AMOUNT" integerOnly="true" value="${items.LAST_WEEK_PLAN_GP_AMOUNT}" />
				<fmt:parseNumber var="LAST_WEEK_ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.LAST_WEEK_ACTUAL_GP_AMOUNT}" />

				<fmt:parseNumber var="THIS_WEEK_TCV_AMOUNT" integerOnly="true" value="${items.THIS_WEEK_TCV_AMOUNT}" />
				<fmt:parseNumber var="THIS_WEEK_REV_AMOUNT" integerOnly="true" value="${items.THIS_WEEK_REV_AMOUNT}" />
				<fmt:parseNumber var="THIS_WEEK_PLAN_GP_AMOUNT" integerOnly="true" value="${items.THIS_WEEK_PLAN_GP_AMOUNT}" />
				<fmt:parseNumber var="THIS_WEEK_ACTUAL_GP_AMOUNT" integerOnly="true" value="${items.THIS_WEEK_ACTUAL_GP_AMOUNT}" /> --%>

				<!-- target -->
				<td><fmt:formatNumber value="${FY_TARGET_REV / 1000000}" type="currency" currencySymbol="" /></td>
				<td><fmt:formatNumber value="${FY_TARGET_GP / 1000000}" type="currency" currencySymbol="" /></td>
				<td><fmt:formatNumber value="${Q_TARGET_REV / 1000000}" type="currency" currencySymbol="" /></td>
				<td><fmt:formatNumber value="${Q_TARGET_GP / 1000000}" type="currency" currencySymbol="" /></td>

				<!-- Acheivment TCV -->
				<td><fmt:formatNumber value="${TCV_AMOUNT / 1000000}" type="currency" currencySymbol="" /></td>
				<c:choose>
					<c:when test="${TCV_AMOUNT > 0 && FY_TARGET_REV > 0}">
						<td><fmt:formatNumber value="${TCV_AMOUNT / FY_TARGET_REV}" type="percent" /></td>
					</c:when>
					<c:when test="${TCV_AMOUNT > 0 && FY_TARGET_REV == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${TCV_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${TCV_AMOUNT > 0 && Q_TARGET_REV > 0}">
						<td><fmt:formatNumber value="${TCV_AMOUNT / Q_TARGET_REV}" type="percent" /></td>
					</c:when>
					<c:when test="${TCV_AMOUNT > 0 && Q_TARGET_REV == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${TCV_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>

				<!-- Acheivment REV -->
				<td><fmt:formatNumber value="${REV_AMOUNT / 1000000}" type="currency" currencySymbol="" /></td>
				<c:choose>
					<c:when test="${REV_AMOUNT > 0 && FY_TARGET_REV > 0}">
						<td><fmt:formatNumber value="${REV_AMOUNT / FY_TARGET_REV}" type="percent" /></td>
					</c:when>
					<c:when test="${REV_AMOUNT > 0 && FY_TARGET_REV == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${REV_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${REV_AMOUNT > 0 && Q_TARGET_REV > 0}">
						<td><fmt:formatNumber value="${REV_AMOUNT / Q_TARGET_REV}" type="percent" /></td>
					</c:when>
					<c:when test="${REV_AMOUNT > 0 && Q_TARGET_REV == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${REV_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>

				<!-- Acheivment P.GP -->
				<td><fmt:formatNumber value="${PLAN_GP_AMOUNT / 1000000}" type="currency" currencySymbol="" /></td>
				<c:choose>
					<c:when test="${PLAN_GP_AMOUNT > 0 && FY_TARGET_GP > 0}">
						<td><fmt:formatNumber value="${PLAN_GP_AMOUNT / FY_TARGET_GP}" type="percent" /></td>
					</c:when>
					<c:when test="${PLAN_GP_AMOUNT > 0 && FY_TARGET_GP == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${PLAN_GP_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${PLAN_GP_AMOUNT > 0 && Q_TARGET_GP > 0}">
						<td><fmt:formatNumber value="${PLAN_GP_AMOUNT / Q_TARGET_GP}" type="percent" /></td>
					</c:when>
					<c:when test="${PLAN_GP_AMOUNT > 0 && Q_TARGET_GP == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${PLAN_GP_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>

				<!-- Acheivment A.GP -->
				<td><fmt:formatNumber value="${ACTUAL_GP_AMOUNT / 1000000}" type="currency" currencySymbol="" /></td>
				<c:choose>
					<c:when test="${ACTUAL_GP_AMOUNT > 0 && FY_TARGET_GP > 0}">
						<td><fmt:formatNumber value="${ACTUAL_GP_AMOUNT / FY_TARGET_GP}" type="percent" /></td>
					</c:when>
					<c:when test="${ACTUAL_GP_AMOUNT > 0 && FY_TARGET_GP == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${ACTUAL_GP_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${ACTUAL_GP_AMOUNT > 0 && Q_TARGET_GP > 0}">
						<td><fmt:formatNumber value="${ACTUAL_GP_AMOUNT / Q_TARGET_GP}" type="percent" /></td>
					</c:when>
					<c:when test="${ACTUAL_GP_AMOUNT > 0 && Q_TARGET_GP == 0}">
						<td><fmt:formatNumber value="1" type="percent" /></td>
					</c:when>
					<c:when test="${ACTUAL_GP_AMOUNT == 0}">
						<td><fmt:formatNumber value="0" type="percent" /></td>
					</c:when>
				</c:choose>

				<!-- Y2Y TCV -->
				<%-- <c:choose>
					<c:when test="${LAST_YEAR_TCV_AMOUNT < THIS_YEAR_TCV_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_TCV_AMOUNT-LAST_YEAR_TCV_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:when test="${LAST_YEAR_TCV_AMOUNT > THIS_YEAR_TCV_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_TCV_AMOUNT-THIS_YEAR_TCV_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:otherwise><td><fmt:formatNumber value="${THIS_YEAR_TCV_AMOUNT / 1000000}" type="currency" currencySymbol=""/></td></c:otherwise>
				</c:choose>
				<c:choose>
             		<c:when test="${THIS_YEAR_TCV_AMOUNT > 0 && LAST_YEAR_TCV_AMOUNT > 0}">
             		<td><fmt:formatNumber value="${THIS_YEAR_TCV_AMOUNT / LAST_YEAR_TCV_AMOUNT}" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_TCV_AMOUNT > 0 && LAST_YEAR_TCV_AMOUNT == 0}">
             		<td><fmt:formatNumber value="1" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_TCV_AMOUNT == 0}">
             		<td><fmt:formatNumber value="0" type="percent"/></td>
             		</c:when>
             	</c:choose> --%>

				<!-- Y2Y REV -->
				<%-- <c:choose>
					<c:when test="${LAST_YEAR_REV_AMOUNT < THIS_YEAR_REV_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_REV_AMOUNT-LAST_YEAR_REV_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:when test="${LAST_YEAR_REV_AMOUNT > THIS_YEAR_REV_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_REV_AMOUNT-THIS_YEAR_REV_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:otherwise><td><fmt:formatNumber value="${THIS_YEAR_REV_AMOUNT / 1000000}" type="currency" currencySymbol=""/></td></c:otherwise>
				</c:choose>
				<c:choose>
             		<c:when test="${THIS_YEAR_REV_AMOUNT > 0 && LAST_YEAR_REV_AMOUNT > 0}">
             		<td><fmt:formatNumber value="${THIS_YEAR_REV_AMOUNT / LAST_YEAR_REV_AMOUNT}" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_REV_AMOUNT > 0 && LAST_YEAR_REV_AMOUNT == 0}">
             		<td><fmt:formatNumber value="1" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_REV_AMOUNT == 0}">
             		<td><fmt:formatNumber value="0" type="percent"/></td>
             		</c:when>
             	</c:choose> --%>

				<!-- Y2Y P.GP -->
				<%-- <c:choose>
					<c:when test="${LAST_YEAR_PLAN_GP_AMOUNT < THIS_YEAR_PLAN_GP_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_PLAN_GP_AMOUNT-LAST_YEAR_PLAN_GP_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:when test="${LAST_YEAR_PLAN_GP_AMOUNT > THIS_YEAR_PLAN_GP_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_PLAN_GP_AMOUNT-THIS_YEAR_PLAN_GP_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:otherwise><td><fmt:formatNumber value="${THIS_YEAR_PLAN_GP_AMOUNT / 1000000}" type="currency" currencySymbol=""/></td></c:otherwise>
				</c:choose>
				<c:choose>
             		<c:when test="${THIS_YEAR_PLAN_GP_AMOUNT > 0 && LAST_YEAR_PLAN_GP_AMOUNT > 0}">
             		<td><fmt:formatNumber value="${THIS_YEAR_PLAN_GP_AMOUNT / LAST_YEAR_PLAN_GP_AMOUNT}" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_PLAN_GP_AMOUNT > 0 && LAST_YEAR_PLAN_GP_AMOUNT == 0}">
             		<td><fmt:formatNumber value="1" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_PLAN_GP_AMOUNT == 0}">
             		<td><fmt:formatNumber value="0" type="percent"/></td>
             		</c:when>
             	</c:choose> --%>

				<!-- Y2Y A.GP -->
				<%-- <c:choose>
					<c:when test="${LAST_YEAR_ACTUAL_GP_AMOUNT < THIS_YEAR_ACTUAL_GP_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_ACTUAL_GP_AMOUNT-LAST_YEAR_ACTUAL_GP_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:when test="${LAST_YEAR_ACTUAL_GP_AMOUNT > THIS_YEAR_ACTUAL_GP_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_ACTUAL_GP_AMOUNT-THIS_YEAR_ACTUAL_GP_AMOUNT) / 1000000}" type="currency" currencySymbol=""/> </td>
					</c:when>
					<c:otherwise><td><fmt:formatNumber value="${THIS_YEAR_ACTUAL_GP_AMOUNT / 1000000}" type="currency" currencySymbol=""/></td></c:otherwise>
				</c:choose>
				<c:choose>
             		<c:when test="${THIS_YEAR_ACTUAL_GP_AMOUNT > 0 && LAST_YEAR_ACTUAL_GP_AMOUNT > 0}">
             		<td><fmt:formatNumber value="${THIS_YEAR_ACTUAL_GP_AMOUNT / LAST_YEAR_ACTUAL_GP_AMOUNT}" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_ACTUAL_GP_AMOUNT > 0 && LAST_YEAR_ACTUAL_GP_AMOUNT == 0}">
             		<td><fmt:formatNumber value="1" type="percent"/></td>
             		</c:when>
             		<c:when test="${THIS_YEAR_ACTUAL_GP_AMOUNT == 0}">
             		<td><fmt:formatNumber value="0" type="percent"/></td>
             		</c:when>
             	</c:choose> --%>

				<!-- Q2Q TCV -->
				<c:choose>
					<c:when test="${LAST_YEAR_TCV_AMOUNT <= THIS_YEAR_TCV_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_TCV_AMOUNT-LAST_YEAR_TCV_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:when test="${LAST_YEAR_TCV_AMOUNT > THIS_YEAR_TCV_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_TCV_AMOUNT-THIS_YEAR_TCV_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol="" /></td>
					</c:otherwise>
				</c:choose>

				<!-- Q2Q REV -->
				<c:choose>
					<c:when test="${LAST_YEAR_REV_AMOUNT <= THIS_YEAR_REV_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_REV_AMOUNT-LAST_YEAR_REV_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:when test="${LAST_YEAR_REV_AMOUNT > THIS_YEAR_REV_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_REV_AMOUNT-THIS_YEAR_REV_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol="" /></td>
					</c:otherwise>
				</c:choose>

				<!-- Q2Q P.GP -->
				<c:choose>
					<c:when test="${LAST_YEAR_PLAN_GP_AMOUNT <= THIS_YEAR_PLAN_GP_AMOUNT}">
						<td class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_PLAN_GP_AMOUNT-LAST_YEAR_PLAN_GP_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:when test="${LAST_YEAR_PLAN_GP_AMOUNT > THIS_YEAR_PLAN_GP_AMOUNT}">
						<td class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_PLAN_GP_AMOUNT-THIS_YEAR_PLAN_GP_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="0" type="currency" currencySymbol="" /></td>
					</c:otherwise>
				</c:choose>

				<!-- W2W A.GP -->
				<c:choose>
					<c:when test="${LAST_YEAR_ACTUAL_GP_AMOUNT <= THIS_YEAR_ACTUAL_GP_AMOUNT}">
						<td class="end" class="fc_blue2 ft_bold">+<fmt:formatNumber value="${(THIS_YEAR_ACTUAL_GP_AMOUNT-LAST_YEAR_ACTUAL_GP_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:when
						test="${LAST_YEAR_ACTUAL_GP_AMOUNT > THIS_YEAR_ACTUAL_GP_AMOUNT}">
						<td class="end" class="cell-status cell-statusColor-sred fc_white">-<fmt:formatNumber value="${(LAST_YEAR_ACTUAL_GP_AMOUNT-THIS_YEAR_ACTUAL_GP_AMOUNT) / 1000000}" type="currency" currencySymbol="" />
						</td>
					</c:when>
					<c:otherwise>
						<td class="end"><fmt:formatNumber value="0" type="currency" currencySymbol="" /></td>
					</c:otherwise>
				</c:choose>
			</tr>

		</c:forEach>
	</c:when>

	<c:otherwise>
		<tr>
			<td colspan="29" style="text-align: center;" class="end">No
				Data</td>
		</tr>
	</c:otherwise>

</c:choose>

