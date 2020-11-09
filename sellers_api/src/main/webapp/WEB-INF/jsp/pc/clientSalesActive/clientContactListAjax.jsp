<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
 <c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
	    <tr class="tr_list" onClick="list.goDetail(${rows.EVENT_ID});">
	    	  <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
              <%-- <td>${NO}</td> --%>
              <td name="cols_EVENT_CATEGORY">${rows.EVENT_CATEGORY}</td>
              <%-- <td name="cols_COMPANY_NAME" class="ag_l">${rows.COMPANY_NAME} </td> --%>
              <c:set var="COMPANY_NAME" value="${fn:split(rows.COMPANY_NAME,',')}" />
              <%-- <td name="cols_COMPANY_NAME">
              		${COMPANY_NAME[0]}
              		<c:if test="${fn:length(COMPANY_NAME) > 1}">
              			외 ${fn:length(COMPANY_NAME)-1}고객사
              		</c:if>
              </td> --%>
              <c:set var="CUSTOMER_NAME" value="${fn:split(rows.CUSTOMER_NAME,',')}" />
              <td name="cols_CUSTOMER_NAME">
              		${CUSTOMER_NAME[0]} [${COMPANY_NAME[0]}]
              		<c:if test="${fn:length(CUSTOMER_NAME) > 1}">
              			외 ${fn:length(CUSTOMER_NAME)-1}명
              		</c:if>
              </td>
              <td name="cols_EVENT_SUBJECT" class="ag_l">
              ${rows.EVENT_SUBJECT}
              	<c:if test="${rows.COACHING_TALK_COUNT > 0}">
              		<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
              	</c:if>
              </td>
              <%-- <td name="cols_MEMBER_DIVISION">${rows.DIVISION_NAME} </td> --%>
              <td name="cols_HAN_NAME">${rows.HAN_NAME} </td>
              <td name="cols_EVENT_DATE">${rows.EVENT_DATE} </td>

			  <td name="cols_FOLLOW_UP_ACTION_STATUS" class="fua_status">
			  	<div class="milestones">
           			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
               			<jsp:param name="DUE_DATE_1" value="${rows.SOLVE_DUE_DATE_1}" />
               			<jsp:param name="DUE_DATE_2" value="${rows.SOLVE_DUE_DATE_2}" />
               			<jsp:param name="DUE_DATE_3" value="${rows.SOLVE_DUE_DATE_3}" />
               			<jsp:param name="DUE_DATE_4" value="${rows.SOLVE_DUE_DATE_4}" />
               			<jsp:param name="DUE_DATE_5" value="${rows.SOLVE_DUE_DATE_5}" />
               			<jsp:param name="CLOSE_DATE_1" value="${rows.SOLVE_CLOSE_DATE_1}" />
               			<jsp:param name="CLOSE_DATE_2" value="${rows.SOLVE_CLOSE_DATE_2}" />
               			<jsp:param name="CLOSE_DATE_3" value="${rows.SOLVE_CLOSE_DATE_3}" />
               			<jsp:param name="CLOSE_DATE_4" value="${rows.SOLVE_CLOSE_DATE_4}" />
               			<jsp:param name="CLOSE_DATE_5" value="${rows.SOLVE_CLOSE_DATE_5}" />
               			<jsp:param name="CONTENTS_1" value="${rows.SOLVE_CONTENTS_1}" />
               			<jsp:param name="CONTENTS_2" value="${rows.SOLVE_CONTENTS_2}" />
               			<jsp:param name="CONTENTS_3" value="${rows.SOLVE_CONTENTS_3}" />
               			<jsp:param name="CONTENTS_4" value="${rows.SOLVE_CONTENTS_4}" />
               			<jsp:param name="CONTENTS_5" value="${rows.SOLVE_CONTENTS_5}" />
               			<jsp:param name="OWNER_NAME_1" value="${rows.SOLVE_OWNER_NAME_1}" />
               			<jsp:param name="OWNER_NAME_2" value="${rows.SOLVE_OWNER_NAME_2}" />
               			<jsp:param name="OWNER_NAME_3" value="${rows.SOLVE_OWNER_NAME_3}" />
               			<jsp:param name="OWNER_NAME_4" value="${rows.SOLVE_OWNER_NAME_4}" />
               			<jsp:param name="OWNER_NAME_5" value="${rows.SOLVE_OWNER_NAME_5}" />
               		</jsp:include>
              	</div>
			  </td>


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
			<td colspan="8" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
	
