<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
 <c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
	    <tr class="tr_list" onClick="list.goDetail(${rows.OPPORTUNITY_HIDDEN_ID});">
              <%-- <td onClick="hiddenOppList.goDetail(${rows.OPPORTUNITY_HIDDEN_ID});" name="cols_OPPORTUNITY_HIDDEN_ID">${rows.OPPORTUNITY_HIDDEN_ID}</td> --%>
              <td name="cols_CUSTOMER_NAME">${rows.CUSTOMER_NAME} </td>
              <td name="cols_COMPANY_NAME" class="ag_l">${rows.COMPANY_NAME}</td>
              <td name="cols_SUBJECT" class="ag_l">${rows.SUBJECT}
              <c:if test="${rows.COACHING_TALK_COUNT > 0}">
              		<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
			  </c:if>
              </td>
              <%-- <td name="cols_CATEGORY">${rows.CATEGORY} </td> --%>
              <td name="cols_OPPORTUNITY_AMOUNT"><fmt:formatNumber value="${rows.OPPORTUNITY_AMOUNT}" groupingUsed="true"/></td>
              <%-- <td name="cols_SALESMAN_DIVISION">${rows.SALESMAN_DIVISION} </td> --%>
              <td name="cols_SALESMAN_NAME">${rows.SALESMAN_NAME} </td>
              <td name="cols_SALES_CHANGE_DATE">${rows.SALES_CHANGE_DATE} </td>
              
              <td name="cols_ACTION_STATUS" class="fua_status">
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
              	
              
              <c:choose>
              	<c:when test="${rows.STATUS != null and rows.STATUS != '' and rows.STATUS != '-'}">
              		<td name="cols_STATUS" style="background-color: ${rows.STATUS}"></td>
              	</c:when>
              	<c:otherwise>
              		<td name="cols_STATUS">-</td>
              	</c:otherwise>
              </c:choose>
 		</tr>
	    </c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="8" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
	
