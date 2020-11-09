<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
 <c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
	    <tr class="tr_list" onClick="issueList.goDetail(${rows.ISSUE_ID});">
	    	  <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
              <td>${NO}</td>
              
              
              <td name="cols_ISSUE_SUBJECT" class="ag_l">${rows.ISSUE_SUBJECT}
              	<c:if test="${rows.COACHING_TALK_COUNT > 0}">
              		<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
              	</c:if>
              </td>
              <td name="cols_GODORY_TERRITORY">${rows.ISSUE_CATEGORY_TEXT} </td>
              
              
              <td name="cols_SOLVE_OWNER">${rows.HAN_NAME} </td>
              
              <td name="cols_ISSUE_DATE">${rows.ISSUE_DATE} </td>
              
              
              <td name="cols_DUE_DATE">${rows.DUE_DATE} </td>
              
              
              
              <c:choose>
				<c:when test="${rows.ISSUE_CLOSE_DATE != null and rows.ISSUE_CLOSE_DATE != ''}">
					<td name="cols_SOLVE_DATE">${rows.ISSUE_CLOSE_DATE}</td>
				</c:when>
				<c:otherwise>
					<td name="cols_SOLVE_DATE">-</td>
				</c:otherwise>
			  </c:choose>
			  
              <%-- 
               <c:choose>
              	<c:when test="${rows.ISSUE_ACTION_STATUS_TEXT eq '-'}">
              		<td name="cols_ISSUE_ACTION_STATUS_TEXT">-</td>
              	</c:when>
              	<c:otherwise>
              		<td name="cols_ISSUE_ACTION_STATUS_TEXT" style="background-color: ${rows.ISSUE_ACTION_STATUS_TEXT}"></td>
              	</c:otherwise>
              </c:choose>
               --%>
              
              
              
              <c:choose>
              	<c:when test="${rows.APPROVAL_YN eq '1'}">
              		<!-- <td name="cols_APPROVAL_STATUS" style="background-color: #1ab394">승인</td> -->
              		<td name="cols_APPROVAL_STATUS">채택</td>
              	</c:when>
              	<c:when test="${rows.APPROVAL_YN eq '2'}">
              		<td name="cols_APPROVAL_STATUS">미채택</td>
              	</c:when>
              	<c:otherwise>
              		<td name="cols_APPROVAL_STATUS">검토중</td>
              	</c:otherwise>
              </c:choose>
              
              <td name="cols_ISSUE_STATUS_TEXT" style="background-color: ${rows.ISSUE_STATUS_TEXT}"></td>
              
              
              <%-- 
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
               --%>
 		</tr>
	    </c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="9" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
	
