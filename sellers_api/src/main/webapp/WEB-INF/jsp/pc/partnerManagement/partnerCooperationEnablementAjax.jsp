<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
						
 <c:choose>
	<c:when test="${fn:length(rows) > 0}">
		<c:forEach items="${rows}" var="rows">
	    <tr class="tr_list" onClick="enableList.goDetail(${rows.EDU_PLAN_ID});">
	    	  <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
              <td>${NO}</td>
              <td name="cols_EDU_AREA" class="ag_l">${rows.SOLUTION_AREA}</td>
              <td name="cols_EDU_SUBJECT" class="ag_l">${rows.EDU_SUBJECT} </td>
              <td name="cols_EDU_TARGET" class="ag_l">${rows.EDU_TARGET} </td>
              <td name="cols_START_DATE">${rows.START_DATE} </td>
              <td name="cols_END_DATE">${rows.END_DATE} </td>
              <td name="cols_EDU_BUDGET">${rows.EDU_BUDGET} </td>
              <td name="cols_EDU_KIND">${rows.EDU_KIND}</td>
              <td name="cols_SAT_VALUE">${rows.SAT_VALUE}</td>
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
			<td colspan="11" style="text-align:center;">No Data</td>
		</tr>
	</c:otherwise>
</c:choose>
	
