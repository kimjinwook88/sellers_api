<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	  <c:choose>
		<c:when test="${fn:length(rows) > 0}">
			<c:forEach items="${rows}" var="rows">
		    <tr class="tr_list" onClick="clientSatisfactionList.goDetail(${rows.CSAT_ID});">
		    	<%-- <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
               <td>${NO}</td> --%>
               <%-- <td name="cols_CSAT_CATEGORY">${rows.CSAT_CATEGORY}</td> --%>
               <td class="ag_l" name="cols_PROJECT_NAME">${rows.CSAT_SUBJECT}</td>
               <td name="cols_CSAT_SURVEY">${rows.CSAT_SURVEY_POST}</td>
               <td name="cols_CSAT_SURVEY">${rows.CSAT_SURVEY_NAME}</td>
               <td name="cols_CSAT_SURVEY_DATE">${rows.CSAT_SURVEY_DATE}</td>
               <td name="cols_COUNT">${rows.AVG_CSAT_VALUE}</td>
               <td name="cols_COUNT">${rows.TOTAL_COUNT}</td>
               <td name="cols_COUNT">${rows.GREAT_COUNT}</td>
               <td name="cols_COUNT">${rows.NICE_COUNT}</td>
               <td name="cols_COUNT">${rows.GOOD_COUNT}</td>
               <td name="cols_COUNT">${rows.BAD_COUNT}</td>
               <td name="cols_COUNT">${rows.HATE_COUNT}</td>
              <%--  <td name="cols_ISSUE">${rows.ISSUE_STATUS_1}</td>
               <td name="cols_ISSUE">${rows.ISSUE_STATUS_2}</td>
               <td name="cols_ISSUE">${rows.ISSUE_STATUS_3}</td>
               <td name="cols_ISSUE">${rows.ISSUE_COUNT}</td> --%>
               <td name="cols_FILE_COUNT">
               <c:choose>
				<c:when test="${rows.FILE_COUNT > 0}">
					<span class="file_inner"></span>
				</c:when>
				<c:otherwise>
					<span>-</span>
				</c:otherwise>
			</c:choose>
               </td>
           </tr>
		    </c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="14" style="text-align:center;">No Data</td>
			</tr>
		</c:otherwise>
	</c:choose>