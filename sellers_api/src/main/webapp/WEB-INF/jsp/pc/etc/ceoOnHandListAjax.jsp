<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

                                        
<c:choose>
	<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows">
		 <tr class="tr_list" onClick="oppList.goDetail(${rows.OPPORTUNITY_ID});">
		 	<fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
             <td>${NO}</td>
		 	
		    <%-- <td>${OPPORTUNITY_ID}</td> --%>
		    <td name="cols_GODORY_TERRITORY">${rows.EXEC_NAME} </td>
		    
            <td name="cols_GODORY_TERRITORY">${rows.ROUTE} </td>
			
			<td name="cols_GODORY_TERRITORY">${rows.SUBJECT} </td>
			
	    	<td class="ag_l" name="cell_MILESTONES">
              <div class="milestones">
                  <div class="step">
                        <c:if test="${rows.KEY_MILESTONE_PREV ne null && rows.KEY_MILESTONE_PREV != '' }">
                        <span class="icon_status statusColor-${rows.STATUS_COLOR_PREV}"></span>
                        <span class="subject">
                        <c:choose>
		        			<c:when test="${fn:length(rows.KEY_MILESTONE_PREV) > 16}">
		        			<c:out value="${fn:substring(rows.KEY_MILESTONE_PREV,0,15)}"/>...
		        			</c:when>
		        			<c:otherwise>
		        			${rows.KEY_MILESTONE_PREV}
		        			</c:otherwise>
		        		</c:choose>
                        </span>
                        <span class="term">(${rows.ACT_DUE_DATE_PREV})</span>
                        </c:if>
                  </div>
                  <div class="step">
                        <c:if test="${rows.KEY_MILESTONE_ING ne null && rows.KEY_MILESTONE_ING != '' }">
                        <span class="icon_status statusColor-${rows.STATUS_COLOR_ING}"></span>
                        <span class="subject">
                        <c:choose>
		        			<c:when test="${fn:length(rows.KEY_MILESTONE_ING) > 16}">
		        			<c:out value="${fn:substring(rows.KEY_MILESTONE_ING,0,15)}"/>...
		        			</c:when>
		        			<c:otherwise>
		        			${rows.KEY_MILESTONE_ING}
		        			</c:otherwise>
		        		</c:choose>
                        </span>
                        <span class="term">(${rows.ACT_DUE_DATE_ING})</span>
                     	</c:if>
                  </div>
                  <div class="step">
                       <c:if test="${rows.KEY_MILESTONE_NEXT ne null && rows.KEY_MILESTONE_NEXT != '' }">
                       <span class="icon_status statusColor-${rows.STATUS_COLOR_NEXT}"></span>
                       <span class="subject">
                       <c:choose>
		        			<c:when test="${fn:length(rows.KEY_MILESTONE_NEXT) > 16}">
		        			<c:out value="${fn:substring(rows.KEY_MILESTONE_NEXT,0,15)}"/>...
		        			</c:when>
		        			<c:otherwise>
		        			${rows.KEY_MILESTONE_NEXT}
		        			</c:otherwise>
		        		</c:choose>
                        </span>
                       <span class="term">(${rows.ACT_DUE_DATE_NEXT})</span>
					   </c:if>
                  </div>
              </div>
          </td>
		  <td name="cell_CONTRACT_DATE">${rows.CONTRACT_DATE}</td>
		  
	  		<c:choose>
              	<c:when test="${rows.statusColor eq '-'}">
              		<td name="cols_STATUS_TEXT">-</td>
              	</c:when>
              	<c:otherwise>
              	
              		<c:choose>
              			<c:when test="${rows.statusColor eq 'G'}">
              				<td name="cols_STATUS_TEXT" style="background-color: #1ab394"></td>
              			</c:when>
              			<c:when test="${rows.statusColor eq 'Y'}">
              				<td name="cols_STATUS_TEXT" style="background-color: #ffc000"></td>
              			</c:when>
              			<c:when test="${rows.statusColor eq 'R'}">
              				<td name="cols_STATUS_TEXT" style="background-color: #f20056"></td>
              			</c:when>
              		</c:choose>
              	
              		<%-- <td name="cols_STATUS_TEXT" style="background-color: ${rows.ISSUE_ACTION_STATUS_TEXT}"></td> --%>
              	</c:otherwise>
              </c:choose>
		</tr>
		
	</c:forEach>
	</c:when>
	<c:otherwise>
	<tr>
		<td colspan="7" style="text-align:center;">No Data</td>
	</tr>
	</c:otherwise>
</c:choose>


<script type="text/javascript">
$('#sum_contract_amount').html(add_comma("${sum_contract_amount/1000000}"));
$('#total_rev').html(add_comma("${total_rev/1000000}"));
$('#total_gp').html(add_comma("${total_gp/1000000}"));
$('#division_sum_rev_1').html(add_comma("${division_sum_rev_1}"));
$('#division_sum_gp_1').html(add_comma("${division_sum_gp_1}"));
$('#division_sum_rev_2').html(add_comma("${division_sum_rev_2}"));
$('#division_sum_gp_2').html(add_comma("${division_sum_gp_2}"));
$('#division_sum_rev_3').html(add_comma("${division_sum_rev_3}"));
$('#division_sum_gp_3').html(add_comma("${division_sum_gp_3}"));
$('#division_sum_rev_4').html(add_comma("${division_sum_rev_4}"));
$('#division_sum_gp_4').html(add_comma("${division_sum_gp_4}"));
</script>
