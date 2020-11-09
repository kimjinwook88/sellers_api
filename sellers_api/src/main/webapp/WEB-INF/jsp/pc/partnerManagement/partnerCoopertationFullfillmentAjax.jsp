<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table id="tech-companies" class="table table-bordered">
  	<colgroup>
        <col width="*"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
    </colgroup>
    <thead>
	    <tr>
	        <th rowspan="2" width="20%">거래처명</th>
	        <th colspan="6"><a href="javascript:void(0);" onClick="fullfill.get('m',1,1);" class="btn-group-sum">&lt;</a> <span id="spanListYear">${searchYear}</span>년 <a href="javascript:void(0);" onClick="fullfill.get('p',1,1);" class="btn-group-sum">&gt;</a></th>
	    </tr>
	    <tr>
	    	<th width="5%">신용등급</th>
	        <th width="5%">여신등급</th>
	        <th width="*">여신급액</th>
	        <th width="5%">거래상태</th>
	        <th width="5%">감사의견</th>
	        <th width="5%">현금흐름</th>
	    </tr>
    </thead>
    <tbody>
	    <c:choose>
		<c:when test="${fn:length(rows) > 0}">
			<c:forEach items="${rows}" var="rows">
		    <tr class="tr_list">
		    	  <fmt:parseNumber var= "NO" integerOnly= "true" value= "${rows.ROWNUM}" />
	              <td class="ag_l">${rows.COMPANY_NAME}</td>
	              <td class="ag_r">${rows.CREDIT_RATING}</td>
	              <td class="ag_r">${rows.LOAN_GRADE}</td>
	              <td class="ag_r"><fmt:formatNumber value="${rows.CREDIT_AMOUNT}" groupingUsed="true"/></td>
	              <td class="ag_r">${rows.BUSINESS_STATUS}</td>
	              <td class="ag_r">${rows.AUDIT_OPINION}</td>
	              <td class="ag_r">${rows.CASH_FLOWS}</td>
	 		</tr>
		    </c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="10" style="text-align:center;">No Data</td>
			</tr>
		</c:otherwise>
		</c:choose>
	</tbody>
</table>						
<div class="btn-group pull-right pd-t10">
    <button type="button" class="btn btn-white" onClick="fullfill.get(null,${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
    <c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
	    <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="fullfill.get(null,${paginNo},${listPaging.toEndPage});">${paginNo}</button>
    </c:forEach>
    <button type="button" class="btn btn-white" onClick="fullfill.get(null,${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
</div>
