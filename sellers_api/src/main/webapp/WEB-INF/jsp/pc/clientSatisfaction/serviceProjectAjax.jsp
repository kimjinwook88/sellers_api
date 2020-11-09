<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	  <c:choose>
		<c:when test="${fn:length(rows) > 0}">
			<c:forEach items="${rows}" var="rows">
		    <tr class="tr_list" onClick="projectMGMTList.goDetail(${rows.PROJECT_ID});">
		       <%-- <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
               <td>${NO}</td> --%>
               
               <%-- <td name="cols_COMPANY">${rows.COMPANY_NAME}</td> --%>
               <td class="ag_l" name="cols_PROJECT_NAME">
               <span class="fc_gray">${rows.COMPANY_NAME}</span><br/>
               <h4 class="subject">${rows.PROJECT_SUBJECT}</h4>
               <c:if test="${rows.COACHING_TALK_COUNT > 0}">
					<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
				</c:if>
               </td>
               <td name="cols_SALES_OWNER">${rows.CLIENT_PM_NAME}</td>
               
               <%-- <td name="cols_TOTAL">${rows.CLIENT_EXEC_PM_NAME}</td> --%>
               <td name="cols_SALES_OWNER">${rows.CUSTOMER_NAME}</td>
               <%-- <td name="cols_Y">${rows.SALES_REPRESENTIVE_POST}</td> --%>
               <td name="cols_OUR_COMPANY">${rows.OUR_PM_NAME}</td>
               <%-- <td name="cols_R">${rows.OUR_PM_POST}</td> --%>
               <td name="cols_OUR_COMPANY">${rows.SALES_REPRESENTIVE_NAME}</td>
               <%-- <td name="cols_R">${rows.OUR_EXEC_PM_NAME}</td> --%>
               
               <td class="ms_status" name="cols_MILESTONES">
                 <div class="milestones">
                 	<jsp:include page="/WEB-INF/jsp/pc/common/milestones_status.jsp">
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
               			<jsp:param name="MILESTONE_1" value="${rows.CONTENTS_1}" />
               			<jsp:param name="MILESTONE_2" value="${rows.CONTENTS_2}" />
               			<jsp:param name="MILESTONE_3" value="${rows.CONTENTS_3}" />
               			<jsp:param name="MILESTONE_4" value="${rows.CONTENTS_4}" />
               			<jsp:param name="MILESTONE_5" value="${rows.CONTENTS_5}" />
               		</jsp:include>
                 </div>
               </td>
               <%-- <td name="cols_MILESTONES">
               		<c:choose>
		        		<c:when test="${rows.KEY_MILESTONE != null && rows.KEY_MILESTONE != ''}">
		        			${rows.KEY_MILESTONE}
		        		</c:when>
		        		<c:otherwise>
		        		-
		        		</c:otherwise>
		        	</c:choose>
               </td> --%>
               <td name="cols_PROGRESS">
               		<div class="progress" style="margin: 0px; position: relative;"><span style="display:block; position: absolute; top:1px; left:0px; width: 100%; text-align: center;">${rows.PROGRESS}%</span>
    					<div class="progress-bar progress-bar-striped progress-bar-info active" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:${rows.PROGRESS}%; color:black;">
    					
    					</div>
					</div>
    			</td>
               
               <%-- <c:choose>
	        		<c:when test="${rows.ISSUE_STATUS eq 'G'}">
	        			<td name="cols_ISSUE_STATUS" class="cell-status cell-statusColor-green"></td>
	        		</c:when>
	        		<c:when test="${rows.ISSUE_STATUS eq 'Y'}">
	        			<td name="cols_ISSUE_STATUS" class="cell-status cell-statusColor-yellow"></td>
	        		</c:when>
	        		<c:when test="${rows.ISSUE_STATUS eq 'R'}">
	        			<td name="cols_ISSUE_STATUS" class="cell-status cell-statusColor-red"></td>
	        		</c:when>
	        		<c:otherwise>
	        			<td name="cols_ISSUE_STATUS">-</td>
	        		</c:otherwise>
	        	</c:choose> --%>
		        	
		        <td class="fua_status" name="cols_ISSUE_STATUS">
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
	               			<jsp:param name="CONTENTS_1" value="${rows.ISSUE_CONTENTS_1}" />
	               			<jsp:param name="CONTENTS_2" value="${rows.ISSUE_CONTENTS_2}" />
	               			<jsp:param name="CONTENTS_3" value="${rows.ISSUE_CONTENTS_3}" />
	               			<jsp:param name="CONTENTS_4" value="${rows.ISSUE_CONTENTS_4}" />
	               			<jsp:param name="CONTENTS_5" value="${rows.ISSUE_CONTENTS_5}" />
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
				<td colspan="14" style="text-align:center;">No Data</td>
			</tr>
		</c:otherwise>
	</c:choose>