<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
 <c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
	    <tr class="tr_list" onClick="issueList.goDetail(${rows.ISSUE_ID});">
	    	  <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
              <%-- <td>${NO}</td> --%>
              <%-- <td name="cols_COMPANY_NAME" class="ag_l">${rows.COMPANY_NAME} </td> --%>
              <c:set var="COMPANY_NAME" value="${fn:split(rows.COMPANY_NAME,',')}" />
              <td name="cols_COMPANY_NAME">
              		${COMPANY_NAME[0]}
              		<c:if test="${fn:length(COMPANY_NAME) > 1}">
              			외 ${fn:length(COMPANY_NAME)-1}고객사
              		</c:if>
              </td>
              <%-- <td name="cols_ISSUE_CREATOR">${rows.CUSTOMER_NAME} </td> --%>
              <c:set var="CUSTOMER_NAME" value="${fn:split(rows.CUSTOMER_NAME,',')}" />
              <td name="cols_CUSTOMER_NAME">
              		${CUSTOMER_NAME[0]}
              		<c:if test="${fn:length(CUSTOMER_NAME) > 1}">
              			외 ${fn:length(CUSTOMER_NAME)-1}명
              		</c:if>
              </td>
              
              <td name="cols_SALES_REPRESENTIVE_NAME">${rows.SALES_REPRESENTIVE_NAME} </td>
              <td name="cols_ISSUE_SUBJECT" class="ag_l">${rows.ISSUE_SUBJECT}
              	<c:if test="${rows.COACHING_TALK_COUNT > 0}">
              		<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
              	</c:if>
              </td>
              <td name="cols_ISSUE_CATEGORY">${rows.ISSUE_CATEGORY} </td>
              <td name="cols_SOLVE_OWNER">${rows.SOLVE_OWNER_NAME} </td>
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
			  
			  <c:choose>
              	<c:when test="${rows.CONFIRM_NAME != null and rows.CONFIRM_NAME !=''}">
					<td name="cols_CONFIRM_NAME">${rows.CONFIRM_NAME}</td>
              	</c:when>
              	<c:otherwise>
          			<td name="cols_CONFIRM_NAME">-</td>
              	</c:otherwise>
              </c:choose>
              
               <td name="cols_ISSUE_ACTION_STATUS_TEXT" class="fua_status">
               	   <div class="milestones">
	           			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
	               			<jsp:param name="DUE_DATE_1" value="${rows.DUE_DATE_1}" />
	               			<jsp:param name="DUE_DATE_2" value="${rows.DUE_DATE_2}" />
	               			<jsp:param name="DUE_DATE_3" value="${rows.DUE_DATE_3}" />
	               			<jsp:param name="DUE_DATE_4" value="${rows.DUE_DATE_4}" />
	               			<jsp:param name="DUE_DATE_5" value="${rows.DUE_DATE_5}" />
	               			<jsp:param name="CLOSE_DATE_1" value="${rows.CLOSE_DATE_1}" />
	               			<jsp:param name="CLOSE_DATE_2" value="${rows.CLOSE_DATE_2}" />
	               			<jsp:param name="CLOSE_DATE_3" value="${rows.CLOSE_DATE_3}" />
	               			<jsp:param name="CLOSE_DATE_4" value="${rows.CLOSE_DATE_4}" />
	               			<jsp:param name="CLOSE_DATE_5" value="${rows.CLOSE_DATE_5}" />
	               			<jsp:param name="CONTENTS_1" value="${rows.CONTENTS_1}" />
	               			<jsp:param name="CONTENTS_2" value="${rows.CONTENTS_2}" />
	               			<jsp:param name="CONTENTS_3" value="${rows.CONTENTS_3}" />
	               			<jsp:param name="CONTENTS_4" value="${rows.CONTENTS_4}" />
	               			<jsp:param name="CONTENTS_5" value="${rows.CONTENTS_5}" />
	               		</jsp:include>
	              	</div>
               </td>
              
              <td name="cols_ISSUE_STATUS_TEXT" style="background-color: ${rows.ISSUE_STATUS_TEXT}"></td>
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
	
