<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fmt_rt" uri="http://java.sun.com/jstl/fmt_rt" %>

<c:set var="sum_contract_amount" 		value="0" />
<c:set var="total_rev" 	value="0" />
<c:set var="total_gp" 	value="0" />


<tr class="total">
    <td colspan="10" class="title" style="text-align:center;"><strong><h3>Forecast In 합계</h3></strong></td>
    <td name="cell_CONTRACT_AMOUNT"><strong><span id="sum_contract_amount">0</span></strong></td>
    <td name="cell_REV"><strong><span id="total_rev">0</span></strong></td>
    <td name="cell_GP"><strong><span id="total_gp">0</span></strong></td>
</tr>
                                        
<c:choose>
	<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows">
		 <tr class="tr_list" onClick="oppList.goDetail(${rows.OPPORTUNITY_ID});">
		 	<fmt:parseNumber var= "OPPORTUNITY_ID" integerOnly= "true" value= "${rows.OPPORTUNITY_ID}" />
		    <%-- <td>${OPPORTUNITY_ID}</td> --%>
		    <td class="ag_l" name="cell_OPPORTUNITY">
               <span class="cata">${rows.CUSTOMER_NAME}</span> 
               <%-- <span><strong>ID : ${OPPORTUNITY_ID}<strong></span> --%> 
               <%-- <span><strong>/ ${rows.IDENTIFIER_NAME}<strong></span> --%>
               <c:if test="${rows.ERP_OPP_CD ne null && rows.ERP_OPP_CD != '' }">
		       	<span class="forecast forecast_out" style="color:#2DB71C; height:18px; line-heigh:18px;">OP</span>
		       </c:if>
		       <c:if test="${rows.ERP_PROJECT_CODE ne null && rows.ERP_PROJECT_CODE != '' }">
		        <span class="forecast forecast_out" style="color:#2DB71C; height:18px; line-heigh:18px;">PJ</span> 
		       </c:if>
		       <c:if test="${rows.KEY_DEAL_YN eq 'Y'}">
               <span><i class="fa fa-star" style="color: orange;"></i></span>
               </c:if>
		       <br />
		        <h4 class="subject">
		        	<c:choose>
		        		<c:when test="${fn:length(rows.SUBJECT) > 29}">
		        		<c:out value="${fn:substring(rows.SUBJECT,0,28)}"/>...
		        		</c:when>
		        		<c:otherwise>
		        		${rows.SUBJECT}
		        		</c:otherwise>
		        	</c:choose>
		        <c:if test="${rows.COACHING_TALK_COUNT > 0 && rows.SALES_CYCLE ne 4}">
              		<span style="color: orange;">(${rows.COACHING_TALK_COUNT})</span> 
              	</c:if>
              	<c:if test="${rows.FILE_COUNT > 0}"><span class="file_inner"></span></c:if>
		        </h4>
               <%-- <div>${rows.IDENTIFIER_NAME}<c:if test="${rows.ERP_PROJECT_CODE ne null && rows.ERP_PROJECT_CODE != '' }"> / ${rows.ERP_PROJECT_CODE}</c:if><c:if test="${rows.FILE_COUNT > 0}"> / 첨부 :<span class="file_inner"></span></c:if></div> --%>
            </td>
            <td name="cell_EXEC_NAME">${rows.OWNER_NAME}<br />${rows.IDENTIFIER_NAME}</td>
		    <c:choose>
				<c:when test="${rows.STATUS1 ne null && rows.STATUS1 != '' }">
				<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${rows.STATUS1}"></td>
				</c:when>
				<c:otherwise>
				<td name="cell_CHECKLIST">-</td>
				</c:otherwise>
			</c:choose>
			</td>
			
			<c:choose>
				<c:when test="${rows.STATUS2 ne null && rows.STATUS2 != '' }">
				<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${rows.STATUS2}"></td>
				</c:when>
				<c:otherwise>
				<td name="cell_CHECKLIST">-</td>
				</c:otherwise>
			</c:choose>
			</td>
		    
		   <c:choose>
				<c:when test="${rows.STATUS3 ne null && rows.STATUS3 != '' }">
				<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${rows.STATUS3}"></td>
				</c:when>
				<c:otherwise>
				<td name="cell_CHECKLIST">-</td>
				</c:otherwise>
			</c:choose>
			</td>
			
			<c:choose>
				<c:when test="${rows.STATUS4 ne null && rows.STATUS4 != '' }">
				<td name="cell_CHECKLIST" class="cell-status cell-statusColor-${rows.STATUS4}"></td>
				</c:when>
				<c:otherwise>
				<td name="cell_CHECKLIST">-</td>
				</c:otherwise>
			</c:choose>
			</td>
			
			<td name="cell_FORECAST">
		    <c:choose>
				<c:when test="${rows.FORECAST_YN ne null && rows.FORECAST_YN != '' }">
				<span class="forecast forecast_${fn:toLowerCase(rows.FORECAST_YN)}">${fn:toLowerCase(rows.FORECAST_YN)}</span>
				</c:when>
				<c:otherwise>
				-
				</c:otherwise>
			</c:choose>
			</td>
		    
		    <%-- <c:choose>
				<c:when test="${rows.SALES_CYCLE eq 1}">
				<td>Identify/Validation</td>
				</c:when>	
				<c:when test="${rows.SALES_CYCLE eq 2}">
				<td>Qualification</td>
				</c:when>
				<c:when test="${rows.SALES_CYCLE eq 3}">
				<td>Close</td>
				</c:when>
				<c:otherwise>
				</c:otherwise>
		    </c:choose> --%>
			<td name="cell_SALES_CYCLE">${rows.SALES_CYCLE}</td>
			
	    	<td class="ag_l ms_status" name="cell_MILESTONES">
	    	  <input type="hidden" name="milestones_oppid" value="${OPPORTUNITY_ID}" />
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
			
		  <td name="cell_CONTRACT_DATE">${rows.CONTRACT_DATE}</td>
		  
		  <%-- <fmt:formatNumber var="var_contract_amount" value="${rows.CONTRACT_AMOUNT}" pattern="#.#"/>
		  <fmt:formatNumber var="temp_contract_amount" value="${var_contract_amount}"/> --%>
		  <td name="cell_CONTRACT_AMOUNT" class="ag_r"><strong>${rows.CONTRACT_AMOUNT}</strong></td>
		    <!-- <td class="ag_l">
		        <div class="milestones">
		            <div class="step">
		                <span class="icon_status statusColor-green"></span>
		                <span class="subject">영업활동 단위테스트 완료</span> 
		                <span class="term">(2016-07-06)</span>
		            </div>
		            <div class="step">
		                <span class="icon_status statusColor-red"></span>
		                <span class="subject">영업관리 단위테스트 완료</span>
		                <span class="term">(2016-07-18)</span>
		            </div>
		            <div class="step">
		                <span class="icon_status statusColor-yellow"></span>
		                <span class="subject">영업관리 단위테스트 완료</span>
		                <span class="term">(2016-08-18)</span>
		            </div>
		        </div>
		    </td> -->
		    
		    <%-- <fmt:formatNumber var="var_amount_rev" value="${rows.AMOUNT_REV}" pattern="#.#"/>
		    <fmt:formatNumber var="var_amount_gp" value="${rows.AMOUNT_GP}" pattern="#.#"/>
		    <fmt:formatNumber var="temp_amount_rev" value="${var_amount_rev/1000000}" pattern="#.#"/>
		    <fmt:formatNumber var="temp_amount_gp" value="${var_amount_gp/1000000}" pattern="#.#"/> --%>
		    <td name="cell_REV" class="ag_r"><strong>${rows.AMOUNT_REV}</strong></td>
		    <td name="cell_GP" class="ag_r"><strong>${rows.AMOUNT_GP}</strong></td>
		    
		     <%-- <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_REV_1/1000000}" groupingUsed="true"/></td>
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_GP_1/1000000}" groupingUsed="true"/></td>
		     
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_REV_2/1000000}" groupingUsed="true"/></td>
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_GP_2/1000000}" groupingUsed="true"/></td>
		     
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_REV_3/1000000}" groupingUsed="true"/></td>
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_GP_3/1000000}" groupingUsed="true"/></td>
		     
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_REV_4/1000000}" groupingUsed="true"/></td>
		     <td name="cell_division_sum" class="ag_r"><fmt:formatNumber value="${rows.DIVISION_GP_4/1000000}" groupingUsed="true"/></td> --%>
		     
		    <%-- <td name="cell_FILE_COUNT"><span class="file_inner"></span></td> --%>
		</tr>
		
			<%-- <fmt:formatNumber var="sum_contract_amount" 		value="${sum_contract_amount + temp_contract_amount}" pattern="#.#"/>
			<fmt:formatNumber var="total_rev" 					value="${total_rev + temp_amount_rev}" pattern="#.#"/>
			<fmt:formatNumber var="total_gp" 					value="${total_gp + temp_amount_gp}" pattern="#.#"/> --%>
	</c:forEach>
	</c:when>
	<c:otherwise>
	<tr>
		<td colspan="20" style="text-align:center;">No Data</td>
	</tr>
	</c:otherwise>
</c:choose>


<script type="text/javascript">
/* $('#sum_contract_amount').html("${sum_contract_amount}");
$('#total_rev').html("${total_rev}");
$('#total_gp').html("${total_gp}"); */
</script>
