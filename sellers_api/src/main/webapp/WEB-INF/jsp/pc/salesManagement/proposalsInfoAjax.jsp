<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
			<tr class="tr_list"
				onClick="suggestList.goDetail(${rows.PROPOSAL_ID});">
				<%-- <fmt:parseNumber var="NO" integerOnly="true" value="${rows.ROWNUM}" />
				<td>${NO}</td> --%>
				<td name="cols_CATEGORY_BIZ">${rows.CATEGORY_BIZ}</td>
				<td name="cols_COMPANY_NAME" class="ag_l">${rows.COMPANY_NAME}</td>
				<td name="cols_CUSTOMER_NAME">${rows.CUSTOMER_NAME}</td>
				<td name="cols_CATEGORY_PRODUCT">${rows.CATEGORY_PRODUCT}</td>
				<td name="cols_PROPOSAL_SUBJECT" class="ag_l">${rows.PROPOSAL_SUBJECT}</td>
				<td name="cols_PROPOSAL_LEADER">${rows.PROPOSAL_LEADER_NAME}</td>
				<td name="cols_PROPOSAL_COST_AMOUNT"><c:choose>
						<c:when test="${rows.PROPOSAL_COST_AMOUNT > 0}">
							<fmt:formatNumber value="${rows.PROPOSAL_COST_AMOUNT/1000}"
								groupingUsed="true" />
						</c:when>
						<c:otherwise>
	        		0
	        		</c:otherwise>
					</c:choose></td>
				<td name="cols_PROPOSAL_AMOUNT"><c:choose>
						<c:when test="${rows.PROPOSAL_AMOUNT > 0}">
							<fmt:formatNumber value="${rows.PROPOSAL_AMOUNT/1000}"
								groupingUsed="true" />
						</c:when>
						<c:otherwise>
	        		0
	        		</c:otherwise>
					</c:choose></td>
				<td name="cols_PROPOSAL_END_DATE">${rows.PROPOSAL_END_DATE}</td>
				<td name="cols_PROPOSAL_RESULT">${rows.PROPOSAL_RESULT}</td>
				<td name="cols_FILE_COUNT"><c:choose>
						<c:when test="${rows.FILE_COUNT > 0}">
							<span class="file_inner"></span>
						</c:when>
						<c:otherwise>
							<span>-</span>
						</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="12" style="text-align: center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>

