<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>							

<c:choose>
<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows">
	<tr class="tr_list" onClick="bizList.goDetail(${rows.BIZ_ID});">
		<%-- <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
	   <td>${NO}</td> --%>
	   <td class="ag_l" name="cols_SUBJECT">
          <h4 class="subject">${rows.SUBJECT}</h4><br/>
          <c:choose>
          	<c:when test="${fn:length(rows.KEY_CONTENTS) > 30}">
            	<span class="fc_gray"><c:out value="${fn:substring(rows.KEY_CONTENTS,0,26)}..."/></span>
           	</c:when>
           	<c:otherwise>
            	<span class="fc_gray"><c:out value="${rows.KEY_CONTENTS}"/></span>
           	</c:otherwise> 
          </c:choose>
	   </td>
	   <%-- <td name="cols_Category">${rows.CATEGORY} </td> --%>
	   <td name="cols_EXEC_POST">${rows.RL_DIVISION} </td>
	   <td name="cols_EXEC_OWNER" <%-- onmouseenter="$(this).html('${rows.HAN_NAME}<br/>${rows.PHONE}<br/>${rows.EMAIL}');" onmouseleave="$(this).html('${rows.HAN_NAME}')" --%>>${rows.RL_NAME}</td>
	   
	  <td class="ms_status" name="cols_KEY_MILESTONE">
          <div class="milestones">
        			<jsp:include page="/WEB-INF/jsp/pc/common/milestones_status.jsp">
            			<jsp:param name="DUE_DATE_1" value="${rows.MS_DUE_DATE_1}" />
            			<jsp:param name="DUE_DATE_2" value="${rows.MS_DUE_DATE_2}" />
            			<jsp:param name="DUE_DATE_3" value="${rows.MS_DUE_DATE_3}" />
            			<jsp:param name="DUE_DATE_4" value="${rows.MS_DUE_DATE_4}" />
            			<jsp:param name="DUE_DATE_5" value="${rows.MS_DUE_DATE_5}" />
            			<jsp:param name="CLOSE_DATE_1" value="${rows.MS_CLOSE_DATE_1}" />
            			<jsp:param name="CLOSE_DATE_2" value="${rows.MS_CLOSE_DATE_2}" />
            			<jsp:param name="CLOSE_DATE_3" value="${rows.MS_CLOSE_DATE_3}" />
            			<jsp:param name="CLOSE_DATE_4" value="${rows.MS_CLOSE_DATE_4}" />
            			<jsp:param name="CLOSE_DATE_5" value="${rows.MS_CLOSE_DATE_5}" />
            			<jsp:param name="MILESTONE_1" value="${rows.KEY_MILESTONE_1}" />
            			<jsp:param name="MILESTONE_2" value="${rows.KEY_MILESTONE_2}" />
            			<jsp:param name="MILESTONE_3" value="${rows.KEY_MILESTONE_3}" />
            			<jsp:param name="MILESTONE_4" value="${rows.KEY_MILESTONE_4}" />
            			<jsp:param name="MILESTONE_5" value="${rows.KEY_MILESTONE_5}" />
            		</jsp:include>
             </div>
       </td>
				
            <td name="cols_ISSUE_STATUS" class="fua_status">
            	<div class="milestones">
          			<jsp:include page="/WEB-INF/jsp/pc/common/common_status.jsp">
              			<jsp:param name="DUE_DATE_1" value="${rows.ISSUE_DUE_DATE_1}" />
              			<jsp:param name="DUE_DATE_2" value="${rows.ISSUE_DUE_DATE_2}" />
              			<jsp:param name="DUE_DATE_3" value="${rows.ISSUE_DUE_DATE_3}" />
              			<jsp:param name="DUE_DATE_4" value="${rows.ISSUE_DUE_DATE_4}" />
              			<jsp:param name="DUE_DATE_5" value="${rows.ISSUE_DUE_DATE_5}" />
              			<jsp:param name="CLOSE_DATE_1" value="${rows.ISSUE_CLOSE_DATE_1}" />
              			<jsp:param name="CLOSE_DATE_2" value="${rows.ISSUE_CLOSE_DATE_2}" />
              			<jsp:param name="CLOSE_DATE_3" value="${rows.ISSUE_CLOSE_DATE_3}" />
              			<jsp:param name="CLOSE_DATE_4" value="${rows.ISSUE_CLOSE_DATE_4}" />
              			<jsp:param name="CLOSE_DATE_5" value="${rows.ISSUE_CLOSE_DATE_5}" />
              			<jsp:param name="CONTENTS_1" value="${rows.ISSUE_NAME_1}" />
              			<jsp:param name="CONTENTS_2" value="${rows.ISSUE_NAME_2}" />
              			<jsp:param name="CONTENTS_3" value="${rows.ISSUE_NAME_3}" />
              			<jsp:param name="CONTENTS_4" value="${rows.ISSUE_NAME_4}" />
              			<jsp:param name="CONTENTS_5" value="${rows.ISSUE_NAME_5}" />
              		</jsp:include>
             	</div>
            </td>
             
             <c:choose>
             <c:when test="${rows.REVIEW_CYCLE eq 0}">
             <td name="cols_REVIEW_CYCLE">매월 1회</td>
             </c:when>
             <c:when test="${rows.REVIEW_CYCLE eq 1}">
             <td name="cols_REVIEW_CYCLE">분기 1회</td>
             </c:when>
             <c:when test="${rows.REVIEW_CYCLE eq 2}">
             <td name="cols_REVIEW_CYCLE">반기 1회</td>
             </c:when>
             <c:when test="${rows.REVIEW_CYCLE eq 3}">
             <td name="cols_REVIEW_CYCLE">매주 1회</td>
             </c:when>
             <c:otherwise>
             <td name="cols_REVIEW_CYCLE">없음</td>
             </c:otherwise>
             </c:choose>
             <td name="cols_SYS_REGISTER_DATE"><span class="date">${rows.SYS_REGISTER_DATE}</td>
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
         </c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="10" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
